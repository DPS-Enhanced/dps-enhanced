-- dps_welcome, client side.
--
-- qbx_core fires 'qb-spawn:client:setupSpawns' once a character is loaded. From there this file
-- builds the list of spawn points, opens the DPS screen, flies the camera to whichever point the
-- player is looking at, and puts them there when they choose. The last steps (the two
-- OnPlayerLoaded events, then the move) are qbx_spawn's, in the same order, because every other
-- script on the server waits on those events.

local config = require 'config.client'

---@type vector3 Where the player's body waits, frozen and hidden, while they choose.
local HOLD <const> = vec3(-21.58, -583.76, 86.31)

local spawns = {}
local cam
local open = false
local busy = false -- true while the camera is moving to another point, or the spawn is finishing

---Turns whatever the server gave us into a vec4. Saved positions come back as plain tables.
---@param coords table | vector3 | vector4 | nil
---@return vector4?
local function toVec4(coords)
    if not coords or not coords.x then return nil end
    return vec4(coords.x + 0.0, coords.y + 0.0, coords.z + 0.0, (coords.w or coords.h or 0.0) + 0.0)
end

---A camera behind and above a spawn point, looking at it.
---@param coords vector4
---@return integer camera
local function createCameraFor(coords)
    local settings = config.camera
    local heading = math.rad(coords.w)
    -- GTA headings: 0 faces north (+Y). "Behind" is the opposite of the facing direction.
    local x = coords.x + math.sin(heading) * settings.distance
    local y = coords.y - math.cos(heading) * settings.distance
    local z = coords.z + settings.height

    local newCam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', x, y, z, 0.0, 0.0, 0.0, settings.fov, false, 2)
    PointCamAtCoord(newCam, coords.x, coords.y, coords.z + 1.0)
    return newCam
end

---Moves the view to a spawn point: a glide when it is close, a short fade when it is far.
---@param index integer
local function lookAt(index)
    local spawn = spawns[index]
    if not spawn or busy then return end
    busy = true

    local newCam = createCameraFor(spawn.coords)
    local far = not cam or #(GetCamCoord(cam) - spawn.coords.xyz) > config.camera.cutDistance

    -- Tell the game to load the world around the point we are about to look at.
    SetFocusPosAndVel(spawn.coords.x, spawn.coords.y, spawn.coords.z, 0.0, 0.0, 0.0)

    if far then
        DoScreenFadeOut(250)
        Wait(300)
        if cam then DestroyCam(cam, false) end
        SetCamActive(newCam, true)
        RenderScriptCams(true, false, 0, true, true)
        Wait(350)
        DoScreenFadeIn(450)
    else
        local oldCam = cam
        SetCamActiveWithInterp(newCam, oldCam, config.camera.glideMs, 1, 1)
        Wait(config.camera.glideMs)
        DestroyCam(oldCam, false)
    end

    cam = newCam
    busy = false
end

---The slow flight a brand new character sees, from high over the city down to the first point.
local function welcomeFlight()
    local settings = config.welcome
    local first = spawns[1]

    local startCam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', settings.from.x, settings.from.y, settings.from.z, 0.0, 0.0, 0.0, 55.0, false, 2)
    PointCamAtCoord(startCam, settings.lookAt.x, settings.lookAt.y, settings.lookAt.z)
    SetFocusPosAndVel(settings.lookAt.x, settings.lookAt.y, settings.lookAt.z, 0.0, 0.0, 0.0)
    SetCamActive(startCam, true)
    RenderScriptCams(true, false, 0, true, true)

    Wait(500)
    DoScreenFadeIn(2500)
    Wait(2500)

    local endCam = createCameraFor(first.coords)
    SetFocusPosAndVel(first.coords.x, first.coords.y, first.coords.z, 0.0, 0.0, 0.0)
    SetCamActiveWithInterp(endCam, startCam, settings.flightMs, 1, 1)
    Wait(settings.flightMs)

    DestroyCam(startCam, false)
    cam = endCam
end

---Hides the player's body at the holding spot while they choose.
local function holdPlayer()
    SetEntityCoords(cache.ped, HOLD.x, HOLD.y, HOLD.z, false, false, false, false)
    FreezeEntityPosition(cache.ped, true)
    SetEntityVisible(cache.ped, false, false)
    DisplayRadar(false)
end

---Closes the screen and gives the game back its own camera.
local function closeScreen()
    open = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })

    RenderScriptCams(false, false, 0, true, true)
    if cam then DestroyCam(cam, false) end
    cam = nil
    ClearFocus()
