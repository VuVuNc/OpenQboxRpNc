local config = require 'config.client'
local currentStatusList = {}
local casings = {}
local currentCasing = nil
local bloodDrops = {}
local currentBloodDrop = nil
local fingerprints = {}
local currentFingerprint = 0
local shotAmount = 0

local statusList = {
    fight = locale('evidence.red_hands'),
    widepupils = locale('evidence.wide_pupils'),
    redeyes = locale('evidence.red_eyes'),
    weedsmell = locale('evidence.weed_smell'),
    gunpowder = locale('evidence.gunpowder'),
    chemicals = locale('evidence.chemicals'),
    heavybreath = locale('evidence.heavy_breathing'),
    sweat = locale('evidence.sweat'),
    handbleed = locale('evidence.handbleed'),
    confused = locale('evidence.confused'),
    alcohol = locale('evidence.alcohol'),
    heavyalcohol = locale('evidence.heavy_alcohol'),
    agitated = locale('evidence.agitated'),
}

local ignoredWeapons = {
    [`weapon_unarmed`] = true,
    [`weapon_snowball`] = true,
    [`weapon_stungun`] = true,
    [`weapon_petrolcan`] = true,
    [`weapon_hazardcan`] = true,
    [`weapon_fireextinguisher`] = true,
}

local function getWeaponName(weaponHash)
    local weaponName = string.upper(GetWeapontypeModel(weaponHash))
    return weaponName
end

local weaponAmmoTypes = {
    -- 9x19mm Parabellum
    [`WEAPON_PISTOL`] = '9x19mm',
    [`WEAPON_PISTOL_MK2`] = '9x19mm',
    [`WEAPON_COMBATPISTOL`] = '9x19mm',
    [`WEAPON_APPISTOL`] = '9x19mm',
    [`WEAPON_SNSPISTOL`] = '9x19mm',
    [`WEAPON_SNSPISTOL_MK2`] = '9x19mm',
    [`WEAPON_CERAMICPISTOL`] = '9x19mm',
    [`WEAPON_SMG`] = '9x19mm',
    [`WEAPON_SMG_MK2`] = '9x19mm',
    [`WEAPON_ASSAULTSMG`] = '9x19mm',
    [`WEAPON_MICROSMG`] = '9x19mm',
    [`WEAPON_MINISMG`] = '9x19mm',
    [`WEAPON_MACHINEPISTOL`] = '9x19mm',
    [`WEAPON_RAYCARBINE`] = '9x19mm',
    [`WEAPON_NAVYREVOLVER`] = '.38 Special',

    -- .45 ACP
    [`WEAPON_HEAVYPISTOL`] = '.45 ACP',
    [`WEAPON_VINTAGEPISTOL`] = '.45 ACP',
    [`WEAPON_GUSENBERG`] = '.45 ACP',
    [`WEAPON_DOUBLEACTION`] = '.45 ACP',

    -- .50 Action Express
    [`WEAPON_PISTOL50`] = '.50 AE',
    [`WEAPON_REVOLVER`] = '.50 AE',
    [`WEAPON_REVOLVER_MK2`] = '.50 AE',

    -- 5.56x45mm NATO
    [`WEAPON_CARBINERIFLE`] = '5.56x45mm',
    [`WEAPON_CARBINERIFLE_MK2`] = '5.56x45mm',
    [`WEAPON_ADVANCEDRIFLE`] = '5.56x45mm',
    [`WEAPON_SPECIALCARBINE`] = '5.56x45mm',
    [`WEAPON_SPECIALCARBINE_MK2`] = '5.56x45mm',
    [`WEAPON_BULLPUPRIFLE`] = '5.56x45mm',
    [`WEAPON_BULLPUPRIFLE_MK2`] = '5.56x45mm',
    [`WEAPON_MILITARYRIFLE`] = '5.56x45mm',
    [`WEAPON_SERVICE_CARBINE`] = '5.56x45mm',

    -- 7.62x39mm
    [`WEAPON_ASSAULTRIFLE`] = '7.62x39mm',
    [`WEAPON_ASSAULTRIFLE_MK2`] = '7.62x39mm',
    [`WEAPON_COMPACTRIFLE`] = '7.62x39mm',
    
    -- 7.62x51mm NATO
    [`WEAPON_MG`] = '7.62x51mm',
    [`WEAPON_COMBATMG`] = '7.62x51mm',
    [`WEAPON_COMBATMG_MK2`] = '7.62x51mm',
    [`WEAPON_TACTICALRIFLE`] = '7.62x51mm',
    [`WEAPON_HEAVYRIFLE`] = '7.62x51mm',

    -- .308 Winchester
    [`WEAPON_SNIPERRIFLE`] = '.308',
    [`WEAPON_MARKSMANRIFLE`] = '.308',
    [`WEAPON_MARKSMANRIFLE_MK2`] = '.308',
    [`WEAPON_PRECISIONRIFLE`] = '.308',

    -- .50 BMG
    [`WEAPON_HEAVYSNIPER`] = '.50 BMG',
    [`WEAPON_HEAVYSNIPER_MK2`] = '.50 BMG',

    -- 12 Gauge
    [`WEAPON_PUMPSHOTGUN`] = '12 Gauge',
    [`WEAPON_PUMPSHOTGUN_MK2`] = '12 Gauge',
    [`WEAPON_SAWNOFFSHOTGUN`] = '12 Gauge',
    [`WEAPON_ASSAULTSHOTGUN`] = '12 Gauge',
    [`WEAPON_BULLPUPSHOTGUN`] = '12 Gauge',
    [`WEAPON_HEAVYSHOTGUN`] = '12 Gauge',
    [`WEAPON_DBSHOTGUN`] = '12 Gauge',
    [`WEAPON_AUTOSHOTGUN`] = '12 Gauge',
    [`WEAPON_COMBATSHOTGUN`] = '12 Gauge'
}

