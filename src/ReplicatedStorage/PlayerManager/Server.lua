local Players = game:GetService("Players")

local function onCharacterAdded(character: Model)
	character:FindFirstChild('Humanoid').Died:Connect(function()
		lb:FindFirstChildOfClass('IntValue').Value += 1
	end)
end

local function onPlayerAdded(player: Player) 
	local lb = script.leaderstats:Clone()
	lb.Parent = player
	player.CharacterAdded:Connect(onCharacterAdded)
end

local function initialize()
	Players.PlayerAdded:Connect(onPlayerAdded)
--local baseplate = workspace.base
--local hats = game.ServerStorage.Hats:GetChildren()
end

return { initialize = initialize }
