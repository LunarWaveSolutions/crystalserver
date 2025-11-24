local botHeal = TalkAction("!botheal")

-- Configurações básicas
local healConfig = {
    spell = "exura", -- feitiço que o player vai usar
    interval = 2000, -- intervalo de checagem em milissegundos
    minHealthPercent = 60 -- abaixo disso ele tenta curar
}

-- Storage pra marcar se o bot tá ativo
local STORAGE_BOT_HEAL = 50000

-- Função que realiza o loop de cura
local function healLoop(playerId)
    local player = Player(playerId)
    if not player or player:getStorageValue(STORAGE_BOT_HEAL) ~= 1 then
        return -- para se o player deslogou ou desativou
    end

    local healthPercent = (player:getHealth() / player:getMaxHealth()) * 100
    if healthPercent < healConfig.minHealthPercent then
		print("cast spell aqui")
	local spell = Spell(healConfig.spell)
	
	print("eaeaea", spell)

    -- Tenta executar o instant spell pelo mesmo fluxo do servidor
    -- Retorna true se conseguiu, caso contrário deixa o chat seguir normalmente
    player:castInstantSpell("exura")

        player:sendTextMessage(MESSAGE_LOOK, "[AutoHeal] HP baixo (" .. math.floor(healthPercent) .. "%), curando...")
		print("cast spell la")
    end

    -- reagenda o próximo check
    addEvent(healLoop, healConfig.interval, playerId)
end

-- Função para exibir o modal de controle
local function sendBotHealModal(player)
    local isActive = player:getStorageValue(STORAGE_BOT_HEAL) == 1

    local window = ModalWindow({
        title = "Bot de Cura Automática",
        message = isActive and "O bot de cura está ativo.\nDeseja desativar?" or "Deseja ativar o bot de cura automática?",
    })

    if isActive then
        window:addChoice("Desativar", function(player, button, choice)
            if button.name ~= "Select" then return true end
            player:setStorageValue(STORAGE_BOT_HEAL, 0)
            player:sendTextMessage(MESSAGE_LOOK, "[AutoHeal] Desativado.")
        end)
    else
        window:addChoice("Ativar", function(player, button, choice)
            if button.name ~= "Select" then return true end
            player:setStorageValue(STORAGE_BOT_HEAL, 1)
            player:sendTextMessage(MESSAGE_LOOK, "[AutoHeal] Ativado.")
            healLoop(player:getId())
        end)
    end

    window:addButton("Select")
    window:addButton("Fechar")
    window:setDefaultEnterButton(0)
    window:setDefaultEscapeButton(1)
    window:sendToPlayer(player)
end

function botHeal.onSay(player, words, param)
    sendBotHealModal(player)
    return true
end

botHeal:separator(" ")
botHeal:groupType("normal")
botHeal:register()
