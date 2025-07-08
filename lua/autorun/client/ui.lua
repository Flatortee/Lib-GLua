FLT_UI = {}
FLT_UI.__index = FLT_UI

displayList = FLT_List:new()

function FLT_UI:new()
    local obj = setmetatable({}, FLT_UI)
    return obj
end

function FLT_UI:Display(list)

    for index, value in ipairs(list) do
        print(index, value)
    end

end