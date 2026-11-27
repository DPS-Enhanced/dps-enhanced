-- One question many DPS resources ask: "does this player hold job X, at grade Y or above, and are
-- they on duty?" Qbox answers the job and grade part with HasGroup, but has no single call that
-- also checks duty. This file holds the rule; server/main.lua and client/main.lua feed it the
-- player's job.
--
-- It is a pure function (no natives, no exports), so it can be checked without a player online.

---@param job { name: string, onduty: boolean, grade: { level: number } }? the player's job from Qbox PlayerData
---@param wanted string | string[] | table<string, number> a job name, a list of names, or { name = minGrade }
---@param minGrade? number lowest grade allowed when `wanted` is a name or a list (default 0)
---@param needDuty? boolean true = must also be on duty
---@return boolean
function JobMatches(job, wanted, minGrade, needDuty)
    if type(job) ~= 'table' or not job.name then return false end
    if needDuty and not job.onduty then return false end

    local level = job.grade and job.grade.level or 0

    if type(wanted) == 'string' then
        return job.name == wanted and level >= (minGrade or 0)
    end

    if type(wanted) ~= 'table' then return false end

    -- { police = 2, sheriff = 0 }
    local need = wanted[job.name]
    if type(need) == 'number' then return level >= need end

    -- { 'police', 'sheriff' }
    for i = 1, #wanted do
        if wanted[i] == job.name then return level >= (minGrade or 0) end
    end

    return false
end
