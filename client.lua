local batonholstered = true
local hasPlayerLoaded = false

Citizen.CreateThread(function()
  if NetworkIsSessionStarted() then
    hasPlayerLoaded = true
  end
end)

Citizen.CreateThread(function()
  while true do
    local sleep = 300
    local ped = PlayerPedId()
    if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) then
      if CheckIfBaton(ped) and batonholstered then
        TriggerServerEvent('server:play', 'out')
        batonholstered = false
      elseif not CheckIfBaton(ped) and not batonholstered then
        TriggerServerEvent('server:play', 'in')
        batonholstered = true
      end
    else
      sleep = 800
    end
    Citizen.Wait(sleep)
  end
end)

RegisterNetEvent('client:play')
AddEventHandler('client:play', function(otherPlayerCoords, maxDistance, soundFile, soundVolume)
  if hasPlayerLoaded then
    local myCoords = GetEntityCoords(PlayerPedId())
    local distance = #(myCoords - otherPlayerCoords)
    if distance < maxDistance then
      SendNUIMessage({
        transactionType = 'playSound',
        transactionFile = soundFile,
        transactionVolume = 0.2
      })
    end
  end
end)

function CheckIfBaton(ped)
  if GetHashKey("weapon_nightstick") == GetSelectedPedWeapon(ped) then
    return true
  end
  return false
end
