-- dps_jobs: hands the DPS job list to qbx_core when the server starts.
--
-- qbx_core has an export for exactly this, so its own shared/jobs.lua is never edited and a
-- qbx_core update cannot wipe the DPS jobs. The second argument is false on purpose: it stops
-- qbx_core writing these jobs into its own file.

local jobs = lib.load('data.jobs')

local count = 0
for _ in pairs(jobs) do count += 1 end

local ok, problem = exports.qbx_core:CreateJobs(jobs, false)
local version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)

if ok then
    print(('^2[dps_jobs]^7 v%s ready: %d jobs added to qbx_core'):format(version, count))
else
    print(('^1[dps_jobs]^7 v%s: %s'):format(version, problem))
end
