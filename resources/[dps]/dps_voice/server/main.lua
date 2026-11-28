-- dps_voice, server side.
--
-- FiveM for GTAV Enhanced replaced Mumble with a voice system the SERVER owns: the server makes
-- channels and decides who is in them, who is muted and who is deaf. Clients cannot join a channel
-- on their own, which is what stops eavesdropping. This file is the whole of that logic.
--
-- Three kinds of channel:
--   talking distance  one 3D channel per line of config.ranges. Every player is in all of them and
--                     can speak in exactly one, so a whisper and a shout are heard at different ranges.
--   phone calls       one 2D channel per call. Both sides speak freely.
--   radio             one 2D channel per frequency. Everyone listens; you speak while you hold the key.

local config = require 'config'

---@type integer What CreateVoiceChannel returns when the server has no channel left to give.
local NO_CHANNEL <const> = 65535

local proximity = {}     -- range index -> voice channel id
local playerRange = {}   -- source -> range index
local micMuted = {}      -- source -> true while the player has muted their own mic
local calls = {}         -- phone call number -> { id = voice channel id, members = { [source] = true } }
local playerCall = {}    -- source -> phone call number
local radios = {}        -- frequency -> { id = voice channel id, members = { [source] = true } }
local playerRadio = {}   -- source -> frequency
local radioChecks = {}   -- frequency -> fun(source): boolean, for frequencies not everyone may join
local radioTalking = {}  -- source -> true while they hold the radio key
local ready = false

---Leaves the call or radio channel a player is in. Deletes the channel when it is empty.
---@param groups table calls or radios
---@param index table playerCall or playerRadio
---@param src integer
local function leaveGroup(groups, index, src)
    local key = index[src]
    if not key then return end
    index[src] = nil

    local group = groups[key]
    if not group then return end

    RemovePlayerFromVoiceChannel(group.id, src)
    group.members[src] = nil

    if not next(group.members) then
        DeleteVoiceChannel(group.id)
        groups[key] = nil
    end
end

---Puts a player in a call or radio channel, making the channel if it is the first one in.
---@param groups table calls or radios
---@param index table playerCall or playerRadio
---@param src integer
---@param key integer call number or frequency
---@param listenOnly boolean true = join muted (radio: you speak only while holding the key)
---@return boolean joined
local function joinGroup(groups, index, src, key, listenOnly)
    if index[src] == key then return true end
    leaveGroup(groups, index, src)

    local group = groups[key]
    if not group then
        local id = CreateVoiceChannel(0, 0.0) -- 0 = 2D: heard at any distance
        if id == NO_CHANNEL then return false end
        group = { id = id, members = {} }
        groups[key] = group
    end

    AddPlayerToVoiceChannel(group.id, src)
    if listenOnly or micMuted[src] then
        SetPlayerMutedInVoiceChannel(group.id, src, true)
    end

    group.members[src] = true
    index[src] = key
    return true
end

---Sets which talking distance a player speaks at. They still hear all of them.
---@param src integer
---@param rangeIndex integer line of config.ranges
local function applyRange(src, rangeIndex)
    playerRange[src] = rangeIndex
    for i = 1, #proximity do
        SetPlayerMutedInVoiceChannel(proximity[i], src, micMuted[src] == true or i ~= rangeIndex)
    end

    local range = config.ranges[rangeIndex]
    -- Same state name and shape pma-voice uses, so HUDs that show the talking distance keep working.
    Player(src).state:set('proximity', { index = rangeIndex, distance = range.distance, mode = range.name }, true)
end

---@param src integer
local function addToProximity(src)
    for i = 1, #proximity do
        AddPlayerToVoiceChannel(proximity[i], src)
    end
    applyRange(src, config.defaultRange)
end

---Moves a player in or out of a phone call. 0 leaves.
---@param src integer
---@param callNumber integer
---@return boolean ok
local function setPlayerCall(src, callNumber)
    if not ready then return false end
    callNumber = math.floor(tonumber(callNumber) or 0)

    if callNumber <= 0 then
        leaveGroup(calls, playerCall, src)
    elseif not joinGroup(calls, playerCall, src, callNumber, false) then
        return false
    end

    Player(src).state:set('callChannel', math.max(callNumber, 0), true)
    return true
end

---Moves a player in or out of a radio frequency. 0 leaves.
---@param src integer
---@param frequency integer
---@return boolean ok
local function setPlayerRadio(src, frequency)
    if not ready then return false end
    frequency = math.floor(tonumber(frequency) or 0)

    if frequency <= 0 then
        leaveGroup(radios, playerRadio, src)
    else
        local allowed = radioChecks[frequency]
        if allowed and not allowed(src) then return false end
        if not joinGroup(radios, playerRadio, src, frequency, true) then return false end
    end

    Player(src).state:set('radioChannel', math.max(frequency, 0), true)
    return true
end

---Mutes or unmutes a player's own mic everywhere: talking distance, call and radio.
---@param src integer
---@param muted boolean
local function setPlayerMuted(src, muted)
    if not ready then return end
    micMuted[src] = muted == true or nil

    if playerRange[src] then applyRange(src, playerRange[src]) end

    local call = calls[playerCall[src]]
    if call then SetPlayerMutedInVoiceChannel(call.id, src, muted == true) end

    -- Radio stays muted either way: it only opens while the key is held.
    local radio = radios[playerRadio[src]]
    if radio and muted then SetPlayerMutedInVoiceChannel(radio.id, src, true) end
end

-- The same server exports pma-voice has, so scripts written for it need no change.
exports('setPlayerCall', setPlayerCall)
exports('setPlayerRadio', setPlayerRadio)
exports('setPlayerMuted', setPlayerMuted)

