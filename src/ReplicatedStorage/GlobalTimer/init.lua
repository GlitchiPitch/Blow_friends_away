local RunService = game:GetService("RunService")
--[[
    taskDataForServer taskName = `{player.UserId} .. {taskName}`
]]

local event = script.Events.Event
local eventActions = require(event.Actions)

local _globalTasks: {} = {}
local _connections: { RBXScriptConnection } = {}

local function addTask(taskName: string, taskData: {})
    if not _globalTasks[taskName] then
        _globalTasks[taskName] = taskData
    end
end

local function removeTask(taskName: string)
    if _globalTasks[taskName] then
        _globalTasks[taskName] = nil
    end
end

local function onRun(deltaTime: number)
    for taskName, taskData in _globalTasks do
        
    end
end

local function eventConnect(action: string, ...: any)
    local actions = {
        [eventActions.addTask] = addTask,
        [eventActions.removeTask] = removeTask,
    }
    
    if actions[action] then
        actions[action](...)
    end
end

local function initialize()

    local runSingal = RunService:IsServer() and RunService.Heartbeat or RunService.RenderStepped

    table.insert(_connections, runSingal:Connect(onRun))
    table.insert(_connections, event.Event:Connect(eventConnect))

    if RunService:IsServer() then
        local function onGameClose()
            for _, _connect in _connections do
                _connect:Disconnect()
            end

            for taskName, _ in _globalTasks do
                _globalTasks[taskName] = nil
            end
        end

        game:BindToClose(onGameClose)
    end
end

return { initialize = initialize }