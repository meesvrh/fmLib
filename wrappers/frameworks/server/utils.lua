---@param src number
---@param msg string
---@param type? 'error'|'success'
function FM.notify(src, msg, type)
    if not src then return end
    if not msg then return end

    if ESX then TriggerClientEvent('esx:showNotification', src, msg, type)
    elseif QB then TriggerClientEvent('QBCore:Notify', src, msg, type) end
end