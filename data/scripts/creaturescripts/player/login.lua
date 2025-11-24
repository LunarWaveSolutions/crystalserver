local function sendBoostMessage(player, category, isIncreased)
	return player:sendTextMessage(MESSAGE_BOOSTED_CREATURE, string.format("Event! %s is %screased. Happy Hunting!", category, isIncreased and "in" or "de"))
end

local function onMovementRemoveProtection(playerId, oldPos, time)
	local player = Player(playerId)
	if not player then
		return true
	end

	local playerPos = player:getPosition()
	if (playerPos.x ~= oldPos.x or playerPos.y ~= oldPos.y or playerPos.z ~= oldPos.z) or player:getTarget() then
		player:kv():remove("combat-protection")
		return true
	end

	addEvent(onMovementRemoveProtection, 1000, playerId, oldPos, time - 1)
end

local playerLoginGlobal = CreatureEvent("PlayerLoginGlobal")

function playerLoginGlobal.onLogin(player)
	-- Disables the chain system by default unless enabled in `config.lua`.
	if not configManager.getBoolean(configKeys.TOGGLE_CHAIN_SYSTEM) then
		player:setFeature(Features.ChainSystem, 0)
	end

	-- Welcome
	local loginStr
	if player:getLastLoginSaved() == 0 then
		loginStr = "Please choose your outfit."
		player:sendOutfitWindow()
		local startStreakLevel = configManager.getNumber(configKeys.START_STREAK_LEVEL)
		if startStreakLevel > 0 then
			player:setStreakLevel(startStreakLevel)
		end

		db.query("UPDATE `players` SET `istutorial` = 0 WHERE `id` = " .. player:getGuid())
	else
		loginStr = string.format("Your last visit in %s: %s.", SERVER_NAME, os.date("%d %b %Y %X", player:getLastLoginSaved()))
		
		
			local questsCompleted = 0

	if not Quests then
		dofile("data-global/lib/core/quests.lua")
	end
	if not Storage then
		dofile("data-global/lib/core/storages.lua")
	end

	for _, quest in pairs(Quests) do
		if quest.missions then
			for _, mission in pairs(quest.missions) do
				local storageId = mission.storageId
				local endValue = mission.endValue or mission.startValue or 1
				if storageId and endValue then
					player:setStorageValue(storageId, endValue)
					questsCompleted = questsCompleted + 1
				end
			end
		end
		-- tambÃ©m marca o storage inicial da quest (questline)
		if quest.startStorageId and quest.startStorageValue then
			player:setStorageValue(quest.startStorageId, quest.startStorageValue)
		end
	end
		
-- In Service of Yalahar
player:setStorageValue(41951, 5)
player:setStorageValue(41952, 6)
player:setStorageValue(41953, 8)
player:setStorageValue(41954, 6)
player:setStorageValue(41955, 6)
player:setStorageValue(41956, 8)
player:setStorageValue(41957, 5)
player:setStorageValue(41958, 5)
player:setStorageValue(41959, 4)
player:setStorageValue(41960, 2)
player:setStorageValue(41961, 1)

-- The New Frontier
player:setStorageValue(42700, 1)
player:setStorageValue(42701, 3)
player:setStorageValue(42702, 6)
player:setStorageValue(42703, 3)
player:setStorageValue(42704, 2)
player:setStorageValue(42705, 7)
player:setStorageValue(42706, 3)
player:setStorageValue(42707, 3)
player:setStorageValue(42708, 2)
player:setStorageValue(42709, 3)
player:setStorageValue(42710, 1)
player:setStorageValue(42720, 12)

-- Threatened Dreams
player:setStorageValue(44000, 1)
player:setStorageValue(44001, 17)
player:setStorageValue(44002, 1)

-- Travelling Trader (Rashid)
player:setStorageValue(42101, 1)
player:setStorageValue(42102, 2)
player:setStorageValue(42103, 5)
player:setStorageValue(42104, 3)
player:setStorageValue(42105, 3)
player:setStorageValue(42106, 3)
player:setStorageValue(42107, 2)
player:setStorageValue(42108, 1)

-- The Inquisition
player:setStorageValue(41691, 2)
player:setStorageValue(41692, 7)
player:setStorageValue(41693, 3)
player:setStorageValue(41694, 6)
player:setStorageValue(41695, 3)
player:setStorageValue(41696, 3)
player:setStorageValue(41697, 3)
player:setStorageValue(41698, 1)

-- Wrath of the Emperor (WOTE)
player:setStorageValue(43000, 1)
player:setStorageValue(43001, 3)
player:setStorageValue(43002, 3)
player:setStorageValue(43003, 3)
player:setStorageValue(43004, 3)
player:setStorageValue(43005, 3)
player:setStorageValue(43006, 4)
player:setStorageValue(43007, 6)
player:setStorageValue(43008, 2)
player:setStorageValue(43009, 2)
player:setStorageValue(43010, 6)

