FLT_Sprite = {}
FLT_Sprite.__index = FLT_Sprite

function FLT_Sprite:new(texture, size, vector)
    local obj = setmetatable({}, FLT_Sprite)
    
    -- //TODO: texture placeholder ? --
    obj.texture = texture or nil
    obj.color = Color(255, 255, 255, 255)
    obj.size = size or FLT_Size:new(50, 50)
    obj.vector = vector or FLT_Vector2:new(100, 100)

    return obj
end

--#region GETTERS

--#endregion

--#region SETTETS

function FLT_Sprite:SetTexture(texture)
    self.texture = texture
end

function FLT_Sprite:SetColor(color)
    self.color = color
end

function FLT_Sprite:SetScale(size)
    self.size = size
end

function FLT_Sprite:SetSize(x, y)
    self.size.x = x or 0
    self.size.y = y or 0
end

function FLT_Sprite:SetVector(vector)
    self.vector = vector
end

function FLT_Sprite:SetPosition(x, y)
    self.vector.x = x or 0
    self.vector.y = y or 0
end

--#endregion



function FLT_Sprite:Display()
    surface.SetMaterial(self.texture)
    surface.SetDrawColor(self.color)
    surface.DrawTexturedRect(self.vector.x, self.vector.y, self.size.x, self.size.y)
end
