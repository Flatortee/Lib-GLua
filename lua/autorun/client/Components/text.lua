FLT_Text = {}
FLT_Text.__index = FLT_Text

function FLT_Text:new(text, color, vector, align)
    local obj = setmetatable({}, FLT_Text)
    
    obj.text = text or ""
    obj.font = "Default"
    obj.vector = vector or FLT_Vector2:new(50,50)
    obj.align = align or TEXT_ALIGN_CENTER
    obj.color = color or Color(255,255,255,255)

    return obj
end

--#region GETTERS

function FLT_Text:GetText()
    return self.text
end

function FLT_Text:GetFont()
    return self.font
end

function FLT_Text:GetVector()
    return self.vector
end

--#endregion

--#region SETTERS

function FLT_Text:SetText(text)
    self.text = text
end

function FLT_Text:SetFont(font)
    self.font = font
end

function FLT_Text:SetVector(vector)
    self.vector = vector
end

function FLT_Text:SetAlign(align)
    self.align = align
end

function FLT_Text:SetPosition(x, y)
    self.vector.x = x
    self.vector.y = y
end

function FLT_Text:SetColor(color)
    self.color = color
end

--#endregion

--#region ORTHERS

function FLT_Text:Display()
    draw.SimpleText(self.text, self.font, self.vector.x, self.vector.y, self.color, self.align)
end

--#endregion