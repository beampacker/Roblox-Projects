-- // Configs

local TeamColors = {Team = Color3.fromRGB(0,225,0) , Enemy = Color3.fromRGB(225,0,0)}

-- // UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))();

-- // ESP Library
local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Sirius/request/library/sense/source.lua'))();
Sense.sharedSettings.useTeamColor = true;

-- // UI Library Folders

local Window = Rayfield:CreateWindow({Name = "Strucid",ConfigurationSaving = {Enabled = true,FileName = "DarkHubStrucid"}});
local CombatTab = Window:CreateTab("Combat");
local PlayerTab = Window:CreateTab("Player");
local VisualsTab = Window:CreateTab("Visuals");
local MiscellaneousTab = Window:CreateTab("Miscellaneous");

-- // Declared Services

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");

-- // Private Variables

local LocalPlayer = Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse();

local Modules = ReplicatedStorage:WaitForChild("Modules", 1);
local NetworkModule = Modules:WaitForChild("NetworkModule", 1);

-- // Network Module Bypass

local FakeInstance = Instance.new("ModuleScript", LocalPlayer.PlayerGui);
FakeInstance.Name = "Extra";
FakeInstance:SetAttribute("O", true);

local AntiCheatModule

-- // Functions()

local FireServer = function(string,...)
	if (AntiCheatModule or AntiCheatModule and AntiCheatModule.Parent ~= nil) then
		AntiCheatModule:FireServer(string,...)
	end
end

local InvokeServer = function(string,...)
	if (AntiCheatModule or AntiCheatModule and AntiCheatModule.Parent ~= nil) then
		AntiCheatModule:InvokeServer(string,...)
	end
end

local Notify = function(Title, Desc, Duration) Rayfield:Notify({Title = Title,Content = Desc,Duration = Duration,Image = 4483362458,}) end

function IsFFA()
	if LocalPlayer.PlayerGui:FindFirstChild("GameUI") then
		return LocalPlayer.PlayerGui.GameUI.CoreFrames.RoundStats.Gamemode.Text == " FFA"   
	end
	return false
end

function Sense.isFriendly(player)
	return (not IsFFA() and player.Team == LocalPlayer.Team)
end

function Sense.getCharacter(player)
	if player and player.Character and not player.Character:GetAttribute("IsMenuChar") then
		return player.Character;
	end
end

function Sense.getTeamColor(player)
	if (not IsFFA() and player.Team == LocalPlayer.Team) and game.PlaceId ~= 3606833500 then
		return player and TeamColors.Team
	else
		return player and TeamColors.Enemy
	end
end

function IsAlive(player)
	return player.Character and not player.Character:GetAttribute("IsMenuChar")
end

local getcallingfunction = function(stack)
	return debug.getinfo(stack + 1).func
end

local damagePlayer = function(player: Player)
	task.spawn(function()
		local runAmount = math.round(getupvalue(require(LocalPlayer.PlayerGui.MainGui.NewLocal.Tools.Tool.Gun.Auto).ShootLogic, 1).WSettings.Damage / 20)
		for i = 1,runAmount do 
			if player and player.ClassName == 'Player' then
				InvokeServer('PickaxeDamage', player.Character.HumanoidRootPart)
			elseif player and player[1] and player[1][1] then
				InvokeServer('PickaxeDamage', player[1][1])
			end
		end
	end)
end

function GetKILLPLR()
	for i, v in pairs(game:GetService('Players'):GetPlayers()) do
		if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild('Head') and v.Character:FindFirstChild('Humanoid') and not v.Character:GetAttribute("IsMenuChar") then
			if IsFFA() or game.PlaceId == 3606833500 then
				return v
			else
				if v.Team ~= game.Players.LocalPlayer.Team then
					return v
				end
			end
		end
	end
	return nil
end

