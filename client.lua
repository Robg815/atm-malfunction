local activeATM = nil

RegisterNetEvent('atm-malfunction:triggerATM', function(coords)
    activeATM = coords

    local targetSystem = Config.Target

    if targetSystem == "auto" then
        if GetResourceState("ox_target") == "started" then
            targetSystem = "ox_target"
        elseif GetResourceState("qb-target") == "started" then
            targetSystem = "qb-target"
        else
            targetSystem = "e-interact"
        end
    end

    if targetSystem == "ox_target" then
        exports.ox_target:addSphereZone({
            coords = coords,
            radius = Config.InteractionDistance,
            debug = false,
            options = {
                {
                    label = 'Grab spilled cash 💸',
                    icon = 'fas fa-money-bill-wave',
                    onSelect = function()
                        collectCash()
                    end
                }
            }
        })
    elseif targetSystem == "qb-target" then
        exports['qb-target']:AddBoxZone("atm_cash_grab", coords, 1.2, 1.2, {
            name = "atm_cash_grab",
            heading = 0.0,
            debugPoly = false,
            minZ = coords.z - 1.0,
            maxZ = coords.z + 1.0,
        }, {
            options = {
                {
                    label = "Grab Cash 💸",
                    action = function()
                        collectCash()
                    end,
                    icon = "fas fa-money-bill"
                }
            },
            distance = 1.5
        })
    else
        -- fallback for key-based
        CreateThread(function()
            while true do
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                if #(pos - coords) < Config.InteractionDistance then
                    DrawText3D(coords, "[E] Grab Cash")
                    if IsControlJustReleased(0, 38) then -- E
                        collectCash()
                        break
                    end
                end
                Wait(0)
            end
        end)
    end

    -- Add FX (money pile prop or spark particles here if desired)
end)

function collectCash()
    activeATM = nil
    TriggerServerEvent('atm-malfunction:collectReward')
end

function DrawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z + 0.5)
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
end
