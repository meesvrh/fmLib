local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.getSlotIDByItem(inv, itemName)
    return exports[resourceName]:GetFirstSlotByItem(FM.player.get(inv).getItems(), itemName)
end

FM_Adapter_server_inventory_ps = adapter