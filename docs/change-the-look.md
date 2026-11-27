# Change the look

The DPS colours live in one resource, `dps_lib`, in two files. Change both and every DPS resource
that uses them follows.

| File | Used by |
|---|---|
| `resources/[dps]/dps_lib/shared/theme.lua` | Lua code |
| `resources/[dps]/dps_lib/web/dps.css` | Web pages (menus and panels) |

## The colours

| Name | Default | Where you see it |
|---|---|---|
| `navy` | `#0e1a2b` | Main panels |
| `navy2` | `#152539` | Rows inside a panel |
| `navy3` | `#1b2e45` | Input fields |
| `line` | `#2b4057` | Thin dividing lines |
| `cream` | `#f2ead9` | Main text |
| `dim` | `#a8b8c9` | Labels |
| `accent` | `#ff7a45` | The main button, outlines, icons |
| `accent2` | `#ffb088` | Focus ring and hover |

## Steps

1. Open `shared/theme.lua` and change the values.
2. Open `web/dps.css` and change the variables with the same names at the top.
3. Restart the server.

## For script writers

In a web page, load the shared style sheet:

```html
<link rel="stylesheet" href="https://cfx-nui-dps_lib/web/dps.css">
```

Then use the classes `dps-panel`, `dps-row`, `dps-label`, `dps-input`, `dps-button` and
`dps-button--main`.

In Lua:

```lua
local theme = exports.dps_lib:GetTheme()
print(theme.accent) -- #ff7a45
```
