fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'GoFast Script for QB-Core'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'qb-core',
    'ox_lib',
    'ox_inventory'
}
