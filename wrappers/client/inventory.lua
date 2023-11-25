FM.inventory = {}

---@param type 'otherplayer'
---@param id string | number
function FM.inventory.open(type, id)
    if not type or not id then return end
    
    if QBInv then
        TriggerServerEvent("inventory:server:OpenInventory", type, id)
    end
end

FM.inv = {}