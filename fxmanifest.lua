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
version '1.8.1'

shared_script {
  'settings.lua',
  'init.lua',
  'modules/**/shared.lua',
  'autodetect.lua',
}

client_scripts {
  'modules/**/client.lua',
  'modules/web/client/*.lua',
  'wrappers/client/*.lua',
}

server_scripts {
  'versioncontrol.lua',
  'modules/**/server.lua',
  'wrappers/server/*.lua',
}

ui_page 'web/build/index.html'

files {
  'web/build/index.html',
  'web/build/**/*',
  'web/assets/**/*',
}

lua54 'yes'