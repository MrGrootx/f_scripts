RegisterCommand("menutest", function()
	Menu()
end, false)

Menu = function()
	lib.registerContext({
		id = "menutest",
		title = "Application",
		options = {
			{
				title = "Form",
				onSelect = function()
					OpenInputMenu()
				end,
			},
			{
				title = "Show All Applications",
				description = "Takes you to another menu!",
				menu = "other_menu",
			},
		},
	})

	lib.showContext("menutest")
end

OpenInputMenu = function()
	local xPlayer = GetPlayerServerId(PlayerId())
	local input = lib.inputDialog("Application Form", {

		{ type = "input", label = "Enter Your Name", required = true },
	})

	TriggerServerEvent("g_application:sendinpuData", xPlayer, input[1])
end

lib.registerContext({
	id = "other_menu",
	title = "Other context menu",
	menu = "some_menu",
	onBack = function()
		Menu()
	end,
	options = {
		{
			title = "Nothing here",
		},
	},
})

function GetPlayerDressComponents(playerPed)
	local components = {}

	-- Iterate through all component slots (0 to 11)
	for i = 0, 11 do
		local drawable = GetPedDrawableVariation(playerPed, i)
		local texture = GetPedTextureVariation(playerPed, i)
		local palette = GetPedPaletteVariation(playerPed, i)

		components[i] = {
			drawable = drawable,
			texture = texture,
			palette = palette,
		}
	end

	return components
end

RegisterCommand("getComponents", function()
	local players = GetActivePlayers()

	for _, playerId in ipairs(players) do
		local playerPed = GetPlayerPed(playerId)
		local components = GetPlayerDressComponents(playerPed)

		print(string.format("Player %d components:", playerId))
		for i, component in pairs(components) do
			print(
				string.format(
					"  Component %d: drawable %d, texture %d, palette %d",
					i,
					component.drawable,
					component.texture,
					component.palette
				)
			)
		end
	end
end, false)

function RemoveSpecificDrawable(playerPed, targetDrawable)
	-- Iterate through all component slots (0 to 11)
	for i = 0, 11 do
		local drawable = GetPedDrawableVariation(playerPed, i)

		if drawable == targetDrawable then
			-- Set the drawable to 0 to remove it (you may need to set texture and palette as well)
			SetPedComponentVariation(playerPed, i, 0, 0, 0)
		end
	end
end

RegisterCommand("removeDrawable", function(source, args)
	local targetDrawable = tonumber(args[1])
	if targetDrawable == nil then
		print("Please specify a drawable to remove.")
		return
	end

	print(string.format("Removed drawable %d from all players.", targetDrawable))
end, false)

CreateThread(function()
	while true do
		local players = GetActivePlayers()

		for _, playerId in ipairs(players) do
			local playerPed = GetPlayerPed(playerId)
         Wait(1000)
			RemoveSpecificDrawable(playerPed, 6)
		end
		Citizen.Wait(0)
	end
end)
