FM.inventory = {}

---@param itemName string item name
---@param cb function callback(src, item)
function FM.inventory.registerUsableItem(itemName, cb)
    if ESX then
        ESX.RegisterUsableItem(itemName, function(src, item)
            cb(src, item)
        end)
    elseif QB then
        QB.Functions.CreateUseableItem(itemName, function(src, item)
            cb(src, item)
        end)
    end
end

---@param item string
---@return string label
function FM.inventory.getItemLabel(item)
    if not item then return end

    if ESX then return ESX.GetItemLabel(item)
    elseif QB then return QB.Shared.Items[item].label end
end

FM.inv = FM.inventory