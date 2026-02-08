# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

fmLib is a multi-framework utility library for FiveM that provides unified wrappers for ESX and QBCore frameworks, along with support for 40+ popular resources. It abstracts framework-specific implementations into a single consistent API exposed through the global `FM` object.

## Commands

### Web Development
```bash
cd web
npm install              # Install dependencies (first time)
npm run dev:game         # Development with hot reload for in-game testing
npm run build            # Production build
```

### Development Mode
Enable debug mode by setting `Settings.debug = true` in [settings.lua](settings.lua) to activate verbose logging and table printing.

## Architecture

### Core Components

1. **Global Namespace**: All functionality exposed via `FM` object with aliases:
   - `FM.p` → `FM.player`
   - `FM.cb` → `FM.callback`
   - `FM.inv` → `FM.inventory`
   - `FM.acc` → `FM.account`

2. **Initialization Flow**:
   - [init.lua](init.lua) creates FM object and helper functions
   - [settings.lua](settings.lua) defines Resources and AdapterResources tables
   - [adapters/detector.lua](adapters/detector.lua) lazy-loads ESX/QB frameworks
   - [adapters/base.lua](adapters/base.lua) provides BaseAdapter class for category adapters
   - [autodetect.lua](autodetect.lua) detects Resources and initializes as globals
   - Modules load via fxmanifest patterns
   - Adapters load (specific implementations first, then base adapters)
   - [api.lua](api.lua) registers exports (loads last)

3. **Resource Detection**: Two systems exist side-by-side:
   - **Legacy `Resources` table** (in [settings.lua](settings.lua)): Auto-detected and stored as globals with three patterns:
     - `export = 'functionName'` - Calls export and stores result
     - `export = 'all'` - Stores entire exports table
     - `export = false` - Sets global to `true` if running
   - **New `AdapterResources` table** (in [settings.lua](settings.lua)): Organized by category (framework, inventory, banking, keys, garage, fuel, textui, appearance, account)

### Adapter System (New Architecture)

The new adapter system uses lazy detection and BaseAdapter class:

1. **Detection**: [adapters/detector.lua](adapters/detector.lua)
   - `FM.adapters.detect(category)` - Detects which resource is running
   - `FM.adapters.get(category)` - Returns cached detection result
   - ESX/QB frameworks are lazy-loaded via metatable proxies

2. **Base Adapter**: [adapters/base.lua](adapters/base.lua)
   - `BaseAdapter:new(category, side)` - Creates adapter instance
   - `BaseAdapter:init()` - Initializes and finds the correct adapter
   - `BaseAdapter:call(funcName, ...)` - Calls adapter function
   - `BaseAdapter:hasFunction(funcName)` - Checks if function exists

3. **Implementation Pattern**:
   - Each category has a base adapter (e.g., [adapters/client/framework.lua](adapters/client/framework.lua))
   - Individual adapters stored in subdirectories (e.g., [adapters/client/framework/esx.lua](adapters/client/framework/esx.lua))
   - Each adapter registers itself via `FM_Adapter_{side}_{category}_{key}` global
   - Base adapter provides backwards-compatible `FM.{category}.{function}()` API

4. **Adapter Categories**:
   - **Framework** (`adapters/*/framework/`): ESX/QB core functionality
   - **Player** (`adapters/*/player/`): Player data and operations (uses framework detection)
   - **Inventory** (`adapters/*/inventory/`): Item operations across 10+ inventory systems
   - **Account** (`adapters/server/account/`): Society/banking systems
   - **Keys** (`adapters/client/keys/`): Vehicle key systems (13+ resources)
   - **Garage** (`adapters/client/garage/`): Garage integrations
   - **Fuel** (`adapters/client/fuel/`): Fuel systems (17+ resources, includes 'default' fallback)
   - **TextUI** (`adapters/client/textui/`): Text UI libraries
   - **Appearance** (`adapters/client/appearance/`): Character appearance systems

### Wrapper System (Legacy)

Legacy wrappers in `wrappers/` provide unified APIs using fallback chains:

