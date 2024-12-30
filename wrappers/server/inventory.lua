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
---@param slot number
function FM.inventory.getMetaData(inv, slot)
    if OXInv then return OXInv:GetSlot(inv, slot).metadata
    elseif QB then return QB.Functions.GetPlayer(inv).PlayerData.items[slot].info end
end

---@param inv string inventory name/player source
---@param itemName string
function FM.inventory.getSlotIDWithItem(inv, itemName)
    if OXInv then return OXInv:GetSlotIdWithItem(inv, itemName)
    elseif PSInv then return PSInv:GetFirstSlotByItem(FM.player.get(inv).getItems(), itemName) end
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

FM.inv = FM.inventory