local Environment : {[any] : any} = getgenv() or _G 
local Interface : {[any] : any} = Environment["Neko"]["Interface"]
local Library : {[any] : any} = Interface.Library 

local Lighting : {[any] : any} = Environment["Neko"]["Services"]:Get("Lighting") -- any : any smh
local Players : Players = Environment["Neko"]["Services"]:Get("Players")

local Camera : Camera = workspace.CurrentCamera 

local BloomEffect : {[any] : any} = Environment["Neko"]["Instances"]:Create("BloomEffect", {Enabled = false, Parent = Lighting})
local ColorCorrectionEffect : {[any] : any} = Environment["Neko"]["Instances"]:Create("ColorCorrectionEffect", {Enabled = false, Parent = Lighting})

local Old : {[any] : any} = {
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

    Tab = Tabs["Combat"]; do 
        Collumn = Tab:Column({Fill = true}); do 
            Section = Collumn:Section({Name = "Aim Assist"}); do 
               Section:Toggle({Flag = "aimAssistEnabled", Name = "Enabled", Tooltip = {Title = "Aim Assist", Text = "Curves your mouse towards the closest player.", Width = 100}}):Keybind({Flag = "aimAssistKey", Name = "Aim Assist", Mode = "Hold"})
                Section:Dropdown({Flag = "aimAssistMethod", Options = {"Mouse", "Camera"}, Default = "Mouse"})
                Section:Dropdown({Flag = "aimAssistTarget", Name = "Body Priority", Options = {"Head", "Torso", "Arms", "Legs"}, Default = {"Head", "Torso"}, Multi = true})
                Section:Toggle({Flag = "aimAssistSmoothingEnabled", Name = "Smoothing Assist", Default = true, Tooltip = {Title = "Smoothing", Text = "Instead of instantly flicking; smoothes out the time to reach the player.", Width = 100}})
                Section:Slider({Flag = "aimAssistSmoothingX", Name = "X Factor", Min = 0, Max = 100, Default = 50, Suffix = "%", Decimals = 0.5})
                Section:Slider({Flag = "aimAssistSmoothingY", Name = "Y Factor", Min = 0, Max = 100, Default = 50, Suffix = "%", Decimals = 0.5})
                Section:Toggle({Flag = "aimAssistStickyEnabled", Name = "Sticky Aim", Tooltip = {Title = "Sticky Aim Assist", Text = "Stops moving your mouse once it's onto the target."}})
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
            end
        end
        Collumn = Tab:Column({Fill = true}); do
            Section = Collumn:Section({Name = "Projectile Redirection"}); do 
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
            end
            Section = Collumn:Section({Name = "Target Validation"}); do 
                Section:Dropdown({Flag = "targetValidation", Options = {"Team", "Behind Wall", "Invisible", "Force Field", "Friend"}, Default = {"Team"}, Multi = true})
                Section:Toggle({Flag = "targetDistanceEnabled", Name = "Distance Limit", Tooltip = {Title = "Distance Validation", Text = "Ignores players who are further than the max distance value.", Width = 100}, Default = true})
                Section:Slider({Flag = "targetDistanceMax", Min = 100, Max = 3000, Default = 2000, Suffix = " studs"})
                Section:Toggle({Flag = "targetHealthEnabled", Name = "Health Limit", Tooltip = {Title = "Health Validation", Text = "Ignores players who don't meet the health requirements.", Width = 100}})
                Section:Slider({Flag = "targetHealthMin", Name = "Minimum Health", Min = 0, Max = 100, Suffix = "%", Default = 0})
                Section:Slider({Flag = "targetHealthMax", Name = "Maximum Health", Min = 0, Max = 100, Suffix = "%", Default = 100})
            end
        end
    end 

    Tab = Tabs["Visual"]; do 
        Collumn = Tab:Column({Fill = true}); do 
            Section = Collumn:Section({Name = "Extrasensory Perception"}); do 
                Element = Section:EspPreview({})
                ExtrasensoryTab = Element:AddTab({ Name = "Players", Model = "rbxassetid://14966982841", Chams = true })
                ExtrasensoryTab.AddBar({Name = "Healthbar", Prefix = "Healthbar"})
                ExtrasensoryTab.AddBox({Name = "Box", Prefix = "Box"})
                
                for Index, Option in next, {"Name", "Display", "Distance", "Weapon"} do 
                    ExtrasensoryTab.AddText({Name = Option, Prefix = Option})
                end
            end
            Section = Collumn:Section({Name = "Camera"}); do 
                Section:Toggle({Flag = "cameraFovEnabled", Name = "Field Of View"})
                Section:Slider({Flag = "cameraFovValue", Max = 120, Default = Old.FieldOfView, Decimal = 1})
                Section:Toggle({Flag = "cameraZoomEnabled", Name = "Zoom In"}):Keybind({Flag = "cameraZoomKey", Name = "Zoom In", Mode = "Toggle"})
                Section:Slider({Flag = "cameraZoomValue", Max = 120, Default = (Old.FieldOfView - 30), Decimal = 1})
                Section:Toggle({Flag = "cameraPovEnabled", Name = "Change POV"})
                Section:Dropdown({Flag = "cameraPovType", Options = {"First Person", "Third Person"}, Default = "First Person"})
            end
        end
        Collumn = Tab:Column({Fill = true}); do 
            Section = Collumn:Section({Name = "World", Side = "Right"}); do 
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
                Element:Dropdown({Flag = "worldTechnology", Options = {"Compatibility", "Voxel", "ShadowMap", "Future", "Unified"}, Default = Lighting.Technology.Name, Callback = function(State : string)
                    sethiddenproperty(Lighting, "Technology", Enum.Technology[State])
                end})
                Section:Toggle({ Flag = "worldTime", Name = "Time of Day", Callback = function(Boolean : boolean)
                    if Boolean then 
                        Lighting.TimeOfDay = Library.Flags["worldTimeValue"]
                    else 
                        Lighting.TimeOfDay = Old.TimeOfDay
                    end
                end})
                Section:Slider({Flag = "worldTimeValue", Min = -12, Max = 12, Default = 0, Decimal = 0.05, Callback = function(Value : number)
                    if not Library.Flags["worldTime"] then return end 
                    Lighting.TimeOfDay = Value
                end})
                Section:Toggle({Name = "No Fog", Flag = "worldFog", Callback = function(Boolean : boolean)
                    if Boolean then 
                        Lighting.FogEnd = 9e9
                        Lighting.FogStart = 9e9 
                    else 
                        Lighting.FogEnd = Old.FogEnd
                        Lighting.FogStart = Old.FogStart
                    end
                end})
                Section:Dropdown({Name = "Custom Skybox", Flag = "worldSkybox", Options = {}})
            end
            Section = Collumn:Section({Name = "Bloom"}); do 
                Section:Toggle({Flag = "bloomEnabled", Name = "Enabled", Callback = function(State : boolean)
                    BloomEffect.Instance.Enabled = State 
                end})
                Section:Slider({Flag = "bloomIntensity", Name = "Intensity", Max = 25, Default = 1, Callback = function(Value : number)
                    BloomEffect.Instance.Intensity = Value 
                end})
                Section:Slider({Flag = "bloomThreshold", Name = "Threshold", Max = 1, Default = 1, Decimal = 0.005, Callback = function(Value : number)
                    BloomEffect.Instance.Threshold = Value 
                end})
                Section:Slider({Flag = "bloomSize", Name = "Size", Max = 10, Default = 1, Callback = function(Value : number)
                    BloomEffect.Instance.Size = Value 
                end})
            end
            Section = Collumn:Section({Name = "Color Correction"}); do 
                Section:Toggle({Flag = "colorCorrectionEnabled", Name = "Enabled", Callback = function(State : boolean)
                    ColorCorrectionEffect.Instance.Enabled = State 
                end}):Colorpicker({Name = "Tint", Flag = "colorCorrectionTint", Callback = function(Value : Color3)
                    ColorCorrectionEffect.Instance.TintColor = Value 
                end})
                Section:Slider({Flag = "colorCorrectionBrightness", Name = "Brightness", Max = 1, Min = -1, Default = 0, Decimal = 0.005, Callback = function(Value : number)
                    ColorCorrectionEffect.Instance.Brightness = Value 
                end})
                Section:Slider({Flag = "colorCorrectionContrast", Name = "Contrast", Max = 25, Min = -25, Default = 0, Decimal = 0.1, Callback = function(Value : number)
                    ColorCorrectionEffect.Instance.Contrast = Value 
                end})
                Section:Slider({Flag = "colorCorrectionSaturation", Name = "Saturation", Max = 10, Min = -1, Default = 0, Decimal = 0.1, Callback = function(Value : number)
                    ColorCorrectionEffect.Instance.Saturation = Value 
                end})
            end
        end
    end 
    
    Tab = Tabs["Miscallaenous"]; do 
        Collumn = Tab:Column({Fill = true}); do 
            Section = Collumn:Section({Name = "Local Player"}); do 
                Section:Toggle({Flag = "localSpeed", Name = "Speed", Tooltip = {Title = "Player Modification", Text = "Edits the local player's speed", Width = 100}}):Keybind({Flag = "localSpeedKey", Name = "Speed", Mode = "Toggle", Callback = function()
                    if string.match(Library.Flags["localSpeedKey"].Mode, "Hold") then 
                        Library.Pointers["localSpeed"].Set(not Library.Flags["localSpeedKey"].Active)
                    else 
                        Library.Pointers["localSpeed"].Set(Library.Flags["localSpeedKey"].Active)
                    end 
                end})
                Section:Dropdown({Flag = "localSpeedMethod", Options = {"Humanoid", "CFrame"}, Default = "CFrame"})
                Section:Slider({Flag = "localSpeedValue", Max = 75, Default = 10, Decimal = 0.0025, Suffix = "%"})
                Section:Toggle({Flag = "localJump", Name = "Jump", Tooltip = {Title = "Player Modification", Text = "Edits the local player's jump power", Width = 100}}):Keybind({Flag = "localJumpKey", Name = "Jump Power", Mode = "Toggle", Callback = function()
                    if string.match(Library.Flags["localJumpKey"].Mode, "Hold") then 
                        Library.Pointers["localJump"].Set(not Library.Flags["localJumpKey"].Active)
                    else 
                        Library.Pointers["localJump"].Set(Library.Flags["localJumpKey"].Active)
                    end 
                end})
                Section:Slider({Flag = "localJumpValue", Max = 200, Default = 50, Decimal = 1, Suffix = "%"})
                Section:Toggle({Flag = "localNoclip", Name = "Noclip"})
                Section:Toggle({Flag = "localFlight", Name = "Flight", Tooltip = {Title = "Player Modification", Text = "Edits the local player's Flight", Width = 100}}):Keybind({Flag = "localFlightKey", Name = "Flight", Mode = "Toggle", Callback = function()
                    if string.match(Library.Flags["localFlightKey"].Mode, "Hold") then 
                        Library.Pointers["localFlight"].Set(not Library.Flags["localFlightKey"].Active)
                    else 
                        Library.Pointers["localFlight"].Set(Library.Flags["localFlightKey"].Active)
                    end 
                end})
                Section:Dropdown({Flag = "localFlightMethod", Options = {"Velocity", "CFrame"}, Default = "Velocity"})
                Section:Slider({Flag = "localFlightSpeed", Name = "Flight Speed", Min = 0, Max = 100, Suffix = "%"})
                Section:Toggle({Flag = "localUsernameSpoof", Name = "Spoof Username", Callback = function(State : boolean)
                    if State then 
                        for i, v in next, game:GetDescendants() do 
                            if v:IsA("TextLabel") or v:IsA("TextButton") then 
                                string.gsub(v.Text, Players.LocalPlayer.Name, "nekohack")
                                string.gsub(v.Text, Players.LocalPlayer.DisplayName, "nekohack")
                            end
                        end
                    else
                        for i, v in next, game:GetDescendants() do 
                            if v:IsA("TextLabel") or v:IsA("TextButton") then 
                                string.gsub(v.Text, "nekohack", Players.LocalPlayer.Name)
                            end
                        end
                    end
                end})
            end
        end
    end
end