FLT_Size = {}
FLT_Size.__index = FLT_Size

function FLT_Size:new(x, y)
    local obj = setmetatable({}, FLT_Size)

    obj.x = x or 0
    obj.y = y or 0




    return obj
end