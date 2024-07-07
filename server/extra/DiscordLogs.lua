-- function Discordlogs(img)
--    local data = {
--        ["color"] = 16711680,
--        ["description"] = img
--    }

--    PerformHttpRequest('https://discord.com/api/webhooks/1257704503617257563/M58ZxOZphEAEY9BSVgWcT9pgqmRXQZij62DMjAoIbSHusILkL_K5ZQOKbZ5T3EvDHMnY', function(err, text, headers)
--        if err == 0 then
--            print("^5DEBUG^7: Successfully sent log to Discord.")
--        else
--            print("^5DEBUG^7: ^4Error sending log to Discord:^7 Error:", err)
--        end
--    end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
-- end

-- RegisterNetEvent('justgroot:screengrab')
-- AddEventHandler('justgroot:screengrab', function(data)
--    Discordlogs(data)
-- end)
