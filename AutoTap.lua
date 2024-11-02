-- Initializing services and remotes
local rs = game:GetService("ReplicatedStorage")
local tr = rs:FindFirstChild("TappingRemote")

local tapEvent = tr and tr:FindFirstChild("Tap")
local superTapEvent = tr and tr:FindFirstChild("SuperTap")

getgenv().flags = {
    autoTap = true,
    autoSuperTap = true
}

local tapDelay = 0.01

getgenv().coroutines = getgenv().coroutines or {}

local function tapDaddy(remote, flag, delay)
    return coroutine.create(function()
        while getgenv().flags[flag] do
            remote:FireServer()
            wait(delay)
        end
    end)
end

if tapEvent and tapEvent:IsA("RemoteEvent") and superTapEvent and superTapEvent:IsA("RemoteEvent") then
    getgenv().coroutines.autoTap = coroutine.resume(tapDaddy(tapEvent, "autoTap", tapDelay))
    getgenv().coroutines.autoSuperTap = coroutine.resume(tapDaddy(superTapEvent, "autoSuperTap", tapDelay))
end
