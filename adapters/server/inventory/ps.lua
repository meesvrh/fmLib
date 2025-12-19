local adapter = {}

function adapter.getSlotIDByItem(inv, itemName)
    return exports['ps-inventory']:GetFirstSlotByItem(FM.player.get(inv).getItems(), itemName)
end

FM_Adapter_server_inventory_ps = adapter