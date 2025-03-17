local function createBubble() : Part
	local BasePart = Instance.new("Part")
	BasePart.Shape = Enum.PartType.Block
	BasePart.Material = Enum.Material.Plastic
	BasePart.TopSurface = Enum.SurfaceType.Smooth
	BasePart.BottomSurface = Enum.SurfaceType.Smooth
	BasePart.FormFactor = Enum.FormFactor.Custom
	BasePart.Size = Vector3.new(0.2, 0.2, 0.2)
	BasePart.CanCollide = true
	BasePart.Locked = true
	BasePart.Anchored = false

	local AirBubble = BasePart:Clone()
	AirBubble.Name = "Effect"
	AirBubble.Shape = Enum.PartType.Ball
	AirBubble.Size = Vector3.new(2, 2, 2)
	AirBubble.CanCollide = false

	return AirBubble
end

local function createBubbles()
	local bubble = createBubble()
	local Mass = (Air:GetMass() * Gravity)

	local BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.maxForce = Vector3.new(Mass, Mass, Mass)
	BodyVelocity.velocity = (Direction * Force)
	BodyVelocity.Parent = Air
end

return createBubbles