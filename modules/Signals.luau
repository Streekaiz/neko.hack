local Library : { [any] : any} = {}; do 
    Library.__index = Library 

    Library.Create = function(self, Signal : RBXScriptSignal, Callback : (any), Name : string?) : RBXScriptConnection
        local Connection = Signal:Connect(Callback)
        Library[Name or #Library + 1] = Connection 

        return Connection 
    end

    Library.Disconnect = function(self, Name : string)
        self[Name]:Disconnect()
    end

    Library.Register = function(self, Connection : RBXScriptConnection, Name : string?) : RBXScriptConnection
        Library[Name or #Library + 1] = Connection 

        return Connection 
    end

    Library.Clean = function(self)
        for Index, Connection in next, Library do 
            Connection:Disconnect()
        end
    end
end

return Library 
