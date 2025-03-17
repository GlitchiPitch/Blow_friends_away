local Players = game:GetService("Players")

local function checkAlive(player: Player) : boolean
	
	if player.Parent ~= Players then return false end
	if player.Character then
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		return humanoid:GetState() ~= Enum.HumanoidStateType.Dead
	end
	
	return false
end

return checkAlive