
local function iteratePlayers(playerList: { Player }, callback: (player: Player, callbackData: any?) -> ())
	--[[
		а что если сделать ключ player и колбек для него
		someList: { [Player]: (player: Player) -> () }
	]]
	for _, player in playerList do
		callback(player)
	end
end

return iteratePlayers