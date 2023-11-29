FM.utils = {}

---@param msg string
---@param type? 'error'|'success'
function FM.utils.notify(msg, type)
    if not msg then return end

    if ESX then ESX.ShowNotification(msg, type)
    elseif QB then QBCore.Functions.Notify(msg, type) end
end