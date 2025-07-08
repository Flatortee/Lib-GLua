FLT_Circle = {}
FLT_Circle.__index = FLT_Circle

--#region CONSTRUCTOR

function FLT_Circle:new(radius, vector, color)
    local obj = setmetatable({}, FLT_Circle)

    if rectType ~= nil and size == nil and vector == nil and color == nil then
        obj.radius = radius
        obj.vector = FLT_Vector2:new(100, 100)
        obj.color = Color(255, 255, 255, 255)
        return obj
    end

    obj.radius = radius or 50
    obj.vector = vector or FLT_Vector2:new(100, 100)
    obj.color = color or Color(255, 255, 255, 255)

    return obj
end


--#endregion

--#region GETTERS

function FLT_Circle:GetType()
    return self.type
end

function FLT_Circle:GetRadius()
    return self.radius
end

function FLT_Circle:GetVector()
    return self.vector
end

function FLT_Circle:GetColor()
    return self.color
end

--#endregion

--#region SETTERS

function FLT_Circle:SetType(type)
    self.type = type
end

function FLT_Circle:SetRadius(r)
    self.radius = r or 0
end

function FLT_Circle:SetVector(vector)
    self.vector = vector
end

function FLT_Circle:SetPosition(x, y)
    self.vector.x = x or 0
    self.vector.y = y or 0
end

function FLT_Circle:SetColor(color)
    self.color = color
end

--#endregion

--#region ORTHERS

function FLT_Circle:Display()

    draw.RoundedBoxEx(
        self.radius,
        self.vector.x,
        self.vector.y,
        self.radius * 2,
        self.radius * 2,
        self.color,
        true,true,true,true
    )
end

function FLT_Circle:DirectDisplay(radius, vector, color)

    draw.RoundedBoxEx(
        radius,
        vector.x,
        vector.y,
        radius * 2,
        radius * 2,
        color,
        true,true,true,true
    )
end

--#endregion
