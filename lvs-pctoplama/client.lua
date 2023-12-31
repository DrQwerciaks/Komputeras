Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

Citizen.CreateThread(function()
	while true do
	sleep = 2000
	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	local dstCheck = GetDistanceBetweenCoords(pedCoords, 1275.36, -1710.6, 54.7714, true)
	if dstCheck < 5.0 then
		sleep = 5
	end
	if dstCheck <= 4.0 then
		sleepThread = 5
	DrawText3Ds(1275.36, -1710.6, 54.7714, '[~g~E~s~] Bilgisayar Parçalarını Kullan')
	if IsControlJustReleased(1, 51) then  
		bilgisayaruret()
	  end
	end
	Citizen.Wait(sleep)
	end
end)

function bilgisayaruret()
	ESX.UI.Menu.CloseAll()
	local elements = {}

		for i=1, #Config.Items, 1 do
			table.insert(elements, {labels =  Config.Items[i].label, label =  Config.Items[i].label .. ' ',	value = Config.Items[i].item})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'bilgisayar',
			{
			title    = 'Bilgisayar Parçalarını Birleştir',
			align    = 'right',
			elements = elements
			},
			function(data, menu)
				menu.close()
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'icecekbema', {
				title = 'Kaç tane bilgisayar toplayacaksın??'
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('pctopla', id, data.current.value, tonumber(data2.value), data.current.labels)
				end, function(data2, menu2)
					menu2.close()
				end)

		end,
		function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('pctoplamaanim')
AddEventHandler('pctoplamaanim', function()
	playerPed = PlayerPedId()
	ClearPedSecondaryTask(playerPed)
	loadAnimDict( "mini@repair" ) 
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
	exports["t0sic_loadingbar"]:StartDelayedFunction("Birleştiriyorsun", 60000, function()
	ClearPedTasks(playerPed)
	end)
end)

function DrawText3Ds(x,y,z, text)
	local camrec = GetGameplayCamCoords()
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(camrec)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

-- BU SCRİPT LEVİS DEVELOPMENTS TARAFINDAN YAPILMIŞTIR 
-- TEKNİK DESTEK İÇİN : https://discord.gg/uB2GnsjCmb , ! Onur#5962