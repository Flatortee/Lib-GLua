FLT_Type = {}
FLT_Type.__index = FLT_Type

function FLT_Type:new(tl, tr, bl, br)
    local obj = setmetatable({}, FLT_Type)

    obj.topLeft = tl or false
    obj.topRight = tr or false
    obj.bottomLeft = bl or false
    obj.bottomRight = br or false

    return obj
end