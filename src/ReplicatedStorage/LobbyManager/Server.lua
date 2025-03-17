local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Constants = require(ReplicatedStorage.Constants)
local iteratePlayers = require(ReplicatedStorage.Utility.iteratePlayers)

local PlayerManager = ReplicatedStorage.PlayerManager
local PlayerManagerAssets = PlayerManager.Assets

local RoundSystem = ReplicatedStorage.RoundSystem
local RoundSystemVariables = RoundSystem.Variables
local roundSystemEvent = RoundSystem.Events.Event
local roundSystemEventActions = require(roundSystemEvent.Actions)

local NotificationManager = ReplicatedStorage.NotificationManager
local notificationManagerEvent = NotificationManager.Events.Event
local notificationManagerEventActions = require(notificationManagerEvent.Actions)

local RewardSystem = ReplicatedStorage.RewardSystem
local rewardSystemEvent = RewardSystem.Events.Event
local rewardSystemEventActions = require(rewardSystemEvent.Actions)


local _readyPlayers: { Player } = {}

local function intermission()
	for i = Constants.INTERMISSION_TIME, 0, -1 do
		notificationManagerEvent:Fire(
			notificationManagerEventActions.intermission,
			i
		)
		task.wait(1)
	end
	
	notificationManagerEvent:Fire(
		notificationManagerEventActions.intermission,
		nil
	)
	
end

local function prepare()
	local function _callback(player: Player)
		local playerStats = player:FindFirstChild(PlayerManagerAssets.Stats.Name) :: typeof(PlayerManagerAssets.Stats)
		local playerInGame = player:GetAttribute(Constants.IN_GAME_ATTRIBUTE)
		if not playerInGame and not playerStats.AFK.Value then
			table.insert(_readyPlayers, player)
		end
	end
	
	iteratePlayers(Players:GetPlayers(), _callback)
end

local function start()
	if #_readyPlayers >= Constants.MIN_PLAYERS then
		roundSystemEvent:Fire(
			roundSystemEventActions.start,
			_readyPlayers
		)
	else
		_readyPlayers = {}
	end
end

local function waitingFinish()
	repeat task.wait(3) until not RoundSystemVariables.IsRunning.Value
end

local function finish()
	-- notif what players win
	notificationManagerEvent:Fire(
		notificationManagerEventActions.finish
	)
	
	rewardSystemEvent:Fire(
		rewardSystemEventActions.giveReward,
		_readyPlayers
	)
	
	task.wait(3)
	
	_readyPlayers = {}
end

local function gameLoop()
	while task.wait(1) do
		intermission()
		prepare()
		start()
		waitingFinish()
		finish()
	end
end

local function initialize()
	coroutine.wrap(gameLoop)()
end

return { initialize = initialize }