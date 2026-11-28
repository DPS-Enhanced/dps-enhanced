-- dps_voice, client side.
-- The server owns every voice channel (see server/main.lua). This file is only the two keys and the
-- client exports that scripts written for pma-voice expect to find.

local config = require 'config'

local radioVolume = 100
local callVolume = 100
local onRadio = false -- true while the radio key is held and we are transmitting

---@return integer frequency the player is on, 0 when none
local function radioChannel()
    return LocalPlayer.state.radioChannel or 0
end

---@param talking boolean
local function radioTalk(talking)
    if talking == onRadio then return end
    if talking and radioChannel() <= 0 then return end

    onRadio = talking
    TriggerServerEvent('dps_voice:radioTalk', talking)
    -- Same local event pma-voice fires, so "on air" indicators in other scripts light up.
    TriggerEvent('pma-voice:radioActive', talking)
end

lib.addKeybind({
    name = 'dps_voice_range',
    description = 'Voice: change how far your voice carries',
    defaultKey = config.rangeKey,
    onPressed = function()
        TriggerServerEvent('dps_voice:cycleRange')
    end,
})

lib.addKeybind({
    name = 'dps_voice_radio',
    description = 'Voice: talk on the radio (hold)',
    defaultKey = config.radioKey,
    onPressed = function() radioTalk(true) end,
    onReleased = function() radioTalk(false) end,
})

-- Leaving a frequency while the key is held must not leave the "on air" light on.
AddStateBagChangeHandler('radioChannel', ('player:%s'):format(cache.serverId), function(_, _, value)
    if onRadio and (value or 0) <= 0 then
        onRadio = false
        TriggerEvent('pma-voice:radioActive', false)
    end
end)

-- Client exports with pma-voice's names.
exports('setRadioChannel', function(frequency)
    TriggerServerEvent('dps_voice:setRadio', frequency)
end)

exports('removePlayerFromRadio', function()
    TriggerServerEvent('dps_voice:setRadio', 0)
end)

exports('setMuted', function(muted)
    TriggerServerEvent('dps_voice:setMuted', muted == true)
end)

-- Volume: the new voice API has no documented volume control yet, so these remember the number and
-- change nothing you can hear. They exist so scripts that call them do not error.
exports('setRadioVolume', function(volume) radioVolume = tonumber(volume) or radioVolume end)
exports('getRadioVolume', function() return radioVolume end)
exports('setCallVolume', function(volume) callVolume = tonumber(volume) or callVolume end)
exports('getCallVolume', function() return callVolume end)