function GetTarget() -- Messy but works for both games (could have made this better tbh)
	local Plr = nil
	local SD = math.huge
	for i, v in pairs(game:GetService('Players'):GetPlayers()) do
		if IsFFA() or game.PlaceId == 3606833500 then
			if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild('Head') and v.Character:FindFirstChild('Humanoid') and not v.Character:GetAttribute("IsMenuChar") then
				local pos, onScreen = Workspace.CurrentCamera:WorldToViewportPoint(v.Character:FindFirstChild('UpperTorso').Position)
				local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
				if onScreen and magnitude < SD and magnitude <= Rayfield.Flags['FV_FOVVALUE'].CurrentValue then
					Plr = v
					SD = magnitude
				end
			end
		else
			if v ~= LocalPlayer and v.Team ~= LocalPlayer.Team and v.Character and v.Character:FindFirstChild('Head') and v.Character:FindFirstChild('Humanoid') and not v.Character:GetAttribute("IsMenuChar") then
				local pos, onScreen = Workspace.CurrentCamera:WorldToViewportPoint(v.Character:FindFirstChild('UpperTorso').Position)
				local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
				if onScreen and magnitude < SD and magnitude <= Rayfield.Flags['FV_FOVVALUE'].CurrentValue  then
					Plr = v
					SD = magnitude
				end
			end
		end
	end
	return Plr
end

