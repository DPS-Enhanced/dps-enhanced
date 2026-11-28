-- DPS item rules for ox_inventory.
--
-- data/items_legacy.lua is the item list from the old DPS server, unchanged (1,662 items).
-- This file decides which of those load. Nothing is deleted: to bring an item back, take its
-- name or pattern out of `hold`. To retire one for good, move it to `drop`.
--
--   keep  everything not matched below
--   hold  waiting for a script that uses it (drugs, mechanic, hunting, paid-script items)
--   drop  old names that ox_inventory already covers, and junk
--
-- Automatic, no list needed: an item whose `export` points at a resource that is not on this
-- server is held, and loads by itself the day that resource is installed.

return {
    -- Always loaded, whatever the lists below say.
    keep = {
        cocacola = true, cocomilk = true, coconut = true, seaweed = true, crackpipe = true,
        cleaning_kit = true, cleaningkit = true, corn_seed = true, lettuce_seed = true,
        potato_seed = true, tomato_seed = true, nitrous = true, repair_kit = true,
        casino_coke = true,
    },

    drop = {
        names = {
            'job', 'weapons', 'default', 'arms', 'ears', 'torso', 'drive',
            'pistol_compensator', 'pistol_ammo', 'rifle_ammo', 'smg_ammo', 'shotgun_ammo',
            'mg_ammo', 'snp_ammo', 'emp_ammo', 'rpg_ammo', 'police_rifle_ammo',
        },
        -- Lua patterns, matched against the item name.
        patterns = {
            '^at_', '^ammo_',                       -- data/weapons.lua owns attachments and ammo
            'weapontint', '_attachment$', '_attachmemt$',
            '_defaultclip$', '_extendedclip$', '_holoscope$', '_smallscope$', '_largescope$',
            '^smg_scope$', '^sniper_scope$', '_squaredmuzzle$',
            '^pistol_', '^rifle_', '^smg_', '^shotgun_', '^sniper_',
        },
        -- Every item the old inventory filed under this category.
        categories = { weapons = true },
    },

    hold = {
        names = {
            -- Mechanic (was jg-mechanic)
            'nitrous_bottle', 'nitrous_install_kit', 'empty_nitrous_bottle', 'turbocharger',
            'tunerchip', 'stancing_kit', 'respray_kit', 'drift_tuning_kit', 'extras_kit',
            'tyre_smoke_kit', 'tyre_replacement', 'clutch_replacement', 'brakepad_replacement',
            'cosmetic_part', 'performance_part', 'suspension_parts', 'spark_plug', 'air_filter',
            'engine_oil', 'manual_gearbox', 'vehicle_wheels', 'mechanic_tablet', 'v8engine',
            'lighting_controller',
            -- Drugs (was rcore_drugs and others)
            'oxy', 'perc15', 'ephedrine', 'pseudoephedrine', 'pseudoephedrine_boxes',
            'rolling_paper', 'empty_baggies', 'chemical_agent', 'coolant_canister', 'fertilizer',
            'industrial_solvent', 'lab_filter_cartridge', 'purification_agent', 'red_phosphorus',
            'prop_weed_tub_01b', 'amethyst_geode', 'm_budweiser', 'coughsyrup', 'jollyranchers',
            -- Quasar fishing, mining, lumberjack, treasure, garbage, housing, motels, books
            'wooden_rod', 'carbon_rod', 'composite_rod', 'tournament_rod', 'master_rod',
            'fishing_kit', 'grasshopper', 'monofilament_reel', 'fluorocarbon_line', 'crab_trap',
            'deepsea_net', 'dive_tank', 'skewer_grill_boat', 'boot',
            'pickaxe_rusty', 'pickaxe_stone', 'pickaxe_iron', 'pickaxe_steel', 'pickaxe_diamond',
            'pickaxe_mythical', 'pinewood_plank', 'oakwood_plank', 'maplewood_plank',
            'pet_food', 'pet_water', 'motelkey', 'book',
            -- Wasabi police, ambulance, billing, gang wars, crutch
            'cuff_key', 'bolt_cutter', 'flush_cutter', 'soft_cuffs', 'evidence_bag_full',
            'gsr_kit', 'breathalyzer', 'radar_post', 'spike_strip', 'bodycam', 'cctv_camera',
            'police_cone', 'police_barrier', 'police_radio', 'invoice', 'wartablet', 'pt_kit',
            -- rcore prison, camping, DJ; other paid scripts
            'sludgie', 'prison_tablet', 'tent_1', 'tent_2', 'chair_1', 'chair_2', 'chair_3',
            'gazebo_1', 'gazebo_2', 'gazebo_3', 'fireplace', 'flint', 'mixer', 'tv_remote',
            'kq_airdrop_flare', 'taser_cartridge', 'insurance_check_tablet', 'boss_tablet',
            'meteo_bmxpapers', 'hotdogstand', 'basketball_hoop',
        },
        patterns = {
            -- Engine swaps (dps-enginesounds, jg-mechanic)
            '_tyres$', '_brakes$', '^transmission_', '_drivetrain$', '_engine$', '^ev_',
            -- Drugs
            'weed', 'coke', 'coca', 'meth', 'xtc', '^crack', '^lean', '^joint$',
            '_leaf$', '_bud$', '_ql$', '^acapulcogold', '^colombiangold', '^dosidos',
            '^lemonskunk', '^northernlights', '^percocet', '^vicodin', '^morphine',
            -- Hunting
            '^taxidermy_', 'hide$', 'horns$', 'leather$', 'bait$', '_pelt$',
            -- Small paid scripts
            '^gunrack_', '^mz', '^prop_', '^beerkeg',
        },
        -- Text the item's description starts with.
        descriptions = { 'Engine swap' },
        -- Items the old inventory never labelled: label and description are just the name.
        unlabelledParts = true,
    },

    -- New on the Enhanced server.
    add = {
        ['phone_black'] = {
            label = 'Black Phone',
            weight = 190,
            stack = false,
            close = true,
            consume = 0,
            description = 'A smartphone.',
            server = { export = 'sd-phone.usePhone_black' },
        },

        -- sd-tablet: one item per frame colour. The MDT terminals (police, EMS, DOJ) live on it.
        ['tablet'] = { label = 'Tablet', weight = 700, stack = false, close = true, description = 'A tablet. Everything your phone does, except calls.', client = { image = 'tablet_black.png' }, server = { export = 'sd-tablet.useTablet' } },
        ['tablet_black'] = { label = 'Black Tablet', weight = 700, stack = false, close = true, description = 'A tablet. Everything your phone does, except calls.', client = { image = 'tablet_black.png' }, server = { export = 'sd-tablet.useTablet_black' } },
        ['tablet_blue'] = { label = 'Blue Tablet', weight = 700, stack = false, close = true, description = 'A tablet. Everything your phone does, except calls.', client = { image = 'tablet_blue.png' }, server = { export = 'sd-tablet.useTablet_blue' } },
        ['tablet_green'] = { label = 'Green Tablet', weight = 700, stack = false, close = true, description = 'A tablet. Everything your phone does, except calls.', client = { image = 'tablet_green.png' }, server = { export = 'sd-tablet.useTablet_green' } },
        ['tablet_orange'] = { label = 'Orange Tablet', weight = 700, stack = false, close = true, description = 'A tablet. Everything your phone does, except calls.', client = { image = 'tablet_orange.png' }, server = { export = 'sd-tablet.useTablet_orange' } },
        ['tablet_pink'] = { label = 'Pink Tablet', weight = 700, stack = false, close = true, description = 'A tablet. Everything your phone does, except calls.', client = { image = 'tablet_pink.png' }, server = { export = 'sd-tablet.useTablet_pink' } },
        ['tablet_purple'] = { label = 'Purple Tablet', weight = 700, stack = false, close = true, description = 'A tablet. Everything your phone does, except calls.', client = { image = 'tablet_purple.png' }, server = { export = 'sd-tablet.useTablet_purple' } },
        ['tablet_red'] = { label = 'Red Tablet', weight = 700, stack = false, close = true, description = 'A tablet. Everything your phone does, except calls.', client = { image = 'tablet_red.png' }, server = { export = 'sd-tablet.useTablet_red' } },
        ['tablet_yellow'] = { label = 'Yellow Tablet', weight = 700, stack = false, close = true, description = 'A tablet. Everything your phone does, except calls.', client = { image = 'tablet_yellow.png' }, server = { export = 'sd-tablet.useTablet_yellow' } },
    },
}
