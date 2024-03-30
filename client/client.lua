local cars = { "adder", "kuruma", "cheetah", "faggio" }

RegisterCommand('carctm', function()
   local getcar = cars[math.random(1, #cars)]
   spawnCar(getcar)
   notify("Car Spawned")
end, false)


RegisterCommand('diectm', function()
   SetEntityHealth(PlayerPedId(), 0)
end, false)