local function GetRandomHitbone(): string
	local CurrentAimbone = Rayfield.Flags["FF_Aimbone"].CurrentOption
	local possible = {"Head", "LowerTorso"}
	if CurrentAimbone[1] == "Random" then
		return possible[math.random(1,#possible)]
	end
	return CurrentAimbone[1]
end

-- [[ START OF COMBAT TAB ]] -- 

CombatTab:CreateSection("Silent-Aim Config")


local silentAimButton = CombatTab:CreateToggle({
	Name = "Toggle Silent-Aim",
	CurrentValue = false,
	Flag = 'FF_Silent',
	Callback = function()end,
})

CombatTab:CreateSlider({
	Name = "Silent Aim Accuracy",
	Range = {1,100},
	Increment = 1,
	Suffix = "%",
	CurrentValue = 100,
	Flag = 'FF_SAccuracy',
	Callback = function(Value)end,
})


CombatTab:CreateSection("Main Config")

CombatTab:CreateToggle({
	Name = "Toggle DrawFOV",
	CurrentValue = false,
	Flag = 'FF_FOVVIS',
	Callback = function()end,
})

CombatTab:CreateSlider({
	Name = "FOV Size",
	Range = {1,2500},
	Increment = 1,
	Suffix = "Size",
	CurrentValue = 100,
	Flag = 'FV_FOVVALUE',
	Callback = function(Value)end,
})

local hooked = false
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 460
FOVCircle.Filled = false
FOVCircle.Transparency = 0.6
FOVCircle.Radius = 100
FOVCircle.Color = Color3.new(0, 255, 0)

CombatTab:CreateDropdown({
	Name = "Aimbone",
	Options = {"Random","Head","LowerTorso"},
	CurrentOption = {"Random"},
	MultipleOptions = false,
	Flag = "FF_Aimbone",
	Callback = function(Option)end,
})


CombatTab:CreateSection("Rage Config")

CombatTab:CreateToggle({
	Name = "Toggle Kill All",
	CurrentValue = false,
	Flag = 'FF_KillAll',
	Callback = function()end,
})

CombatTab:CreateSection("Weapon Modification")

CombatTab:CreateToggle({
	Name = "Wallbang",
	CurrentValue = false,
	Flag = 'FF_Wallbang',
	Callback = function()end,
})

CombatTab:CreateToggle({
	Name = "FireRate Mod",
	CurrentValue = false,
	Flag = 'FF_FireRate',
	Callback = function()
	end,
})

CombatTab:CreateToggle({
	Name = "No Spread",
	CurrentValue = false,
	Flag = 'FF_Spread',
	Callback = function()
	end,
})

CombatTab:CreateToggle({
	Name = "No Recoil",
	CurrentValue = false,
	Flag = 'FF_Recoil',
	Callback = function()
	end,
})

CombatTab:CreateToggle({
	Name = "Infinite Ammo",
	CurrentValue = false,
	Flag = 'FF_InfAmmo',
	Callback = function(Value)
	end,
})

-- [[ END OF COMBAT TAB ]] --

LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
	if tostring(child) == 'MainGui' then
    task.wait(3)
		debug.getupvalue(require(child.NewLocal.Tools.Tool.Gun.Auto).ShootLogic, 1).GetMouseInfo = function(...)
			if Rayfield.Flags["FF_Silent"].CurrentValue and debug.getinfo(getcallingfunction(3)).name ~= 'CheckInteraction' and GetTarget() and Rayfield.Flags["FF_SAccuracy"].CurrentValue >= math.random(1, 100)  then                          
				return GetTarget().Character[GetRandomHitbone()], GetTarget().Character[GetRandomHitbone()].Position
			end
				return Mouse.Target, Mouse.Hit.p
			end
		end
	end)

local rayHook;
rayHook = hookfunction(workspace.FindPartOnRayWithIgnoreList, newcclosure(function(...)
	local Args = {...}
	if Rayfield.Flags["FF_Wallbang"].CurrentValue then
	Args[3] = {game:GetService("Terrain"),workspace.IgnoreThese,LocalPlayer.Character,workspace.BuildStuff,workspace.Map,workspace.Terrain}
	return rayHook(unpack(Args))
	end
	return rayHook(...)
end))


local OldSelf
OldSelf = hookfunction(ReplicatedStorage.Network.RemoteEvent.FireServer,function(self,...)
   local Args = {...}
    if Args[2] == 5.5 and LocalPlayer.PlayerGui.FindFirstChild(LocalPlayer.PlayerGui,'MainGui') and Rayfield.Flags["FF_Wallbang"].CurrentValue then
            Args[5] = require(LocalPlayer.PlayerGui.MainGui.NewLocal.Shared).CurrIndex
            Args[6] = Args[4][1][1]
    end
    if Rayfield.Flags['FF_InfAmmo'].CurrentValue and LocalPlayer.Character and not LocalPlayer.Character:GetAttribute("IsMenuChar") then
       warn("Quick Inf check!")
        require(LocalPlayer.PlayerGui.MainGui.NewLocal.Shared).CurrTool.Ammo = 2
    end
    if Args[2] == 10.5 and Rayfield.Flags["FF_InfAmmo"].CurrentValue and not LocalPlayer.Character:GetAttribute("IsMenuChar") then
        return
    end
    if Args[2] == 5.5 and Rayfield.Flags["FF_InfAmmo"].CurrentValue and not LocalPlayer.Character:GetAttribute("IsMenuChar") then
        local newPlayer = Players:GetPlayerFromCharacter(Args[4][1][1].Parent)
        warn(not newPlayer and damagePlayer(Args[4]), damagePlayer(Players:GetPlayerFromCharacter(Args[4][1][1].Parent)))
        return not newPlayer and damagePlayer(Args[4]) or damagePlayer(Players:GetPlayerFromCharacter(Args[4][1][1].Parent))
    end
   
   return OldSelf(self,unpack(Args))
end)

local GetWSettings = require(game:GetService("ReplicatedStorage").Modules.GlobalStuff).GetWSettings
local WeaponModules = game:GetService("ReplicatedStorage").Weapons.Modules:Clone()
pcall(function() -- Weapon mod bypass (Adam)
	require(game:GetService("ReplicatedStorage").Modules.GlobalStuff).GetWSettings = function(Argument_1, Argument_2)
		if tostring(getfenv(2).script.Name) == "NewLocal" then
			return GetWSettings(Argument_1, Argument_2)
		end
		return require(WeaponModules:FindFirstChild(Argument_2))
	end
end)
game:GetService("RunService").Heartbeat:Connect(function()
	pcall(function()
		if Rayfield.Flags["FF_Recoil"].CurrentValue and not LocalPlayer.Character:GetAttribute("IsMenuChar") then
			getupvalue(require(LocalPlayer.PlayerGui.MainGui.NewLocal.Tools.Tool.Gun.Auto).ShootLogic, 1).WSettings.Recoil = 0
		end
		if Rayfield.Flags["FF_FireRate"].CurrentValue and not LocalPlayer.Character:GetAttribute("IsMenuChar") then
			getupvalue(require(LocalPlayer.PlayerGui.MainGui.NewLocal.Tools.Tool.Gun.Auto).ShootLogic, 1).WSettings.Debounce = 0.05
		end
		if Rayfield.Flags["FF_Spread"].CurrentValue and not LocalPlayer.Character:GetAttribute("IsMenuChar") then
			getupvalue(require(LocalPlayer.PlayerGui.MainGui.NewLocal.Tools.Tool.Gun.Auto).ShootLogic, 1).WSettings.Inaccuracy = 0
		end
	end)
end)


-- [[ Start Of Visuals Tab ]] --

local enemySection = VisualsTab:CreateSection("Toggle Visuals")

local showFriendlyToggle = VisualsTab:CreateToggle({
	Name = "Show Team",
	CurrentValue = false,
	Flag = 'ShowFriendly',
    Callback = function(Value)
		Sense.teamSettings.friendly.enabled = Value
	end,
})

local showMurderToggle = VisualsTab:CreateToggle({
	Name = "Show Enemies",
	CurrentValue = false,
	Flag = 'ShowEnemies',
	Callback = function(Value)
		Sense.teamSettings.enemy.enabled = Value
	end,
})

local totalVisuals = {}
local ignoreVisual = {'weapon','weaponOutline', 'enabled', 'boxOutline', 'nameOutline', 'healthBarOutline', 'tracerOutline', 'offScreenArrowOutline', 'chamsOutline', 'box3d', 'healthTextOutline', 'chamsVisibleOnly', 'distanceOutline'}
for i,v in pairs(Sense.teamSettings.enemy) do
    if typeof(v) == 'boolean' and not table.find(ignoreVisual, i) then
       table.insert(totalVisuals, tostring(i))
    end
end

VisualsTab:CreateDropdown({
   Name = "ESP Type",
   Options = totalVisuals,
   CurrentOption = {},
   MultipleOptions = true,
   Flag = "FF_EspType",
   Callback = function(Option)
    for i,v in pairs(totalVisuals) do -- may call lag, but ehh not that bad
	if table.find(Option, v) then
	  Sense.teamSettings.enemy[v] = true
	  Sense.teamSettings.friendly[v] = true
	else
	  Sense.teamSettings.enemy[v] = false
	  Sense.teamSettings.friendly[v] = false
	end
    end
end,
})

local FriendlySection = VisualsTab:CreateSection("ESP Customization")

VisualsTab:CreateColorPicker({
	Name = "Team Color",
	Color = Color3.fromRGB(0, 225, 0),
	Callback = function(Value)
		TeamColors.Team = Value
	end
})

VisualsTab:CreateColorPicker({
	Name = "Enemy Color",
	Color = Color3.fromRGB(225,0,0),
	Callback = function(Value)
		TeamColors.Enemy = Value
	end
})

-- [[ End Of Visuals Tab ]] --

-- [[ START OF LOCALPLAYER TAB / EXTRA SCRIPTS ]] --


PlayerTab:CreateSection("LocalPlayer Modifications")

PlayerTab:CreateToggle({
   Name = "No Fall-Damage",
   CurrentValue = false,
   Flag = 'NoFD',
   Callback = function()end,
})

PlayerTab:CreateSection("LocalPlayer Manipulation")

PlayerTab:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Flag = 'FF_Fly',
   Callback = function()end,
})


