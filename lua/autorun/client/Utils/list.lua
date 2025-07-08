List = {}
List.__index = List

function List:new()
    local obj = setmetatable({}, List)
    obj.items = {}
    return obj
end

function List:Add(item)
    table.insert(self.items, item)
end

function List:Remove(item)
    table.remove(self.items, item)
end

function List:Get(index)
    return self.items[index]
end

function List:Count()
    return #self.items
end