-- Forgotten Knowledge (Imbuements)
player:setStorageValue(44500, 1)
player:setStorageValue(44501, 1)
player:setStorageValue(44502, 1)
player:setStorageValue(44503, 1)
player:setStorageValue(44504, 1)
player:setStorageValue(44505, 1)
player:setStorageValue(44506, 1)
player:setStorageValue(44507, 1)
player:setStorageValue(44508, 1)

-- Sea Routes Around Yalahar
player:setStorageValue(41994, 1) -- Darashia
player:setStorageValue(41995, 1) -- Ab'Dendriel
player:setStorageValue(41996, 1) -- Venore
player:setStorageValue(41997, 1) -- Ankrahmun
player:setStorageValue(41998, 1) -- Port Hope
player:setStorageValue(41999, 1) -- Thais
player:setStorageValue(42000, 1) -- Liberty Bay
player:setStorageValue(42001, 1) -- Carlin
player:setStorageValue(42002, 1) -- Carlin

-- Forgotten Knowledge Access (Portais de Imbuement)
player:setStorageValue(44509, 1) -- AccessIce
player:setStorageValue(44510, 1) -- AccessFire
player:setStorageValue(44511, 1) -- AccessGolden
player:setStorageValue(44512, 1) -- AccessViolet
player:setStorageValue(44513, 1) -- AccessEarth
player:setStorageValue(44514, 1) -- AccessDeath

