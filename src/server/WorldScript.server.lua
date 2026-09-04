-- World Building Script - Creates the game environment
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Clear default terrain if needed
if Workspace:FindFirstChild("Baseplate") then
	Workspace.Baseplate:Destroy()
end

local function CreateWorld()
	-- Main Baseplate
	local baseplate = Instance.new("Part")
	baseplate.Name = "Baseplate"
	baseplate.Shape = Enum.PartType.Block
	baseplate.Material = Enum.Material.Concrete
	baseplate.Size = Vector3.new(200, 1, 200)
	baseplate.TopSurface = Enum.SurfaceType.Smooth
	baseplate.BottomSurface = Enum.SurfaceType.Smooth
	baseplate.Color = Color3.fromRGB(50, 50, 60)
	baseplate.CanCollide = true
	baseplate.Position = Vector3.new(0, 0, 0)
	baseplate.Parent = Workspace
	
	-- Spawn Platform (where players start)
	local spawnPlatform = Instance.new("Part")
	spawnPlatform.Name = "SpawnPlatform"
	spawnPlatform.Shape = Enum.PartType.Block
	spawnPlatform.Material = Enum.Material.Neon
	spawnPlatform.Size = Vector3.new(30, 1, 30)
	spawnPlatform.TopSurface = Enum.SurfaceType.Smooth
	spawnPlatform.BottomSurface = Enum.SurfaceType.Smooth
	spawnPlatform.Color = Color3.fromRGB(0, 255, 0)
	spawnPlatform.CanCollide = true
	spawnPlatform.Position = Vector3.new(0, 2, 0)
	spawnPlatform.Parent = Workspace
	
	-- Money Zone (central area)
	local moneyZone = Instance.new("Part")
	moneyZone.Name = "MoneyZone"
	moneyZone.Shape = Enum.PartType.Block
	moneyZone.Material = Enum.Material.Neon
	moneyZone.Size = Vector3.new(60, 1, 60)
	moneyZone.TopSurface = Enum.SurfaceType.Smooth
	moneyZone.BottomSurface = Enum.SurfaceType.Smooth
	moneyZone.Color = Color3.fromRGB(255, 215, 0)
	moneyZone.CanCollide = true
	moneyZone.Position = Vector3.new(0, 5, 0)
	moneyZone.Parent = Workspace
	
	-- Bridge to Money Zone
	local bridge = Instance.new("Part")
	bridge.Name = "Bridge"
	bridge.Shape = Enum.PartType.Block
	bridge.Material = Enum.Material.Metal
	bridge.Size = Vector3.new(20, 0.5, 30)
	bridge.TopSurface = Enum.SurfaceType.Smooth
	bridge.BottomSurface = Enum.SurfaceType.Smooth
	bridge.Color = Color3.fromRGB(100, 100, 100)
	bridge.CanCollide = true
	bridge.Position = Vector3.new(0, 3.5, 15)
	bridge.Parent = Workspace
	
	-- Left Platform (Upgrade Zone)
	local leftPlatform = Instance.new("Part")
	leftPlatform.Name = "UpgradePlatform"
	leftPlatform.Shape = Enum.PartType.Block
	leftPlatform.Material = Enum.Material.Neon
	leftPlatform.Size = Vector3.new(40, 1, 40)
	leftPlatform.TopSurface = Enum.SurfaceType.Smooth
	leftPlatform.BottomSurface = Enum.SurfaceType.Smooth
	leftPlatform.Color = Color3.fromRGB(100, 150, 255)
	leftPlatform.CanCollide = true
	leftPlatform.Position = Vector3.new(-60, 5, 0)
	leftPlatform.Parent = Workspace
	
	-- Right Platform (Leaderboard Zone)
	local rightPlatform = Instance.new("Part")
	rightPlatform.Name = "LeaderboardPlatform"
	rightPlatform.Shape = Enum.PartType.Block
	rightPlatform.Material = Enum.Material.Neon
	rightPlatform.Size = Vector3.new(40, 1, 40)
	rightPlatform.TopSurface = Enum.SurfaceType.Smooth
	rightPlatform.BottomSurface = Enum.SurfaceType.Smooth
	rightPlatform.Color = Color3.fromRGB(255, 100, 150)
	rightPlatform.CanCollide = true
	rightPlatform.Position = Vector3.new(60, 5, 0)
	rightPlatform.Parent = Workspace
	
	-- Bridges to side platforms
	local leftBridge = Instance.new("Part")
	leftBridge.Name = "LeftBridge"
	leftBridge.Shape = Enum.PartType.Block
	leftBridge.Material = Enum.Material.Metal
	leftBridge.Size = Vector3.new(20, 0.5, 30)
	leftBridge.TopSurface = Enum.SurfaceType.Smooth
	leftBridge.BottomSurface = Enum.SurfaceType.Smooth
	leftBridge.Color = Color3.fromRGB(100, 100, 100)
	leftBridge.CanCollide = true
	leftBridge.Position = Vector3.new(-30, 3.5, 0)
	leftBridge.Parent = Workspace
	
	local rightBridge = Instance.new("Part")
	rightBridge.Name = "RightBridge"
	rightBridge.Shape = Enum.PartType.Block
	rightBridge.Material = Enum.Material.Metal
	rightBridge.Size = Vector3.new(20, 0.5, 30)
	rightBridge.TopSurface = Enum.SurfaceType.Smooth
	rightBridge.BottomSurface = Enum.SurfaceType.Smooth
	rightBridge.Color = Color3.fromRGB(100, 100, 100)
	rightBridge.CanCollide = true
	rightBridge.Position = Vector3.new(30, 3.5, 0)
	rightBridge.Parent = Workspace
	
	-- Decorative Pillars
	for i = 1, 4 do
		local pillar = Instance.new("Part")
		pillar.Name = "Pillar_" .. i
		pillar.Shape = Enum.PartType.Block
		pillar.Material = Enum.Material.Concrete
		pillar.Size = Vector3.new(8, 15, 8)
		pillar.TopSurface = Enum.SurfaceType.Smooth
		pillar.BottomSurface = Enum.SurfaceType.Smooth
		pillar.Color = Color3.fromRGB(70, 70, 70)
		pillar.CanCollide = true
		pillar.Position = Vector3.new(-60 + (i-1)*40, 8, -50)
		pillar.Parent = Workspace
	end
	
	-- Floating Money Coins (decorative)
	for i = 1, 8 do
		local coin = Instance.new("Part")
		coin.Name = "Coin_" .. i
		coin.Shape = Enum.PartType.Cylinder
		coin.Material = Enum.Material.Neon
		coin.Size = Vector3.new(0.5, 2, 2)
		coin.Color = Color3.fromRGB(255, 215, 0)
		coin.CanCollide = false
		coin.Position = Vector3.new(math.random(-80, 80), 10 + i, math.random(-80, 80))
		coin.Rotation = Vector3.new(0, 0, 45)
		coin.Parent = Workspace
		
		-- Rotate coins continuously
		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Parent = coin
		bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
		
		-- Spinning animation
		game:GetService("RunService").RenderStepped:Connect(function()
			coin.CFrame = coin.CFrame * CFrame.Angles(0, math.rad(2), 0)
		end)
	end
	
	-- Victory Tower (tall structure in center)
	local tower = Instance.new("Part")
	tower.Name = "VictoryTower"
	tower.Shape = Enum.PartType.Block
	tower.Material = Enum.Material.Neon
	tower.Size = Vector3.new(15, 30, 15)
	tower.TopSurface = Enum.SurfaceType.Smooth
	tower.BottomSurface = Enum.SurfaceType.Smooth
	tower.Color = Color3.fromRGB(255, 100, 255)
	tower.CanCollide = true
	tower.Position = Vector3.new(0, 20, -60)
	tower.Parent = Workspace
	
	-- Platform on top of tower
	local towerTop = Instance.new("Part")
	towerTop.Name = "TowerTop"
	towerTop.Shape = Enum.PartType.Block
	towerTop.Material = Enum.Material.Neon
	towerTop.Size = Vector3.new(20, 1, 20)
	towerTop.TopSurface = Enum.SurfaceType.Smooth
	towerTop.BottomSurface = Enum.SurfaceType.Smooth
	towerTop.Color = Color3.fromRGB(255, 215, 0)
	towerTop.CanCollide = true
	towerTop.Position = Vector3.new(0, 35, -60)
	towerTop.Parent = Workspace
	
	-- Sky
	local sky = Instance.new("Sky")
	sky.Name = "Sky"
	sky.SkyboxBk = "rbxasset://textures/sky/sky512_bk.png"
	sky.SkyboxDn = "rbxasset://textures/sky/sky512_dn.png"
	sky.SkyboxFt = "rbxasset://textures/sky/sky512_ft.png"
	sky.SkyboxLf = "rbxasset://textures/sky/sky512_lf.png"
	sky.SkyboxRt = "rbxasset://textures/sky/sky512_rt.png"
	sky.SkyboxUp = "rbxasset://textures/sky/sky512_up.png"
	sky.CelestialBodiesShown = true
	sky.Parent = Workspace.Terrain
	
	-- Lighting
	local lighting = game:GetService("Lighting")
	lighting.Ambient = Color3.fromRGB(200, 200, 200)
	lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
	lighting.Brightness = 2
	lighting.ClockTime = 14
	
	-- Sunlight
	local sunLight = Instance.new("Part")
	sunLight.Name = "SunLight"
	sunLight.CanCollide = false
	sunLight.CanTouch = false
	sunLight.CanQuery = false
	sunLight.Transparency = 1
	sunLight.Size = Vector3.new(1, 1, 1)
	sunLight.Position = Vector3.new(0, 100, 0)
	sunLight.Parent = Workspace
	
	local light = Instance.new("PointLight")
	light.Brightness = 3
	light.Range = 100
	light.Color = Color3.fromRGB(255, 255, 200)
	light.Parent = sunLight
	
	-- Spawn location for players
	local spawnLocation = Instance.new("SpawnLocation")
	spawnLocation.Name = "SpawnLocation"
	spawnLocation.Shape = Enum.PartType.Block
	spawnLocation.Material = Enum.Material.Neon
	spawnLocation.Size = Vector3.new(30, 1, 30)
	spawnLocation.TopSurface = Enum.SurfaceType.Smooth
	spawnLocation.BottomSurface = Enum.SurfaceType.Smooth
	spawnLocation.Color = Color3.fromRGB(0, 255, 0)
	spawnLocation.CanCollide = true
	spawnLocation.Position = Vector3.new(0, 3, 0)
	spawnLocation.CanTouch = true
	spawnLocation.Parent = Workspace
	spawnLocation.Anchored = true
	
	print("Advanced world created successfully!")
end

-- Run the world creation
if RunService:IsStudio() then
	CreateWorld()
else
	-- In-game
	CreateWorld()
end
