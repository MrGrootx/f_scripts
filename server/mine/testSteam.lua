ESX = exports["es_extended"]:getSharedObject()

local img = 'https://media.discordapp.net/attachments/1163004945088397383/1218068083743133778/SPOILER_saree_dress.png?ex=6687844d&is=668632cd&hm=c96889a02deb5362c1464c9219e33ccc34ff9b9ba0078bca157b378e60c99c3e&=&format=webp&quality=lossless&width=350&height=350'
local steamKey = '9F17E28D6A7ADAF6269E6EA248EB41B5'

function GetSteamID(id)
    local steamid = nil
    for k, v in ipairs(GetPlayerIdentifiers(id)) do
        if string.find(v, "steam:") then
            steamid = v
            break
        end
    end
    return steamid
end

function GetSteamProfilePicture(id)
    local steamid = GetSteamID(id)
    if steamid == nil then
        return img
    end

    local steam64 = tonumber(string.gsub(steamid, "steam:", ""), 16)
    print("Steam64 ID: " .. steam64)
    local p = promise:new()
    local url = "https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key=" .. steamKey .. "&steamids=" .. steam64

    PerformHttpRequest(url, function(err, text, headers)
        if err == 200 then
            local data = json.decode(text)
            print(json.encode(data, { indent = true }))
            if data.response.players[1] ~= nil then
                p:resolve(data.response.players[1].avatarfull)
                print('Avatar URL: ' .. data.response.players[1].avatarfull)
            else
                p:resolve(img)
            end
        else
            p:resolve(img)
        end
    end)
    return Citizen.Await(p)
end

RegisterCommand('getsteam', function(source)
    print('Executing getsteam command')
    local steamProfilePicture = GetSteamProfilePicture(source)
    print('Steam Profile Picture URL: ' .. steamProfilePicture)
end, false)

function GetIdentifier(source)
    return GetPlayerIdentifiers(source)[1]
end
