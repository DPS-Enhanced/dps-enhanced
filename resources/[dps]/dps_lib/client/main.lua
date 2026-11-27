-- dps_lib, client side.
-- For everything Qbox already does (GetPlayerData, HasGroup, Notify) call exports.qbx_core directly.

---Does the local player hold the job, at the grade, and (if asked) on duty?
---@param wanted string | string[] | table<string, number>
---@param minGrade? number
---@param needDuty? boolean
---@return boolean
exports('HasJob', function(wanted, minGrade, needDuty)
    local data = exports.qbx_core:GetPlayerData()
    return data ~= nil and JobMatches(data.job, wanted, minGrade, needDuty)
end)

exports('GetTheme', GetTheme)
exports('JobMatches', JobMatches)
