FLT_Vector2 = {}
FLT_Vector2.__index = FLT_Vector2

function FLT_Vector2:new(x, y)
    local obj = setmetatable({}, FLT_Vector2)
    obj.x = x or 0
    obj.y = y or 0
    return obj
end