PlayerTab:CreateSlider({
	Name = "Fly Speed",
	Range = {50,1000},
	Increment = 1,
	Suffix = "Fly Speed",
	CurrentValue = 50,
    Flag = 'FF_FlySpeed',
	Callback = function(Value)end,
})

PlayerTab:CreateToggle({
   Name = "Toggle WalkSpeed",
   CurrentValue = false,
   Flag = 'FF_WS2',
   Callback = function()end,
})

PlayerTab:CreateSlider({
	Name = "WalkSpeed Slider",
	Range = {16,120},
	Increment = 1,
	Suffix = "WalkSpeed",
	CurrentValue = 16,
    Flag = 'FF_WS',
	Callback = function(Value)
    if Rayfield.Flags['FF_WS2'].CurrentValue then
        LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
    end,
})

PlayerTab:CreateToggle({
   Name = "Toggle JumpPower",
   CurrentValue = false,
   Flag = 'FF_JP2',
   Callback = function()end,
})

PlayerTab:CreateSlider({
	Name = "JumpPower Slider",
	Range = {35,100},
	Increment = 1,
	Suffix = "JumpPower",
	CurrentValue = 35,
    Flag = 'FF_JP',
	Callback = function(Value)
    end,
})

PlayerTab:CreateToggle({
   Name = "Toggle FieldOfView",
   CurrentValue = false,
   Flag = 'FF_FOV',
   Callback = function()end,
})

