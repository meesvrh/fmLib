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
Enable debug mode by setting `Settings.debug = true` in `settings.lua` to activate verbose logging and table printing.

## Architecture

### Core Components

1. **Global Namespace**: All functionality exposed via `FM` object with aliases:
   - `FM.p` → `FM.player`
   - `FM.cb` → `FM.callback`
   - `FM.inv` → `FM.inventory`
   - `FM.acc` → `FM.account`

2. **Initialization Flow**:
   - `init.lua` creates FM object
   - `settings.lua` defines resources
   - `autodetect.lua` detects and initializes resources as globals
   - Modules and wrappers load automatically

3. **Resource Detection**: Resources defined in `settings.lua` with three detection types:
   - `export = 'functionName'` - Calls export and stores result
   - `export = 'all'` - Stores entire exports table
   - `export = false` - Sets global to `true` if running

### Wrapper System

Wrappers provide unified APIs across frameworks using fallback chains:

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
- **Player** (`wrappers/client/player.lua`, `wrappers/server/player.lua`): Data, money, items, notifications
- **Inventory** (`wrappers/*/inventory.lua`): Item operations, stashes, metadata
- **Vehicle** (`wrappers/client/vehicle.lua`): Keys, fuel, garage systems (15+ resources each)
- **Account** (`wrappers/server/account.lua`): Society/banking (RxBanking, esx_addonaccount, qb-management)
- **Utils** (`wrappers/*/utils.lua`): Framework utilities

### Module System

Standalone modules in `modules/`:
- **Callback**: Custom promise-based client-server RPC system
- **Console**: Colored logging with debug support
- **Web**: React-based NUI components (dialog, progress, pin, loading)

### Web Stack

- React 18 + TypeScript
- Material-UI Joy components
- Vite build system
- TailwindCSS + Sass
- NUI communication via `SendNUIMessage` and `RegisterNUICallback`

## Key Patterns

1. **Server Player Object Pattern**:
```lua
local p = FM.player.get(source)
p.addMoney(100, 'bank')
p.removeItem('water', 1)
```

2. **Unified Data Structures**:
```lua
-- Job/Gang: { name, label, grade, gradeLabel }
-- Item: { name, label, amount, metadata? }
```

3. **Custom Events**:
- `fm:player:onJobUpdate` - Job changed
- `fm:player:onGangUpdate` - Gang changed
- `fm:player:onPlayerLoaded` - Character loaded

## Adding New Features

### New Framework/Resource Support
1. Add to `Resources` table in `settings.lua`
2. Update relevant wrapper files following existing patterns
3. Use fallback chain pattern for compatibility

### New Module
1. Create folder in `modules/` with `shared.lua`/`client.lua`/`server.lua`
2. Auto-loads via fxmanifest patterns
3. Add to FM namespace in init

### New UI Component
1. Create React component in `web/src/components/`
2. Add Lua wrapper in `modules/web/client/`
3. Use NUI message pattern for communication

## Current State

- Version: 1.15.3
- Active branch: v2
- Main branch: main
- Modified file: `wrappers/server/utils.lua`
- Documentation: https://forgem.gitbook.io/