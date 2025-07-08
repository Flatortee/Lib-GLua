include("autorun/client/system.lua")
include("autorun/client/Utils/resource_manager.lua")



    -- Variables globales
local cachedAvatarMat = nil
local HUDAvSize = 100
local HUDAvX = 922.5
local HUDAvY = 914
local HUDAvBorderWidth = 5

-- Téléchargement et cache d'avatar Steam (extrait simplifié)
local AVATAR_IMAGE_CACHE_EXPIRES = 86400 -- 1 jour en secondes

function getAvatarMaterial(steamid64, callback)
    local fallback
    if os.time() - file.Time("avatars/" .. steamid64 .. ".png", "DATA") > AVATAR_IMAGE_CACHE_EXPIRES then
        fallback = Material("../data/avatars/" .. steamid64 .. ".png", "smooth")
    elseif os.time() - file.Time("avatars/" .. steamid64 .. ".jpg", "DATA") > AVATAR_IMAGE_CACHE_EXPIRES then
        fallback = Material("../data/avatars/" .. steamid64 .. ".jpg", "smooth")
    end

    if not fallback or fallback:IsError() then
        fallback = Material("vgui/avatar_default")
    else
        return callback(fallback)
    end

    http.Fetch("https://steamcommunity.com/profiles/" .. steamid64 .. "?xml=1",
        function(body, size, headers, code)
            if size == 0 or code < 200 or code > 299 then return callback(fallback, steamid64) end

            local url, fileType = body:match("<avatarFull>.-(https?://%S+%f[%.]%.)(%w+).-</avatarFull>")
            if not url or not fileType then return callback(fallback, steamid64) end
            if fileType == "jpeg" then fileType = "jpg" end

            http.Fetch(url .. fileType,
                function(body, size, headers, code)
                    if size == 0 or code < 200 or code > 299 then return callback(fallback, steamid64) end

                    local cachePath = "avatars/" .. steamid64 .. "." .. fileType
                    file.CreateDir("avatars")
                    file.Write(cachePath, body)

                    local material = Material("../data/" .. cachePath, "smooth")
                    if material:IsError() then
                        file.Delete(cachePath)
                        callback(fallback, steamid64)
                    else
                        callback(material, steamid64)
                    end
                end,
                function() callback(fallback, steamid64) end
            )
        end,
        function() callback(fallback, steamid64) end
    )
end

gameManager = FLT_GameManager:new()


--#region JSP
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
--#endregion

    --#region Exemple

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
    -- local sprite1 = FLT_Sprite:new()
    -- sprite1.SetTexture(sprite1, ResourceManager:GetMaterial("ammo"))
    -- sprite1.SetSize(sprite1, 70, 70)
    -- sprite1.SetPosition(sprite1, 215, 215)
    -- sprite1.Display(sprite1)

    -- Text --
    local text1 = FLT_Text:new()
    text1.SetText(text1, health)
    text1.SetPosition(text1, 350, 230)
    text1.Display(text1)

    -- Button --


    --#endregion

    --#region Avatar


    hook.Add("HUDPaint", "DrawRoundedAvatarOnTop", function()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end

        -- Bordure et fond
        draw.RoundedBoxEx(HUDAvSize / 2, HUDAvX - HUDAvBorderWidth, HUDAvY - HUDAvBorderWidth, HUDAvSize + 2 * HUDAvBorderWidth, HUDAvSize + 2 * HUDAvBorderWidth, Color(0, 200, 255, 150), true, true, true, true)
        draw.RoundedBox(HUDAvSize / 2, HUDAvX, HUDAvY, HUDAvSize, HUDAvSize, Color(0, 0, 0, 255))

        -- Chargement asynchrone de l'avatar (une seule fois)
        if not cachedAvatarMat then
            getAvatarMaterial(ply:SteamID64(), function(mat)
                cachedAvatarMat = mat
            end)
        end

        -- Avatar rond (si déjà chargé)
        if cachedAvatarMat and not cachedAvatarMat:IsError() then
            render.ClearStencil()
            render.SetStencilEnable(true)
            render.SetStencilWriteMask(1)
            render.SetStencilTestMask(1)
            render.SetStencilReferenceValue(1)
            render.SetStencilFailOperation(STENCIL_KEEP)
            render.SetStencilZFailOperation(STENCIL_KEEP)
            render.SetStencilPassOperation(STENCIL_REPLACE)
            render.SetStencilCompareFunction(STENCIL_ALWAYS)

            draw.NoTexture()
            surface.SetDrawColor(255, 255, 255, 255)
            local circle = {}
            local segments = 64
            local radius = HUDAvSize / 2
            local centerX = HUDAvX + radius
            local centerY = HUDAvY + radius
            for i = 0, segments do
                local angle = math.rad((i / segments) * 360)
                table.insert(circle, {
                    x = centerX + math.cos(angle) * radius,
                    y = centerY + math.sin(angle) * radius
                })
            end
            surface.DrawPoly(circle)

            render.SetStencilCompareFunction(STENCIL_EQUAL)
            render.SetStencilPassOperation(STENCIL_KEEP)

            surface.SetMaterial(cachedAvatarMat)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(HUDAvX, HUDAvY, HUDAvSize, HUDAvSize)

            render.SetStencilEnable(false)
            render.ClearStencil()
        end
    end)


    --#endregion

end)


