local cars = { "adder", "kuruma", "cheetah", "faggio" }

RegisterCommand('carctm', function()
   local getcar = cars[math.random(1, #cars)]
   spawnCar(getcar)
   notify("Car Spawned")
end, false)

-- local G = exports['g-bridgeV2']:GetGroot()
-- RegisterCommand('gadditem', function(source)
--    -- local player = G.GetPlayer(source)
--    -- print("Player Name: ", player.getName())
--    -- print("Player Identifier: ", G.GetIdentifier(source))
--    -- G.ShowNotification(source, "Added Item", "success")
--    G.ShowNotification("Added Item", "success")
-- end, false)
