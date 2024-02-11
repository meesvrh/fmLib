FM.inventory = {}

---@param itemName string
---@param cb function
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

local cachedItemLabels = {}
---@param item string
---@return string label
function FM.inventory.getItemLabel(item)
    if not item then return end

    if OXInv then
        if cachedItemLabels[item] then return cachedItemLabels[item]
        else
            for itemName, v in pairs(OXInv:Items()) do
                cachedItemLabels[itemName] = v.label
            end

            return cachedItemLabels[item]
        end
    elseif ESX then return ESX.GetItemLabel(item)
    elseif QB then return QB.Shared.Items[item].label end
end

FM.inv = FM.inventory