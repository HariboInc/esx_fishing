fx_version 'adamant'

game 'gta5'

description 'ESX Fishing'

shared_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
	'config.lua'
}

client_scripts {
	'locales/*.lua',
	'client/main.lua'
} 

server_scripts {
	'locales/*.lua',
	'server/main.lua'
}
