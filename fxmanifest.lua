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
version '2.0.1'
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
  'adapters/client/**/*.lua',
  'adapters/client/*.lua',
  'api.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'versioncontrol.lua',
  'modules/**/server.lua',
  'adapters/server/**/*.lua',
  'adapters/server/*.lua',
  'api.lua',
}

ui_page 'web/build/index.html'

files {
  'web/build/index.html',
  'web/build/**/*',
  'web/assets/**/*',
}