---Limits a frequency to players the check allows, for example police only.
---@param frequency integer
---@param check fun(source: integer): boolean
exports('addChannelCheck', function(frequency, check)
    radioChecks[math.floor(tonumber(frequency) or 0)] = check
end)

---@param frequency integer
---@return table<integer, true> sources on that frequency
exports('getPlayersInRadioChannel', function(frequency)
    local radio = radios[math.floor(tonumber(frequency) or 0)]
    local copy = {}
    if radio then for src in pairs(radio.members) do copy[src] = true end end
    return copy
end)

-- A player may change their OWN radio frequency, talking distance and mute. Phone calls are not on
-- this list on purpose: only a server script may put a player in a call, so nobody can listen in.
RegisterNetEvent('dps_voice:setRadio', function(frequency)
    setPlayerRadio(source, frequency)
end)

RegisterNetEvent('dps_voice:radioTalk', function(talking)
    local src = source
    local radio = radios[playerRadio[src]]
    if not radio then return end
    radioTalking[src] = talking == true or nil
    SetPlayerMutedInVoiceChannel(radio.id, src, micMuted[src] == true or talking ~= true)
end)

-- /voicetest: shows the voice state the server holds for you. It cannot prove sound, but it proves
-- the channel logic: change talking distance, join a frequency, hold the radio key, and run it again.
lib.addCommand('voicetest', {
    help = 'Voice: show which voice channels you are in',
    restricted = 'group.admin',
}, function(source)
    if source == 0 then return print('[dps_voice] /voicetest is for a player in game') end
    if not ready then
        return TriggerClientEvent('ox_lib:notify', source, { title = 'Voice', description = 'Voice is OFF. See the server console.', type = 'error' })
    end

    local lines = {}
    local mine = playerRange[source]
    for i = 1, #proximity do
        local state = (micMuted[source] or i ~= mine) and 'listen only' or 'SPEAKING'
        lines[#lines + 1] = ('%s %sm (channel %d): %s'):format(config.ranges[i].name, config.ranges[i].distance, proximity[i], state)
    end

    local call = calls[playerCall[source]]
    lines[#lines + 1] = call
        and ('Phone call %d (channel %d): %s'):format(playerCall[source], call.id, micMuted[source] and 'listen only' or 'SPEAKING')
        or 'Phone call: none'

    local radio = radios[playerRadio[source]]
    if radio then
        local others = -1
        for _ in pairs(radio.members) do others = others + 1 end
        local state = (radioTalking[source] and not micMuted[source]) and 'SPEAKING' or 'listen only'
        lines[#lines + 1] = ('Radio %d (channel %d): %s, %d other(s) on it'):format(playerRadio[source], radio.id, state, others)
    else
        lines[#lines + 1] = 'Radio: none'
    end

    lines[#lines + 1] = ('Mic muted by you: %s'):format(micMuted[source] and 'yes' or 'no')

    local text = table.concat(lines, '  \n')
    print(('[dps_voice] /voicetest for %s (%d)\n  %s'):format(GetPlayerName(source), source, table.concat(lines, '\n  ')))
    TriggerClientEvent('ox_lib:notify', source, { id = 'dps_voice_test', title = 'Voice test', description = text, type = 'inform', duration = 12000 })
end)

RegisterNetEvent('dps_voice:setMuted', function(muted)
    setPlayerMuted(source, muted == true)
end)

RegisterNetEvent('dps_voice:cycleRange', function()
    local src = source
    if not ready or not playerRange[src] then return end

    local nextIndex = playerRange[src] % #config.ranges + 1
    applyRange(src, nextIndex)

    if config.notifyRange then
        TriggerClientEvent('ox_lib:notify', src, {
            id = 'dps_voice_range',
            title = 'Voice',
            description = ('Talking distance: %s'):format(config.ranges[nextIndex].name),
            type = 'inform',
            duration = 2000,
        })
    end
end)

AddEventHandler('playerJoining', function()
    if ready then addToProximity(source) end
end)

-- The server takes a leaving player out of every channel by itself. What is left to do is forget
-- them here and delete a call or radio channel they were the last one in. This matters more on
-- Enhanced than before: the next player to join can be given the same source number.
AddEventHandler('playerDropped', function()
    local src = source
    leaveGroup(calls, playerCall, src)
    leaveGroup(radios, playerRadio, src)
    playerRange[src] = nil
    micMuted[src] = nil
    radioTalking[src] = nil
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for i = 1, #proximity do DeleteVoiceChannel(proximity[i]) end
    for _, call in pairs(calls) do DeleteVoiceChannel(call.id) end
    for _, radio in pairs(radios) do DeleteVoiceChannel(radio.id) end
end)

CreateThread(function()
    local ok, problem = pcall(function()
        for i = 1, #config.ranges do
            local id = CreateVoiceChannel(1, config.ranges[i].distance + 0.0) -- 1 = 3D: heard by distance
            if id == NO_CHANNEL then error('the server has no free voice channel') end
            proximity[i] = id
        end
    end)

    if not ok then
        print(('^1[dps_voice]^7 voice is OFF: %s'):format(problem))
        print('^1[dps_voice]^7 check that server.cfg has the line: voice_internal')
        return
    end

    ready = true
    for _, id in ipairs(GetPlayers()) do
        addToProximity(tonumber(id) --[[@as integer]])
    end

    print(('^2[dps_voice]^7 v%s ready: %d talking distances (voice channels %s)'):format(
        GetResourceMetadata(GetCurrentResourceName(), 'version', 0), #proximity, table.concat(proximity, ', ')))
end)
