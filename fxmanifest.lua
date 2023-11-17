--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
--]]

fx_version 'cerulean'
games { 'gta5' }

author 'meesvrh (Rejox)'

description 'A library for FiveM developers that wraps multiple frameworks, resources and modules.'
version '0.0.1'

shared_script {
  'settings.lua',
  'init.lua',
  'modules/**/shared.lua',
  'autodetect.lua',
}

client_scripts {
  'modules/**/client.lua',
  'wrappers/**/client/*.lua',
}

server_scripts {
  'versioncontrol.lua',
  'modules/**/server.lua',
  'wrappers/**/server/*.lua',
}

lua54 'yes'