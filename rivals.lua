-- Loading external modules
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Exunys-ESP/main/src/ESP.lua"))()
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
print("UI and External Modules Loaded")

-- Create Rayfield window
local Window = Rayfield:CreateWindow({
    Name = "My Script",
    LoadingTitle = "Loading Interface",
    LoadingSubtitle = "Powered by Rayfield",
})

-- Tabs
local AimTab = Window:CreateTab("Aim", nil)
local VisualsTab = Window:CreateTab("Visuals", nil)
local MiscTab = Window:CreateTab("Misc", nil)

-- Global services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Fly Variables
local flying, flySpeed, maxFlySpeed, speedIncrement, originalGravity = false, 100, 1000, 0.4, workspace.Gravity
local Character, HumanoidRootPart, Humanoid = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait(), nil, nil

-- Silent Aim Variables
local function getPlayersInRange(fov)
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

local function getClosestPlayer(fov)
    local closest, minDist = nil, math.huge
    local character = Players.LocalPlayer.Character
    if not character then return end
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in ipairs(getPlayersInRange(fov)) do
        if player == Players.LocalPlayer then continue end
        if player:FindFirstChild("HumanoidRootPart") then
            local pos = Camera:WorldToViewportPoint(player.HumanoidRootPart.Position)
            local dist = (center - Vector2.new(pos.X, pos.Y)).Magnitude
            if dist < minDist and dist < fov then
                closest, minDist = player, dist
            end
        end
    end
    return closest
end

local function toggleSilentAim(enabled)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local utility = require(ReplicatedStorage.Modules.Utility)
    local oldRaycast = utility.Raycast

    if enabled then
        utility.Raycast = function(...)
            local args = {...}
            if args[4] == 999 then
                local closestPlayer = getClosestPlayer(200)
                if closestPlayer then
                    args[3] = closestPlayer.Head.Position
                end
            end
            return oldRaycast(table.unpack(args))
        end
    else
        utility.Raycast = oldRaycast
    end
end

-- Fly Function
local function fly()
    while flying do
        local MoveDirection = Vector3.new()
        local cameraCFrame = Camera.CFrame

        MoveDirection = MoveDirection + (UserInputService:IsKeyDown(Enum.KeyCode.W) and cameraCFrame.LookVector or Vector3.new())
        MoveDirection = MoveDirection - (UserInputService:IsKeyDown(Enum.KeyCode.S) and cameraCFrame.LookVector or Vector3.new())
        MoveDirection = MoveDirection - (UserInputService:IsKeyDown(Enum.KeyCode.A) and cameraCFrame.RightVector or Vector3.new())
        MoveDirection = MoveDirection + (UserInputService:IsKeyDown(Enum.KeyCode.D) and cameraCFrame.RightVector or Vector3.new())
        MoveDirection = MoveDirection + (UserInputService:IsKeyDown(Enum.KeyCode.Space) and Vector3.new(0, 1, 0) or Vector3.new())
        MoveDirection = MoveDirection - (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and Vector3.new(0, 1, 0) or Vector3.new())

        if MoveDirection.Magnitude > 0 then
            flySpeed = math.min(flySpeed + speedIncrement, maxFlySpeed)
            MoveDirection = MoveDirection.Unit * math.min(flySpeed, maxFlySpeed)
            HumanoidRootPart.Velocity = MoveDirection * 0.5
        else
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        end

        RunService.RenderStepped:Wait()
    end
end

-- Fly Button in Misc Tab
MiscTab:CreateButton({
    Name = "Fly",
    Callback = function()
        flying = not flying
        print("Flying: " .. tostring(flying))
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

-- ESP Button in Visuals Tab
VisualsTab:CreateButton({
    Name = "Enable ESP",
    Callback = function()
        local success, message = pcall(function()
            ESPLibrary.Load()
        end)
        if success then
            print("ESP loaded successfully.")
        else
            warn("Failed to load ESP: " .. message)
        end
    end,
})

-- Silent Aim Toggle in Aim Tab
AimTab:CreateToggle({
    Name = "Silent Aim",
    Default = false,
    Callback = function(state)
        toggleSilentAim(state)
        print("Silent Aim: " .. tostring(state))
    end,
})

-- Gun Modifications
local function modifyGunProperties()
    local clientItemModule = require(LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem)
    local inputFunc = clientItemModule.Input
    local originalValues = {}

    -- Hook input function
    local oldInputFunc
    oldInputFunc = hookfunction(inputFunc, function(...)
        local args = {...}
        if not originalValues.Recoil then
            originalValues.Recoil = args[1].Info.ShootRecoil
            originalValues.Spread = args[1].Info.ShootSpread
            originalValues.Cooldown = args[1].Info.ShootCooldown
            originalValues.QuickShotCooldown = args[1].Info.QuickShotCooldown
            originalValues.ProjectileSpeed = args[1].Info.ProjectileSpeed
            print("Original gun settings saved.")
        end

        -- Modify gun properties
        local info = args[1].Info
        if info then
            info.ShootRecoil = 0
            info.ShootSpread = 0
            info.ShootCooldown = 0
            info.QuickShotCooldown = 0
            info.ProjectileSpeed = math.huge
            print("Gun properties modified.")
        end

        return oldInputFunc(...)
    end)
end

-- Gun Modifications Button in Misc Tab
MiscTab:CreateButton({
    Name = "Enable Gun Modifications",
    Callback = function()
        modifyGunProperties()
    end,
})

-- Update character and humanoid root part on character respawn
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = newCharacter:WaitForChild("Humanoid")
    HumanoidRootPart = newCharacter:WaitForChild("HumanoidRootPart")
end)

print("Main Script Initialized and Tabs Created")
