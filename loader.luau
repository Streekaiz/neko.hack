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
    "Players",
    "Interface"
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

Environment["Neko"].Build = "Public"
Environment["Neko"].UID = 0
Environment["Neko"].Version = 1.00

return Environment["Neko"] -- // yippee!