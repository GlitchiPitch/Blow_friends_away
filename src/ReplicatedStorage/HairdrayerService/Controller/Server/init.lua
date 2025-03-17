local HairdrayerController = script.Parent

local function getOffset() : Vector3
	return Vector3.new(
		((math.random() - 0.5) * 50),
		((math.random() - 0.5) * 50),
		((math.random() - 0.5) * 50)
	)
end

local function createBubbles()
	local Mass = (Air:GetMass() * Gravity)

	local BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.maxForce = Vector3.new(Mass, Mass, Mass)
	BodyVelocity.velocity = (Direction * Force)
	BodyVelocity.Parent = Air
end

local _HairdrayerContoller = {}
_HairdrayerContoller.__index = _HairdrayerContoller

export type HairdrayerControllerType = {
	force: number,
	bubblePrefab: BasePart,
	Activate: () -> (),
}
_HairdrayerContoller.New = function(tool: Tool & { Handle: Part }) : HairdrayerControllerType
	local self = {
		force = 80,
		bubblePrefab = nil,
	}
	return setmetatable(self, _HairdrayerContoller)
end

_HairdrayerContoller.Activate = function(self)
	
end

return _HairdrayerContoller