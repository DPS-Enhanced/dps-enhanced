return {
    -- How far a voice carries, in metres. A player switches between these with rangeKey.
    -- Add or remove lines as you like; each one becomes its own voice channel.
    ranges = {
        { name = 'Whisper', distance = 3.0 },
        { name = 'Normal',  distance = 7.0 },
        { name = 'Shout',   distance = 15.0 },
    },

    -- Which line of `ranges` a player starts on (2 = Normal).
    defaultRange = 2,

    -- Default keys. Each player can change them in Settings > Key Bindings > FiveM.
    rangeKey = 'F11',    -- press: next talking distance
    radioKey = 'CAPITAL',  -- hold: talk on the radio (Caps Lock). Left Alt is ox_target's key.

    -- Show a notice when the talking distance changes.
    notifyRange = true,
}
