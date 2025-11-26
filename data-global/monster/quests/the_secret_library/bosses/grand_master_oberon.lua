local mType = Game.createMonsterType("Grand Master Oberon")
local monster = {}

monster.description = "Grand Master Oberon"
monster.experience = 20000

monster.outfit = {
	lookType = 1072,
	lookHead = 21,
	lookBody = 96,
	lookLegs = 21,
	lookFeet = 105,
	lookAddons = 1,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1576,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 60000
monster.maxHealth = 60000
monster.race = "blood"
monster.corpse = 28625
monster.speed = 115
monster.manaCost = 0

monster.events = { "killingLibrary" }

monster.changeTarget = { interval = 4000, chance = 10 }

monster.strategiesTarget = { nearest = 100 }

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = { level = 0, color = 0 }

monster.voices = { interval = 5000, chance = 10 }

monster.loot = {
	{ id = 3115, chance = 30000 },
	{ name = "brass shield", chance = 30000 },
	{ name = "spatial warp almanac", chance = 25000 },
	{ name = "viking helmet", chance = 23000 },
	{ name = "falcon battleaxe", chance = 500 },
	{ name = "falcon longsword", chance = 500 },
	{ name = "falcon mace", chance = 500 },
	{ name = "grant of arms", chance = 500 },
	{ name = "falcon bow", chance = 350 },
	{ name = "falcon circlet", chance = 350 },
	{ name = "falcon coif", chance = 350 },
	{ name = "falcon rod", chance = 350 },
	{ name = "falcon wand", chance = 350 },
	{ name = "falcon shield", chance = 200 },
	{ name = "falcon greaves", chance = 200 },
	{ name = "falcon plate", chance = 200 },
	{ name = "falcon sai", chance = 200 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1400 },
	{ name = "combat", interval = 3000, chance = 40, type = COMBAT_HOLYDAMAGE, minDamage = -800, maxDamage = -1200, length = 8, effect = CONST_ME_HOLYAREA, target = false },
	{ name = "combat", interval = 4250, chance = 35, type = COMBAT_EARTHDAMAGE, minDamage = -500, maxDamage = -1000, radius = 5, effect = CONST_ME_HITAREA, target = false },
	{ name = "combat", interval = 5000, chance = 37, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -1000, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 60,
	armor = 82,
	{ name = "speed", interval = 1000, chance = 10, speedChange = 180, effect = CONST_ME_POFF, duration = 4000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

----------------------------------------------------------------
--               SISTEMA OBERON - MELHORADO                   --
----------------------------------------------------------------

mType.onThink = function(monster, interval)
	local storageLife = GrandMasterOberonConfig.Storage.Life

	-- Inicializa storage caso seja -1
	if monster:getStorageValue(storageLife) < 0 then
		monster:setStorageValue(storageLife, 0)
	end

	local currentLife = monster:getStorageValue(storageLife)

	-- Verifica se ainda pode perguntar (número máximo de "asks")
	if currentLife >= GrandMasterOberonConfig.AmountLife then
		return true
	end

	local hpPercent = (monster:getHealth() * 100) / monster:getMaxHealth()

	if hpPercent <= 20 then
		SendOberonAsking(monster)
	end

	return true
end

mType.onSay = function(monster, creature, type, message)
	if type ~= TALKTYPE_SAY then
		return false
	end

	if not creature:isPlayer() then
		return false
	end

	if not message then
		return false
	end

	local storageExhaust = GrandMasterOberonConfig.Storage.Exhaust

	-- Verifica e aplica exhaust
	local exhaustTime = monster:getStorageValue(storageExhaust)
	if exhaustTime > os.time() then
		return false
	end

	monster:setStorageValue(storageExhaust, os.time() + 1)

	-- Recupera pergunta ativa
	local askingStorage = monster:getStorageValue(GrandMasterOberonConfig.Storage.Asking)
	local data = GrandMasterOberonResponses[askingStorage]

	if not data then
		return false
	end

	local msg = message:lower():trim()

	local answer1 = data.msg and data.msg:lower() or ""
	local answer2 = data.msg2 and data.msg2:lower() or ""

	if msg == answer1 or msg == answer2 then
		monster:say("GRRRAAANNGH!", TALKTYPE_MONSTER_SAY)

		if monster:hasEvent("OberonImmunity") then
			monster:unregisterEvent("OberonImmunity")
		end
	else
		monster:say("HAHAHAHA!", TALKTYPE_MONSTER_SAY)
	end

	return true
end

mType:register(monster)
