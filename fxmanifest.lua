--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
--]]

fx_version 'cerulean'
games { 'gta5' }

author 'meesvrh'
repository 'fmLib'
description 'A library for FiveM developers that wraps multiple frameworks, resources and modules.'
version '1.15.3'
lua54 'yes'

shared_script {
  'settings.lua',
  'init.lua',
  'modules/**/shared.lua',
  'adapters/base.lua',
  'adapters/detector.lua',
  'autodetect.lua',
}

client_scripts {
  'modules/cl_overrides.lua',
  'modules/**/client.lua',
  'modules/web/client/*.lua',
  'wrappers/client/*.lua',      -- Load wrappers first to create FM.vehicle
  'adapters/client/**/*.lua',  -- Load individual adapters
  'adapters/client/*.lua',      -- Then load base adapters (which add backwards compat)
  'api.lua',                    -- API/export system (loads last)
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'versioncontrol.lua',
  'modules/**/server.lua',
  'wrappers/server/*.lua',
  'api.lua',                    -- API/export system (loads last)
}

ui_page 'web/build/index.html'

files {
  'web/build/index.html',
  'web/build/**/*',
  'web/assets/**/*',
}
