------- If you use QBcore or Qbox ------------------


local QBCore = exports['qb-core']:GetCoreObject()

-- Percentage of money laundering (ex: 85%)
-- For exemple if you put 0.85 it will give you 85% of the money you laundered
-- 1000 $ = 850$ clean money
local LAUNDER_PERCENTAGE = 0.85

---- Cooldown Time in seconds---- Here 12 Hours
local LAUNDER_COOLDOWN = 43200

local lastLaunder = {}

RegisterNetEvent('launder:server:launderMoney', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    amount = tonumber(amount)
    local now = os.time()
    if lastLaunder[src] and now - lastLaunder[src] < LAUNDER_COOLDOWN then
        local remaining = LAUNDER_COOLDOWN - (now - lastLaunder[src])
        local hours = math.floor(remaining / 3600)
        local minutes = math.floor((remaining % 3600) / 60)
        return TriggerClientEvent('QBCore:Notify', src, ('Vous devez attendre %dh %dm avant de blanchir à nouveau.'):format(hours, minutes), 'error')
    end

    if not amount or amount <= 0 then
        return TriggerClientEvent('QBCore:Notify', src, 'Montant invalide.', 'error')
    end

    local blackMoney = exports.ox_inventory:GetItemCount(src, 'black_money')

    if blackMoney >= amount then
        exports.ox_inventory:RemoveItem(src, 'black_money', amount)
        local cleanAmount = math.floor(amount * LAUNDER_PERCENTAGE)
        Player.Functions.AddMoney('cash', cleanAmount, 'money-laundering')

        lastLaunder[src] = now
        TriggerClientEvent('QBCore:Notify', src, ('Vous avez blanchi %s$ (%.0f%%)'):format(cleanAmount, LAUNDER_PERCENTAGE * 100), 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Vous n\'avez pas assez d\'argent sale.', 'error')
    end
end)

AddEventHandler('playerDropped', function()
    lastLaunder[source] = nil
end)




----------------if you use ESX------------------------

-- ESX = exports['es_extended']:getSharedObject()

-- -- Percentage of money laundering (ex: 85%)
-- -- For exemple if you put 0.85 it will give you 85% of the money you laundered
-- -- 1000 $ = 850$ clean money
-- local LAUNDER_PERCENTAGE = 0.85

-- ---- Cooldown Time in seconds---- Here 12 Hours
-- local LAUNDER_COOLDOWN = 43200
-- local lastLaunder = {}

-- RegisterNetEvent('launder:server:launderMoney')
-- AddEventHandler('launder:server:launderMoney', function(amount)
--     local src = source
--     local xPlayer = ESX.GetPlayerFromId(src)
--     amount = tonumber(amount)
--     local now = os.time()
--     if lastLaunder[src] and now - lastLaunder[src] < LAUNDER_COOLDOWN then
--         local remaining = LAUNDER_COOLDOWN - (now - lastLaunder[src])
--         local hours = math.floor(remaining / 3600)
--         local minutes = math.floor((remaining % 3600) / 60)
--         return TriggerClientEvent('esx:showNotification', src, ('~r~Vous devez attendre %dh %dm avant de blanchir à nouveau.'):format(hours, minutes))
--     end

--     if not amount or amount <= 0 then
--         return TriggerClientEvent('esx:showNotification', src, '~r~Montant invalide.')
--     end

--     local blackMoney = xPlayer.getAccount('black_money').money

--     if blackMoney >= amount then
--         xPlayer.removeAccountMoney('black_money', amount)
--         local cleanAmount = math.floor(amount * LAUNDER_PERCENTAGE)
--         xPlayer.addMoney(cleanAmount)
--         lastLaunder[src] = now
--         TriggerClientEvent('esx:showNotification', src, ('~g~Vous avez blanchi %s$ (%.0f%%)'):format(cleanAmount, LAUNDER_PERCENTAGE * 100))
--     else
--         TriggerClientEvent('esx:showNotification', src, '~r~Vous n\'avez pas assez d\'argent sale.')
--     end
-- end)

-- AddEventHandler('playerDropped', function()
--     lastLaunder[source] = nil
-- end)
