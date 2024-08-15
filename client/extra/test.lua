-- Define the command to spawn the prop
RegisterCommand("spawnprop", function(source, args, rawCommand)
    local playerPed = PlayerPedId() -- Get the player's Ped
    local pos = GetEntityCoords(playerPed) -- Get the player's coordinates
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 10.0, 0, 71) -- Find the nearest vehicle within a 10.0 radius

    if vehicle then
        local vehicleCoords = GetEntityCoords(vehicle) -- Get the vehicle's coordinates
        local propName = args[1] or "prop_boxpile_07d" -- Default prop if none specified

        RequestModel(propName) -- Request the prop model
        while not HasModelLoaded(propName) do
            Citizen.Wait(0) -- Wait for the model to load
        end

        local prop = CreateObject(GetHashKey(propName), vehicleCoords.x, vehicleCoords.y, vehicleCoords.z + 2.0, true,
            true, true) -- Create the prop above the vehicle

        -- Attach the prop to the vehicle
        AttachEntityToEntity(prop, vehicle, 0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0, false, false, true, false, 2, true)

        -- Optionally, make the prop persistent
        SetEntityAsMissionEntity(prop, true, true)

        -- Notify the player
        TriggerEvent('chat:addMessage', {
            args = {'Prop spawned and attached to the vehicle.'}
        })
    else
        -- Notify the player if no vehicle is found
        TriggerEvent('chat:addMessage', {
            args = {'No vehicle found nearby.'}
        })
    end
end, false)
RegisterCommand("testrob", function(source, args, rawCommand)
    exports['g-scoreboardV2-last']:SetHeistAvailability('fleecabankrobbery', true)
    -- exports['g-scoreboardV2-last']:SetHeistAvailability('storerobbery', true)

    Wait(6000)
    TriggerServerEvent('g-scoreboardv2:SetHeistAvailability', 'fleecabankrobbery', false)
    -- TriggerServerEvent('g-scoreboardv2:SetHeistAvailability', 'storerobbery', false)
    print('done')
end, false)

RegisterCommand('testshop', function(source)
    exports['g-ownable-job-vehicle']:OpenVehicleManagementMenu(2)
end, false)
