FM.inventory = {}

local function isNewQBInv()
    local version = GetResourceMetadata(Resources.QBInv.name or 'qb-inventory', 'version', 0)
    if not version then return false end

    local vNums = {}

    for num in version:gmatch("(%d+)") do
        vNums[#vNums + 1] = tonumber(num)
    end

    return vNums and vNums[1] >= 2
end

local function isNewPSInv()
    local version = GetResourceMetadata('ps-inventory', 'version', 0)
    if not version then return false end

    local vNums = {}

    for num in version:gmatch("(%d+)") do
        vNums[#vNums + 1] = tonumber(num)
    end

    return vNums and vNums[1] >= 2
end

--- Currently only working for qb-inventory
---@param type 'otherplayer'
---@param id string | number
function FM.inventory.open(type, id)
    if not type or not id then return end

    if QBInv then
        TriggerServerEvent("inventory:server:OpenInventory", type, id)
    end
end

---@param stashId string | number
---@param owner? string | boolean
---@param weight? number
---@param slots? number
function FM.inventory.openStash(stashId, owner, weight, slots)
    if not stashId then
        FM.console.err('No stash ID provided')
        return
    end

    if OXInv then
        OXInv:openInventory('stash', { id = stashId, owner = owner })
    elseif QBInv or QSInv or PSInv or CODEMInv then
        if (QBInv and isNewQBInv()) or (PSInv and isNewPSInv()) then
            TriggerServerEvent('fm:internal:openStash', stashId, owner, weight, slots)
        else
            if QSInv then
                QSInv:RegisterStash(stashId, slots, weight)
            end

            TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashId, {
                maxweight = weight,
                slots = slots,
            })
            TriggerEvent('inventory:client:SetCurrentStash', stashId)
        end
    elseif JPRInv then
        TriggerServerEvent('fm:internal:openStash', stashId, owner, weight, slots)
    else
        FM.console.err("No inventory found for opening stash")
    end
end

function FM.inventory.getItemsAmounts()
    local items = FM.inventory.getItems()
    local amounts = {}

    for slot, item in pairs(items) do
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
        for slot, item in pairs(items) do
            inventory[slot] = {
                name = item.name,
                label = item.label,
                amount = item.count
            }
        end
    elseif ESX then
        local items = ESX.GetPlayerData().inventory
        for slot, item in pairs(items) do
            inventory[slot] = {
                name = item.name,
                label = item.label,
                amount = item.count
            }
        end
    elseif QB then
        local items = QB.Functions.GetPlayerData().items
        for slot, item in pairs(items) do
            inventory[slot] = {
                name = item.name,
                label = item.label,
                amount = item.amount
            }
        end
    end

    return inventory
end

---@param metadata table<string|number, string>
function FM.inventory.displayMetadata(metadata)
    if OXInv then
        OXInv:displayMetadata(metadata)
    end
end

---@param state boolean
function FM.inventory.setWeaponWheel(state)
    if OXInv then
        OXInv:weaponWheel(state)
    elseif QSInv then
        QSInv:WeaponWheel(state)
    end
end

---@param item string
function FM.inventory.hasItem(item)
    if ESX then
        local has = ESX.SearchInventory(item, 1)
        return has and has > 0
    elseif QB then
        return QB.Functions.HasItem(item)
    end
end

FM.inv = {}
