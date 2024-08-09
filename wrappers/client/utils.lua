FM.utils = {}

---@param message string
---@param type? 'error'|'success'
function FM.utils.notify(message, type)
    if not message then return end

    if MOVHUD then MOVHUD:ShowNotification(message, type)
    elseif ESX then ESX.ShowNotification(message, type)
    elseif QB then QB.Functions.Notify(message, type) end
end