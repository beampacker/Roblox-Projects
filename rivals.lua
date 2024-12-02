-- Load Exunys ESP module
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Exunys-ESP/main/src/ESP.lua"))()
-- ESPLibrary and getgenv().ExunysDeveloperESP is equivalent.

-- Load UI Library
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local Window = Rayfield:CreateWindow({
    Name = "My Script",
    LoadingTitle = "Loading Interface",
    LoadingSubtitle = "Powered by Rayfield",
})

print("UI Library Loaded")

-- Aim Tab
local AimTab = Window:CreateTab("Aim", nil)
print("Aim Tab Created")

-- Silent Aim Toggle Functionality
local function toggleSilentAim(state)
    print("Toggling Silent Aim: " .. tostring(state))
    local replicated_storage = game:GetService("ReplicatedStorage")
    local players = game:GetService("Players")
    local camera = workspace.CurrentCamera
    local utility = require(replicated_storage.Modules.Utility)

    local get_players = function()
        local entities = {}
        for _, child in workspace:GetChildren() do
            if child:FindFirstChildOfClass("Humanoid") then
                table.insert(entities, child)
            elseif child.Name == "HurtEffect" then
                for _, hurt_player in child:GetChildren() do
                    if hurt_player.ClassName ~= "Highlight" then
                        table.insert(entities, hurt_player)
                    end
                end
            end
        end
        return entities
    end

    local get_closest_player = function(fov)
        local closest, closest_distance = nil, math.huge
        local character = players.LocalPlayer.Character

        if not character then
            print("No character found for local player.")
            return
        end

        for _, player in get_players() do
            if player == players.LocalPlayer then continue end
            if not player:FindFirstChild("HumanoidRootPart") then continue end

            local position, on_screen = camera:WorldToViewportPoint(player.HumanoidRootPart.Position)
            if not on_screen then continue end

            local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
            local distance = (center - Vector2.new(position.X, position.Y)).Magnitude

            if distance < fov then
                if distance < closest_distance then
                    closest = player
                    closest_distance = distance
                end
            end
        end
        return closest
    end

    local old = utility.Raycast
    if state then
        print("Silent Aim Enabled.")
        utility.Raycast = function(...)
            local arguments = {...}
            if #arguments > 0 and arguments[4] == 999 then
                local closest = get_closest_player(200)  -- Max FOV 200
                if closest then
                    arguments[3] = closest.Head.Position
                end
            end
            return old(table.unpack(arguments))
        end
    else
        print("Silent Aim Disabled.")
        utility.Raycast = old  -- Revert to original function when toggled off
    end
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 100
local maxFlySpeed = 1000
local speedIncrement = 0.4
local originalGravity = workspace.Gravity

LocalPlayer.CharacterAdded:Connect(function(newCharacter) 
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end)

local function randomizeValue(value, range)
    return value + (value * (math.random(-range, range) / 100))
end

local function fly()
    while flying do
        local MoveDirection = Vector3.new()
        local cameraCFrame = workspace.CurrentCamera.CFrame

        MoveDirection = MoveDirection + (UserInputService:IsKeyDown(Enum.KeyCode.W) and cameraCFrame.LookVector or Vector3.new())
        MoveDirection = MoveDirection - (UserInputService:IsKeyDown(Enum.KeyCode.S) and cameraCFrame.LookVector or Vector3.new())
        MoveDirection = MoveDirection - (UserInputService:IsKeyDown(Enum.KeyCode.A) and cameraCFrame.RightVector or Vector3.new())
        MoveDirection = MoveDirection + (UserInputService:IsKeyDown(Enum.KeyCode.D) and cameraCFrame.RightVector or Vector3.new())
        MoveDirection = MoveDirection + (UserInputService:IsKeyDown(Enum.KeyCode.Space) and Vector3.new(0, 1, 0) or Vector3.new())
        MoveDirection = MoveDirection - (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and Vector3.new(0, 1, 0) or Vector3.new())

        if MoveDirection.Magnitude > 0 then
            flySpeed = math.min(flySpeed + speedIncrement, maxFlySpeed) 
            MoveDirection = MoveDirection.Unit * math.min(randomizeValue(flySpeed, 10), maxFlySpeed)
            HumanoidRootPart.Velocity = MoveDirection * 0.5
        else
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        end

        RunService.RenderStepped:Wait()
    end
end

-- Misc Tab (Moved Gun Modifications to Misc Tab)
local MiscTab = Window:CreateTab("Misc", nil)

