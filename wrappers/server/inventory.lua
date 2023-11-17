FM.inventory = {}

---@param item string
---@return string label
function FM.inventory.getItemLabel(item)
    if not item then return end

    if ESX then return ESX.GetItemLabel(item)
    elseif QB then return QB.Shared.Items[item].label end
end

FM.inv = FM.inventory