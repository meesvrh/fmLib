--[[
    fmLib - Framework Client Adapter
]]

FM = FM or {}
FM.framework = FM.framework or {}

local frameworkAdapter = BaseAdapter:new('framework', 'client')

---@param vehicle number Vehicle entity handle
---@return string plate Trimmed vehicle license plate text
function FM.framework.getPlate(vehicle)
    return frameworkAdapter:call('getPlate', vehicle)
end

---@param message string Notification message to display
---@param type? 'error'|'success'|'info' Notification type (optional, defaults to info)
---@return nil
function FM.framework.notify(message, type)
    return frameworkAdapter:call('notify', message, type)
end

---@param item string Item name to check
---@return boolean hasItem True if player has the item
function FM.framework.hasItem(item)
    return frameworkAdapter:call('hasItem', item)
end

---@return table<number, { name: string, label: string, amount: number, metadata?: table }> items Table of player items indexed by slot
function FM.framework.getItems()
    return frameworkAdapter:call('getItems')
end

-- Backwards compatibility
FM.vehicle = FM.vehicle or {}
FM.utils = FM.utils or {}

---@deprecated Use FM.framework.getPlate instead
---@param vehicle number Vehicle entity handle
---@return string plate Trimmed vehicle license plate
function FM.vehicle.getPlate(vehicle)
    Warning('FM.vehicle.getPlate is deprecated, use FM.framework.getPlate instead')
    return FM.framework.getPlate(vehicle)
end

---@deprecated Use FM.framework.notify instead
---@param message string Notification message
---@param type? 'error'|'success'|'info' Notification type
---@return nil
function FM.utils.notify(message, type)
    Warning('FM.utils.notify is deprecated, use FM.framework.notify instead')
    return FM.framework.notify(message, type)
end