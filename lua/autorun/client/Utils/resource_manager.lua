FLT_ResourceManager = FLT_ResourceManager or {}

function FLT_ResourceManager:new()
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.materials = {}
    return obj
end

function FLT_ResourceManager:AddMaterial(name, mat)
    self.materials[name] = mat
end

function FLT_ResourceManager:GetMaterial(name)
    return self.materials[name]
end

function FLT_ResourceManager:Init(resourcePath)
    -- S'assurer que le chemin se termine par un slash
    if not resourcePath:match("/$") then
        resourcePath = resourcePath .. "/"
    end

    local files, dirs = file.Find(resourcePath .. "*.png", "GAME")

    for _, filename in ipairs(files) do
        local matName = filename:gsub("%.png$", "")
        local fullPath = resourcePath .. filename -- inclure le .png

        -- Les flags doivent être passés en second argument
        local mat = Material(fullPath, "smooth mips") -- flags recommandés

        self:AddMaterial(matName, mat)
    end
end
