local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = {
	LobbyManager = ReplicatedStorage.LobbyManager,
	RoundSystem = ReplicatedStorage.RoundSystem,
	NotificationManager = ReplicatedStorage.NotificationManager,
	RewardSystem = ReplicatedStorage.RewardSystem,
	PlayerManager = ReplicatedStorage.PlayerManager,
}

local function initialize()
	for _, module in Modules do
		require(module).initialize()
	end
end

initialize()

--while wait(10) do 
--	local hat = hats[math.random(#hats)]:Clone()
--	hat.Parent, hat.Position = workspace, Vector3.new(math.random(baseplate.Position.X - baseplate.Size.X / 2), 100, math.random(baseplate.Position.Z - baseplate.Size.Z / 2)) 
--end

--[[
	раунды, надо выжить определенное количество времени, чем меньше игроков остается тем больше победитель получает денег.
	чтобы сыграть в игру надо кинуть монету, когда будет начинатся игра, будет выскакивать сообщение, хотите поиграть?
	да, кидается монета и игрок попадает в список, далее игроки попадют на карту идет таймер и они лупятся
	
	сделать такой модуль сразу хорошо, потому что была идея для ставок в японских завабах
	
	
	надо еще добавить увеличение силы фена, и чтобы на высоких уровнях он люты выдувал игроков,
	тогда надо еще подумать над дефом этой силы
	
	и на иконку поставить слабый фен 1 уровня и 999 уровня
]]