local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Constants = require(ReplicatedStorage.Constants)
local iteratePlayers = require(ReplicatedStorage.Utility.iteratePlayers)

local NotificationManager = ReplicatedStorage.NotificationManager
local notificationManagerEvent = NotificationManager.Events.Event
local notificationManagerEventActions = require(notificationManagerEvent.Actions)

local RoundSystem = script.Parent
local Variables = RoundSystem.Variables

local event = RoundSystem.Events.Event
local eventActions = require(event.Actions)

local _playersInGame: { Player } = {}

local function checkValidPlayers()
	local function _callback(player: Player)
		local _canDelete = false
		if player.Parent ~= Players then
			_canDelete = true
		end
		
		if player.Character then
			local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
			_canDelete = humanoid:GetState() == Enum.HumanoidStateType.Dead
		end
		
		if _canDelete then
			local playerIndex = table.find(_playersInGame, player)
			table.remove(_playersInGame, playerIndex)
		end
	end
	
	iteratePlayers(_playersInGame, _callback)
	
	if #_playersInGame <= Constants.WIN_PLAYER_COUNT then
		Variables.IsRunning.Value = false
	end
end

local function start(_readyPlayers: { Player })
	_playersInGame = _readyPlayers
	Variables.IsRunning.Value = true
	
	for i = Constants.MATCH_TIME, 0, -1 do
		if not Variables.IsRunning.Value then
			break
		end

		notificationManagerEvent:Fire(
			notificationManagerEventActions.roundInProgress,
			i
		)

		task.wait(1)
	end

	notificationManagerEvent:Fire(
		notificationManagerEventActions.roundInProgress,
		nil
	)
	
	Variables.IsRunning.Value = false
	
end

local function eventConnect(action: string, ...: any)
	local actions = {
		[eventActions.start] = start,
	}
	
	if actions[action] then
		actions[action](...)
	end 
end

local function initalize()
	event.Event:Connect(eventConnect)
end

return { initalize = initalize }