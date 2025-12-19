--[[
    fmLib - Player Server Adapter
]]

FM = FM or {}
FM.player = FM.player or {}

local playerAdapter = BaseAdapter:new('player', 'server')

---@param identifier string Player identifier (ESX identifier or QB citizen ID)
---@return string|nil fullname Player's full name (firstname lastname) or nil if not found
function FM.player.getFullnameByIdentifier(identifier)
    return playerAdapter:call('getFullnameByIdentifier', identifier)
end

---@param id number|string Player source ID (number) or identifier (string)
---@return table|nil player Player object with methods and data, or nil if not found
---@return Player object contains methods like:
--- - getIdentifier() -> string
--- - getName() -> string
--- - getFullName() -> string
--- - getFirstName() -> string
--- - getLastName() -> string
--- - getSource() -> number
--- - getJob() -> { name: string, label: string, grade: number, gradeLabel: string }
--- - getGang() -> { name: string, label: string, grade: number, gradeLabel: string }|nil
--- - getMoney(type?) -> number
--- - addMoney(amount, type?) -> boolean
--- - removeMoney(amount, type?) -> boolean
--- - getItem(item) -> { name: string, label: string, amount: number }|nil
--- - getItems() -> table<number, { name: string, label: string, amount: number, metadata?: table }>
--- - addItem(item, amount, metadata?, ignoreCheck?) -> boolean
--- - removeItem(item, amount) -> boolean
--- - canAddItem(item, amount) -> boolean
--- - hasItem(item, amount?) -> boolean
--- - notify(message, type?) -> nil
--- - setJob(jobName, grade) -> nil
--- - setGang(gangName, grade) -> nil
function FM.player.get(id)
    local isSource = type(id) == 'number'
    local isIdentifier = type(id) == 'string'

    if not isSource and not isIdentifier then
        return nil
    end

    if isSource then
        return playerAdapter:call('getPlayerBySrc', id)
    else
        return playerAdapter:call('getPlayerByIdentifier', id)
    end
end

-- Event registrations
FM.callback.register('fm:internal:getGang', function(src)
    return adapter.getPlayerBySrc(src).getGang()
end)

-- Backwards compatibility alias
FM.p = FM.player