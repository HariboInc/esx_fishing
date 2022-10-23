if Config.OldEsx == true then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
 end

RegisterServerEvent('esx_fishing:caughtFish')
AddEventHandler('esx_fishing:caughtFish', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('fish', 1)
end)

ESX.RegisterUsableItem('fishingrod', function(source)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local baitquantity = xPlayer.getInventoryItem('bait').count
	if baitquantity > 0 then
		TriggerClientEvent('esx_fishing:startFishing', source)
		-- xPlayer.removeInventoryItem('bait', 1)
	else 
		TriggerClientEvent('esx:showNotification', source, ('fishing_bait'))
	end
end)

ESX.RegisterUsableItem('fish', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fish', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx_fishing:onEatFish', source)
	TriggerClientEvent('esx:showNotification', source, ('fishing_baituse'))

end)


RegisterServerEvent('esx_fishing:removeInventoryItem')
AddEventHandler('esx_fishing:removeInventoryItem', function(item, quantity)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, quantity)
end)


--[[ Version Checker ]]--
local version = "1.0.2"

if Config.CheckForUpdates then
    AddEventHandler("onResourceStart", function(resource)
        if resource == GetCurrentResourceName() then
            CheckFrameworkVersion()
        end
    end)
end

function CheckFrameworkVersion()
    PerformHttpRequest("https://raw.githubusercontent.com/HariboInc/esx_fishing/main/version.txt", function(err, text, headers)
        if string.match(text, version) then
            print(" ")
            print("--------- ^4ESX_FISHING VERSION^7 ---------")
            print("esx_fishing ^2is up to date^7 and ready to go!")
            print("Running on Version: ^2" .. version .."^7")
            print("^4https://github.com/HariboInc/esx_fishing^7")
            print("--------------------------------------------")
            print(" ")
        else
          print(" ")
          print("--------- ^4ESX_FISHING VERSION^7 ---------")
          print("esx_fishing ^1is not up to date!^7 Please update!")
          print("Curent Version: ^1" .. version .. "^7 Latest Version: ^2" .. text .."^7")
          print("^4https://github.com/HariboInc/esx_fishing^7")
          print("--------------------------------------------")
          print(" ")
        end

    end, "GET", "", {})

end