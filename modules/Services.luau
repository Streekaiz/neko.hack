local Library : { [any] : any} = {}; do 
    Library.__index = Library 

    local CloneReference = cloneref or function(... : any) 
        return ... 
    end 

    Library.Get = function(self, Name : string) : ServiceProvider
        local Service = CloneReference(game:GetService(Name))
        Library[Name] = Service 
        return Service 
    end

    Library.Fetch = function(self, Name : string) : ServiceProvider
        return Library[Name]
    end

    Library.Insert = function(self, Service : ServiceProvider)
        Library[Service.Name] = Service 
    end
end

return Library 