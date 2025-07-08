FLT_Type = {}
FLT_Type.__index = FLT_Type

function FLT_Type:new(type)
    local obj = setmetatable({}, FLT_Type)

    obj.rounded = type or false


    return obj
end