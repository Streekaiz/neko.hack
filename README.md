# neko
A open source extension written in LUAU.

For any questions/inquiries, DM @streekaiz on Discord (responses will be a bit late).
## loader (incomplete)
```lua
local Environment : {[any] : any} = getgenv()
local Author : string = "Streekaiz"
local Repository : string = "neko.hack"
local LoadTick : number = tick()

local StringFormat : (any) = string.format
local Debug = function(Data : string)
    if Environment["DEBUG"] then 
        warn(Data)
    end
end

local Modules : {string} = {
    "Cats",
    "Services",
    "Signals",
    "String",
    "Miscallaenous",
    "Instances",
    "Players"
}

Environment["Neko"] = {}

for Index, Module in next, Modules do 
    local Success : boolean = false 
    local Source: (() -> any)

    Success, Source = pcall(function()
        return loadstring(
            game:HttpGet(
                StringFormat('https://raw.githubusercontent.com/%s/%s/main/modules/%s.luau', Author, Repository, Module)
            ), Module
        ) 
    end)

    if not Success then 
        Debug(StringFormat("Failed to fetch %s.luau", Module))
        Debug(StringFormat("Error Message: %s", tostring(Source)))
        continue 
    end

    Environment["Neko"][Module] = Source()
    Debug(StringFormat("Loaded %s in %s milliseconds", LoadTick - tick()))
end

return Environment["Neko"] -- // yippee!
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