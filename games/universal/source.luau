local Environment : {[any] : any} = getgenv() or _G 
local Library : {[any] : any} = Environment["Neko"]["Interface"].Library
local Esp : {[any] : {any}} = Library.Esp
local Flags : {[string] : any} = Library.Flags 
local Pointers : {[string] : {any}} = Library.Pointers 

local Players : Players = Environment["Neko"]["Services"]:Get("Players")
local RunService : RunService = Environment["Neko"]["Services"]:Get("RunService")
local UserInputService : UserInputService = Environment["Neko"]["Services"]:Get("UserInputService")

local LocalPlayer = Players.LocalPlayer 
local Camera = workspace.CurrentCamera 

Environment["Neko"]["Local Player Data"] = {
    Alive = false,
    Character = nil,
    HumanoidRootPart = nil,
    Humanoid = nil 
}

Environment["Neko"]["Target Data"] = { -- // Could add some more stuff for more api usage?
    Player = nil,
    TargetPart = nil,
    Character = nil,
    HumanoidRootPart = nil,
    Magnitude = math.huge,
    BodyParts = {}
}

Environment["Neko"]["Update"] = function(Delta)
    Environment["Neko"]["Local Player Data"].Alive, Environment["Neko"]["Local Player Data"].Character, Environment["Neko"]["Local Player Data"].HumanoidRootPart, Environment["Neko"]["Local Player Data"].Humanoid = Library:IsAlive(LocalPlayer)
    if not Environment["Neko"]["Local Player Data"].Alive then return end 

    if (Library.Flags["aimAssistEnabled"] and Library.Flags["aimAssistKey"].Active) then 
        Environment["Neko"]["Target Data"].Player, Environment["Neko"]["Target Data"].Magnitude = Environment["Neko"]["Players"]:GetClosestPlayer("Mouse", function(Player: Player, Magnitude: number, Character: any, HumanoidRootPart: BasePart?, Humanoid: Humanoid, CurrentPlayer: Player)
            if (Library.Flags["targetValidation"]["Team"] and Environment["Neko"]["Players"]:IsFriendly(Player, LocalPlayer.Team)) then 
                return false 
            end

            if (Library.Flags["targetValidation"]["Invisible"] and Character.Head.Transparency == 1) then 
                return false 
            end

            if (Library.Flags["targetValidation"]["Behind Wall"] and not Environment["Neko"]["Miscallaenous"]:IsVisible(Character.Head, Environment["Neko"]["Local Player Data"].Character.Head)) then 
                return false 
            end 

            if Library.Flags["targetDistanceEnabled"] then 
                local Distance = (Environment["Neko"]["Local Player Data"].HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude 

                if Distance > Library.Flags["targetDistanceMax"] then 
                    return false 
                end
            end 

            if (Library.Flags["aimAssistFovEnabled"] and Library.Flags["aimAssistFovRadius"] > Magnitude) then 
                return false 
            end

            if (Library.Flags["aimAssistDeadzoneEnabled"] and Library.Flags["aimAssistDeadzoneRadius"] < Magnitude) then 
                return false 
            end

            Environment["Neko"]["Target Data"].Character = Character 
            Environment["Neko"]["Target Data"].HumanoidRootPart = HumanoidRootPart

            return true 
        end)

        if Environment["Neko"]["Target Data"].Player then 
            Environment["Neko"]["Target Data"].BodyParts = Environment["Neko"]["Players"]:GetBodyParts(Environment["Neko"]["Target Data"].Character, Environment["Neko"]["Target Data"].HumanoidRootPart, false, Library.Flags["aimAssistTarget"])
            Environment["Neko"]["Target Data"].TargetPart = Environment["Neko"]["Players"]:GetClosestBodyPart(Environment["Neko"]["Target Data"].Character, Environment["Neko"]["Target Data"].BodyParts)
            local Position, OnScreen = Camera:WorldToViewportPoint( Environment["Neko"]["Target Data"].TargetPart.Position)

            if OnScreen then 
                Environment["Neko"]["Miscallaenous"]:MouseMove(
                    Position, 
                    UserInputService:GetMouseLocation(), 
                    Library.Flags["aimAssistSmoothingX"], 
                    Library.Flags["aimAssistSmoothingY"]
                )
            end
        end
    end

    if Library.Flags["localSpeed"] and Library.Flags["localSpeedMethod"] == "CFrame" then 
        if Environment["Neko"]["Local Player Data"].Humanoid.MoveDirection.Magnitude > 0 then 
            Environment["Neko"]["Local Player Data"].Character:TranslateBy(Environment["Neko"]["Local Player Data"].Humanoid.MoveDirection * Library.Flags["localSpeedValue"] * Delta * 10)
        end
    end

    if Library.Flags["localNoclip"] then 
        for _, Part in next, Environment["Neko"]["Local Player Data"].Character:GetDescendants() do 
            if Part:IsA("BasePart") and Part.CanCollide == true then 
                Part.CanCollide = false 
            end
        end
    end
end

Environment["Neko"]["Signals"]:Create(RunService.Heartbeat, Environment["Neko"]["Update"])