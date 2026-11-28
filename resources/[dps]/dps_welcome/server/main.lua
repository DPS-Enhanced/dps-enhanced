-- dps_welcome, server side. The two lookups below are qbx_spawn's, unchanged in what they return.

lib.callback.register('qbx_spawn:server:getLastLocation', function(source)
    local player = exports.qbx_core:GetPlayer(source)
    local queryResult = MySQL.single.await('SELECT position FROM players WHERE citizenid = ?', { player.PlayerData.citizenid })
    local position = queryResult and json.decode(queryResult.position)
    local currentPropertyId = player.PlayerData.metadata.currentPropertyId

    return position, currentPropertyId
end)

lib.callback.register('qbx_spawn:server:getProperties', function(source)
    if not GetResourceState('qbx_properties'):find('start') then
        return {}
    end

    local player = exports.qbx_core:GetPlayer(source)
    local houseData = {}
    local properties = MySQL.query.await('SELECT id, property_name, coords FROM properties WHERE owner = ?', { player.PlayerData.citizenid })

    for i = 1, #properties do
        local property = properties[i]

        houseData[#houseData + 1] = {
            label = property.property_name,
            coords = json.decode(property.coords),
            propertyId = property.id,
        }
    end

    return houseData
end)

-- Loading screen: hand the player's name to the page while they are still connecting, so it can
-- greet them. From bd_loadingscreen.
AddEventHandler('playerConnecting', function(_, _, deferrals)
    deferrals.handover({ name = GetPlayerName(source) })
end)

-- Boot self-check. qbx_core only opens the spawn screen if a resource called qbx_spawn reports
-- as started, so say plainly at boot whether our `provide 'qbx_spawn'` line is doing that job.
CreateThread(function()
    Wait(1000)
    local state = GetResourceState('qbx_spawn')
    local version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)

    if state:find('start') then
        print(('^2[dps_welcome]^7 v%s ready, answering as qbx_spawn (%s)'):format(version, state))
    else
        print(('^1[dps_welcome]^7 v%s started, but qbx_spawn reports "%s". qbx_core will not open the spawn screen.'):format(version, state))
    end
end)
