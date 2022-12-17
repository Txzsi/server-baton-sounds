RegisterNetEvent('server:play')
AddEventHandler('server:play', function(sound)
    local src = source
    local DistanceLimit = 300
    local maxDistance = 4
    local soundFile = sound
    local soundVolume = 0.3
    if maxDistance < DistanceLimit then
        TriggerClientEvent('client:play', -1, GetEntityCoords(GetPlayerPed(src)), maxDistance, soundFile, soundVolume)
    else
        print(('[Debug] [^3WARNING^7] %s attempted to trigger baton sounds over the distance limit ' .. DistanceLimit):format(GetPlayerName(src)))
    end
end)
