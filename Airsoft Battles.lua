--// Made by 5pect and rhky on discord
--// Will not work for solara

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local UserInputService = game:GetService("UserInputService");

local LocalPlayer = Players.LocalPlayer;
local Camera = Workspace.CurrentCamera;

local Modules = {}; do
    Modules.Shoot = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Projectile"):FindFirstChild("ShootModule"));
end;
local Closest;

local GetClosestPlayer = function(Radius)
    local ClosestDistance = Radius or math.huge;
    local Player = nil;

    for Index, Value in Players:GetPlayers() do
        if not (Value == LocalPlayer) then
            local Character = Value.Character;
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then continue; end;
            if Value:GetAttribute("Team") == LocalPlayer:GetAttribute("Team") then continue; end; -- stupid team check but thats what the game uses 

            local Position, Visible = Camera:WorldToViewportPoint(HumanoidRootPart.Position);
            local Distance = (Vector2.new(Position.X, Position.Y) - UserInputService:GetMouseLocation()).Magnitude;

            if not Visible then continue end;

            if Distance < ClosestDistance then
                ClosestDistance = Distance;
                Player = Value;
            end;
        end;
    end;

    return Player;
end;

RunService.Heartbeat:Connect(function()
    Closest = GetClosestPlayer();
end);

local Old; Old = hookfunction(Modules.Shoot.fire, function(Arguement1, Origin, Direction, ...)
    if (Closest) then
        local BonePosition = Closest.Character.Head.Position;
        Origin = BonePosition + Vector3.new(0, 0.05, 0); -- fake wallkbang
        Direction = CFrame.new(Origin, BonePosition).LookVector.Unit * (BonePosition - Origin).Magnitude;
    end;
    
    return Old(Arguement1, Origin, Direction, ...)
end);
