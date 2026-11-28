-- The DPS job list. Same shape as qbx_core's shared/jobs.lua.
--
--   label        the name players see
--   type         what kind of job it is: 'leo' (law enforcement), 'ems', 'military'.
--                Other scripts use this to decide who counts as police or medical.
--   grades       the ranks, lowest first. `payment` is the pay per paycheck.
--   isboss       this rank can hire, fire and promote
--   bankAuth     this rank can use the department's bank account
--
-- A job here with the same name as one in qbx_core replaces it.

---@type table<string, Job>
return {
    -- ---------- Law enforcement ----------

    ['police'] = {
        label = 'Los Santos Police Department',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Cadet', payment = 75 },
            [1] = { name = 'Probationary Officer', payment = 90 },
            [2] = { name = 'Police Officer', payment = 105 },
            [3] = { name = 'Field Training Officer', payment = 120 },
            [4] = { name = 'Corporal', payment = 135 },
            [5] = { name = 'Sergeant', payment = 155 },
            [6] = { name = 'Lieutenant', payment = 175 },
            [7] = { name = 'Captain', payment = 195 },
            [8] = { name = 'Commander', payment = 215 },
            [9] = { name = 'Deputy Chief', payment = 222 },
            [10] = { name = 'Assistant Chief', payment = 230 },
            [11] = { name = 'Chief of Police', isboss = true, bankAuth = true, payment = 240 },
        },
    },

    ['bcso'] = {
        label = 'Blaine County Sheriff\'s Office',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Cadet', payment = 75 },
            [1] = { name = 'Probationary Deputy', payment = 90 },
            [2] = { name = 'Deputy Sheriff', payment = 105 },
            [3] = { name = 'Senior Deputy', payment = 120 },
            [4] = { name = 'Corporal', payment = 135 },
            [5] = { name = 'Sergeant', payment = 155 },
            [6] = { name = 'Lieutenant', payment = 175 },
            [7] = { name = 'Captain', payment = 195 },
            [8] = { name = 'Undersheriff', payment = 215 },
            [9] = { name = 'Sheriff', isboss = true, bankAuth = true, payment = 235 },
        },
    },

    ['sasp'] = {
        label = 'San Andreas Highway Patrol',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Cadet', payment = 75 },
            [1] = { name = 'Probationary Trooper', payment = 90 },
            [2] = { name = 'Trooper', payment = 105 },
            [3] = { name = 'Senior Trooper', payment = 120 },
            [4] = { name = 'Corporal', payment = 135 },
            [5] = { name = 'Sergeant', payment = 155 },
            [6] = { name = 'Lieutenant', payment = 175 },
            [7] = { name = 'Captain', payment = 195 },
            [8] = { name = 'Assistant Commissioner', payment = 215 },
            [9] = { name = 'Commissioner', isboss = true, bankAuth = true, payment = 235 },
        },
    },

    ['fib'] = {
        label = 'Federal Investigation Bureau',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Academy Trainee', payment = 86 },
            [1] = { name = 'Special Agent', payment = 121 },
            [2] = { name = 'Senior Special Agent', payment = 138 },
            [3] = { name = 'Supervisory Special Agent', payment = 178 },
            [4] = { name = 'Assistant Special Agent in Charge', payment = 224 },
            [5] = { name = 'Special Agent in Charge', payment = 247 },
            [6] = { name = 'Deputy Director', payment = 262 },
            [7] = { name = 'Director', isboss = true, bankAuth = true, payment = 285 },
        },
    },

    ['doc'] = {
        label = 'Department of Corrections',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'CO Trainee', payment = 75 },
            [1] = { name = 'Corrections Officer', payment = 105 },
            [2] = { name = 'Senior Corrections Officer', payment = 120 },
            [3] = { name = 'Corporal', payment = 135 },
            [4] = { name = 'Sergeant', payment = 155 },
            [5] = { name = 'Lieutenant', payment = 175 },
            [6] = { name = 'Captain', payment = 195 },
            [7] = { name = 'Deputy Warden', payment = 215 },
            [8] = { name = 'Warden', isboss = true, bankAuth = true, payment = 230 },
        },
    },

    ['dfw'] = {
        label = 'Department of Fish & Wildlife',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Warden Cadet', payment = 75 },
            [1] = { name = 'Park Ranger', payment = 100 },
            [2] = { name = 'Game Warden', payment = 110 },
            [3] = { name = 'Senior Warden', payment = 120 },
            [4] = { name = 'Warden Sergeant', payment = 155 },
            [5] = { name = 'Warden Lieutenant', payment = 175 },
            [6] = { name = 'Chief Game Warden', isboss = true, bankAuth = true, payment = 225 },
        },
    },

    ['uscg'] = {
        label = 'Coast Guard',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Seaman Recruit', payment = 75 },
            [1] = { name = 'Seaman', payment = 90 },
            [2] = { name = 'Petty Officer', payment = 105 },
            [3] = { name = 'Chief Petty Officer', payment = 120 },
            [4] = { name = 'Ensign', payment = 135 },
            [5] = { name = 'Lieutenant', payment = 155 },
            [6] = { name = 'Commander', payment = 175 },
            [7] = { name = 'Captain', isboss = true, bankAuth = true, payment = 195 },
        },
    },

    ['natguard'] = {
        label = 'National Guard',
        type = 'military',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Private', payment = 75 },
            [1] = { name = 'Specialist', payment = 90 },
            [2] = { name = 'Sergeant', payment = 105 },
            [3] = { name = 'Staff Sergeant', payment = 120 },
            [4] = { name = 'Lieutenant', payment = 135 },
            [5] = { name = 'Captain', payment = 155 },
            [6] = { name = 'Major', payment = 175 },
            [7] = { name = 'Colonel', isboss = true, bankAuth = true, payment = 195 },
        },
    },

    -- ---------- Medical and fire ----------

    -- The ambulance service: field care.
    ['sams'] = {
        label = 'San Andreas Medical Services',
        type = 'ems',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'EMT Trainee', payment = 75 },
            [1] = { name = 'EMT', payment = 95 },
            [2] = { name = 'Advanced EMT', payment = 115 },
            [3] = { name = 'Paramedic', payment = 135 },
            [4] = { name = 'Senior Paramedic', payment = 155 },
            [5] = { name = 'Field Supervisor', payment = 180 },
            [6] = { name = 'Chief of EMS', isboss = true, bankAuth = true, payment = 205 },
        },
    },

    -- The Los Santos hospital: clinical staff.
    ['lsmc'] = {
        label = 'Los Santos Medical Center',
        type = 'ems',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Orderly', payment = 70 },
            [1] = { name = 'Nurse', payment = 110 },
            [2] = { name = 'Charge Nurse', payment = 140 },
            [3] = { name = 'Physician', payment = 180 },
            [4] = { name = 'Surgeon', payment = 215 },
            [5] = { name = 'Chief of Medicine', isboss = true, bankAuth = true, payment = 245 },
        },
    },

    ['lsfd'] = {
        label = 'Los Santos Fire Department',
        type = 'ems',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Probationary Firefighter', payment = 75 },
            [1] = { name = 'Firefighter', payment = 105 },
            [2] = { name = 'Senior Firefighter', payment = 120 },
            [3] = { name = 'Engineer', payment = 135 },
            [4] = { name = 'Lieutenant', payment = 155 },
            [5] = { name = 'Captain', payment = 175 },
            [6] = { name = 'Battalion Chief', payment = 195 },
            [7] = { name = 'Deputy Chief', payment = 215 },
            [8] = { name = 'Fire Chief', isboss = true, bankAuth = true, payment = 230 },
        },
    },

    -- ---------- Justice ----------

    ['judge'] = {
        label = 'Honorary',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Judge', payment = 100 },
        },
    },

    ['lawyer'] = {
        label = 'Law Firm',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Paralegal', payment = 50 },
            [1] = { name = 'Lawyer', isboss = true, bankAuth = true, payment = 100 },
        },
    },

    -- Prosecutors: case files from detectives, charges filed with the judge.
    ['da'] = {
        label = "District Attorney's Office",
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Paralegal', payment = 50 },
            [1] = { name = 'Assistant DA', payment = 75 },
            [2] = { name = 'Deputy DA', payment = 100 },
            [3] = { name = 'District Attorney', isboss = true, bankAuth = true, payment = 125 },
        },
    },
}
