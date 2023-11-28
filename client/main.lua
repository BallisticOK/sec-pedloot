local QBCore = exports['qb-core']:GetCoreObject()
local lootedPeds = {}
local isBlacklisted = false

local function isPlayerBlacklisted()
    QBCore.Functions.TriggerCallback("mh-blacklisted:server:isBlacklisted", function(_isBlacklisted)
        isBlacklisted = _isBlacklisted
    end)
end

local function IsPadAlreadyLooted(entity)
    local looted = false
    for k, v in pairs(lootedPeds) do
        if v.ped == entity then
            looted = true
        end
    end
    return looted
end

local function PedHasLooted(entity)
    if IsPadAlreadyLooted(entity) then return end
    lootedPeds[#lootedPeds + 1] = {ped = entity}
    if not isBlacklisted then 
        TriggerServerEvent('mh-blackmarket:server:taskCountAdd', 8)
    end
end

-- ON PLAYER LOAD
local PlayerData = {}
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('sec-pedloot:server:onjoin')
end)

-- Delete Dead Ped
RegisterNetEvent("sec-pedloot:client:deleteped", function(entity)
    local tmpEntity = NetToPed(entity)
    local closedPed = QBCore.Functions.GetClosestPed(GetEntityCoords(PlayerPedId()))
    if DoesEntityExist(tmpEntity) and not IsPedAPlayer(tmpEntity) then
        DeletePed(tmpEntity)
        DeleteEntity(tmpEntity)
    end
end)

-- TAKE LOOT
RegisterNetEvent("sec-pedloot:client:takeloot", function(entity)
    TriggerServerEvent('sec-pedloot:server:getloot', PedToNet(entity))
    PedHasLooted(entity)
end)

-- TARGET SYSTEM
exports['qb-target']:AddTargetModel(Config.PedModels, {
    options = {
        {
            type = "client",
            event = "sec-pedloot:client:takeloot",
            icon = 'fas fa-skull-crossbones',
            label = Lang:t('target.label'),
            targeticon = 'fas fa-skull-crossbones',
            action = function(entity)
                if IsPedAPlayer(entity) then return false end
                if IsPadAlreadyLooted(entity) then return false end
                if isBlacklisted then return false end
                TriggerEvent('sec-pedloot:client:takeloot', entity)
            end,
            canInteract = function(entity, distance, data)
                if IsPedAPlayer(entity) then return false end
                if not IsPedAPlayer(entity) and not IsEntityDead(entity) then return false end
                if IsPadAlreadyLooted(entity) then return false end
                if isBlacklisted then
                    isPlayerBlacklisted()
                    return false
                end
                return true
            end
        }
    },
    distance = 2.5,
})
