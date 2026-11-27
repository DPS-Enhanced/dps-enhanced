-- The DPS look, in one place. Every DPS resource that draws something reads its colours from here
-- (Lua) or from web/dps.css (NUI pages), so a server owner changes the look once.
--
-- To restyle the whole suite: change the values below AND the matching variables in web/dps.css.

DpsTheme = {
    -- panels
    navy    = '#0e1a2b', -- main panel
    navy2   = '#152539', -- rows inside a panel
    navy3   = '#1b2e45', -- input fields
    line    = '#2b4057', -- thin dividing lines
    -- text
    cream   = '#f2ead9', -- main text
    dim     = '#a8b8c9', -- labels and secondary text
    -- accents
    accent  = '#ff7a45', -- the one action, outlines, icons
    accent2 = '#ffb088', -- focus ring, hover
    -- state colours for notices
    success = '#4ec9b0',
    warning = '#ffb088',
    error   = '#ff5a5a',
    -- type
    font    = 'Roboto, Arial, sans-serif',
    radius  = 12, -- panel corner radius in px
}

---Returns a copy, so a caller cannot change the shared table by accident.
---@return table<string, string|number>
function GetTheme()
    local copy = {}
    for k, v in pairs(DpsTheme) do copy[k] = v end
    return copy
end

---Converts '#rrggbb' to r, g, b numbers (0-255) for natives such as DrawRect or SetTextColour.
---@param hex string
---@return integer r, integer g, integer b
function HexToRgb(hex)
    hex = hex:gsub('#', '')
    return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end