PlayerTab:CreateSlider({
	Name = "FieldOfView Slider",
	Range = {10,120},
	Increment = 1,
	Suffix = "FOV",
	CurrentValue = 80,
        Flag = 'FV_FOV',
	Callback = function(Value)
    end,
})
spawn(function()
	while task.wait(.2) do
		pcall(function()
			if not LocalPlayer.Character:FindFirstChild("LowerTorso"):FindFirstChild("BouncerTrail") and Rayfield.Flags["NoFD"].CurrentValue then
				require(game.ReplicatedStorage.Modules.NetworkModule2):FireServer("Bouncing")
			end
		end)
	end
end)

spawn(function()
	RunService:BindToRenderStep("DarkHub x IRay <3", 1, function() -- Credit IRay
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Rayfield.Flags["FF_Fly"].CurrentValue then
			local LookVector  = workspace.Camera.CFrame.LookVector
			local RightVector = workspace.Camera.CFrame.RightVector
			local UpVector    = workspace.Camera.CFrame.UpVector
			local Velocity    = Vector3.new()
			workspace.Gravity = 0
			if UserInputService:IsKeyDown("W") then
				Velocity = Velocity + LookVector * Rayfield.Flags["FF_FlySpeed"].CurrentValue or 75
			end
			if UserInputService:IsKeyDown("S") then
				Velocity = Velocity - LookVector * Rayfield.Flags["FF_FlySpeed"].CurrentValue or 75
			end
			if UserInputService:IsKeyDown("A") then
				Velocity = Velocity - RightVector * Rayfield.Flags["FF_FlySpeed"].CurrentValue or 75
			end
			if UserInputService:IsKeyDown("D") then
				Velocity = Velocity + RightVector * Rayfield.Flags["FF_FlySpeed"].CurrentValue or 75
			end
			if UserInputService:IsKeyDown("LeftShift") then
				Velocity = Velocity - UpVector * Rayfield.Flags["FF_FlySpeed"].CurrentValue or 75
			end
			if UserInputService:IsKeyDown("Space") then
				Velocity = Velocity + UpVector * Rayfield.Flags["FF_FlySpeed"].CurrentValue or 75
			end
			LocalPlayer.Character.HumanoidRootPart.Velocity = Velocity
		else
			workspace.Gravity = 95
		end
	end)
end)

