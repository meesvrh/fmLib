local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.addItem(src, item, amount, metadata)
    if not exports[resourceName]:CanCarryItem(src, item, amount) then return false end
    local success = exports[resourceName]:AddItem(src, item, amount, nil, metadata, false)
    return success or false
end

function adapter.removeItem(src, item, amount, slot, metadata)
    local success = exports[resourceName]:RemoveItem(src, item, amount, slot, metadata)
    return success or false
end

function adapter.canCarryItem(src, item, amount)
    return exports[resourceName]:CanCarryItem(src, item, amount)
end

function adapter.hasItem(src, item, amount)
    return exports[resourceName]:HasItem(src, item, amount or 1)
end

function adapter.getItem(src, item, metadata)
    local _item = exports[resourceName]:GetItemByName(src, item, metadata)
    if not _item then return nil end
    return {
        name = _item.name,
        label = _item.label,
        amount = _item.amount,
        metadata = _item.info or _item.metadata or {},
    }
end

function adapter.getInventory(src)
    local inventory = {}
    local items = exports[resourceName]:GetPlayerItems(src)
    for _, item in pairs(items) do
        if tonumber(_) then
            inventory[item.slot] = {
                name = item.name,
                label = item.label,
                amount = item.amount,
                metadata = item.info or item.metadata,
            }
        end
    end
    return inventory
end

function adapter.getItemLabel(item)
    local itemList = exports[resourceName]:GetItemList()
    return itemList[item] and itemList[item].label
end

function adapter.getMetaDataBySlot(src, slot)
    local item = exports[resourceName]:GetItemBySlot(src, slot)
    return item and (item.info or item.metadata)
end

function adapter.setMetaDataBySlot(src, slot, metadata)
    local item = exports[resourceName]:GetItemBySlot(src, slot)
    if not item then return end
    exports[resourceName]:UpdateItemMetadata(src, item.name, slot, metadata)
end

function adapter.registerStash(stash)
    -- tgiann-inventory creates stashes on demand via ForceOpenInventory
end

function adapter.openStash(src, stashId, stashData)
    local data = stashData or {}
    exports[resourceName]:ForceOpenInventory(src, "stash", stashId, {
        maxWeight = data.weight or 1000000,
        slots = data.slots or 50,
        label = data.label or "Stash",
    })
end

function adapter.clearStash(id, _type)
    exports[resourceName]:DeleteInventory(_type or "stash", id)
end

function adapter.addTrunkItems(identifier, items)
    if type(items) ~= "table" then return false end
    for _, v in pairs(items) do
        exports[resourceName]:AddItemToSecondaryInventory("trunk", identifier, v.item, v.count, nil, v.metadata)
    end
    return true
end

function adapter.updatePlate(oldplate, newplate)
    local queries = {
        'UPDATE tgiann_inventory_trunkitems SET plate = @newplate WHERE plate = @oldplate',
        'UPDATE tgiann_inventory_gloveboxitems SET plate = @newplate WHERE plate = @oldplate',
    }
    MySQL.transaction.await(queries, { newplate = newplate, oldplate = oldplate })
    exports[resourceName]:UpdateVehicle(oldplate, newplate)
end

function adapter.openPlayerInventory(src, target)
    exports[resourceName]:OpenInventoryById(src, target)
end

FM_Adapter_server_inventory_tgiann = adapter