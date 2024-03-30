fx_version 'cerulean'
games { 'gta5' }
author 'author'
client_scripts {
   'client/*.lua',
   'Config.lua'
}

shared_script {
   'Config.lua'
}


server_scripts {
   '@oxmysql/lib/MySQL.lua',
   'server/*.lua',
   'Config.lua'
}
