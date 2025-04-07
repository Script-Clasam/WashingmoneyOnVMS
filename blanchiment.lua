-----------If you use QBCore or Qbox ------------------
RegisterNUICallback('launderMoney', function(data, cb)
local amount = tonumber(data.amount)

    if not amount or amount <= 0 then
        TriggerEvent('QBCore:Notify', 'Montant invalide.', 'error')
        return cb({ status = "error" })
    end
 TriggerServerEvent('launder:server:launderMoney', amount)
    cb({ status = "ok" })
end)
-----------If you use ESX ------------------
-- RegisterNUICallback('launderMoney', function(data, cb)
--     local amount = tonumber(data.amount)

--     if not amount or amount <= 0 then
--         ESX.ShowNotification('~r~Montant invalide.')
--         return cb({ status = "error" })
--     end

--     TriggerServerEvent('launder:server:launderMoney', amount)
--     cb({ status = "ok" })
-- end)