local function dropBulletCasing(weapon, ped)
    local randX = math.random() + math.random(-1, 1)
    local randY = math.random() + math.random(-1, 1)
    local coords = GetOffsetFromEntityInWorldCoords(ped, randX, randY, 0)
    local serial = exports.ox_inventory:getCurrentWeapon().metadata.serial
    TriggerServerEvent('evidence:server:CreateCasing', weapon, serial, coords)
    Wait(300)
end

local function dnaHash(s)
    local h = string.gsub(s, '.', function(c)
        return string.format('%02x', string.byte(c))
    end)
    return h
end

RegisterNetEvent('evidence:client:SetStatus', function(statusId, time)
    if time > 0 and statusList[statusId] then
        if not currentStatusList?[statusId] or currentStatusList[statusId].time < 20 then
            currentStatusList[statusId] = {
                text = statusList[statusId],
                time = time
            }
            exports.qbx_core:Notify(currentStatusList[statusId].text, 'error')
        end
    elseif statusList[statusId] then
        currentStatusList[statusId] = nil
    end
    TriggerServerEvent('evidence:server:UpdateStatus', currentStatusList)
end)

RegisterNetEvent('evidence:client:AddBlooddrop', function(bloodId, citizenid, bloodtype, coords)
    bloodDrops[bloodId] = {
        citizenid = citizenid,
        bloodtype = bloodtype,
        coords = vec3(coords.x, coords.y, coords.z - 0.9)
    }
end)

RegisterNetEvent('evidence:client:RemoveBlooddrop', function(bloodId)
    bloodDrops[bloodId] = nil
    currentBloodDrop = 0
end)

RegisterNetEvent('evidence:client:AddFingerPrint', function(fingerId, fingerprint, coords)
    fingerprints[fingerId] = {
        fingerprint = fingerprint,
        coords = vec3(coords.x, coords.y, coords.z - 0.9)
    }
end)

RegisterNetEvent('evidence:client:RemoveFingerprint', function(fingerId)
    fingerprints[fingerId] = nil
    currentFingerprint = 0
end)

RegisterNetEvent('evidence:client:ClearBlooddropsInArea', function()
    local pos = GetEntityCoords(cache.ped)
    local bloodDropList = {}
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        label = locale('progressbar.blood_clear'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = false,
            combat = true,
            mouse = false
        }
    })
    then
        if bloodDrops and next(bloodDrops) then
            for bloodId in pairs(bloodDrops) do
                if #(pos - bloodDrops[bloodId].coords) < 10.0 then
                    bloodDropList[#bloodDropList + 1] = bloodId
                end
            end
            TriggerServerEvent('evidence:server:ClearBlooddrops', bloodDropList)
            exports.qbx_core:Notify(locale('success.blood_clear'), 'success')
        end
    else
        exports.qbx_core:Notify(locale('error.blood_not_cleared'), 'error')
    end
end)

RegisterNetEvent('evidence:client:AddCasing', function(casingId, weapon, coords, serie)
    casings[casingId] = {
        type = weapon,
        serie = serie and serie or locale('evidence.serial_not_visible'),
        coords = vec3(coords.x, coords.y, coords.z - 0.9)
    }
end)

RegisterNetEvent('evidence:client:RemoveCasing', function(casingId)
    casings[casingId] = nil
    currentCasing = 0
end)

RegisterNetEvent('evidence:client:ClearCasingsInArea', function()
    local pos = GetEntityCoords(cache.ped)
    local casingList = {}

    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        label = locale('progressbar.bullet_casing'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = false,
            combat = true,
            mouse = false,
        }
    })
    then
        if casings and next(casings) then
            for casingId in pairs(casings) do
                if #(pos - casings[casingId].coords) < 10.0 then
                    casingList[#casingList + 1] = casingId
                end
            end
            TriggerServerEvent('evidence:server:ClearCasings', casingList)
            exports.qbx_core:Notify(locale('success.bullet_casing_removed'), 'success')
        end
    else
        exports.qbx_core:Notify(locale('error.bullet_casing_not_removed'), 'error')
    end
end)

local function updateStatus()
    if not LocalPlayer.state.isLoggedIn then return end
    if currentStatusList and next(currentStatusList) then
        for k in pairs(currentStatusList) do
            if currentStatusList[k].time > 0 then
                currentStatusList[k].time -= 10
            else
                currentStatusList[k].time = 0
            end
        end
        TriggerServerEvent('evidence:server:UpdateStatus', currentStatusList)
    end
    if shotAmount > 0 then
        shotAmount = 0
    end
