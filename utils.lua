Utils = {}

function Utils.Notify(source, msg)
    TriggerClientEvent('ox_lib:notify', source, {
        type = 'inform',
        description = msg,
        duration = 5000
    })
end

function Utils.GiveReward(source)
    local reward = math.random(Config.Reward.min, Config.Reward.max)
    local fw = Utils.GetFramework()

    if Config.Inventory.type == "ox_inventory" then
        exports.ox_inventory:AddItem(source, Config.Inventory.item, Config.Inventory.amount)
    elseif Config.Inventory.type == "qb-inventory" then
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            Player.Functions.AddItem(Config.Inventory.item, Config.Inventory.amount)
        end
    elseif Config.Inventory.type == "none" then
        if fw == "qbcore" then
            local QBCore = exports['qb-core']:GetCoreObject()
            local Player = QBCore.Functions.GetPlayer(source)
            if Player then
                Player.Functions.AddMoney('cash', reward)
            end
        elseif fw == "esx" then
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer then
                xPlayer.addMoney(reward)
            end
        end
    end

    Utils.Notify(source, "You grabbed some cash from the ATM!")
end

function Utils.GetFramework()
    if Config.Framework ~= "auto" then return Config.Framework end

    if GetResourceState("qb-core") == "started" then
        return "qbcore"
    elseif GetResourceState("es_extended") == "started" then
        return "esx"
    elseif GetResourceState("qbox") == "started" then
        return "qbox"
    else
        return "none"
    end
end