-- Explorer Society Quest (Total Unlock)
	player:setStorageValue(40629, 17) -- QuestLine
	player:setStorageValue(40631, 5) -- JoiningTheExplorers
	player:setStorageValue(40632, 8) -- TheIceDelivery
	player:setStorageValue(40633, 10) -- TheButterflyHunt
	player:setStorageValue(40634, 10) -- ThePlantCollection
	player:setStorageValue(40635, 10) -- TheLizardUrn
	player:setStorageValue(40636, 10) -- TheBonelordSecret
	player:setStorageValue(40637, 10) -- TheOrcPowder
	player:setStorageValue(40638, 10) -- CalassaQuest
	player:setStorageValue(40639, 10) -- TheMemoryStone
	player:setStorageValue(40640, 10) -- TheRuneWritings
	player:setStorageValue(40641, 10) -- TheEctoplasm
	player:setStorageValue(40642, 10) -- TheSpectralDress
	player:setStorageValue(40643, 10) -- TheSpectralStone
	player:setStorageValue(40644, 10) -- TheAstralPortals
	player:setStorageValue(40645, 10) -- TheIslandofDragons
	player:setStorageValue(40646, 10) -- TheIceMusic
	player:setStorageValue(40647, 10) -- BansheeDoor
	player:setStorageValue(40648, 10) -- BonelordsDoor
	player:setStorageValue(40649, 10) -- CalassaDoor
	player:setStorageValue(40650, 10) -- MemoryStoneDoor
	player:setStorageValue(40651, 10) -- ElvenDoor
	player:setStorageValue(40652, 10) -- OrcDoor
	player:setStorageValue(40653, 10) -- ChorurnDoor
	player:setStorageValue(40654, 10) -- DwacatraDoor
	player:setStorageValue(40655, 10) -- FamilyBroochDoor
	player:setStorageValue(40656, 10) -- TheElvenPoetry
	player:setStorageValue(40657, 10) -- SpectralStoneDoor
	player:setStorageValue(40658, 10) -- IceMusicDoor
	player:setStorageValue(40659, 10) -- ExplorerBrooch
	player:setStorageValue(40660, 10) -- SkullOfRatha.Bag1
	player:setStorageValue(40661, 10) -- SkullOfRatha.Bag2
	player:setStorageValue(40662, 10) -- GiantSmithHammer.Talon
	player:setStorageValue(40663, 10) -- GiantSmithHammer.Hammer
	player:setStorageValue(40664, 10) -- GiantSmithHammer.GoldCoin
	player:setStorageValue(40665, 10) -- Books.Cyclops
	player:setStorageValue(40666, 10) -- Books.Hengis
		
	end
	player:sendTextMessage(MESSAGE_LOGIN, loginStr)

	-- Promotion
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		local hasPromotion = player:kv():get("promoted")
		if not player:isPromoted() and hasPromotion then
			player:setVocation(promotion)
		end
	elseif player:isPromoted() then
		player:setVocation(vocation:getDemotion())
	end

	-- Boosted
	player:sendTextMessage(MESSAGE_BOOSTED_CREATURE, string.format("Today's boosted creature: %s.\nBoosted creatures yield more experience points, carry more loot than usual, and respawn at a faster rate.", Game.getBoostedCreature()))
	player:sendTextMessage(MESSAGE_BOOSTED_CREATURE, string.format("Today's boosted boss: %s.\nBoosted bosses contain more loot and count more kills for your Bosstiary.", Game.getBoostedBoss()))

	-- Rewards
	local rewards = #player:getRewardList()
	if rewards > 0 then
		player:sendTextMessage(MESSAGE_LOGIN, string.format("You have %d reward%s in your reward chest.", rewards, rewards > 1 and "s" or ""))
	end
	
	-- Rate events:
	if SCHEDULE_EXP_RATE ~= 100 then
		sendBoostMessage(player, "Exp Rate", SCHEDULE_EXP_RATE > 100)
	end

	if SCHEDULE_SPAWN_RATE ~= 100 then
		sendBoostMessage(player, "Spawn Rate", SCHEDULE_SPAWN_RATE > 100)
	end

	if SCHEDULE_LOOT_RATE ~= 100 then
		sendBoostMessage(player, "Loot Rate", SCHEDULE_LOOT_RATE > 100)
	end

	if SCHEDULE_BOSS_LOOT_RATE ~= 100 then
		sendBoostMessage(player, "Boss Loot Rate", SCHEDULE_BOSS_LOOT_RATE > 100)
	end

	if SCHEDULE_SKILL_RATE ~= 100 then
		sendBoostMessage(player, "Skill Rate", SCHEDULE_SKILL_RATE > 100)
	end

	-- Send Recruiter Outfit
	local resultId = db.storeQuery("SELECT `recruiter` FROM `accounts` WHERE `id`= " .. Game.getPlayerAccountId(getPlayerName(player)))
	if resultId then
		local recruiterStatus = Result.getNumber(resultId, "recruiter")
		local sex = player:getSex()
		local outfitId = (sex == 1) and 746 or 745
		for outfitAddOn = 0, 2 do
			if recruiterStatus >= outfitAddOn * 3 + 1 then
				if not player:hasOutfit(outfitId, outfitAddOn) then
					if outfitAddOn == 0 then
						player:addOutfit(outfitId)
					else
						player:addOutfitAddon(outfitId, outfitAddOn)
					end
				end
			end
		end
	end

	-- Send Client Exp Display
	if configManager.getBoolean(configKeys.XP_DISPLAY_MODE) then
		local baseRate = player:getFinalBaseRateExperience() * 100
		if configManager.getBoolean(configKeys.VIP_SYSTEM_ENABLED) then
			local vipBonusExp = configManager.getNumber(configKeys.VIP_BONUS_EXP)
			if vipBonusExp > 0 and player:isVip() then
				vipBonusExp = (vipBonusExp > 100 and 100) or vipBonusExp
				baseRate = baseRate * (1 + (vipBonusExp / 100))
				player:sendTextMessage(MESSAGE_BOOSTED_CREATURE, "Normal base xp is: " .. baseRate .. "%, because you are VIP, bonus of " .. vipBonusExp .. "%")
			end
		end

		player:setBaseXpGain(baseRate)
	end

	player:setStaminaXpBoost(player:getFinalBonusStamina() * 100)
	player:getFinalLowLevelBonus()

	-- Updates the player's VIP status and executes corresponding actions if applicable.
	if configManager.getBoolean(configKeys.VIP_SYSTEM_ENABLED) then
		local isCurrentlyVip = player:isVip()
		local hadVipStatus = player:kv():scoped("account"):get("vip-system") or false

		if hadVipStatus ~= isCurrentlyVip then
			if hadVipStatus then
				player:onRemoveVip()
			else
				player:onAddVip(player:getVipDays())
			end
		end

		if isCurrentlyVip then
			player:sendVipStatus()
		end
	end

	-- Set Ghost Mode
	if player:getGroup():getId() >= GROUP_TYPE_GAMEMASTER and player:getGroup():getId() < GROUP_TYPE_TESTER then
		player:setGhostMode(true)
	end

	-- Resets
	if _G.OnExerciseTraining[player:getId()] then
		stopEvent(_G.OnExerciseTraining[player:getId()].event)
		_G.OnExerciseTraining[player:getId()] = nil
		player:setTraining(false)
	end

	local playerId = player:getId()
	_G.NextUseStaminaTime[playerId] = 1
	_G.NextUseXpStamina[playerId] = 1
	_G.NextUseConcoctionTime[playerId] = 1
	DailyReward.init(playerId)

	local stats = player:inBossFight()
	if stats then
		stats.playerId = player:getId()
	end

	-- Remove Boss Time
	if GetDailyRewardLastServerSave() >= player:getLastLoginSaved() then
		player:setRemoveBossTime(1)
	end

	-- Remove combat protection
	local isProtected = player:kv():get("combat-protection") or 0
	if isProtected < 1 then
		player:kv():set("combat-protection", 1)
		onMovementRemoveProtection(playerId, player:getPosition(), 10)
	end

	-- fix stash
	player:setSpecialContainersAvailable(true, true, true)

	player:initializeLoyaltySystem()
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("BossParticipation")
	player:registerEvent("UpdatePlayerOnAdvancedLevel")
	return true
end

playerLoginGlobal:register()