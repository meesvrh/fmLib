FM.inventory = {}

---@param type 'otherplayer'
---@param id string | number
function FM.inventory.open(type, id)
    if not type or not id then return end
    
    if QBInv then
        TriggerServerEvent("inventory:server:OpenInventory", type, id)
    end
end

function FM.inventory.getItemsAmounts()
    local items = FM.inventory.getItems()
    local amounts = {}

    for i = 1, #items do
        local item = items[i]
        if amounts[item.name] then
            amounts[item.name] = amounts[item.name] + item.amount
        else
            amounts[item.name] = item.amount
        end
    end

    return amounts
end

-- TODO: test for qbcore
function FM.inventory.getItems()
    local inventory = {}

    if OXInv then
        local items = OXInv:GetPlayerItems()
        for i = 1, #items do
            local item = items[i]
            inventory[#inventory+1] = {
                name = item.name,
                label = item.label,
                amount = item.count
            }
        end
    elseif ESX then
        local items = ESX.GetPlayerData().inventory
        for i = 1, #items do
            local item = items[i]
            inventory[#inventory+1] = {
                name = item.name,
                label = item.label,
                amount = item.count
            }
        end
    elseif QB then
        local items = QB.Functions.GetPlayerData().items
        for i = 1, #items do
            local item = items[i]
            inventory[#inventory+1] = {
                name = item.name,
                label = item.label,
                amount = item.amount
            }
        end
    end

    return inventory
end

FM.inv = {}