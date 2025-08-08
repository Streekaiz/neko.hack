local Environment : {[any] : any} = getgenv() or _G 
local Interface : {[any] : any} = Environment["Neko"]["Interface"]
local Library : {[any] : any} = Interface.Library 
local Esp : {[any] : any} = Interface.Esp

local Lighting : {[any] : any} = Environment["Neko"]["Services"]:Get("Lighting") -- any : any smh
local Players : Players = Environment["Neko"]["Services"]:Get("Players")

local LocalPlayer = Players.LocalPlayer 
local Camera = workspace.CurrentCamera 

local Old = {
    TimeOfDay = Lighting.TimeOfDay,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
    FieldOfView = Camera.FieldOfView
}

local Window : {[any] : any} = Library:Window({
    Name = "neko.hack",
    Size = UDim2.fromOffset(455, 605)
})

local Panel : {[any] : any} = Window:Panel({
    Name = "neko.cheat",
    ButtonName = "Window",
    Size = UDim2.fromOffset(550, 710),
    Position = UDim2.fromScale(0.5, 0.5)
}); do 
    local Tabs : {[string] : {any}} = {
        ["Combat"] = Panel:Tab({Name = "Combat"}),
        ["Visual"] = Panel:Tab({Name = "Visual"}),
        ["Miscallaenous"] = Panel:Tab({Name = "Misc"}),
        ["Settings"] = Library:Configs(Window, Panel:Tab({Name = "Settings"}))
    }

    local Tab : {[any] : any}
    local ExtrasensoryTab : {[any] : any}
    local Collumn : {[any] : any}
    local Section : {[any] : any}
    local Element : {[any] : any}

    Tab = Tabs["Combat"]
    Collumn = Tab:Column({Fill = true})
    Section = Collumn:Section({Name = "Aim Assist"})
    Section:Toggle({Flag = "aimAssistEnabled", Name = "Enabled", Tooltip = {Title = "Aim Assist", Text = "Curves your mouse towards the closest player.", Width = 100}}):Keybind({Flag = "aimAssistKey", Name = "Aim Assist", Mode = "Hold"})
    Section:Dropdown({Flag = "aimAssistMethod", Options = {"Mouse", "Camera"}, Default = "Mouse"})
    Section:Dropdown({Flag = "aimAssistTarget", Name = "Body Priority", Options = {"Head", "Torso", "Arms", "Legs"}, Default = {"Head", "Torso"}, Multi = true})
    Section:Toggle({Flag = "aimAssistSmoothingEnabled", Name = "Smoothing Assist", Tooltip = {Title = "Smoothing", Text = "Instead of instantly flicking; smoothes out the time to reach the player.", Width = 100}})
    Section:Slider({Flag = "aimAssistSmoothingX", Name = "X Factor", Min = 0, Max = 100, Default = 50, Suffix = "%", Decimals = 0.5})
    Section:Slider({Flag = "aimAssistSmoothingY", Name = "Y Factor", Min = 0, Max = 100, Default = 50, Suffix = "%", Decimals = 0.5})
    Section:Dropdown({Flag = "aimAssistStickyEnabled", Name = "Sticky Aim", Tooltip = {Title = "Sticky Aim Assist", Text = "Stops moving your mouse once it's onto the target."}})
    Section:Toggle({Flag = "aimAssistPredictionEnabled", Name = "Predict Target", Tooltip = {Title = "Prediction", Text = "Calculates the player's velocity to predict projectiles.", Width = 100}})
    Section:Dropdown({Flag = "aimAssistPredictionMethod", Options = {"Static", "Dynamic"}, Default = "Dynamic"})
    Section:Slider({Flag = "aimAssistPredictionX", Name = "X Factor", Min = 0, Max = 5, Default = 1, Suffix = "%", Decimals = 0.1})
    Section:Slider({Flag = "aimAssistPredictionY", Name = "Y Factor", Min = 0, Max = 5, Default = 1, Suffix = "%", Decimals = 0.1})
    Section:Toggle({Flag = "aimAssistDeadzoneEnabled", Name = "Dead Zone", Tooltip = {Title = "Dead Zone", Text = "Ignores players that are inside the deadzone radius.", Width = 100}})
    Section:Slider({Flag = "aimAssistDeadzoneRadius", Min = 0, Max = 360, Default = 180, Suffix = "°"})
    Section:Toggle({Flag = "aimAssistFovEnabled", Name = "Limit to FOV", Tooltip = {Title = "Field Of View", Text = "Ignores players that are outside the field of view radius.", Width = 100}})
    Section:Slider({Flag = "aimAssistFovRadius", Min = 0, Max = 360, Default = 180, Suffix = "°"})
    Section:Toggle({Flag = "aimAssistOffsetEnabled", Name = "Offset Location", Tooltip = {Title = "Target Offset", Text = "Offsets the point of where the mouse should move.", Width = 100}})
    Section:Slider({Flag = "aimAssistOffsetX", Name = "X Offset", Min = -25, Max = 25, Default = 0, Suffix = " pixels"})
    Section:Slider({Flag = "aimAssistOffsetY", Name = "Y Offset", Min = -25, Max = 25, Default = 0, Suffix = " pixels"})

    Collumn = Tab:Column({Fill = true})
    Section = Collumn:Section({Name = "Projectile Redirection", Side = "Right"})
    Section:Toggle({Flag = "silentAimEnabled", Name = "Enabled", Tooltip = {Title = "Projectile Manipulation", Text = "Redirects projectiles to the closest target.", Width = 100}}):Keybind({Flag = "silentAimKey", Name = "Redirect Bullets", Mode = "Toggle"})
    Section:Dropdown({Flag = "silentAimMethod", Options = {"Raycast", "Mouse"}, Default = "Mouse"})
    Section:Dropdown({Flag = "silentAimTarget", Name = "Body Priority", Options = {"Head", "Torso", "Arms", "Legs"}, Default = {"Head", "Torso"}, Multi = true})
    Section:Toggle({Flag = "silentAimPredictionEnabled", Name = "Predict Target", Tooltip = {Title = "Prediction (Mouse Only)", Text = "Calculates the player's velocity to predict projectiles.", Width = 100}})
    Section:Dropdown({Flag = "silentAimPredictionMethod", Options = {"Static", "Dynamic"}, Default = "Dynamic"})
    Section:Slider({Flag = "silentAimPredictionX", Name = "X Factor", Min = 0, Max = 5, Default = 1, Suffix = "%", Decimals = 0.1})
    Section:Slider({Flag = "silentAimPredictionY", Name = "Y Factor", Min = 0, Max = 5, Default = 1, Suffix = "%", Decimals = 0.1})
    Section:Toggle({Flag = "silentAimDeadzoneEnabled", Name = "Dead Zone", Tooltip = {Title = "Dead Zone", Text = "Ignores players that are inside the deadzone radius.", Width = 100}})
    Section:Slider({Flag = "silentAimDeadzoneRadius", Min = 0, Max = 360, Default = 180, Suffix = "°"})
    Section:Toggle({Flag = "silentAimFovEnabled", Name = "Limit to FOV", Tooltip = {Title = "Field Of View", Text = "Ignores players that are outside the field of view radius.", Width = 100}})
    Section:Slider({Flag = "silentAimFovRadius", Min = 0, Max = 360, Default = 180, Suffix = "°"})
    Section:Toggle({Flag = "silentAimOffsetEnabled", Name = "Offset Location", Tooltip = {Title = "Target Offset", Text = "Offsets the point of where the bullet should redirect.", Width = 100}})
    Section:Slider({Flag = "silentAimOffsetX", Name = "X Offset", Min = -25, Max = 25, Default = 0, Suffix = " pixels"})
    Section:Slider({Flag = "silentAimOffsetY", Name = "Y Offset", Min = -25, Max = 25, Default = 0, Suffix = " pixels"})

    Section = Collumn:Section({Name = "Target Validation", Side = "Right"})
    Collumn:Dropdown({Flag = "targetValidation", Options = {"Team", "Behind Wall", "Invisible", "Force Field", "Friend"}, Default = {"Team"}, Multi = true})
    Collumn:Toggle({Flag = "targetDistanceEnabled", Name = "Distance Limit", Tooltip = {Title = "Distance Validation", Text = "Ignores players who are further than the max distance value.", Width = 100}, Default = true})
    Collumn:Slider({Flag = "targetDistanceMax", Min = 100, Max = 3000, Default = 2000, Suffix = " studs"})
    Collumn:Toggle({Flag = "targetHealthEnabled", Name = "Health Limit", Tooltip = {Title = "Health Validation", Text = "Ignores players who don't meet the health requirements.", Width = 100}})
    Collumn:Slider({Flag = "targetHealthMin", Name = "Minimum Health", Min = 0, Max = 100, Suffix = "%", Default = 0})
    Collumn:Slider({Flag = "targetHealthMax", Name = "Maximum Health", Min = 0, Max = 100, Suffix = "%", Default = 100})

    Tab = Tabs["Visual"]
    Collumn = Tab:Collumn({Fill = true})
    Section = Collumn:Section({Name = "Extrasensory Perception"})
    Element = Section:EspPreview({})
    ExtrasensoryTab = Element:AddTab({ Name = "Players", Model = "rbxassetid://14966982841", Chams = true })
    Tab.AddBar({Name = "Healthbar", Prefix = "Healthbar"})
    Tab.AddBox({Name = "Box", Prefix = "Box"})
    
    for Index, Option in next, {"Name", "Display", "Distance", "Weapon"} do 
        Tab.AddText({Name = Option, Prefix = Option})
    end
    
    Section = Collumn:Section({Name = "Camera"})
    Section:Toggle({Flag = "cameraFovEnabled", Name = "Field Of View"})
    Section:Slider({Flag = "cameraFovValue", Max = 120, Default = workspace.CurrentCamera.FieldOfView, Decimal = 1})
    Section:Toggle({Flag = "cameraZoomEnabled", Name = "Zoom In"}):Keybind({Flag = "cameraZoomKey", Name = "Zoom", Mode = "Toggle"})
    Section:Slider({Flag = "cameraZoomValue", Max = 120, Default = (workspace.CurrentCamera.FieldOfView - 30), Decimal = 1})
    Section:Toggle({Flag = "cameraPovEnabled", Name = "Change POV"})
    Section:Dropdown({Flag = "cameraPovType", Options = {"First Person", "Third Person"}, Default = "First Person"})

    Collumn = Tab:Collumn({Fill = true})
    Section = Collumn:Section({Name = "World", Side = "Right"})
    Element = Section:Toggle({Flag = "worldAmbient", Name = "Ambience", Callback = function(State : boolean)
        if State then 
            Lighting.Ambient = Library.Flags["worldAmbientPicker1"].Color 
            Lighting.OutdoorAmbient = Library.Flags["worldAmbientPicker2"].Color 
        else 
            Lighting.Ambient = Old.Ambient
            Lighting.OutdoorAmbient = Old.OutdoorAmbient
        end
    end})
    Element:Colorpicker({Flag = "worldAmbientPicker1", Name = "Indoor Ambience", Callback = function(Color : Color3)
        if not Library.Flags["worldAmbient"] then return end 
        Lighting.Ambient = Color 
    end})
    Element:Colorpicker({Flag = "worldAmbientPicker2", Name = "Outdoor Ambience", Callback = function(Color : Color3)
        if not Library.Flags["worldAmbient"] then return end 
        Lighting.OutdoorAmbient = Color 
    end})
    Element:Toggle({Flag = "worldGlobalShadows", Name = "Global Shadows", Default = Old.GlobalShadows, Callback = function(State : boolean)
        Lighting.GlobalShadows = State 
    end})
    Element:Dropdown({Flag = "worldTechnology", Options = {"Voxel", "ShadowMap", "Future", "Unified"}, Default = Lighting.Technology.Name, Callback = function(Value : string)
        
    end})
end