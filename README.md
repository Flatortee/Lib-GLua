# Lib GLua

## Exemple
-- Rectangle --
local rectangle1 = FLT_Rectangle:new()
rectangle1.SetTypeEx(rectangle1, true, false, false, true)
rectangle1.SetPosition(rectangle1, 200, 200)
rectangle1.SetSize(rectangle1, 100, 100, 30)
rectangle1.SetColor(rectangle1, Color(255, 0, 0, 255))
-- rectangle1.SetAngle(rectangle1, 45) 
rectangle1.Display(rectangle1)

-- Circle --
local circle1 = FLT_Circle:new()
circle1.SetRadius(circle1, 50)
circle1.SetPosition(circle1, 300, 200)
circle1.SetColor(circle1, Color(0, 255, 0, 255))
circle1.Display(circle1);

-- Sprite --
local sprite1 = FLT_Sprite:new()
sprite1.SetTexture(sprite1, ResourceManager:GetMaterial("ammo"))
sprite1.SetSize(sprite1, 70, 70)
sprite1.SetPosition(sprite1, 215, 215)
sprite1.Display(sprite1)

-- Text --
local text1 = FLT_Text:new()
text1.SetText(text1, health)
text1.SetPosition(text1, 350, 230)
text1.Display(text1)
