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
--- Currently not working for weapons in ESX & OXInv
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

---@param inv string inventory name/player source
---@param slot? number slot number
function FM.inventory.getMetaDataBySlot(inv, slot)
    if OXInv then return OXInv:GetSlot(inv, slot)?.metadata
    elseif COREInv then return COREInv:getItemBySlot(inv, slot)?.metadata
    elseif QSInv then
        local items = QSInv:GetInventory(inv)
        for _, item in pairs(items) do
            if item.slot == slot then return item.info end
        end
    elseif QBInv then return QBInv:GetItemBySlot(inv, slot)?.info end

    Debug('(inventory.getMetaDataBySlot) Missing compatibility')
end

---@param inv string inventory name/player source
---@param itemName string item name
function FM.inventory.getSlotIDByItem(inv, itemName)
    if OXInv then return OXInv:GetSlotIdWithItem(inv, itemName)
    elseif QBInv then return QBInv:GetFirstSlotByItem(QB.Functions.GetPlayer(inv).PlayerData.Items, itemName)
    elseif COREInv then return COREInv:getFirstSlotByItem(inv, itemName)
    elseif QSInv then
        local items = QSInv:GetInventory(inv)
        for name, item in pairs(items) do
            if name == itemName then return item.slot end
        end
    elseif PSInv then return PSInv:GetFirstSlotByItem(FM.player.get(inv).getItems(), itemName) end

    Debug('(inventory.getSlotIDByItem) Missing compatibility')
end

---@param inv string inventory name/player source
---@param slot number slot number
---@param metadata table metadata
function FM.inventory.setMetaDataBySlot(inv, slot, metadata)
    if OXInv then return OXInv:SetMetadata(inv, slot, metadata)
    elseif COREInv then return COREInv:setMetadata(inv, slot, metadata)
    elseif QSInv then return QSInv:SetItemMetadata(inv, slot, metadata)
    elseif QBInv then return QBInv:SetMetaData(inv, slot, metadata) end

    Debug('(inventory.setMetaDataBySlot) Missing compatibility')
end

--- Only necessary for ox-inventory
---@param stash { id: string | number, label: string, slots: number, weight: number, owner?: string | boolean, groups?: table, coords?: vector3 | vector3[] }
function FM.inventory.registerStash(stash)
    if OXInv then
        OXInv:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, stash.owner, stash.groups, stash.coords)
    end
end

--- Only necessary for ox-inventory
---@param stashId string | number
---@param newWeight? number
---@param newSlots? number
function FM.inventory.upgradeStash(stashId, newWeight, newSlots)
    if newWeight then
        if OXInv then OXInv:SetMaxWeight(stashId, newWeight) end
    end

    if newSlots then
        if OXInv then OXInv:SetSlotCount(stashId, newSlots) end
    end
end

--[[
    INTERNAL EVENT HANDLERS
    DO NOT USE
--]]

RegisterNetEvent('fm:internal:openStash', function(stashId, owner, weight, slots)
    local src = source
    exports['qb-inventory']:OpenInventory(src, stashId, {
        maxweight = weight,
        slots = slots,
    })
end)

-- Compatibility bridge for older versions
FM.inventory.getSlotIDWithItem = FM.inventory.getSlotIDByItem
FM.inventory.getMetaData = FM.inventory.getMetaDataBySlot

-- Aliases
FM.inv = FM.inventory