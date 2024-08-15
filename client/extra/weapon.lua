local weaponObject = nil
local isShowingWeapon = false
local cam = nil
local camCoords = vector3(0.0, 0.0, 0.0)
local camRotation = vector3(0.0, 0.0, 0.0)

local muzzleCoords = nil
local triggerCoords = nil
local clipCoords = nil
local reloadCoords = nil

-- Register the /showweapon command
RegisterCommand('showweapon', function()
    if not isShowingWeapon then
        ShowWeapon()
    else
        HideWeapon()
    end
end, false)

function ShowWeapon()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    -- Set the fixed camera location and rotation
    camCoords = playerCoords + vector3(0.0, 2.0, 1.0) -- Adjust this as needed
    camRotation = vector3(-10.0, 0.0, 180.0) -- Adjust this as needed

    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(cam, camCoords.x, camCoords.y, camCoords.z)
    SetCamRot(cam, camRotation.x, camRotation.y, camRotation.z, 2)
    RenderScriptCams(true, false, 0, true, true)

    -- Define the weapon hash (using a prop model for visible weapon)
    local weaponModel = GetHashKey('w_pi_pistol')  -- using a prop model of a pistol
    local weaponPos = playerCoords + vector3(0.0, 1.0, 0.5) -- Adjust this as needed
    RequestModel(weaponModel)
    while not HasModelLoaded(weaponModel) do
        Wait(1)
    end

    if HasModelLoaded(weaponModel) then
        weaponObject = CreateObject(weaponModel, weaponPos.x, weaponPos.y, weaponPos.z, true, true, false)
        SetEntityRotation(weaponObject, 0.0, 0.0, 0.0, 2, true)
        SetEntityVisible(weaponObject, true, false)
        print("Weapon spawned successfully")

        -- Get positions of specific parts
        muzzleCoords = GetWorldPositionOfEntityBone(weaponObject, GetEntityBoneIndexByName(weaponObject, "gun_muzzle"))
        triggerCoords = GetWorldPositionOfEntityBone(weaponObject, GetEntityBoneIndexByName(weaponObject, "gun_trigger"))
        clipCoords = GetWorldPositionOfEntityBone(weaponObject, GetEntityBoneIndexByName(weaponObject, "gun_clip"))
        reloadCoords = GetWorldPositionOfEntityBone(weaponObject, GetEntityBoneIndexByName(weaponObject, "gun_reload"))

    else
        print("Failed to load weapon model")
    end

    -- Enable mouse movement for rotation
    Citizen.CreateThread(function()
        while isShowingWeapon do
            DisableControlAction(0, 1, true) -- LookLeftRight
            DisableControlAction(0, 2, true) -- LookUpDown

            local mouseX = GetDisabledControlNormal(0, 1) * 10.0
            local mouseY = GetDisabledControlNormal(0, 2) * 10.0

            local currentRot = GetEntityRotation(weaponObject, 2)
            local newRot = vector3(currentRot.x + mouseY, currentRot.y, currentRot.z + mouseX)

            SetEntityRotation(weaponObject, newRot.x, newRot.y, newRot.z, 2, true)

            -- Draw text for weapon parts
            DrawText3D(muzzleCoords.x, muzzleCoords.y, muzzleCoords.z, "Muzzle")
            DrawText3D(triggerCoords.x, triggerCoords.y, triggerCoords.z, "Trigger")
            DrawText3D(clipCoords.x, clipCoords.y, clipCoords.z, "Clip")
            DrawText3D(reloadCoords.x, reloadCoords.y, reloadCoords.z, "Reload")

            Wait(0)
        end
    end)

    isShowingWeapon = true
end

function HideWeapon()
    RenderScriptCams(false, false, 0, true, true)
    DestroyCam(cam, false)

    if DoesEntityExist(weaponObject) then
        DeleteEntity(weaponObject)
        weaponObject = nil
    end

    isShowingWeapon = false
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end
