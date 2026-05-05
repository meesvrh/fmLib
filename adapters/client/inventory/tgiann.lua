local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.hasItem(item, requiredCount)
    return exports[resourceName]:HasItem(item, requiredCount or 1)
end

function adapter.getItemCount(item)
    return exports[resourceName]:GetItemCount(item, nil, false) or 0
end

function adapter.getItems()
    local inventory = {}
    local items = exports[resourceName]:GetPlayerItems()
    for _, item in pairs(items) do
        inventory[item.slot] = {
            name = item.name,
            label = item.label,
            amount = item.amount,
            metadata = item.info or item.metadata,
            stack = item.unique,
            weight = item.weight,
        }
    end
    return inventory
end

function adapter.getItemInfo(item)
    local itemList = exports[resourceName]:GetItemList()
    if not itemList or not itemList[item] then return {} end
    local data = itemList[item]
    return {
        name = data.name or item,
        label = data.label or item,
        stack = data.unique or false,
        weight = data.weight or 0,
        description = data.description or "",
        image = data.image or ("nui://" .. resourceName .. "/html/images/" .. item .. ".png"),
    }
end

function adapter.openStash(stashId, owner, weight, slots)
    if not stashId then return end
    TriggerServerEvent('fm:internal:openStash', stashId, owner, weight, slots)
end

function adapter.getImgDirectory()
    return resourceName .. '/html/images/'
end

FM_Adapter_client_inventory_tgiann = adapter
