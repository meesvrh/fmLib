--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
    Discord: http://discord.rxscripts.xyz/
    Store: https://store.rxscripts.xyz/
--]]

fx_version 'cerulean'
games { 'gta5' }

author 'meesvrh (Rejox) | rxscripts.xyz'

description 'A library for FiveM developers that wraps multiple frameworks, resources and modules.'
version '1.0.0'

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
  'modules/**/server.lua',
  'wrappers/**/server/*.lua',
}

lua54 'yes'