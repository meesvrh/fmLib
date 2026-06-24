local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.openStash(stashId, owner, weight, slots)
    if not stashId then
        Error('No stash ID provided')
        return
    end

    local data = { id = stashId }

    if owner ~= nil then
        data.owner = owner
    end

    if weight then
        data.maxWeight = weight
    end

    if slots then
        data.slots = slots
    end

    exports[resourceName]:OpenInventory('stash', data)
end

function adapter.getItems()
    local inventory = {}
    local items = exports[resourceName]:GetInventoryItems()

    for _, item in ipairs(items) do
        inventory[item.slot] = {
            name = item.name,
            label = item.label,
            amount = item.count,
            metadata = item.metadata,
        }
    end

    return inventory
end

function adapter.hasItem(item, requiredCount)
    return exports[resourceName]:HasItem(item, requiredCount or 1)
end

function adapter.displayMetadata(metadata)
    exports[resourceName]:ShowItemMetadata(metadata)
end

function adapter.getImgDirectory()
    return 'one_inventory/web/images/'
end

FM_Adapter_client_inventory_one = adapter
