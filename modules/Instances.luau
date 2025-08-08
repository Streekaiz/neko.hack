local Library : {[any] : any} = {} do 
    Library.__index = Library 

    local InstanceNew = Instance.new 
    local MathRandom = math.random 
    local ToString = tostring 
    
    local Environment = getgenv() or _G

    Library.Create = function(self, ClassName : string, Properties : {}?, Name : string?) : {Instance : Instance, ClassName : string, Properties : {[string] : any}, Name : string}
        Properties = Properties or {}
        Name = Name or ToString(MathRandom(1, 1000))

        local Data = setmetatable({
            Instance = InstanceNew(ClassName),
            ClassName = ClassName,
            Properties = Properties,
            Name = Name 
        }, Library)

        for Index, Value in next, Data.Properties do 
            Data:Set(Index, Value)
        end

        if self.Instance then 
            Data:Set("Parent", self.Instance)
        end

        return Data 
    end

    Library.Set = function(self, Index : string, Value : any, UpdateProperties : boolean?) : {Instance : Instance, ClassName : string, Properties : {[string] : any}, Name : string}?
        if not self.Instance then 
            return 
        end

        self.Instance[Index] = Value 

        if UpdateProperties then 
            self.Properties[Index] = Value 
        end

        return self 
    end

    Library.Clean = function(self)
        if not self.Instance then 
            return 
        end

        self.Instance:Destroy()
        self = nil 
    end

    Library.OnHover = function(self, Function : (any), Name : string?) : RBXScriptConnection?
        if not self.Instance then 
            return 
        end

        local Connection = Environment.Neko.Connections:Create(self.Instance.MouseEnter, Function, Name)

        return Connection 
    end

    Library.OnLeave = function(self, Function : (any), Name : string?) : RBXScriptConnection?
        if not self.Instance then 
            return 
        end

        local Connection = Environment.Neko.Connections:Create(self.Instance.MouseLeave, Function, Name)

        return Connection 
    end
end

return Library 