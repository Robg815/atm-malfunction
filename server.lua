local lastEventTime = 0
local atmCooldowns = {}

CreateThread(function()
    while true do
        Wait(10000) -- check every 10s

        if os.time() - lastEventTime >= Config.GlobalCooldown then
            local atm = Config.ATMs[math.random(#Config.ATMs)]
            local players = GetPlayers()

            for _, src in pairs(players) do
                local ped = GetPlayerPed(src)
                local pos = GetEntityCoords(ped)
                local dist = #(pos - atm)

                if dist <= Config.TriggerDistance then
                    if not atmCooldowns[atm] or os.time() - atmCooldowns[atm] >= Config.ATMReuseCooldown then
                        atmCooldowns[atm] = os.time()
                        lastEventTime = os.time()

                        TriggerClientEvent('atm-malfunction:triggerATM', src, atm)

                        if Config.Dispatch.enabled then
                            TriggerEvent('ps-dispatch:addAlert', {
                                job = Config.Dispatch.job,
                                title = Config.Dispatch.title,
                                message = Config.Dispatch.message,
                                coords = atm
                            })
                        end

                        if Config.MDT.enabled then
                            TriggerEvent('ps-mdt:addIncident', {
                                category = Config.MDT.category,
                                description = Config.MDT.description,
                                location = atm
                            })
                        end

                        break
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('atm-malfunction:collectReward', function()
    local src = source
    Utils.GiveReward(src)
end)
