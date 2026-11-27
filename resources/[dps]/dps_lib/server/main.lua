-- dps_lib, server side.
-- For everything Qbox already does (GetPlayer, AddMoney, RemoveMoney, HasGroup, Notify) call
-- exports.qbx_core directly. This file only adds what Qbox has no single call for.

---@param source integer
---@return table? PlayerData or nil if the player has no character loaded
local function playerData(source)
    local player = exports.qbx_core:GetPlayer(source)
    return player and player.PlayerData or nil
end

---Does this player hold the job, at the grade, and (if asked) on duty?
---@param source integer
---@param wanted string | string[] | table<string, number>
---@param minGrade? number
---@param needDuty? boolean
---@return boolean
exports('HasJob', function(source, wanted, minGrade, needDuty)
    local data = playerData(source)
    return data ~= nil and JobMatches(data.job, wanted, minGrade, needDuty)
end)

---The citizen ID is the key to store against. Never store the server ID: FiveM for GTAV Enhanced
---hands a server ID to the next player as soon as the first one leaves.
---@param source integer
---@return string? citizenid
exports('GetCitizenId', function(source)
    local data = playerData(source)
    return data and data.citizenid or nil
end)

---@param source integer
---@return string? "Firstname Lastname" of the loaded character
exports('GetFullName', function(source)
    local data = playerData(source)
    if not data or not data.charinfo then return nil end
    return ('%s %s'):format(data.charinfo.firstname, data.charinfo.lastname)
end)

exports('GetTheme', GetTheme)
exports('JobMatches', JobMatches)

-- Self-check at start: proves the rule in shared/job.lua on this server build, with no player needed.
CreateThread(function()
    local cop = { name = 'police', onduty = true, grade = { level = 2 } }
    local offDuty = { name = 'police', onduty = false, grade = { level = 2 } }
    local checks = {
        JobMatches(cop, 'police') == true,
        JobMatches(cop, 'ambulance') == false,
        JobMatches(cop, 'police', 3) == false,
        JobMatches(cop, { 'sheriff', 'police' }, 2) == true,
        JobMatches(cop, { police = 2 }) == true,
        JobMatches(cop, { police = 3 }) == false,
        JobMatches(offDuty, 'police', 0, true) == false,
        JobMatches(nil, 'police') == false,
        select('#', HexToRgb(DpsTheme.accent)) == 3 and HexToRgb(DpsTheme.accent) == 255,
    }
    local passed = 0
    for i = 1, #checks do if checks[i] then passed = passed + 1 end end
    local colour = passed == #checks and '^2' or '^1'
    print(('%s[dps_lib]^7 v%s ready, self-check %d/%d'):format(colour, GetResourceMetadata(GetCurrentResourceName(), 'version', 0), passed, #checks))
end)
