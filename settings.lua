--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
--]]

---@class Settings
Settings = {
    ---@type boolean Whether or not to print console.debug messages
    debug = true,
    ---@type boolean Whether or not to use sfx for web modules (overrides sfx = true in modules)
    useSfx = true,
    ---@type boolean Whether or not to ignore resource initialized logs
    ignoreResourceInitializedLogs = false,
}

---@enum Defaults
---Fallbacks for when you don't specify a value
Defaults = {
    MONEY = 'money',
    ADMIN_ESX = 'admin',
    ADMIN_QB = 'admin',
    GOD_QB = 'god',
}

---@enum KeyMappings
---Key mappings for the library
KeyMappings = {
    CANCEL = { mapper = 'keyboard', key = 'x' },
}

--[[
    This is used for autodetecting resources
    Any table with an export, will have the export called and put in the global variable
    Any table with export = false, will be set to true if the resource is started (mostly used for event-based resources)
    Any table with export = 'all', will have all exports put in the global variable
--]]
---@type table Only change these if you have changed the name of a resource
Resources = {
    ESX = { name = 'es_extended', export = 'getSharedObject' },
    QB = { name = 'qb-core', export = 'GetCoreObject' },
    OXInv = { name = 'ox_inventory', export = 'all' },
    QBInv = { name = 'qb-inventory', export = 'all', },
    QSInv = { name = 'qs-inventory', export = 'all' },
    PSInv = { name = 'ps-inventory', export = 'all' },
    CHEZZAInv = { name = 'inventory', export = 'all' },
    -- MOVHUD = { name = '17mov_Hud', export = 'all' },
    QBVehKeys = { name = 'qb-vehiclekeys', export = false },
    CDGarage = { name = 'cd_garage', export = false },
    okokGarage = { name = 'okokGarage', export = false },
    QSVehKeys = { name = 'qs-vehiclekeys', export = 'all' },
    RenewedVehKeys = { name = 'Renewed-Vehiclekeys', export = 'all' },
    LEGACYFUEL = { name = 'LegacyFuel', export = 'all' },
    OXFUEL = { name = 'ox_fuel', export = false },
}