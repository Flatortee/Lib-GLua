FLT_List = {}
FLT_List.__index = FLT_List

function FLT_List:new()
    local obj = setmetatable({}, FLT_List)
    obj.items = {}
    return obj
end

function FLT_List:Add(item)
    table.insert(self.items, item)
end

function FLT_List:Remove(item)
    table.remove(self.items, item)
end

function FLT_List:Get(index)
    return self.items[index]
end

function FLT_List:Count()
    return #self.items
end
