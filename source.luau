local Author: string = "Streekaiz"
local Repository: string = "neko.hack"

local Modules : {string} = { -- // Load independent files first
    "Services",
    "Signals",
    "String",
    "Miscallaenous",
    "Instances",
    "Players"
}

local Environment : {[any] : any} = getgenv() or _G or {} 

Environment["Neko"] = {}

for Index, Module in next, Modules do 
    local Success : boolean = false 
    local Source: (() -> any)

    Success, Source = pcall(function()
        return loadstring(game:HttpGet(string.format("https://raw.githubusercontent.com/%s/%s/main/modules/%s.luau", Author, Repository, Module)))
    end)

    if not Success then 
        print("Failed to fetch " .. Module .. ".luau")
        print(string.format("Error Message: %s", tostring(Source)))
        continue 
    end

    print("Loading Module: " .. Module)

    Environment["Neko"][Module] = Source()

    print("Loaded Module " .. Module)
    for i, v in next, Environment["Neko"] do 
        print(i, v)
    end 
end

Environment["Neko"].Build = "Public"
Environment["Neko"].UID = 0
Environment["Neko"].Version = 1.00

return Environment["Neko"]