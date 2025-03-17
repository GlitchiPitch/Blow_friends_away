local RewardSystem = script.Parent
local event = RewardSystem.Events.Event
local eventActions = require(event.Actions)

local function giveReward(player: Player, ...: any)
	
end

local function eventConnect(action: string, ...: any)
	local actions = {
		[eventActions.giveReward] = giveReward,
	}
	
	if actions[action] then
		actions[action](...)
	end
end

local function initialize()
	event.Event:Connect(eventConnect)
end

return { initialize = initialize }