--[[
    fmLib - Player Client Adapter
]]

FM = FM or {}
FM.player = FM.player or {}

local playerAdapter = BaseAdapter:new('player', 'client')

---@return boolean isLoggedIn True if player is logged in with a character
function FM.player.isLoggedIn()
    return playerAdapter:call('isLoggedIn')
end

---@return string|nil fullname Player's full name (firstname lastname) or nil if not logged in
function FM.player.getFullName()
    return playerAdapter:call('getFullName')
end

---@return string|nil identifier Player's unique identifier (ESX identifier or QB citizen ID) or nil if not logged in
function FM.player.getIdentifier()
    return playerAdapter:call('getIdentifier')
end

---@return { name: string, label: string, grade: number, gradeLabel: string }|nil job Player's job data or nil if not logged in
function FM.player.getJob()
    return playerAdapter:call('getJob')
end

---@return { name: string, label: string, grade: number, gradeLabel: string }|nil gang Player's gang data (QB only, nil for ESX)
function FM.player.getGang()
    return playerAdapter:call('getGang')
end