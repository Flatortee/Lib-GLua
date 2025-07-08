FLT_GameManager = {}
FLT_GameManager.__index = FLT_GameManager

function FLT_GameManager:new()
    local obj = setmetatable({}, FLT_GameManager)
    return obj
end

function FLT_GameManager:GetPlayer()
    return LocalPlayer()
end

function FLT_GameManager:GetPlayerLife()
    return LocalPlayer():Health()
end

function FLT_GameManager:GetPlayerArmor()
    return LocalPlayer():Armor()
end

function FLT_GameManager:GetPlayerName()
    return LocalPlayer():getDarkRPVar("rpname")
end

function FLT_GameManager:GetPlayerMoney()
    return LocalPlayer():getDarkRPVar("money")
end

function FLT_GameManager:GetPlayerEnergy()
    return LocalPlayer():getDarkRPVar("Energy")
end

function FLT_GameManager:GetPlayerJob()
    return LocalPlayer():getDarkRPVar("job")
end

