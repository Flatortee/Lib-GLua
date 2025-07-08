include("autorun/client/Utils/game_manager.lua")
include("autorun/client/Utils/resource_manager.lua")
include("autorun/client/Utils/type.lua")
include("autorun/client/Utils/vector2.lua")
include("autorun/client/Utils/size.lua")
include("autorun/client/Components/rectangle.lua")
include("autorun/client/Components/circle.lua")
include("autorun/client/Components/sprite.lua")
include("autorun/client/Components/text.lua")

GameManager = FLT_GameManager:new()
ResourceManager = FLT_ResourceManager:new()
System = System or {}
init = false

function System:HideDefaultHUD()
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
end

function System:ForceLoadResource(path)
    ResourceManager:Init(path)
end

function System:Init(func, addonName, path, isDebugMode)

    if addonName then
        print("Initialisation : " ..addonName)
    end

    if isDebugMode then
        System:ForceLoadResource("materials/jibey_hud/")
    end

    hook.Add("InitPostEntity", "GameLoop_Init", function()
        if not init then
            ResourceManager:Init(path)
            func()
            init = true
        end
    end)
end

function System:Update(func)
    hook.Add("Think", "GameLoop_Update", function()
        func()
    end)
end

function System:Display(func)
    hook.Add("HUDPaint", "GameLoop_Display", function()
        func()
    end)
end