-- Gun Modifications Functionality
local function GunModifications()
    print("Initializing Gun Modifications")
    local clientItemModule = require(game:GetService("Players").LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem)
    local inputFunc = clientItemModule.Input

    -- Store original values to revert back to them when needed
    local originalValues = {
        Recoil = nil,
        Spread = nil,
        Cooldown = nil,
        QuickShotCooldown = nil,
        ProjectileSpeed = nil
    }

    local modifications = {
        RemoveRecoil = false,
        RemoveSpread = false,
        RemoveCooldown = false,
        QuickShoot = false,
        EnableProjectileSpeed = false,
        ProjectileSpeedValue = math.huge, -- Default to maximum speed
    }

    -- Hook function to modify the input function
    local oldInputFunc
    oldInputFunc = hookfunction(inputFunc, function(...)

        local args = {...}

        -- Store original values in the first run
        if not originalValues.Recoil then
            originalValues.Recoil = args[1].Info.ShootRecoil
            originalValues.Spread = args[1].Info.ShootSpread
            originalValues.Cooldown = args[1].Info.ShootCooldown
            originalValues.QuickShotCooldown = args[1].Info.QuickShotCooldown
            originalValues.ProjectileSpeed = args[1].Info.ProjectileSpeed
            print("Original gun settings stored.")
        end

        -- Set all values to nil, and only modify what's necessary
        if type(args[1]) == "table" then
            local info = args[1].Info
            args[1].Info.ShootRecoil = nil
            args[1].Info.ShootSpread = nil
            args[1].Info.ProjectileSpeed = nil
            args[1].Info.ShootCooldown = nil
            args[1].Info.QuickShotCooldown = nil

            -- Apply modifications
            if modifications.RemoveRecoil then
                info.ShootRecoil = 0
                print("Recoil removed.")
            else
                info.ShootRecoil = originalValues.Recoil
            end

            if modifications.RemoveSpread then
                info.ShootSpread = 0
                print("Spread removed.")
            else
                info.ShootSpread = originalValues.Spread
            end

            if modifications.RemoveCooldown then
                info.ShootCooldown = 0
                print("Cooldown removed.")
            else
                info.ShootCooldown = originalValues.Cooldown
            end

            if modifications.QuickShoot then
                info.QuickShotCooldown = 0
                print("Quick Shoot enabled.")
            else
                info.QuickShotCooldown = originalValues.QuickShotCooldown
            end

            if modifications.EnableProjectileSpeed then
                info.ProjectileSpeed = math.huge  -- Set to maximum speed
                print("Projectile Speed enabled.")
            else
                info.ProjectileSpeed = nil  -- Revert to original value (nil = original speed)
            end
        end
        return oldInputFunc(...)
    end)

    return modifications
end

local gunMods = GunModifications()

-- Gun Modifications Toggles in Misc Tab
MiscTab:CreateButton({
    Name = "Remove Recoil",
    CurrentValue = false,
    Callback = function(state)
        print("Remove Recoil toggled: " .. tostring(state))
        gunMods.RemoveRecoil = state
    end,
})

MiscTab:CreateButton({
    Name = "Fly",
    Callback = function()
        flying = not flying
        print("Fly Button Clicked. Flying: " .. tostring(flying))

        if flying then
            workspace.Gravity = 0
            fly()
        else
            flySpeed = 100
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            workspace.Gravity = originalGravity
        end
    end,
})

MiscTab:CreateButton({
    Name = "Remove Spread",
    CurrentValue = false,
    Callback = function(state)
        print("Remove Spread toggled: " .. tostring(state))
        gunMods.RemoveSpread = state
    end,
})

MiscTab:CreateButton({
    Name = "Remove Cooldown",
    CurrentValue = false,
    Callback = function(state)
        print("Remove Cooldown toggled: " .. tostring(state))
        gunMods.RemoveCooldown = state
    end,
})

MiscTab:CreateButton({
    Name = "Quick Shoot",
    CurrentValue = false,
    Callback = function(state)
        print("Quick Shoot toggled: " .. tostring(state))
        gunMods.QuickShoot = state
    end,
})

-- Add a button to the Aim tab in your UI to toggle Silent Aim
AimTab:CreateToggle({
    Name = "Silent Aim",
    CurrentValue = false,
    Callback = function(state)
        print("Silent Aim toggled: " .. tostring(state))
        toggleSilentAim(state)
    end,
})

local VisualsTab = Window:CreateTab("Visuals", nil)

-- ESP Button (Now as a Button instead of a Toggle)
VisualsTab:CreateButton({
    Name = "Enable ESP",
    Callback = function()
        print("ESP Button Clicked")

        -- Check if the ESP script is loaded correctly
        local success, message = pcall(function()
            ExunysDeveloperESP.Load()
        end)

        if success then
            print("ESP script loaded successfully.")
        else
            warn("Failed to load ESP script: " .. message)
        end
    end,
})

-- Silent Aim FOV Toggle (Max 400)
VisualsTab:CreateToggle({
    Name = "Enable Silent Aim FOV",
    CurrentValue = false,
    Callback = function(state)
        print("Silent Aim FOV toggled: " .. tostring(state))
        _G.SilentAimEnabled = state
    end,
})

-- Visualize Silent Aim FOV as a circle
local fovCircle
game:GetService("RunService").RenderStepped:Connect(function()
    local camera = workspace.CurrentCamera
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    local fovRadius = _G.SilentAimEnabled and math.min(400, _G.FOVRadius or 400) or 0 -- Max FOV 400 if enabled

    -- Create or update the circle based on visibility
    if _G.SilentAimEnabled then
        if not fovCircle then
            fovCircle = Drawing.new("Circle")
            fovCircle.Position = screenCenter
            fovCircle.Radius = fovRadius
            fovCircle.Thickness = 2
            fovCircle.Color = Color3.fromRGB(255, 0, 0)
            fovCircle.Filled = false
            fovCircle.NumSides = 32
            print("Drawing new FOV circle.")
        end
        fovCircle.Visible = true
    else
        if fovCircle then
            fovCircle.Visible = false
            print("Silent Aim FOV circle hidden.")
        end
    end
end)

-- Unload UI Button in Misc Tab
MiscTab:CreateButton({
    Name = "Reload Rivals",
    Callback = function()
        print("Unloading UI... Disabling features.")
        -- Destroy the UI
        Rayfield:Destroy()
        print("UI Unloaded.")
        
        -- Wait a bit before teleporting to the new place
        task.wait(2)  -- Wait for 2 seconds
        
        -- Teleport to a new PlaceId (replace with your desired PlaceId)
        local placeId = 17625359962  -- Example PlaceId, change as needed
        game:GetService("TeleportService"):Teleport(placeId)
        print("Teleporting to new PlaceId.")
    end,
})
print("Script Loaded Successfully.")
