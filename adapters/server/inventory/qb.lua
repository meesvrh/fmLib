local adapter = {}

local function isNewQBInv()
    local version = GetResourceMetadata(Resources.QBInv.name or 'qb-inventory', 'version', 0)
    if not version then return false end

    local vNums = {}

    for num in version:gmatch("(%d+)") do
        vNums[#vNums + 1] = tonumber(num)
    end

    return vNums and vNums[1] >= 2
end

function adapter.canCarryItem(src, item, amount)
    if isNewQBInv() then
        return exports['qb-inventory']:CanAddItem(src, item, amount)
    end
    return true
end

function adapter.getMetaDataBySlot(inv, slot)
    return exports['qb-inventory']:GetItemBySlot(inv, slot)?.info
end

function adapter.getSlotIDByItem(inv, itemName)
    return exports['qb-inventory']:GetFirstSlotByItem(QB.Functions.GetPlayer(inv).PlayerData.Items, itemName)
end

function adapter.setMetaDataBySlot(inv, slot, metadata)
    return exports['qb-inventory']:SetMetaData(inv, slot, metadata)
end

FM_Adapter_server_inventory_qb = adapter