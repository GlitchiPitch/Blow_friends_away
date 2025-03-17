local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local NotificationManager = script.Parent

local event = NotificationManager.Events.Event
local eventActions = require(event.Actions)
local remote = NotificationManager.Events.Remote
local remoteActions = require(remote.Actions)

local iteratePlayers = require(ReplicatedStorage.Utility.iteratePlayers)

local function intermission(timeLeft: number)
	local function _callback(player: Player)
		remote:FireClient(player, remoteActions.intermission, timeLeft)
	end
	
	iteratePlayers(Players:GetPlayers(), _callback)
end

local function eventConnect(action: string, ...: any)
	local actions = {
		[eventActions.intermission] = intermission,
	}
	
	if actions[action] then
		actions[action](...)
	end
end

local function initialize()
	event.Event:Connect(eventConnect)
end

return { initialize = initialize }