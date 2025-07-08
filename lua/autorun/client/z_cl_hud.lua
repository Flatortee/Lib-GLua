include("autorun/client/Utils/type.lua")
include("autorun/client/Utils/vector2.lua")
include("autorun/client/Utils/size.lua")
include("autorun/client/Components/rectangle.lua")

resource.AddFile("resource/fonts/stratum2-medium-webfont.ttf")
surface.CreateFont("Default", {
    font = "Stratum2 Md",
    size = ScrW() * 0.018,
    weight = 800,
    antialiasing = true  

})

hook.Add("Initialize", "NO_PROPS_PROPERTY", function()
    hook.Remove("HUDPaint", "FPP_HUDPaint")
end)


hook.Add("HUDPaint", "hud_jibey", function()
    local health    = FLT_GameManager:GetPlayerLife()
    local armor     = FLT_GameManager:GetPlayerArmor()
    local money     = FLT_GameManager:GetPlayerMoney()
    local energy    = FLT_GameManager:GetPlayerEnergy()
    local job       = FLT_GameManager:GetPlayerJob()
    local name      = FLT_GameManager:GetPlayerName()
    local moneyText = tostring(money)
    
    --------------------------------------écran rouge vie---text faim-------------
    if health < 20 then
        surface.SetDrawColor(255, 0, 0, 50) -- Rouge transparent
        surface.DrawRect(0, 0, ScrW(), ScrH()) -- Dessine un rectangle rouge sur tout l'écran
    end

    -- if energy > 20 then
    --    local message = "Vous avez besoin de manger !"
    --    local messageColor = Color(255, 0, 0) -- Couleur rouge
    --    draw.SimpleText(message, "Default", ScrW() / 2, ScrH() / 2, messageColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    -- end
    
   
    ------------------------------------
    --------------------------------------Ammo Hud--------------------------------------------------------

if !LocalPlayer():Alive() then return end
    if not IsValid(LocalPlayer():GetActiveWeapon()) then return end

    if LocalPlayer():GetActiveWeapon():Clip1() ~= -1 then
        local roundedWidth = 240
        local roundedHeight = 100
        local borderRadius = 100
        local iconMaterial = Material("materials/jibey_hud/ammo.png")
        local squareX = 1640
        local squareY = 950
        local borderWidth = 5
    
        draw.RoundedBoxEx(borderRadius, squareX - borderWidth, squareY - borderWidth, roundedWidth + 2 * borderWidth, roundedHeight + 2 * borderWidth, Color(0, 200, 255, 150), true, true, true, true)
        draw.RoundedBox(borderRadius, squareX, squareY, roundedWidth, roundedHeight, Color(0, 0, 0, 230))
        draw.SimpleText(LocalPlayer():GetActiveWeapon():Clip1() .. "/" .. LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "Default", ScrW() * 0.935, ScrH() -100, Color( 255,255,255), TEXT_ALIGN_CENTER)

        surface.SetMaterial(iconMaterial)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(squareX + 28, squareY + 15, 70, 70)
    end

     
 --------------------------------------Draw Hud--------------------------------------------------------

-- apres alternative 2

    local rectangle3 = FLT_Rectangle:new()
    rectangle3.DirectDisplay(rectangle3, true, FLT_Size:new(50, 50), FLT_Vector2:new(200,200), Color(0, 50, 255, 150))

-- apres alternative 1

    local rectangle1 = FLT_Rectangle:new()
    rectangle1.SetType(rectangle1, false)
    rectangle1.SetPosition(rectangle1, 200, 200)
    rectangle1.SetSize(rectangle1, 100, 100)
    rectangle1.Display(rectangle1)

-- apres
    local rectType = FLT_Type:new(false)
    local rectPos = FLT_Vector2:new(200,200)
    local rectSize = FLT_Size:new(50, 50)
    local rectangle2 = FLT_Rectangle:new(rectType, rectSize, rectPos, Color(0, 200, 255, 150))

    -- rectangle2.Display(rectangle2)


 -- avant 
    local HUDroundedWidth = 900
    local HUDroundedHeight = 150
    local HUDborderRadius = 100
    local HUDsquareX = 520
    local HUDsquareY = 925
    local HUDborderWidth = 5 

    local HUDsquareX2 = 0
    local HUDsquareY2 = 0
    local HUDroundedWidth2 = 300
    local HUDroundedHeight2 = 300


    
    -- Dessiner la bordure
    draw.RoundedBoxEx(HUDborderRadius, HUDsquareX - HUDborderWidth, HUDsquareY - HUDborderWidth, HUDroundedWidth + 2 * HUDborderWidth, HUDroundedHeight + 2 * HUDborderWidth, Color(0, 200, 255, 150), true, true, true, true)
    
    -- Dessiner la boîte principale
    draw.RoundedBoxEx(HUDborderRadius, HUDsquareX, HUDsquareY, HUDroundedWidth, HUDroundedHeight, Color(0, 0, 0, 230), true, true, true, true)

    ---------------------------------------------------Vie------------------------------------------------------------

    local HUD1roundedWidth = 240
    local HUD1roundedHeight = 100
    local HUD1borderRadius = 100
    local HUD1iconMaterial = Material("materials/jibey_hud/heart.png")
    local HUD1squareX = 520
    local HUD1squareY = 910
    local HUD1borderWidth = 5

    local healthColor = Color(255, 0, 0) -- Couleur rouge par défaut
    if health > 50 then
        healthColor = Color(0, 255, 0) -- Si la santé est supérieure à 50, utilisez la couleur verte
    elseif health > 20 then
        healthColor = Color(255, 255, 0) -- Si la santé est entre 20 et 50, utilisez la couleur jaune
    end

    draw.RoundedBoxEx(HUD1borderRadius, HUD1squareX - HUD1borderWidth, HUD1squareY - HUD1borderWidth, HUD1roundedWidth + 2 * HUD1borderWidth, HUD1roundedHeight + 2 * HUD1borderWidth, Color(0, 200, 255, 0), true, true, true, true)
    draw.RoundedBox(HUD1borderRadius, HUD1squareX, HUD1squareY, HUD1roundedWidth, HUD1roundedHeight, Color(0, 0, 0, 0))

    surface.SetMaterial(HUD1iconMaterial)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(HUD1squareX + 28, HUD1squareY + 15, 70, 70)
    draw.SimpleText(health, "Default", ScrW() * 0.338, ScrH() * 0.87, healthColor, TEXT_ALIGN_CENTER)

    ---------------------------------------------------Armor------------------------------------------------------------

    local HUD2roundedWidth = 240
    local HUD2roundedHeight = 100
    local HUD2borderRadius = 100
    local HUD2iconMaterial = Material("materials/jibey_hud/gilet.png")
    local HUD2squareX = 1295
    local HUD2squareY = 910
    local HUD2borderWidth = 5

    local armorColor = Color(0, 0, 255) -- Couleur bleue par défaut
    if armor > 50 then
        armorColor = Color(0, 255, 0) -- Si l'armure est supérieure à 50, utilisez la couleur verte
    elseif armor > 20 then
        armorColor = Color(255, 255, 0) -- Si l'armure est entre 20 et 50, utilisez la couleur jaune
    end

    draw.RoundedBoxEx(HUD2borderRadius, HUD2squareX - HUD2borderWidth, HUD2squareY - HUD2borderWidth, HUD2roundedWidth + 2 * HUD2borderWidth, HUD2roundedHeight + 2 * HUD2borderWidth, Color(0, 200, 255, 0), true, true, true, true)
    draw.RoundedBox(HUD2borderRadius, HUD2squareX, HUD2squareY, HUD2roundedWidth, HUD2roundedHeight, Color(0, 0, 0, 0))

    surface.SetMaterial(HUD2iconMaterial)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(HUD2squareX + 28, HUD2squareY + 15, 70, 70)
    draw.SimpleText(armor, "Default", ScrW() * 0.685, ScrH() * 0.87, armorColor, TEXT_ALIGN_RIGHT)

    ---------------------------------------------Job----------------------------------------

    local HUD3roundedWidth = 240
    local HUD3roundedHeight = 100
    local HUD3borderRadius = 100
    local HUD3iconMaterial = Material("materials/jibey_hud/malette.png")
    local HUD3squareX = 520
    local HUD3squareY = 980
    local HUD3borderWidth = 5

    draw.RoundedBoxEx(HUD3borderRadius, HUD3squareX - HUD3borderWidth, HUD3squareY - HUD3borderWidth, HUD3roundedWidth + 2 * HUD3borderWidth, HUD3roundedHeight + 2 * HUD3borderWidth, Color(0, 200, 255, 0), true, true, true, true)
    draw.RoundedBox(HUD3borderRadius, HUD3squareX, HUD3squareY, HUD3roundedWidth, HUD3roundedHeight, Color(0, 0, 0, 0))

    surface.SetMaterial(HUD3iconMaterial)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(HUD3squareX + 28, HUD3squareY + 15, 70, 70)
    draw.SimpleText(job, "Default", ScrW() * 0.322, ScrH() * 0.94, Color(255, 255, 255), TEXT_ALIGN_LEFT)

    ----------------------------------------------Hamburger------------------------------------------------OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO

    local HUD4roundedWidth = 240
    local HUD4roundedHeight = 100
    local HUD4borderRadius = 100
    local HUD4iconMaterial = Material("materials/jibey_hud/eats.png")
    local HUD4squareX = 885
    local HUD4squareY = 1003
    local HUD4borderWidth = 5

    --local energyColor = Color(255, 0, 0) -- Couleur rouge par défaut
    --if energy > 50 then
    --    energyColor = Color(0, 255, 0) -- Si l'énergie est supérieure à 50, utilisez la couleur verte
    --elseif energy > 20 then
    --    energyColor = Color(255, 255, 0) -- Si l'énergie est entre 20 et 50, utilisez la couleur jaune
    --end

    draw.RoundedBoxEx(HUD4borderRadius, HUD4squareX - HUD4borderWidth, HUD4squareY - HUD4borderWidth, HUD4roundedWidth + 2 * HUD4borderWidth, HUD4roundedHeight + 2 * HUD4borderWidth, Color(0, 200, 255, 0), true, true, true, true)
    draw.RoundedBox(HUD4borderRadius, HUD4squareX, HUD4squareY, HUD4roundedWidth, HUD4roundedHeight, Color(0, 0, 0, 0))

    surface.SetMaterial(HUD4iconMaterial)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(HUD4squareX + 28, HUD4squareY + 15, 60, 60)
    draw.SimpleText(energy, "Default", ScrW() * 0.52, ScrH() * 0.96, energyColor, TEXT_ALIGN_CENTER)

    ------------------------Money-------------------------------

    local HUD5roundedWidth = 240
    local HUD5roundedHeight = 100
    local HUD5borderRadius = 100
    local HUD5iconMaterial = Material("materials/jibey_hud/wallet.png")
    local HUD5squareX = 1295
    local HUD5squareY = 980
    local HUD5borderWidth = 5

    draw.RoundedBoxEx(HUD5borderRadius, HUD5squareX - HUD5borderWidth, HUD5squareY - HUD5borderWidth, HUD5roundedWidth + 2 * HUD5borderWidth, HUD5roundedHeight + 2 * HUD5borderWidth, Color(0, 200, 255, 0), true, true, true, true)
    draw.RoundedBox(HUD5borderRadius, HUD5squareX, HUD5squareY, HUD5roundedWidth, HUD5roundedHeight, Color(0, 0, 0, 0))

    surface.SetMaterial(HUD5iconMaterial)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(HUD5squareX + 28, HUD5squareY + 15, 70, 70)

    -- Ajoutez le symbole d'euro à gauche de la valeur de l'argent (ajustez la valeur pour déplacer vers la gauche)
    local euroSymbolX = ScrW() * 0.625
    local euroSymbolWidth, euroSymbolHeight = surface.GetTextSize("€")
    draw.SimpleText("€", "Default", euroSymbolX, ScrH() * 0.94, Color(255, 255, 255), TEXT_ALIGN_LEFT)

    -- Affichez le montant d'argent à droite du symbole d'euro avec un espacement
    draw.SimpleText(moneyText, "Default", euroSymbolX + euroSymbolWidth + 10, ScrH() * 0.94, Color(255, 255, 255), TEXT_ALIGN_LEFT)

    -----------------------------------------Avatar--------------------------------------------------

    local HUDAvroundedWidth = 100
    local HUDAvroundedHeight = 100
    local HUDAvborderRadius = 100
    local HUDAvsquareX = 922.5
    local HUDAvsquareY = 914
    local HUDAvborderWidth = 5

    draw.RoundedBoxEx(HUDAvborderRadius, HUDAvsquareX - HUDAvborderWidth, HUDAvsquareY - HUDAvborderWidth, HUDAvroundedWidth + 2 * HUDAvborderWidth, HUDAvroundedHeight + 2 * HUDAvborderWidth, Color(0, 200, 255, 150), true, true, true, true)
    draw.RoundedBox(HUDAvborderRadius, HUDAvsquareX, HUDAvsquareY, HUDAvroundedWidth, HUDAvroundedHeight, Color(0, 0, 0, 255))

    local function CheckPlayerDeath()
        if IsValid(jibey_avatar) and not LocalPlayer():Alive() then
            jibey_avatar:Remove()
            jibey_avatar = nil
        end
    end
    
    -- Hook "Think" pour appeler la fonction de v�rification r�guli�rement
    hook.Add("Think", "CheckPlayerDeath", CheckPlayerDeath)
    
    -- Hook "CreateMove" pour détecter si la touche �chap est press�e
    hook.Add("CreateMove", "RemoveAvatarOnEscape", function(cmd)
        if IsValid(jibey_avatar) and input.IsKeyDown(KEY_ESCAPE) then
            jibey_avatar:Remove()
            jibey_avatar = nil
        end
    end)
    
    -- Cr�ez l'avatar � l'initialisation (vous pouvez �galement le cr�er ailleurs dans votre code si n�cessaire)
    if not jibey_avatar then
        jibey_avatar = vgui.Create("AvatarImage")
        jibey_avatar:SetSize(ScrW() * 0.035, ScrH() * 0.065)
        jibey_avatar:SetPos(ScrW() * 0.49, ScrH() * 0.86)
        jibey_avatar:SetPlayer(LocalPlayer(), 64)
    end
    --------------------------------------------------Name RP----------------------------------------------------

    local HUD5roundedWidth = 460
    local HUD5roundedHeight = 100
    local HUD5borderRadius = 100
    local HUD5iconMaterial = Material("materials/jibey_hud/name.png")
    local HUD5squareX = 20
    local HUD5squareY = 950
    local HUD5borderWidth = 5

    draw.RoundedBoxEx(HUD5borderRadius, HUD5squareX - HUD5borderWidth, HUD5squareY - HUD5borderWidth, HUD5roundedWidth + 2 * HUD5borderWidth, HUD5roundedHeight + 2 * HUD5borderWidth, Color(0, 200, 255, 150), true, true, true, true)
    draw.RoundedBox(HUD5borderRadius, HUD5squareX, HUD5squareY, HUD5roundedWidth, HUD5roundedHeight, Color(0, 0, 0, 230))

    surface.SetMaterial(HUD5iconMaterial)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(HUD5squareX + 10, HUD5squareY + 5, 85, 85)
    draw.SimpleText(name, "Default", ScrW() * 0.055, ScrH() * 0.912, Color(255, 255, 255), TEXT_ALIGN_LEFT)

end)

local HideElement = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,

    ["DarkRP_HUD"] = false,
    ["DarkRP_EntityDisplay"] = true,
    ["DarkRP_LocalPlayerHUD"] = true,
    ["DarkRP_Hungermod"] = true,
    ["DarkRP_Agenda"] = true,
    ["DarkRP_LockdownHUD"] = true,
    ["DarkRP_ArrestedHUD"] = true,
    ["DarkRP_ChatReceivers"] = true,
}

hook.Add("HUDShouldDraw", "mTxServ:ShouldDraw", function(name)
    if HideElement[name] then return false end
end)