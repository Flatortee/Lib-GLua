FLT_Rectangle = {}
FLT_Rectangle.__index = FLT_Rectangle

--#region CONSTRUCTOR

function FLT_Rectangle:new(rectType, size, vector, color)
    local obj = setmetatable({}, FLT_Rectangle)

    -- //TODO: si 1er arg alors mettre tous en rounded

    if rectType ~= nil and size == nil and vector == nil and color == nil then
        obj.type = rectType
        obj.size = FLT_Size:new(50, 50)
        obj.vector = FLT_Vector2:new(100, 100)
        obj.color = Color(255, 255, 255, 255)
        return obj
    end

    obj.type = rectType or false
    obj.size = size or FLT_Size:new(50, 50)
    obj.vector = vector or FLT_Vector2:new(100, 100)
    obj.color = color or Color(255, 255, 255, 255)

    return obj
end


--#endregion

--#region GETTERS

function FLT_Rectangle:GetType()
    return self.type
end

function FLT_Rectangle:GetSize()
    return self.size
end

function FLT_Rectangle:GetVector()
    return self.vector
end

function FLT_Rectangle:GetColor()
    return self.color
end

--#endregion

--#region SETTERS

function FLT_Rectangle:SetType(type)
    self.type = type
end

function FLT_Rectangle:SetScale(size)
    self.size = size
end

function FLT_Rectangle:SetSize(x, y)
    self.size.x = x or 0
    self.size.y = y or 0
end

function FLT_Rectangle:SetVector(vector)
    self.vector = vector
end

function FLT_Rectangle:SetPosition(x, y)
    self.vector.x = x or 0
    self.vector.y = y or 0
end

function FLT_Rectangle:SetColor(color)
    self.color = color
end

--#endregion

--#region ORTHERS

-- //TODO: Radius
function FLT_Rectangle:Display()

    draw.RoundedBoxEx(
        5,
        self.vector.x,
        self.vector.y,
        self.size.x,
        self.size.y,
        self.color,
        self.type, self.type, self.type, self.type
    )
end

function FLT_Rectangle:DirectDisplay(type, size, vector, color)

    draw.RoundedBoxEx(
        5,
        vector.x,
        vector.y,
        size.x,
        size.y,
        color,
        type, type, type, type
    )
end

--#endregion
