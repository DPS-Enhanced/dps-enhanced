# ox_inventory item list

Files that go on top of a stock [ox_inventory](https://github.com/overextended/ox_inventory).
They replace its item list with the DPS one.

## What is in here

| File | What it is |
|---|---|
| `data/items.lua` | A small loader. It builds the item list from the two files below. |
| `data/items_legacy.lua` | The full DPS item list, about 1,700 items. |
| `data/items_dps.lua` | The rules: which of those items load, which wait, and which are retired. |

## Install

1. Copy the three files into `ox_inventory/data/`. Say yes to replacing `items.lua`.
   Keep a copy of the stock `items.lua` first if you have changed it.
2. Restart the server.
3. Look for this line in the console:

```
[dps] items: 1095 from the DPS list, 9 new, 485 held, 153 dropped
```

## Change what loads

Open `data/items_dps.lua`. Every item is in one of three groups:

- **keep**: it loads. Anything not named in the file is kept.
- **hold**: it is waiting for a script that uses it, for example drugs or mechanic parts. To bring
  an item back, take its name or pattern out of `hold` and restart.
- **drop**: old names that ox_inventory already covers.

One rule needs no list: an item wired to a script that is not on your server is held, and loads by
itself the day you install that script.

To add a brand new item, put it in the `add` block at the bottom of `items_dps.lua`.

## Pictures

Item pictures are not in this repo. Each item needs a picture named after it in
`ox_inventory/web/images/`, for example `water.png`.
