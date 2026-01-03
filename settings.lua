--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
--]]

---@class Settings
Settings = {
    ---@type boolean Whether or not to print debug messages
    debug = true,
    ---@type boolean Whether or not to print warning messages
    warning = true,
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

-- Resource definitions organized by category
-- Only change these if you have changed the name of a resource
AdapterResources = {
    framework = {
        { key = 'esx', resource = 'es_extended' },
        { key = 'qb',  resource = 'qb-core' },
    },

    inventory = {
        { key = 'ox',     resource = 'ox_inventory' },
        { key = 'qb',     resource = 'qb-inventory' },
        { key = 'qs',     resource = 'qs-inventory' },
        { key = 'core',   resource = 'core_inventory' },
        { key = 'ps',     resource = 'ps-inventory' },
        { key = 'chezza', resource = 'inventory' },
        { key = 'tgiann', resource = 'tgiann-inventory' },
        { key = 'jpr',    resource = 'jpr-inventory' },
        { key = 'codem',  resource = 'codem-inventory' },
        { key = 'origen', resource = 'origen_inventory' },
    },

    banking = {
        { key = 'rx',         resource = 'RxBanking' },
        { key = 'addon',      resource = 'esx_addonaccount' },
        { key = 'management', resource = 'qb-management' },
    },

    keys = {
        { key = 'qb',      resource = 'qb-vehiclekeys' },
        { key = 'qs',      resource = 'qs-vehiclekeys' },
        { key = 'renewed', resource = 'Renewed-Vehiclekeys' },
        { key = 'wasabi',  resource = 'wasabi_carlock' },
        { key = 'tgiann',  resource = 'tgiann-hotwire' },
        { key = 'mm',      resource = 'mm_carkeys' },
        { key = 'mrnewb',  resource = 'MrNewbVehicleKeys' },
        { key = 'is',      resource = 'is_vehiclekeys' },
        { key = 'fast',    resource = 'fast-vehiclekeys' },
        { key = 'filo',    resource = 'filo_vehiclekey' },
        { key = 'qbx',     resource = 'qbx_vehiclekeys' },
    },

    garage = {
        { key = 'cd',    resource = 'cd_garage' },
        { key = 'okok',  resource = 'okokGarage' },
        { key = 'jg',    resource = 'jg-advancedgarages' },
        { key = 'codem', resource = 'mGarage' },
        { key = 'rx',    resource = 'RxGarages' },
        { key = 'op',    resource = 'op-garages' },
    },

    fuel = {
        { key = 'ox',       resource = 'ox_fuel' },
        { key = 'legacy',   resource = 'LegacyFuel' },
        { key = 'cdn',      resource = 'cdn-fuel' },
        { key = 'renewed',  resource = 'renewed-fuel' },
        { key = 'qb',       resource = 'qb-fuel' },
        { key = 'lc',       resource = 'lc_fuel' },
        { key = 'ps',       resource = 'ps-fuel' },
        { key = 'rcore',    resource = 'rcore_fuel' },
        { key = 'qs',       resource = 'qs-fuelstations' },
        { key = 'nd',       resource = 'ND_Fuel' },
        { key = 'bigdaddy', resource = 'BigDaddy-Fuel' },
        { key = 'gks',      resource = 'gks-fuel' },
        { key = 'rip',      resource = 'RiP-Fuel' },
        { key = 'my',       resource = 'myFuel' },
        { key = 'lj',       resource = 'lj-fuel' },
        { key = 'melons',   resource = 'melons_fuel' },
        { key = 'hrs',      resource = 'hrs_fuel' },
    },

    textui = {
        { key = 'jg',   resource = 'jg-textui' },
        { key = 'okok', resource = 'okokTextUI' },
        { key = 'ox',   resource = 'ox_lib' },
    },

    appearance = {
        { key = 'fivem',    resource = 'fivem-appearance' },
        { key = 'illenium', resource = 'illenium-appearance' },
        { key = 'qb',       resource = 'qb-clothing' },
        { key = 'esx',      resource = 'esx_skin' },
        { key = 'crm',      resource = 'crm-appearance' },
        { key = 'mov',      resource = '17mov_CharacterSystem' },
    },

    account = {
        { key = 'esxaddon',     resource = 'esx_addonaccount' },
        { key = 'qbmanagement', resource = 'qb-management' },
    },
}
