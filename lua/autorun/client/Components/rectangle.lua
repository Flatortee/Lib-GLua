FLT_Rectangle = {}
FLT_Rectangle.__index = FLT_Rectangle

if not FLT_Rectangle then FLT_Rectangle = {} end

if not FLT_Rectangle.Mat then
    FLT_Rectangle.Mat = CreateMaterial("flt_rectangle_mat", "UnlitGeneric", {
        ["$basetexture"] = "color/white",
        ["$vertexcolor"] = "1",
        ["$vertexalpha"] = "1"
    })
end


--#region CONSTRUCTOR

function FLT_Rectangle:new(rectType, size, vector, color)
    local obj = setmetatable({}, FLT_Rectangle)

    -- //TODO: si 1er arg alors mettre tous en rounded

    obj.type = rectType or FLT_Type:new(false,false,false,false)
    obj.size = size or FLT_Size:new(50, 50)
    obj.vector = vector or FLT_Vector2:new(100, 100)
    obj.color = color or Color(255, 255, 255, 255)
    obj.angle = 0

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

function FLT_Rectangle:GetAngle()
    return self.angle
end

--#endregion

--#region SETTERS

function FLT_Rectangle:IsRounded(rounded)

    if rounded then
        self.type.topLeft = true
        self.type.topRight = true
        self.type.bottomLeft = true
        self.type.bottomRight = true
    else
        self.type.topLeft = false
        self.type.topRight = false
        self.type.bottomLeft = false
        self.type.bottomRight = false
    end
end

function FLT_Rectangle:SetType(type)
    self.type = type
end

function FLT_Rectangle:SetTypeEx(tl, tr, bl, br)
    self.type.topLeft = tl
    self.type.topRight = tr
    self.type.bottomLeft = bl
    self.type.bottomRight = br
end

function FLT_Rectangle:SetScale(size)
    self.size = size
end

function FLT_Rectangle:SetSize(x, y, r)
    self.size.x = x or 0
    self.size.y = y or 0
    self.size.r = r or 0
end

-- Attention enleve les corners radius
function FLT_Rectangle:SetAngle(angle)
    self.angle = angle or 0
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

function FLT_Rectangle:Display()

    if self.angle ~= 0 then
        surface.SetDrawColor(self.color)
        surface.SetMaterial(FLT_Rectangle.Mat)

        surface.DrawTexturedRectRotated(
            self.vector.x + self.size.x / 2,
            self.vector.y + self.size.y / 2,
            self.size.x,
            self.size.y,
            self.angle
        )
    else
        draw.RoundedBoxEx(
            self.size.r or 0,
            self.vector.x,
            self.vector.y,
            self.size.x,
            self.size.y,
            self.color,
            self.type.topLeft, self.type.topRight, self.type.bottomLeft, self.type.bottomRight
        )
    end

end


function FLT_Rectangle:DirectDisplay(type, size, vector, color)

    draw.RoundedBoxEx(
        size.r,
        vector.x,
        vector.y,
        size.x,
        size.y,
        color,
        type.topLeft, type.topRight, type.bottomLeft, type.bottomRight
    )
end

--#endregion
