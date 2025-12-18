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

FM_Adapter_server_inventory_qb = adapter