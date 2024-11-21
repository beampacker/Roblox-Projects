--// Made by Ray. Script contributors are NG, Zro, and convict.
--// Credits to rhky for the football magnets.
--// Pure Documentation for learning, Enjoy.

--// Luraph Macros
if not LPH_OBFUSCATED then
	getfenv().LPH_NO_VIRTUALIZE = function(Function)
		return Function
	end
end

--// Services
local Players = cloneref(game:GetService("Players"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local Teams = cloneref(game:GetService("Teams"))
local TweenService = cloneref(game:GetService("TweenService"))
local Stats = cloneref(game:GetService("Stats"))
local RunService = cloneref(game:GetService("RunService"))

--// Variables
local Executor = identifyexecutor and identifyexecutor() or nil
task.wait()

--// Utilities
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character and Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character and Character:WaitForChild("HumanoidRootPart")

--// UI Initialization
local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
local Window =
    Library:CreateWindow(
    {
	Title = "Ray's Domain",
	SubTitle = "",
	TabWidth = 160,
	Size = UDim2.fromOffset(580, 460),
	Acrylic = false,
	Theme = "Dark",
	MinimizeKey = Enum.KeyCode.LeftControl
}
)

--// Functions
local CalculateDistance = function(PointOne, PointTwo)
	return (PointOne - PointTwo).Magnitude
end

local CalculateUnit = function(PointOne, PointTwo)
	return (PointOne - PointTwo).Unit
end

local TweenObject = function(Object, TargetCFrame)
	local Distance = (Object.Position - TargetCFrame.Position).Magnitude
	local Time = 0.5    
	local Tween =
        TweenService:Create(
        Object,
        TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
        {
		CFrame = TargetCFrame
	}
    )
	Tween:Play()
	Tween.Completed:Wait()
end

local IsQB = function()
	if Character:FindFirstChild("Football") then
		return Character:FindFirstChild("Football")
	end
end

local AutoCatch = function()
	Remote:fireServer("PlayerActions", "catch")
end

local GetOppositeTeam = function()
	if #Teams:GetChildren() < 2 then
		return LocalPlayer.Team
	else
		return Teams:GetChildren()[1] == LocalPlayer.Team and Teams:GetChildren()[2] or Teams:GetChildren()[1]
	end
end

local GetClientEndZone = function()
	if LocalPlayer.Team == ReplicatedStorage:FindFirstChild("Remotes").Home.Value then
		return workspace:FindFirstChild("LineGoal1")
	elseif LocalPlayer.Team ~= ReplicatedStorage:FindFirstChild("Remotes").Home.Value then
		return workspace:FindFirstChild("LineGoal2")
	end
end

local GetPing = function()
	return Stats.PerformanceStats.Ping:GetValue()
end

local FireTouchInterest = function(Part, Transmitter, Toggle, CatchPart)
    Value = Value == 0

    local MinimumTeleportations = 10
    local MaxTeleportations = 30

    local Calculation = math.random(MinimumTeleportations, MaxTeleportations)

    for Index = 1, #Calculation do
        local Tween = TweenService:Create(CatchPart, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = CatchPart.CFrame})
        Tween:Play()
        Tween.Completed:Wait()
    end 
end

local GetClosestPlayer = function()
	local Closest = nil
	local ClosestDistance = 10e9
	for Index, Value in next, Players.GetPlayers(Players) do
		if Value ~= LocalPlayer then
			if Value.Team ~= LocalPlayer.Team then
				if Value and workspace[Value.Name]:FindFirstChild("HumanoidRootPart") then
					local DistanceTwo =
                        (HumanoidRootPart.Position - workspace[Value.Name].HumanoidRootPart.Position).Magnitude
					if DistanceTwo < ClosestDistance then
						ClosestDistance = DistanceTwo
						ClosestDistance = workspace[Value.Name]
					end
				end
			end
		end
	end
	return Closest
end

--> Toggles
local Options = Library.Options

--// Utilities
local RayDomain = {
	Catching = {
		FootballMagnets = {
			Enabled = false,
			MagnetType = "Regular",
			MagnetsPower = 10,
			ShowMagnetHitbox = false
		}
	},
	Visuals = {
		Visualizations = {
			VisualizeBallPath = {
				Enabled = false
			},
			VisualizeBallTrajectory = {
				Enabled = false
			},
			VisualizeBestJumpSpot = {
				Enabled = false
			},
			RemoveBallTrail = {
				Enabled = false
			},
			CatchEffects = {
				Enabled = false
			},
			SelectCatchEffects = {
				CatchType = ""
			}
		}
	},
	Defense = {
		TackleAimbot = {
			Enabled = false,
			Distance = 5
		}
	},
	Physics = {
		QuickTeleport = {
			Enabled = false
		},
		AntiBlock = {
			Enabled = false
		},
		AntiJam = {
			Enabled = false
		},
		BigHead = {
			Enabled = false,
			Size = 0,
			Transparency = 0
		}
	},
	Automatics = {
		AutoGuard = {
			Enabled = false
		},
		AutoGetUp = {
			Enabled = false,
			Delay = 0.5
		},
		AutoRush = {
			Enabled = false,
			Delay = 1
		},
		AutoQB = {
			Enabled = false,
			Method = "Teleport"
		}
	},
	Player = {
		Jersey = {
			SetJerseyName = {
				Value = ""
			},
			SetJerseyNumber = {
				Value = ""
			}
		}
	}
}

--// Options
local Options = Library.Options

--// Notification Alert
Library:Notify(
    {
	Title = "Ray Domain",
	Content = "By Ray and NG",
	Duration = 5
}
)

--// Tabs
local Catching = Window:AddTab({
	Title = "Catching",
	Icon = ""
})
local Visuals = Window:AddTab({
	Title = "Visuals",
	Icon = ""
})
local Throwing = Window:AddTab({
    Title = "Throwing",
    Icon = ""
})
local Defense = Window:AddTab({
	Title = "Defense",
	Icon = ""
})
local Physics = Window:AddTab({
	Title = "Physics",
	Icon = ""
})
local Automatics = Window:AddTab({
	Title = "Automatics",
	Icon = ""
})
local Player = Window:AddTab({
	Title = "Player",
	Icon = ""
})

--// Tab Initialization
do
    --// Toggles

    --// Catching
	local Magnets = Catching:AddToggle("Magnets", {
		Title = "Enable Magnets",
		Default = false
	})
	local ShowMagnetHitbox = Catching:AddToggle("Hitbox", {
		Title = "Show Magnet Hitbox",
		Default = false
	})

    --// Visuals
	local VisualizeBallPath = Visuals:AddToggle("BallPath", {
		Title = "Visualize Ball Path",
		Default = false
	})
	local VisualizeBallTrajectory = Visuals:AddToggle("BallTrajectory", {
		Title = "Visualize Ball Trajectory",
		Default = false
	})
	local RemoveBallTrail = Visuals:AddToggle("RemoveBallTrail", {
		Title = "Remove Ball Trail",
		Default = false
	})
	local ShowCatchEffects = Visuals:AddToggle("ShowCatchEffects", {
		Title = "Show Catch Effects",
		Default = false
	})

    --// Defense
	local TackleAimbot = Defense:AddToggle("Tackle", {
		Title = "Click Tackle Aimbot",
		Default = false
	})

    --// Physics
	local QuickTP = Physics:AddToggle("QuickTP", {
		Title = "Enable Quick TP",
		Default = false
	})
	local AntiBlock = Physics:AddToggle("AntiBlock", {
		Title = "Anti Block",
		Default = false
	})
	local AntiJam = Physics:AddToggle("AntiJam", {
		Title = "Anti Jam",
		Default = false
	})
	local BigHead = Physics:AddToggle("BigHead", {
		Title = "Enable Big Head",
		Default = false
	})

    --// Automatics
	local AutoGuard = Automatics:AddToggle("AutoGuard", {
		Title = "Auto Guard",
		Default = false
	})
	local AutoGetUp = Automatics:AddToggle("AutoGetUp", {
		Title = "Auto Get Up Fast",
		Default = false
	})
	local AutoRush = Automatics:AddToggle("AutoRush", {
		Title = "Auto Guard",
		Default = false
	})
	local AutoQB = Automatics:AddToggle("AutoQB", {
		Title = "Auto QB",
		Default = false
	})

    --// Callbacks
	Magnets:OnChanged(
        function()
		RayDomain.Catching.FootballMagnets.Enabled = Options.Magnets.Value
	end
    )
	ShowMagnetHitbox:OnChanged(
        function()
		RayDomain.Catching.FootballMagnets.ShowMagnetHitbox = Options.Hitbox.Value
	end
    )
	VisualizeBallPath:OnChanged(
        function()
		RayDomain.Visuals.Visualizations.VisualizeBallPath.Enabled = Options.BallPath.Value
	end
    )
	VisualizeBallTrajectory:OnChanged(
        function()
		RayDomain.Visuals.Visualizations.VisualizeBallTrajectory.Enabled = Options.BallTrajectory.Value
	end
    )
	RemoveBallTrail:OnChanged(
        function()
		RayDomain.Visuals.Visualizations.RemoveBallTrail.Enabled = Options.RemoveBallTrail.Value
	end
    )
	ShowCatchEffects:OnChanged(
        function()
		RayDomain.Visuals.Visualizations.SelectCatchEffects.Enabled = Options.ShowCatchEffects.Value
	end
    )
	TackleAimbot:OnChanged(
        function()
		RayDomain.Defense.TackleAimbot.Enabled = Options.Tackle.Value
	end
    )
	QuickTP:OnChanged(
        function()
		RayDomain.Physics.QuickTeleport.Enabled = Options.QuickTP.Value
	end
    )
	AntiBlock:OnChanged(
        function()
		RayDomain.Physics.AntiBlock.Enabled = Options.AntiBlock.Value
	end
    )
	AntiJam:OnChanged(
        function()
		RayDomain.Physics.AntiJam.Enabled = Options.AntiJam.Value
	end
    )
	BigHead:OnChanged(
        function()
		RayDomain.Physics.BigHead.Enabled = Options.BigHead.Value
	end
    )
	AutoGuard:OnChanged(
        function()
		RayDomain.Automatics.AutoGuard.Enabled = Options.AutoGuard.Value
	end
    )
	AutoGetUp:OnChanged(
        function()
		RayDomain.Automatics.AutoGetUp.Enabled = Options.AutoGetUp.Value
	end
    )
	AutoRush:OnChanged(
        function()
		RayDomain.Automatics.AutoRush.Enabled = Options.AutoRush.Value
	end
    )
	AutoQB:OnChanged(
        function()
		RayDomain.Automatics.AutoQB.Enabled = Options.AutoQB.Value
	end
    )

    --// Sliders
	local MagnetsPower =
        Catching:AddSlider(
        "MagnetsPower",
        {
		Title = "Magnets Power",
		Description = "Set power level for magnets",
		Default = 10,
		Min = 0,
		Max = 100,
		Rounding = 1,
		Callback = function(Value)
			RayDomain.Catching.FootballMagnets.MagnetsPower = Value
		end
	}
    )
	local MagnetType =
        Catching:AddDropdown(
        "MagnetType",
        {
		Title = "Magnet Type",
		Values = {
			"Regular",
			"League",
			"Blatant"
		},
		Default = "Regular",
		Callback = function(Value)
			RayDomain.Catching.FootballMagnets.MagnetType = Value
		end
	}
    )
	local BigHeadSize =
        Physics:AddSlider(
        "BigHeadSize",
        {
		Title = "Big Head Size",
		Default = 2,
		Min = 0,
		Max = 6,
		Rounding = 1,
		Callback = function(Value)
			RayDomain.Physics.BigHead.Size = Value
		end
	}
    )
	local BigHeadTransparency =
        Physics:AddSlider(
        "BigHeadTransparency",
        {
		Title = "Big Head Transparency",
		Default = 0.5,
		Min = 0,
		Max = 1,
		Rounding = 2,
		Callback = function(Value)
			RayDomain.Physics.BigHead.Transparency = Value
		end
	}
    )
	local AutoGetUpDelay =
        Automatics:AddSlider(
        "AutoGetUpDelay",
        {
		Title = "Auto Get Up Delay",
		Default = 0.5,
		Min = 0,
		Max = 1.5,
		Rounding = 1,
		Callback = function(Value)
			RayDomain.Automatics.AutoGetUp.Delay = Value
		end
	}
    )
	local AutoRushDelay =
        Automatics:AddSlider(
        "AutoRushDelay",
        {
		Title = "Auto Rush Delay",
		Default = 1,
		Min = 0,
		Max = 2,
		Rounding = 1,
		Callback = function(Value)
			RayDomain.Automatics.AutoRush.Delay = Value
		end
	}
    )

    --// Inputs
	local JerseyNameInput =
        Player:AddInput(
        "JerseyNameInput",
        {
		Title = "Set Jersey Name",
		Default = "",
		Placeholder = "Enter Jersey Name",
		Numeric = false,
		Finished = true,
		Callback = function(Value)
			RayDomain.Player.SetJerseyName.Value = Value
		end
	}
    )
	local JerseyNumberInput =
        Player:AddInput(
        "JerseyNumberInput",
        {
		Title = "Set Jersey Number",
		Default = "",
		Placeholder = "Enter Jersey Number",
		Numeric = true,
		Finished = true,
		Callback = function(Value)
			RayDomain.Player.SetJerseyNumber.Value = Value
		end
	}
    )

    --// Dropdowns
	local AutoQBMethod =
        Automatics:AddDropdown(
        "AutoQBMethod",
        {
		Title = "Auto QB Method",
		Values = {
			"Teleport",
			"Walk"
		},
		Default = "Teleport",
		Callback = function(Value)
			RayDomain.Automatics.AutoQB.Method = Value
		end
	}
    )
end

--// Football Magnets
task.spawn(
    function()
	while task.wait(0.35) do
		local CatchRight = Character:WaitForChild("CatchRight")

		if RayDomain.Catching.FootballMagnets.Enabled then
			for _, Child in next, workspace:GetChildren() do
				if Child.Name == "Football" and Child:IsA("BasePart") then
					local Distance = (HumanoidRootPart.Position - Child.Position).Magnitude
					local MagnetSettings = RayDomain.Catching.FootballMagnets

					if Distance <= tonumber(MagnetSettings.MagnetsPower) then
						FireTouchInterest(CatchRight, Child, 1, CatchRight)
						FireTouchInterest(CatchRight, Child, 1, CatchRight)
						task.wait()
						FireTouchInterest(CatchRight, Child, 0, CatchRight)
						FireTouchInterest(CatchRight, Child, 0, CatchRight)
					end
				end
			end
		end
	end
end
)

--// Anti Block
Character.DescendantAdded:Connect(
    function(Descendant)
	if RayDomain.Physics.AntiBlock.Enabled and string.match(Descendant.Name, "FFmover") then
		Descendant:Destroy()
	end
end
)

--// Anti Jam
task.spawn(
    function()
	while task.wait() do
		for _, Player in next, Players:GetPlayers() do
			if Player ~= LocalPlayer then
				if Player.Character then
					local Character = Player.Character
					for _, Child in next, Character:GetChildren() do
						if Child:IsA("Part") then
							if RayDomain.Physics.AntiJam.Enabled then
								Child.CanCollide = false
                            elseif not RayDomain.Physics.AntiJam.Enabled then
                                Child.CanCollide = true
							end
						end
					end
				end
			end
		end
	end
end)

--// Saving
local SizeX, SizeY, SizeZ
local OriginalTransparency

--// Big Head
task.spawn(function()
	while task.wait() do
		for _, Player in next, Players:GetPlayers() do
			if Player ~= LocalPlayer then
				local Character = Player.Character

				if Character then
					local Head = Character.Head

					if Head then
						if RayDomain.Physics.BigHead.Enabled then
							SizeX = Head.Size.X
							SizeY = Head.Size.Y
							SizeZ = Head.Size.Z
							OriginalTransparency = Head.Transparency
							Head.Size = Vector3.new(RayDomain.Physics.BigHead.Size, RayDomain.Physics.BigHead.Size, RayDomain.Physics.BigHead.Size)
							Head.Transparency = RayDomain.Physics.BigHead.Transparency
						elseif not RayDomain.Physics.BigHead.Enabled then
							Head.Size = Vector3.new(SizeX, SizeY, SizeZ)
							Head.Transparency = 0
						end
					end 
				end 
			end
		end
	end
end)
