local ReplicatedStorage = game:GetService("ReplicatedStorage")


export type HairdrayerContollerType = {
    _tool: Tool,
    _connections: { RBXScriptConnection },
}

local Controller = script.Parent
local HairdrayerService = Controller.Parent

local _HairdrayerContoller = {}
_HairdrayerContoller.__index = _HairdrayerContoller

_HairdrayerContoller.New = function(tool: Tool) : HairdrayerContollerType
    local self = {
        _tool = tool,
        _connections = {}
    }

    return setmetatable(self, _HairdrayerContoller)
end

_HairdrayerContoller.Initialize = function(self: HairdrayerContollerType)

    local function onEquipped()
        
    end

    local function onUnequipped()
        
    end

    table.insert(
        self._connections,
        self._tool.Equipped:Connect(onEquipped)
    )

    table.insert(
        self._connections,
        self._tool.Unequipped:Connect(onUnequipped)
    )
end

_HairdrayerContoller.Activate = function(self)
    
end

return _HairdrayerContoller