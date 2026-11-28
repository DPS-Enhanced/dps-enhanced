return {
    -- The words at the top of the spawn screen.
    serverName = 'Del Perro Sands',

    -- A brand new character gets a welcome line and a slow flight down to the first spawn point.
    welcome = {
        enabled = true,
        -- Where the flight starts: high over the city.
        from = vec3(-420.0, -1650.0, 620.0),
        lookAt = vec3(-75.0, -820.0, 300.0),
        flightMs = 9000,
    },

    -- The camera that looks at each spawn point while you choose.
    camera = {
        distance = 38.0,   -- metres behind the spawn point
        height = 22.0,     -- metres above it
        fov = 50.0,
        glideMs = 1800,    -- how long the glide between two nearby spawn points takes
        cutDistance = 900, -- further apart than this (metres): fade and cut, no glide across the map
    },

    -- Spawn points everyone, or only some jobs, can pick.
    --   label   the name on the card
    --   detail  the small line under it (optional)
    --   coords  vec4(x, y, z, heading)
    --   jobs    who sees it (optional). A job name, a list, or { name = minimum grade }.
    --           Leave it out and everyone sees the card.
    --   onDuty  true = only while on duty (optional)
    spawns = {
        {
            label = 'Legion Square',
            detail = 'City centre',
            coords = vec4(195.17, -933.77, 29.7, 144.5),
        },
        {
            label = 'Paleto Bay',
            detail = 'North county',
            coords = vec4(80.35, 6424.12, 31.67, 45.5),
        },
        {
            label = 'Motels',
            detail = 'Hawick',
            coords = vec4(327.56, -205.08, 53.08, 163.5),
        },
        {
            label = 'Mission Row Police Station',
            detail = 'Police',
            coords = vec4(428.23, -984.28, 29.76, 3.5),
            jobs = 'police',
        },
        {
            label = 'Pillbox Hill Medical Center',
            detail = 'Ambulance',
            coords = vec4(295.83, -584.56, 43.26, 70.0),
            jobs = 'ambulance',
        },

        -- TODO(human): the real DPS spawn points go here. See "Add a spawn point" in the README.
    },
}
