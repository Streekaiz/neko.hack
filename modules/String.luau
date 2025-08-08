local Library : { [any] : any} = {}; do 
    Library.__index = Library 

    Library.Case = function(self, Text : string, Casing : string)
        if Casing == "lowercase" then 
            return string.lower(Text)
        elseif Casing == "uppercase" then 
            return string.upper(Text)
        else 
            return Text 
        end
    end

    Library.Surround = function(self, Text : string, Front : string, Behind : string)
        return Front .. Text .. Behind 
    end
end

return Library 