-- IN DEVELPOMENT THIS IS NOT THE FULL SCRIPT, IM STILL IN THE WORKS TO DISABLE THE ANTICHEAT. in oother words silent aim, manipulation, wallbang, fly,speed,spider, zoom, anti aim, aimbot(with bones), esp, gun spawner, player kicker, teleport, etc coming after i finish off the AC

-- so i can view remote spy and dex
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

pcall(function()
    RunService:SetRobloxGuiFocused(false)
    GuiService:ClearError()
end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        RunService:SetRobloxGuiFocused(false)
        GuiService:ClearError()
    end)
end)

-- to trigger the ac

local blockedRemoteName = "EnteredRadiationZone"
local hasFired = false

local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()

    if method == "FireServer" and self.Name == blockedRemoteName then
        if hasFired then
            return nil
        else
            hasFired = true
        end
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)