game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
	  task.spawn(function()
		if Rayfield.Flags["FF_FOV"].CurrentValue then
			workspace.Camera.FieldOfView = Rayfield.Flags["FV_FOV"].CurrentValue
		end
	  end)
          task.spawn(function()
              if GetKILLPLR() and Rayfield.Flags["FF_KillAll"].CurrentValue then
                  InvokeServer('PickaxeDamage', GetKILLPLR().Character.Head)
              end
          end)
      end)
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		if Rayfield.Flags["FF_WS2"].CurrentValue then
			LocalPlayer.Character.Humanoid.WalkSpeed = Rayfield.Flags["FF_WS"].CurrentValue
		end
		if Rayfield.Flags["FF_JP2"].CurrentValue then
			LocalPlayer.Character.Humanoid.JumpPower = Rayfield.Flags["FF_JP"].CurrentValue
		end
	end
		if Rayfield.Flags["FF_Rejoin"].CurrentValue and LocalPlayer.PlayerGui.MenuUI.VoteKick and LocalPlayer.PlayerGui.MenuUI.VoteKick.Title.Text == "Vote Kick <font color = '#FFA500'>" .. LocalPlayer.Name .. "</font>?" then
			game:GetService("TeleportService").Teleport(game:GetService('TeleportService'), game.PlaceId)
	    end
    FOVCircle.Position = game:GetService('UserInputService'):GetMouseLocation()
	FOVCircle.Radius = Rayfield.Flags['FV_FOVVALUE'].CurrentValue
	if Rayfield.Flags['FF_FOVVIS'].CurrentValue then
		FOVCircle.Visible = true
	else
		FOVCircle.Visible = false
	end
end)

-- [[ END OF LOCALPLAYER TAB ]] --


-- [[ Start of Misc Tab ]] --

MiscellaneousTab:CreateToggle({
   Name = "Rejoin on Votekick",
   CurrentValue = true,
   Flag = 'FF_Rejoin',
   Callback = function()
        Notify('Warning!', 'You will rejoin the game once the VoteKick screen appears!', 5)
   end,
})

local panicButton = MiscellaneousTab:CreateButton({
   Name = "Anti-Spectate",
   Callback = function()
    ReplicatedStorage.Network.LookDir:FireServer(0/0)
   end,
})

local used = {}
for i, v in pairs(game:GetService("ReplicatedStorage").Emotes:GetChildren()) do
	table.insert(used, v.Name)
end
MiscellaneousTab:CreateDropdown({
   Name = "Emote Replicator",
   Options = used,
   CurrentOption = {"Crawly"},
   MultipleOptions = false,
   Callback = function(Option)
        ReplicatedStorage.Network.ClientToClient:Fire("Animate", LocalPlayer, "Emote", Option[1])
		ReplicatedStorage.Network.Remotes.Animate:FireServer("Emote", Option[1])
   end,
})

local panicButton = MiscellaneousTab:CreateButton({
   Name = "Destroy Builds",
   Callback = function()
    for _, v in pairs(game:GetService("Workspace").BuildStuff:GetChildren()) do
			ReplicatedStorage.Network.Remotes.Edit:FireServer(v, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
		end
   end,
})

 MiscellaneousTab:CreateButton({
   Name = "Crash Server",
   Callback = function()
        if LocalPlayer.PlayerGui:FindFirstChild("MainGui") then
            for i = 1, 20 do
                for _, v in pairs(replicatedStorage.Emotes:GetChildren()) do
                    ReplicatedStorage.Network.Remotes.Animate:FireServer("Emote", v.Name)
                end
            end
            else
            Notify('Error!', 'You must be spawned in to crash!', 5)
        end
   end,
})

MiscellaneousTab:CreateButton({
   Name = "Anti-Crash",
   Callback = function()
    Notify('Protection!', "You're now protected from 90% of crash scripts", 5)
    game:GetService("ScriptContext"):SetTimeout(0.05)
   end,
})

-- // Anti-Cheat Module
Sense.Load()
setthreadidentity(2)
AntiCheatModule = require(NetworkModule):Initialize(FakeInstance) -- Remote Caller
setthreadidentity(8)
