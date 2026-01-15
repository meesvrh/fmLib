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