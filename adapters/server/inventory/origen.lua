local adapter = {}

function adapter.canCarryItem(source, item, amount)
    local canCarry, reason = exports['origen_inventory']:canCarryItem(source, item, amount)
    return canCarry
end

FM_Adapter_server_inventory_origen = adapter