end

CreateThread(function()
    while true do
        Wait(10000)
        updateStatus()
    end
end)

local function onPlayerShooting()
    shotAmount += 1
    if shotAmount > 5 and not currentStatusList?.gunpowder then
        if math.random(1, 10) <= 7 then
            TriggerEvent('evidence:client:SetStatus', 'gunpowder', 200)
        end
    end
    dropBulletCasing(cache.weapon, cache.ped)
end

CreateThread(function() -- Gunpowder Status when shooting
    while true do
        Wait(0)
        if IsPedShooting(cache.ped) and not ignoredWeapons[cache.weapon] then
            onPlayerShooting()
        end
    end
end)

---@param coords vector3
---@return string
local function getStreetLabel(coords)
    local s1, s2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 then
        streetLabel = streetLabel .. ' | ' .. street2
    end
    local sanitized = streetLabel:gsub("%'", "")
    return sanitized
end

local function getPlayerDistanceFromCoords(coords)
    local pos = GetEntityCoords(cache.ped)
    return #(pos - coords)
end

---@class DrawEvidenceIfInRangeArgs
---@field evidenceId integer
---@field coords vector3
---@field text string
---@field metadata table
---@field serverEventOnPickup string

---@param args DrawEvidenceIfInRangeArgs
local function drawEvidenceIfInRange(args)
    if getPlayerDistanceFromCoords(args.coords) >= 1.5 then return end
    qbx.drawText3d({text = args.text, coords = args.coords})
    if IsControlJustReleased(0, 47) then
        TriggerServerEvent(args.serverEventOnPickup, args.evidenceId, args.metadata)
    end
end

--- draw 3D text on the ground to show evidence, if they press pickup button, set metadata and add it to their inventory.
CreateThread(function()
    while true do
        Wait(0)
        if currentCasing and currentCasing ~= 0 and casings[currentCasing] then
            local weaponHash = casings[currentCasing].type
            local ammoType = weaponAmmoTypes[weaponHash] or 'Unknown'
            
            drawEvidenceIfInRange({
                evidenceId = currentCasing,
                coords = casings[currentCasing].coords,
                text = locale('info.bullet_casing', casings[currentCasing].type),
                metadata = {
                    type = locale('info.casing'),
                    street = getStreetLabel(casings[currentCasing].coords),
                    ammolabel = ammoType,
                    ammotype = weaponHash,
                    serie = casings[currentCasing].serie
                },
                serverEventOnPickup = 'evidence:server:AddCasingToInventory'
            })
        end

        if currentBloodDrop and currentBloodDrop ~= 0 then
            drawEvidenceIfInRange({
                evidenceId = currentBloodDrop,
                coords = bloodDrops[currentBloodDrop].coords,
                text = locale('info.blood_text', dnaHash(bloodDrops[currentBloodDrop].citizenid)),
                metadata = {
                    type = locale('info.blood'),
                    street = getStreetLabel(bloodDrops[currentBloodDrop].coords),
                    dnalabel = dnaHash(bloodDrops[currentBloodDrop].citizenid),
                    bloodtype = bloodDrops[currentBloodDrop].bloodtype
                },
                serverEventOnPickup = 'evidence:server:AddBlooddropToInventory'
            })
        end

        if currentFingerprint and currentFingerprint ~= 0 then
            drawEvidenceIfInRange({
                evidenceId = currentFingerprint,
                coords = fingerprints[currentFingerprint].coords,
                text = locale('info.fingerprint_text'),
                metadata = {
                    type = locale('info.fingerprint'),
                    street = getStreetLabel(fingerprints[currentFingerprint].coords),
                    fingerprint = fingerprints[currentFingerprint].fingerprint
                },
                serverEventOnPickup = 'evidence:server:AddFingerprintToInventory'
            })
        end
    end
end)

local function canDiscoverEvidence()
    return LocalPlayer.state.isLoggedIn
    and QBX.PlayerData.job.type == 'leo'
    and QBX.PlayerData.job.onduty
    and IsPlayerFreeAiming(cache.playerId)
    and cache.weapon == `WEAPON_FLASHLIGHT`
end

---@param evidence table<number, {coords: vector3}>
---@return number? evidenceId
local function getCloseEvidence(evidence)
    local pos = GetEntityCoords(cache.ped, true)
    for evidenceId, v in pairs(evidence) do
        local dist = #(pos - v.coords)
        if dist < 1.5 then
            return evidenceId
        end
    end
end

CreateThread(function()
    while true do
        local closeEvidenceSleep = 1000
        if canDiscoverEvidence() then
            closeEvidenceSleep = 10
            currentCasing = getCloseEvidence(casings) or currentCasing
            currentBloodDrop = getCloseEvidence(bloodDrops) or currentBloodDrop
            currentFingerprint = getCloseEvidence(fingerprints) or currentFingerprint
        end
        Wait(closeEvidenceSleep)
    end
end)