----------------------------------------------------------------- SYS -----------------------------------------------------------------

local addonName = "ExempleAddon"
function Init()
    -- CODE HERE --
end
System:Init(Init, addonName, "materials/jibey_hud/", true)

function Update()
    -- CODE HERE --
end
System:Update(Update)

function Display()
    -- CODE HERE --

    -- Background HUD --
    local rectangle = FLT_Rectangle:new()
    local sprite = FLT_Sprite:new()
    local text = FLT_Text:new()

    rectangle.SetTypeEx(rectangle, true, true, true, true)
    rectangle.SetPosition(rectangle, 515, 920)
    rectangle.SetSize(rectangle, 910, 160, 100)
    rectangle.SetColor(rectangle, Color(0, 200, 255, 150))
    rectangle.Display(rectangle)

    rectangle.SetPosition(rectangle, 520, 925)
    rectangle.SetSize(rectangle, 900, 150, 100)
    rectangle.SetColor(rectangle, Color(0, 0, 0, 230))
    rectangle.Display(rectangle)

    -- Player RP Name --
    rectangle = FLT_Rectangle:new()
    rectangle.SetTypeEx(rectangle, true, true, true, true)
    rectangle.SetPosition(rectangle, 20, 950)
    rectangle.SetSize(rectangle, 460, 100, 100)
    rectangle.SetColor(rectangle, Color(0, 200, 255, 150))
    rectangle.Display(rectangle)

    rectangle.SetPosition(rectangle, 25, 955)
    rectangle.SetSize(rectangle, 450, 90, 100)
    rectangle.SetColor(rectangle, Color(0, 0, 0, 230))
    rectangle.Display(rectangle)

    sprite.SetTexture(sprite, ResourceManager:GetMaterial("name"))
    sprite.SetPosition(sprite, 35, 960)
    sprite.SetSize(sprite, 70, 70)
    sprite.Display(sprite)

    text.SetText(text, FLT_GameManager:GetPlayerName())
    text.SetPosition(text, 170, 985)
    text.Display(text)

    -- Life --
    sprite.SetTexture(sprite, ResourceManager:GetMaterial("heart"))
    text.SetAlign(text, TEXT_ALIGN_LEFT)
    sprite.SetPosition(sprite, 580, 925)
    sprite.SetSize(sprite, 70, 70)
    sprite.Display(sprite)

    local healthColor = Color(255, 0, 0)
    if FLT_GameManager:GetPlayerLife() > 50 then
        healthColor = Color(0, 255, 0)
    elseif FLT_GameManager:GetPlayerLife() > 20 then
        healthColor = Color(255, 255, 0)
    end

    text.SetText(text, tostring(FLT_GameManager:GetPlayerLife()))
    text.SetPosition(text, 650, 940)
    text.SetColor(text, healthColor)
    text.Display(text)

    -- Armor --
    sprite.SetTexture(sprite, ResourceManager:GetMaterial("gilet"))
    sprite.SetPosition(sprite, 1305, 925)
    sprite.SetSize(sprite, 70, 70)
    sprite.Display(sprite)

    local armorColor = Color(0, 0, 255)
    if FLT_GameManager:GetPlayerArmor() > 50 then
        armorColor = Color(0, 255, 0)
    elseif FLT_GameManager:GetPlayerArmor() > 20 then
        armorColor = Color(255, 255, 0)
    end

    text.SetText(text, tostring(FLT_GameManager:GetPlayerArmor()))
    text.SetAlign(text, TEXT_ALIGN_RIGHT)
    text.SetPosition(text, 1300, 940)
    text.SetColor(text, armorColor)
    text.Display(text)

    -- Set Default Color text --
    text.SetColor(text, Color(255,255,255,255))

    -- Job -- 
    sprite.SetTexture(sprite, ResourceManager:GetMaterial("malette"))
    sprite.SetPosition(sprite, 580, 1000)
    sprite.SetSize(sprite, 70, 70)
    sprite.Display(sprite)

    text.SetText(text, tostring(FLT_GameManager:GetPlayerJob()))
    text.SetAlign(text, TEXT_ALIGN_LEFT)
    text.SetPosition(text, 650, 1020)
    text.Display(text)

    -- Money --
    sprite.SetTexture(sprite, ResourceManager:GetMaterial("wallet"))
    sprite.SetPosition(sprite, 1300, 1000)
    sprite.SetSize(sprite, 70, 70)
    sprite.Display(sprite)

    text.SetText(text, tostring("€ " ..FLT_GameManager:GetPlayerMoney()))
    text.SetAlign(text, TEXT_ALIGN_RIGHT)
    text.SetPosition(text, 1300, 1020)
    text.Display(text)

    -- Energy --

    --local energyColor = Color(255, 0, 0) -- Couleur rouge par défaut
    --if energy > 50 then
    --    energyColor = Color(0, 255, 0) -- Si l'énergie est supérieure à 50, utilisez la couleur verte
    --elseif energy > 20 then
    --    energyColor = Color(255, 255, 0) -- Si l'énergie est entre 20 et 50, utilisez la couleur jaune
    --end

    text.SetText(text, tostring(FLT_GameManager:GetPlayerEnergy()))
    text.SetAlign(text, TEXT_ALIGN_RIGHT)
    text.SetPosition(text, 990, 1035)
    text.Display(text)



end
System:Display(Display)
