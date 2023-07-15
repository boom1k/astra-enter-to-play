local DrawText = function(x, y, scale, text, font, j)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextJustification(j or 1)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y)
end



AddEventHandler('playerSpawned', function()
    _SpawnPlayer()
	print("[BASE] Spawning Player")
end)

local CameraParams = {
	--[[     [1] = {
			starting = vector3(-268.14, -2427.67, 70.49),
			sheading = 55.0,
			eheading = 55.0,
			ending = vector3(-376.91, -2350.06, 70.49)
		},
		[2] = {
			starting = vector3(-27.01, -949.22, 42.14),
			sheading = -90.0,
			eheading = -60.0,
			ending = vector3(82.12, -1006.69, 42.14)
		}, ]]
		[1] = {
			starting = vector3(-835.41, 4431.59, 45.14),
			sheading = -90.0,
			eheading = -110.0,
			ending = vector3(-644.04, 4484.56, 110.24)
		}
	}
	
	_SpawnPlayer = function()
		DoScreenFadeOut(500)
		DisplayRadar(false)
		ClearFocus()
		local PlayerPed = PlayerPedId()
		SetEntityCoords(PlayerPed, 0.0, 0.0, 0.0)
		FreezeEntityPosition(PlayerPed, true)
		TriggerMusicEvent("GLOBAL_KILL_MUSIC")
		local camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
		PrepareMusicEvent("RAMPAGE_2_START")
		TriggerMusicEvent("RAMPAGE_2_START")
		SetCamActive(camera, true)
		for i = 1, #CameraParams do
			DoScreenFadeOut(500)
			Citizen.Wait(2000)
			SetFocusArea(CameraParams[i].starting)
			RenderScriptCams(true, false, 3000, 1, 1, 0)
			Citizen.Wait(250)
			SetCamParams(camera, CameraParams[i].starting, -10.97, 0.0, CameraParams[i].sheading, 60.0, 0, 1, 1, 2)
			SetCamParams(camera, CameraParams[i].ending, -10.97, 0.0, CameraParams[i].eheading, 60.0, 7000, 0, 0, 2)
			DoScreenFadeIn(2000)
			if i < #CameraParams then
				Citizen.Wait(6500)
			else
				ShakeCam(camera, "HAND_SHAKE", 0.5)
			end
		end
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(0)
				DrawText(.5, .1, 1.0, "Press ~g~Enter~w~ to play",  4, 0)
				if IsControlJustPressed(1, 18) then
					DoScreenFadeOut(500)
					Wait(500)
					ClearFocus()
					RenderScriptCams(false, false, 0, true, false)
					DestroyCam(camera, false)
					DestroyAllCams()
					FreezeEntityPosition(PlayerPedId(), false)
					Wait(250)
					DisplayRadar(true)
					SetEntityCoords(PlayerPedId(), 230.0812, -1394.4417, 30.4996)
					DoScreenFadeIn(500)
					break
				end
			end
		end)
	end