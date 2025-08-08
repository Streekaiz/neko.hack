local Library : {[any] : any} = {}; do 
    Library.__index = Library 

    local FindFirstChild = workspace.FindFirstChild 
    local FindFirstChildOfClass = workspace.FindFirstChildOfClass

    local TableFind = table.find 

    local MathHuge = math.huge
    local CloneReference = cloneref or function(... : any) -- // i can just use the services module but it doesn't work so ermm wtf?
        return ... 
    end 

    local Players = CloneReference(game:GetService("Players"))
    local UserInputService = CloneReference(game:GetService("UserInputService"))

    local Camera = workspace.CurrentCamera 
    local LocalPlayer = Players.LocalPlayer

    Library.IsAlive = function(self, Player : Player, IncludeParts : boolean?) : boolean
        local Character = Library:GetCharacter(Player)

        if not Character then 
            return false
        end

        local HumanoidRootPart, Humanoid = Library:GetHumanoidRootPart(Character), Library:GetHumanoid(Character)

        if not HumanoidRootPart or not Humanoid then 
            return false
        end

        if Humanoid.Health < 0 then 
            return false
        end

        if IncludeParts then 
            return true, Character, HumanoidRootPart, Humanoid 
        end

        return true 
    end

    Library.IsFriendly = function(self, Player : Player, SecondPlayer : Player, IncludeTeam : boolean?) : boolean
        local Team1 = Player.Team 
        local Team2 = SecondPlayer.Team 
        local IsFriendly = Team1 == Team2 

        if IncludeTeam then 
            return IsFriendly, Team1, Team2 
        end

        return IsFriendly 
    end

    Library.GetCharacter = function(self, Player : Player) : Model?
        return Player.Character 
    end

    Library.GetHumanoidRootPart = function(self, Character : Model?) : Part?
        return FindFirstChild(Character, "HumanoidRootPart")
    end

    Library.GetHumanoid = function(self, Character : Model?) : Humanoid?
        return FindFirstChildOfClass(Character, "Humanoid")
    end

    Library.GetBodyParts = function(self, Character : Model, RootPart : Part?, Indexes : boolean?, Hitboxes : {string}?)
        local Parts = {}
        local BodyParts = Hitboxes or {"Head", "Torso", "Arms", "Legs"}

        for Index, Part in pairs(Character:GetChildren()) do
            if Part:IsA("BasePart") and Part ~= RootPart then
                if TableFind(BodyParts, "Head") and Part.Name:lower():find("head") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif TableFind(BodyParts, "Torso") and Part.Name:lower():find("torso") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif TableFind(BodyParts, "Arms") and Part.Name:lower():find("arm") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif TableFind(BodyParts, "Legs") and Part.Name:lower():find("leg") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif (TableFind(BodyParts, "Arms") and Part.Name:lower():find("hand")) or (TableFind(BodyParts, "Legs") and Part.Name:lower():find("foot")) then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                end
            end
        end

        return Parts
    end

    Library.GetClosestPlayer = function(self, Mode : string?, Validate: ((Player: Player, Magnitude: number, Character: Model?, HumanoidRootPart: BasePart?, Humanoid: Humanoid, CurrentPlayer: Player) -> boolean)) : Player
        Mode = Mode or "Mouse" -- // Mouse, Character
        Validate = Validate or function() return true end 

        local Mouse = UserInputService:GetMouseLocation() 
        local ClosestPlayer, PlayerMagnitude = nil, MathHuge 

        if Mode == "Mouse" then 
            for Index, Player in next, Players:GetChildren() do 
                if Players == LocalPlayer then continue end 
                local Alive, Character, HumanoidRootPart, Humanoid = Library:IsAlive(Player, true)
                if not Alive then continue end 

                
                local ScreenPosition = Camera:WorldToViewportPoint(HumanoidRootPart.Position)
                local MousePosition = Vector2.new(Mouse.X, Mouse.Y)
                local Magnitude = (ScreenPosition - MousePosition).Magnitude

                if not Validate(Player, Magnitude, Character, HumanoidRootPart, Humanoid, ClosestPlayer) then continue end 

                if Magnitude > PlayerMagnitude then continue end 

                ClosestPlayer = Player 
                PlayerMagnitude = Magnitude
            end
        elseif Mode == "Character" then 
            -- // uhh make the logic here!!1
        end

        return ClosestPlayer, PlayerMagnitude 
    end

    Library.GetClosestBodyPart = function(self, Character : Model, List : {[any] : Part})
        local Mouse = UserInputService:GetMouseLocation() 
        local ClosestPart, PartMagnitude = nil, MathHuge 

        for _, Object in next, Character:GetChildren() do 
            if Object:IsA("BasePart") then 
                local Position = Camera:WorldToViewportPoint(Object.Position)
                local Magnitude = (Position - Mouse).Magnitude

                if Magnitude < PartMagnitude and table.find(List, Object) then 
                    ClosestPart = Object 
                    PartMagnitude = Magnitude
                end
            end
        end

        return ClosestPart, PartMagnitude 
    end
end

return Library 