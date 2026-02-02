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

    exports[resourceName]:openInventory('stash', { id = stashId, owner = owner })
end

function adapter.getItems()
    local inventory = {}
    local items = exports[resourceName]:GetPlayerItems()

    for slot, item in pairs(items) do
        inventory[slot] = {
            name = item.name,
            label = item.label,
            amount = item.count
        }
    end

    return inventory
end

function adapter.displayMetadata(metadata)
    exports[resourceName]:displayMetadata(metadata)
end

function adapter.setWeaponWheel(state)
    exports[resourceName]:weaponWheel(state)
end

function adapter.getImgDirectory()
    return 'ox_inventory/web/images/'
end

FM_Adapter_client_inventory_ox = adapter