```lua
if OXInv then
    -- Use ox_inventory
elseif QBInv then
    -- Use qb-inventory
elseif ESX then
    -- Use ESX default
end
```

Key wrapper modules:
- **Player** ([wrappers/client/player.lua](wrappers/client/player.lua), [wrappers/server/player.lua](wrappers/server/player.lua)): Data, money, items, notifications
- **Inventory** ([wrappers/*/inventory.lua](wrappers/client/inventory.lua)): Item operations, stashes, metadata
- **Vehicle** ([wrappers/client/vehicle.lua](wrappers/client/vehicle.lua)): Keys, fuel, garage systems
- **Account** ([wrappers/server/account.lua](wrappers/server/account.lua)): Society/banking (RxBanking, esx_addonaccount, qb-management)
- **Utils** ([wrappers/*/utils.lua](wrappers/client/utils.lua)): Framework utilities

### Module System

Standalone modules in `modules/`:
- **Callback** ([modules/callback/](modules/callback/)): Custom promise-based client-server RPC system
  - `FM.callback.register(event, callback)` - Register server callback
  - `FM.callback.sync(event, ...)` - Synchronous client request
  - `FM.callback.async(event, callback, ...)` - Asynchronous client request
- **Console** ([modules/console/shared.lua](modules/console/shared.lua)): Colored logging with debug support
- **Web** ([modules/web/](modules/web/)): React-based NUI components (dialog, progress, pin, loading)
- **Animation** ([modules/animation/](modules/animation/)): Animation utilities
- **PositionObject** ([modules/positionObject/](modules/positionObject/)): Object positioning

### Web Stack

Located in `web/` directory:
- React 18 + TypeScript
- Material-UI Joy components
- Vite build system
- TailwindCSS + Sass
- NUI communication via `SendNUIMessage` and `RegisterNUICallback`
- Settings fetched via 'fetchSettings' NUI callback (see [init.lua](init.lua))

## Key Patterns

1. **Adapter Implementation Pattern** (new):
```lua
-- In adapters/client/category/specific.lua
FM_Adapter_client_category_specific = {
    functionName = function(...)
        -- Implementation
    end
}
```

2. **Server Player Object Pattern** (wrapper):
```lua
local p = FM.player.get(source)
p.addMoney(100, 'bank')
p.removeItem('water', 1)
```

3. **Unified Data Structures**:
```lua
-- Job/Gang: { name, label, grade, gradeLabel }
-- Item: { name, label, amount, metadata? }
```

4. **Custom Events**:
- `fm:player:onJobUpdate` - Job changed
- `fm:player:onGangUpdate` - Gang changed
- `fm:player:onPlayerLoaded` - Character loaded

## Adding New Features

### New Framework/Resource Support

**For Adapters (Preferred):**
1. Add to `AdapterResources` table in [settings.lua](settings.lua) under appropriate category
2. Create adapter file in `adapters/{side}/{category}/{key}.lua`
3. Register functions in `FM_Adapter_{side}_{category}_{key}` global table
4. Adapter automatically available via `FM.{category}.{function}()` API

**For Legacy Wrappers:**
1. Add to `Resources` table in [settings.lua](settings.lua)
2. Update relevant wrapper files following existing fallback chain patterns

### New Adapter Category
1. Add category to `AdapterResources` in [settings.lua](settings.lua)
2. Create `adapters/{side}/{category}.lua` base adapter using BaseAdapter class
3. Create `adapters/{side}/{category}/` directory for specific implementations
4. Export functions via [api.lua](api.lua) if needed

### New Module
1. Create folder in `modules/` with `shared.lua`/`client.lua`/`server.lua`
2. Auto-loads via fxmanifest patterns
3. Add to FM namespace in [init.lua](init.lua) if needed
4. Add to modules list in [api.lua](api.lua) for exports

### New UI Component
1. Create React component in `web/src/components/`
2. Add Lua wrapper in `modules/web/client/`
3. Use NUI message pattern for communication

## Current State

- Version: 1.15.3
- Active branch: v2
- Main branch: main
- Documentation: https://forgem.gitbook.io/
- Architecture: Transitioning from wrappers to adapters (both systems coexist)
