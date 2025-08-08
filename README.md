# neko
A open source extension written in LUAU.

For any questions/inquiries, DM @streekaiz on Discord (responses will be a bit late).
## loader (incomplete)
```lua
local NekoInit = loadstring(game:HttpGet("https://raw.githubusercontent.com/Streekaiz/neko.hack/refs/heads/main/loader.luau"),
    [[
        author: @streekaizu
        repository: @neko.hack 
        description: 
            open source extension written in luau
            dm me on discord @streekaiz for any questions/inquiries
    ]]
)

if not game:IsLoaded() then 
    game.Loaded:Wait()
end 

NekoInit()
```

## info
To run this extension safely, your executor should support these functions:
```lua
cloneref -- // This isn't required; but will help you stay safe
gethui -- // This isn't required; but will help you stay safe
hookmetamethod -- // This is required for most features
newcclosure -- // This isn't required; but will help you stay safe (Most exploits already include newcclosures on hooks anyways)
mousemoverel -- // This is required for the aim asisst.
```

## api
The extension also has an API for developers to add custom support for other games; you can access it through a global (Neko).

API documentation hasn't been written yet; but it'll be wrote when development is fully/nearly finished.

## discord
There is no discord server; however it'll be linked here when one is made.