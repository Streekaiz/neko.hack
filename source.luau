local Repository : string = "neko.hack"
local Author : string = "Streekaiz"
local Url : string = ""

local LoadedModules : {[string] : any} = {}
local Modules : {string} = { -- // Load independent files first
    "Services",
    "Signals",
    "String",
    "Miscallaenous",
    "Instances",
    "Players"
}

local Environment = getgenv() or _G or {}

