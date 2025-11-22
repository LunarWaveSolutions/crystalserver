local internalNpcName = "Agiota O que Cobra Juros"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128, -- Citizen
	lookHead = 97,
	lookBody = 77,
	lookLegs = 87,
	lookFeet = 115,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Ei, carinha… quer saber qual é a boa hoje?" },
	{ text = "Troco gold por Programa Coins!" },
	{ text = "Vem, compra já!" },
	{ text = "Quer saber qual é a boa hoje? Compre suas Programa Coins aqui!" },
}

-- Configuration
local coinItemId = 37317
local coinPrice = 5000 -- Price in gold per coin. Adjust as needed.

npcConfig.shop = {
	{ itemName = "Programa Coin", clientId = coinItemId, buy = coinPrice },
}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	if itemId == coinItemId then
		if player:removeMoney(totalCost) then
			-- Add Tibia Coins to the player's account
			-- The second argument 'true' is based on existing scripts (e.g. online_coins.lua)
			player:addTransferableCoins(amount, true)
			player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Você comprou %d Programa Coins por %d gold.", amount, totalCost))
			
			-- Send the trade message to update the UI or confirm the transaction
			-- We don't call npc:sellItem because we don't want to give the physical item
		else
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "Você não tem dinheiro seu pobre sai daqui.")
		end
	else
		-- For other items, use the default behavior
		npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
	end
end

-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Vendeu %ix %s por %i gold.", amount, name, totalCost))
end

-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local function creatureSayCallback(npc, player, type, message)
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end

	if MsgContains(message, "trade") or MsgContains(message, "negociar") then
		npc:openShopWindow(player)
		npcHandler:say("Dê uma olhada no pacotão, relaxa o lá ele, aqui tem respeito.", npc, player)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Olá, |PLAYERNAME|! Eu vendo Programa Coins. Peça para {negociar}.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Até logo.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Até logo.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Dê uma olhada no pacotão, relaxa o lá ele, aqui tem respeito.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
