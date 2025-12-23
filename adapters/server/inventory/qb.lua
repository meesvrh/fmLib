local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

local function isNewQBInv()
    local version = GetResourceMetadata('qb-inventory', 'version', 0)
    if not version then return false end

    local vNums = {}

    for num in version:gmatch("(%d+)") do
        vNums[#vNums + 1] = tonumber(num)
    end

    return vNums and vNums[1] >= 2
end

function adapter.canCarryItem(src, item, amount)
    if isNewQBInv() then
        return exports[resourceName]:CanAddItem(src, item, amount)
    end
    return true
end

function adapter.getMetaDataBySlot(inv, slot)
    return exports[resourceName]:GetItemBySlot(inv, slot)?.info
end

function adapter.getSlotIDByItem(inv, itemName)
    return exports[resourceName]:GetFirstSlotByItem(QB.Functions.GetPlayer(inv).PlayerData.Items, itemName)
end

function adapter.setMetaDataBySlot(inv, slot, metadata)
    return exports[resourceName]:SetMetaData(inv, slot, metadata)
end

FM_Adapter_server_inventory_qb = adapter