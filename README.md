# fmLib - A Multi-Framework Utility Library

[![Downloads](https://img.shields.io/github/downloads/meesvrh/fmLib/total?style=flat-square&logo=github)](https://github.com/meesvrh/fmLib/releases)
[![GitHub Stars](https://img.shields.io/github/stars/meesvrh/fmLib?style=flat-square&logo=github)](https://github.com/meesvrh/fmLib/stargazers)

This versatile library is designed to simplify your scripting experience by consolidating various frameworks, resources, and utilities into a cohesive package.
Whether you're a seasoned developer or just getting started, fmLib aims to provide a convenient wrapper to streamline the integration of commonly used tools and functionalities in your scripts.

## Overview

fmLib is a continuously evolving project, offering a collection of adapters and modules designed to enhance scripting in FiveM.
The library provides unified APIs that work across **ESX**, **QBCore**, and **QBox** frameworks, along with support for **40+ popular resources**.

## Key Features

### 🔄 Multi-Framework Support
Write your scripts once, and they work on **ESX**, **QBCore**, and **QBox** without any code changes. fmLib automatically detects your framework and provides a consistent API.

### 🎯 Smart Adapters
The v2 adapter system automatically detects and integrates with 40+ popular resources:
- **10+ Inventory Systems** - ox_inventory, qb-inventory, qs-inventory, and more
- **13+ Vehicle Key Systems** - Unified key management across all systems
- **17+ Fuel Systems** - Consistent fuel handling with automatic fallback
- **Multiple Garage Systems** - Unified garage operations
- **TextUI Libraries** - ox_lib, jg-textui, okokTextUI support
- **Appearance Systems** - Character customization across systems
- **Banking/Accounts** - Society account management
- **Gang Systems** - To retrieve gangs for players

### ⚡ Powerful Player Object
Server-side player object with 20+ methods for common operations:
```lua
local player = FM.player.get(src)
player.addMoney(500, 'bank')
player.addItem("water", 5)
player.notify("Transaction complete!", "success")
```

### 📞 Built-in RPC System
Promise-based callback system for clean client-server communication:
```lua
-- Server
FM.callback.register('getBalance', function(src)
    local player = FM.player.get(src)
    return player.getMoney('bank')
end)

-- Client
local balance = FM.callback.sync('getBalance')
print("Balance:", balance)
```

### 🔌 Zero Configuration
Just install fmLib, and it automatically detects all compatible resources on your server. No manual configuration needed!

## Quick Start

### Installation

1. **Download** the [latest release](https://github.com/meesvrh/fmLib/releases/latest/download/fmLib.zip)
2. **Extract** the archive into your resources folder
3. **Add** `ensure fmLib` to your server.cfg
4. **Restart** your server

```cfg
ensure fmLib                # fmLib loads automatically
ensure your-custom-script   # Your scripts that use fmLib
```

### Basic Usage

In your resource's fxmanifest.lua:
```lua
fx_version 'cerulean'
game 'gta5'

dependency 'fmLib'

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}
```

In your client/server lua files:
```lua
FM = exports.fmLib:new()

-- Client-side
if FM.player.isLoggedIn() then
    local job = FM.player.getJob()
    FM.framework.notify(string.format("Welcome %s!", job.label), "success")
end

-- Server-side
RegisterNetEvent('shop:purchase', function(item, amount)
    local src = source
    local player = FM.player.get(src)
    if not player then return end

    if player.getMoney('money') >= 100 then
        player.removeMoney(100, 'money')
        player.addItem(item, amount)
        player.notify("Purchase successful!", "success")
    else
        player.notify("Insufficient funds", "error")
    end
end)
```

## What's New in v2

The v2 release brings a completely redesigned architecture:

- **Adapter System** - Replaces the old wrapper system with a more flexible adapter pattern
- **Lazy Loading** - Resources are only loaded when needed, improving performance
- **Better Detection** - Automatic resource detection without manual configuration
- **Consistent API** - All adapters follow the same patterns and structure
- **Full Type Hints** - Complete LuaLS annotations for better IDE support

> **Note:** v1 wrapper functions still work but will show deprecation warnings. We recommend migrating to the new adapter API.

## Supported Frameworks

- **ESX** (es_extended)
- **QBCore** (qb-core)
- **QBox** (qbx_core)

## Supported Resources

### Inventories
ox_inventory, qb-inventory, qs-inventory, ps-inventory, codem-inventory, jpr-inventory, tgiann-inventory, chezza inventory, core_inventory, origen_inventory, jaksam_inventory

### Vehicle Keys
qb-vehiclekeys, qs-vehiclekeys, Renewed-Vehiclekeys, wasabi_carlock, tgiann-hotwire, mm_carkeys, MrNewbVehicleKeys, is_vehiclekeys, fast-vehiclekeys, filo_vehiclekey, qbx_vehiclekeys

### Fuel Systems
ox_fuel, LegacyFuel, cdn-fuel, renewed-fuel, qb-fuel, lc_fuel, ps-fuel, rcore_fuel, qs-fuelstations, ND_Fuel, BigDaddy-Fuel, gks-fuel, RiP-Fuel, myFuel, lj-fuel, melons_fuel, hrs_fuel, Native (automatic fallback)

### Garages
cd_garage, okokGarage, jg-advancedgarages, mGarage (codem), RxGarages, op-garages

### TextUI
ox_lib, jg-textui, okokTextUI

### Appearance/Clothing
fivem-appearance, illenium-appearance, qb-clothing, esx_skin, crm-appearance, 17mov_CharacterSystem

### Accounts/Banking
esx_addonaccount, qb-management, RxBanking (optional integration)

### Gang Systems
arketype_GangBuilder

## Documentation

For complete documentation, examples, and API reference:

**📚 [Documentation](https://docs.rxscripts.xyz/fmlib)**

**🚀 [Getting Started](https://docs.rxscripts.xyz/fmlib/installation)**

## Configuration

Debug mode and resource names can be configured in `settings.lua`:

```lua
Settings = {
    debug = true,    -- Enable debug messages
    warning = true,  -- Enable warning messages
    useSfx = true,   -- Enable sound effects for web modules
}
```

If you've renamed any supported resources, update them in `AdapterResources` table.

## Community & Support

- **GitHub**: [github.com/meesvrh/fmLib](https://github.com/meesvrh/fmLib)
- **Issues**: Report bugs or request features on GitHub
- **Documentation**: [docs.rxscripts.xyz/fmlib](https://docs.rxscripts.xyz/fmlib)

## License

fmLib is open-source and free to use in your FiveM projects.
