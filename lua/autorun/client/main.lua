include("autorun/client/system.lua")
include("autorun/client/Utils/resource_manager.lua")

local addonName = "ExempleAddon"
function Init()
    -- CODE HERE --
end
System:HideDefaultHUD()
System:Init(Init, addonName, "resources/materials/", true)

function Update()
    -- CODE HERE --
end
System:Update(Update)

function Display()
    -- CODE HERE --
end
System:Display(Display)
