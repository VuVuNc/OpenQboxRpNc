local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory

RegisterNetEvent('DeliveredDone')
AddEventHandler('DeliveredDone', function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end 

    -- Add money based on configuration using ox_inventory
    local amount = math.random(Config.AddAmount[1], Config.AddAmount[2])
    if Config.TypeMoney == 'black_money' then
        exports.ox_inventory:AddItem(src, 'black_money', amount)
    else
        exports.ox_inventory:AddItem(src, 'money', amount)
    end

    TriggerClientEvent('QBCore:Notify', src, 'You earned $' .. amount .. ' for the delivery!', 'success')
end)

RegisterNetEvent('Alertpolice')
AddEventHandler('Alertpolice', function()
    local src = source
    local players = QBCore.Functions.GetPlayers()
    for _, v in pairs(players) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player.PlayerData.job.name == Config.PoliceJob then
            TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, 'A go-fast vehicle has been spotted!', 'error')
        end
    end
end)
