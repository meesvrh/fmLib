--[[
    fmLib - Vehicle Keys Client Adapter
]]

FM = FM or {}
FM.keys = FM.keys or {}

local keysAdapter = BaseAdapter:new('keys', 'client')

---@param vehicle number Vehicle entity handle to give keys for
---@return boolean|nil success True if keys were given successfully
function FM.keys.give(vehicle)
    return keysAdapter:call('give', vehicle)
end

---@param vehicle number Vehicle entity handle to remove keys for
---@return boolean|nil success True if keys were removed successfully
function FM.keys.remove(vehicle)
    return keysAdapter:call('remove', vehicle)
end

---@param vehicle number Vehicle entity handle to check keys for
---@return boolean hasKeys True if player has keys for the vehicle
function FM.keys.has(vehicle)
    return keysAdapter:call('has', vehicle)
end

-- Backwards compatibility
FM.vehicle = FM.vehicle or {}

---@deprecated Use FM.keys.give instead
---@param vehicle number Vehicle entity handle
---@return boolean|nil success
function FM.vehicle.giveKeys(vehicle)
    Warning('FM.vehicle.giveKeys is deprecated, use FM.keys.give instead')
    return FM.keys.give(vehicle)
end

---@deprecated Use FM.keys.remove instead
---@param vehicle number Vehicle entity handle
---@return boolean|nil success
function FM.vehicle.removeKeys(vehicle)
    Warning('FM.vehicle.removeKeys is deprecated, use FM.keys.remove instead')
    return FM.keys.remove(vehicle)
end

---@deprecated Use FM.keys.has instead
---@param vehicle number Vehicle entity handle
---@return boolean hasKeys
function FM.vehicle.hasKey(vehicle)
    Warning('FM.vehicle.hasKey is deprecated, use FM.keys.has instead')
    return FM.keys.has(vehicle)
end