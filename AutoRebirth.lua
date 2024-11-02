local rs = game:GetService("ReplicatedStorage")
local lp = game.Players.LocalPlayer
local stats = lp:WaitForChild("leaderstats")

local tgModule = require(rs:WaitForChild("TappingGameModule"))
local rebirths = tgModule.Rebirths

local rebirthEvent = rs:WaitForChild("Rebirth")


local rebirthWaitTime = 10
local minimumRebirthMulti = 1

getgenv().flags.autoRebirth = true
getgenv().coroutines = getgenv().coroutines or {}


local function canRebirth(amount)
    local mainCurrencyValue = stats[tgModule.MainCurrency].Value
    local price = rebirths.GetPrice(amount, stats[tgModule.RebirthCurrency].Value)
    return mainCurrencyValue >= price and true or false
end

local function autoRebirth(waitTime, minRebirthMulti)
    while getgenv().flags.autoRebirth do
        local bestRebirth = nil

        for _, amount in ipairs(rebirths.Buttons) do
            bestRebirth = (canRebirth(amount) and (not minRebirthMulti or amount >= minRebirthMulti)) 
                          and amount or bestRebirth
        end

        bestRebirth and rebirthEvent:FireServer(bestRebirth)

        wait(waitTime or 0)
    end
end

getgenv().coroutines.autoRebirth = coroutine.create(function()
    autoRebirth(rebirthWaitTime, minimumRebirthMulti)
end)


coroutine.resume(getgenv().coroutines.autoRebirth)
