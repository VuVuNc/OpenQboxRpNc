local GoFastStarted = false

local QBCore = exports['qb-core']:GetCoreObject()

local function SpawnGoFastVehicle(model, coords)
    QBCore.Functions.SpawnVehicle(model, function(vehicle)
        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
        SetVehicleEngineOn(vehicle, true, true, true)
        SetVehicleNumberPlateText(vehicle, "GOFAST")
        SetVehicleDirtLevel(vehicle, 0.0)
    end, coords, true)
end

local function DeleteVehicle(vehicle)
    QBCore.Functions.DeleteVehicle(vehicle)
end

local function ShowNotification(msg)
    QBCore.Functions.Notify(msg, 'error')
end

CreateThread(function()
    local pedHash = GetHashKey(Config.StartGoFast.PedHash)
    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Wait(0)
    end
    local ped = CreatePed(4, pedHash, Config.StartGoFast.PedCoords.x, Config.StartGoFast.PedCoords.y, Config.StartGoFast.PedCoords.z, Config.StartGoFast.PedCoords.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)

    exports.ox_target:addBoxZone({
        coords = vector3(Config.StartGoFast.TargetCoords.x, Config.StartGoFast.TargetCoords.y, Config.StartGoFast.TargetCoords.z),
        size = vec3(1, 1, 2),
        rotation = 0,
        debug = false,
        options = {
            {
                name = 'gofast_start',
                icon = 'fas fa-car',
                label = 'Start Go Fast',
                canInteract = function()
                    return not GoFastStarted
                end,
                onSelect = function()
                    local vehicle = GetHashKey(Config.StartGoFast.VehicleHash)
                    SpawnGoFastVehicle(vehicle, Config.StartGoFast.VehicleCoords)
                    GoFastStarted = true
                    TriggerEvent('GoFastRun')
                    TriggerServerEvent('Alertpolice')
                end
            }
        }
    })
end)

RegisterNetEvent('GoFastRun')
AddEventHandler('GoFastRun', function()
    local randomIndex = math.random(1, #Config.DeliveryCoords)
    local randomCoord = Config.DeliveryCoords[randomIndex]

    local randomIndex2 = math.random(1, #Config.DeliveryModel)
    local randomModel = Config.DeliveryModel[randomIndex2]

    local model = GetHashKey(randomModel)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    
    local ped = CreatePed(4, model, randomCoord[1], randomCoord[2], randomCoord[3], randomCoord[4], false, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)

    local blip = AddBlipForCoord(randomCoord[1], randomCoord[2], randomCoord[3])
    SetBlipSprite(blip, 304)
    SetBlipColour(blip, 59)
    SetBlipScale(blip, 0.8)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 59)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Go Fast Delivery")
    EndTextCommandSetBlipName(blip)

    exports.qtarget:AddBoxZone('deliverygofast', randomCoord, 1.0, 1.0, {
        name = 'deliverygofast',
        heading = randomCoord[4],
        debugPoly = false,
        minZ = randomCoord.z - 1.5,
        maxZ = randomCoord.z + 1.5
    }, {
        options = { 
            {
                icon = "fas fa-box-open",
                label = 'Livrer le vehicle',
                canInteract = function()
                    if GoFastStarted then
                        return true
                    end
                end,
                action = function()
                    local vehicle = QBCore.Functions.GetClosestVehicle()
                    if DoesEntityExist(vehicle) and GetEntityModel(vehicle) == GetHashKey(Config.StartGoFast.VehicleHash) and GoFastStarted then
                        DeleteVehicle(vehicle)
                        RemoveBlip(blip)
                        DeleteEntity(ped)
                        GoFastStarted = false
                        TriggerServerEvent('DeliveredDone')
                        exports.qtarget:RemoveZone('deliverygofast')
                    else
                        ShowNotification("Vous n'avez pas le bon vehicle")
                    end
                end,
            },
        },
        distance = 1.5
    })
end)
