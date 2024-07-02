fx_version 'cerulean'
games { 'gta5' }
author 'justgroot'


shared_script {
   'Config.lua',
   '@es_extended/imports.lua',
   '@ox_lib/init.lua'

}
client_scripts {
   -- 'client/*.lua',
   'Config.lua',
   'client/**/*.lua'
}




server_scripts {
   '@oxmysql/lib/MySQL.lua',
   -- 'server/*.lua',
   'server/**/*.lua',
   'Config.lua',
}



lua54 'yes'
