local rs = game:GetService("ReplicatedStorage")
local tr = rs:FindFirstChild("TappingRemote")

local tap = tr and tr:FindFirstChild("Tap")
local superTap = tr and tr:FindFirstChild("SuperTap")

getgenv().flags = {
    autoTap = true,
    autoSuperTap = true
}

getgenv().coroutines = getgenv().coroutines or {}

local function tapDaddy(remote, flag)
    return coroutine.create(function()
        while getgenv().flags[flag] do
            remote:FireServer()
            wait(0.01)
        end
    end)
end

if tap and tap:IsA("RemoteEvent") and superTap and superTap:IsA("RemoteEvent") then
    getgenv().coroutines.autoTap = coroutine.resume(tapDaddy(tap, "autoTap"))
    getgenv().coroutines.autoSuperTap = coroutine.resume(tapDaddy(superTap, "autoSuperTap"))
end