end

---Puts the player at the chosen spawn point. Same steps, same order as qbx_spawn.
---@param index integer
local function spawnAt(index)
    local spawn = spawns[index]
    if not spawn or busy then return end
    busy = true

    DoScreenFadeOut(1000)
    while not IsScreenFadedOut() do Wait(0) end

    closeScreen()

    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    FreezeEntityPosition(cache.ped, false)
    SetEntityVisible(cache.ped, true, false)
    DisplayRadar(true)

    if spawn.propertyId then
        TriggerServerEvent('qbx_properties:server:enterProperty', { id = spawn.propertyId, isSpawn = true })
    else
        RequestCollisionAtCoord(spawn.coords.x, spawn.coords.y, spawn.coords.z)
        SetEntityCoords(cache.ped, spawn.coords.x, spawn.coords.y, spawn.coords.z, false, false, false, false)
        SetEntityHeading(cache.ped, spawn.coords.w)
    end

    Wait(500)
    DoScreenFadeIn(1000)
    busy = false
end

---Builds the list of cards: where you left off, your job's places, public places, your homes.
---@return table[] spawns
local function buildSpawns()
    local list = {}

    local lastCoords, lastPropertyId = lib.callback.await('qbx_spawn:server:getLastLocation')
    local last = toVec4(lastCoords)
    if last then
        list[#list + 1] = {
            kind = 'continue',
            label = locale('last_location'),
            detail = locale('last_location_detail'),
            coords = last,
            propertyId = lastPropertyId,
        }
    end

    for i = 1, #config.spawns do
        local spawn = config.spawns[i]
        if not spawn.jobs or exports.dps_lib:HasJob(spawn.jobs, nil, spawn.onDuty) then
            list[#list + 1] = {
                kind = spawn.jobs and 'job' or 'public',
                label = spawn.label,
                detail = spawn.detail,
                coords = spawn.coords,
            }
        end
    end

    local properties = lib.callback.await('qbx_spawn:server:getProperties') or {}
    for i = 1, #properties do
        local coords = toVec4(properties[i].coords)
        if coords then
            list[#list + 1] = {
                kind = 'home',
                label = properties[i].label,
                detail = locale('home_detail'),
                coords = coords,
                propertyId = properties[i].propertyId,
            }
        end
    end

    return list
end

---qbx_core passes a citizen id for an existing character and a table of form answers for a new one.
RegisterNetEvent('qb-spawn:client:setupSpawns', function(character)
    if open then return end
    open = true
    busy = true

    local isNew = type(character) == 'table'
    spawns = buildSpawns()

    Wait(400)
    holdPlayer()

    local cards = {}
    for i = 1, #spawns do
        cards[i] = { kind = spawns[i].kind, label = spawns[i].label, detail = spawns[i].detail }
    end

    local charinfo = QBX.PlayerData and QBX.PlayerData.charinfo
    local welcome = isNew and config.welcome.enabled

    if welcome then
        SendNUIMessage({ action = 'welcome', serverName = config.serverName, firstName = charinfo and charinfo.firstname })
        welcomeFlight()
    else
        cam = createCameraFor(spawns[1].coords)
        SetFocusPosAndVel(spawns[1].coords.x, spawns[1].coords.y, spawns[1].coords.z, 0.0, 0.0, 0.0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)
        Wait(500)
        DoScreenFadeIn(1500)
    end

    busy = false
    SendNUIMessage({ action = 'open', serverName = config.serverName, spawns = cards, theme = exports.dps_lib:GetTheme() })
    SetNuiFocus(true, true)
end)

-- The screen tells us which card the player is on, and which one they picked. Lua lists start
-- at 1 and the page counts from 0, so add one.
RegisterNUICallback('look', function(data, cb)
    cb(1)
    if open then CreateThread(function() lookAt((tonumber(data.index) or 0) + 1) end) end
end)

RegisterNUICallback('spawn', function(data, cb)
    cb(1)
    if open then CreateThread(function() spawnAt((tonumber(data.index) or 0) + 1) end) end
end)

-- If this resource is restarted while the screen is up, do not leave the player hidden and frozen.
AddEventHandler('onResourceStop', function(resource)
    if resource ~= cache.resource or not open then return end
    closeScreen()
    FreezeEntityPosition(cache.ped, false)
    SetEntityVisible(cache.ped, true, false)
    DisplayRadar(true)
    DoScreenFadeIn(0)
end)
