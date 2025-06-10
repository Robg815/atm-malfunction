fx_version 'cerulean'
game 'gta5'

description 'ATM Malfunction - Random ATM cash drop with police alerts'
author 'Smokey'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'utils.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}
