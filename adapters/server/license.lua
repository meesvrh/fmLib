--[[
    fmLib - License Server Adapter
]]

FM = FM or {}
FM.license = FM.license or {}

local licenseAdapter = BaseAdapter:new('license', 'server')

---@param src number The source/player ID
---@param license string The license to check
---@return boolean Whether the player has the license
function FM.license.has(src, license)
    return licenseAdapter:call('has', src, license)
end

---@param src number The source/player ID
---@param license string The license to grant
---@return boolean Whether the license was newly granted (false if player already had it or grant failed)
function FM.license.give(src, license)
    return licenseAdapter:call('give', src, license)
end

---@param src number The source/player ID
---@param license string The license to revoke
---@return boolean Whether the license was removed (false if player did not have it)
function FM.license.remove(src, license)
    return licenseAdapter:call('remove', src, license)
end