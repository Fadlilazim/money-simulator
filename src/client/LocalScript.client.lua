-- Client-side UI and input handling
local Config = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Config"))
local Utils = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Utils"))

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ClickEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ClickEvent")
local BuyUpgradeEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("BuyUpgradeEvent")

-- Player state
local playerMoney = 0
local playerClickBonus = 0

-- Create UI
local function CreateUI()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MoneySimulatorGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui
	
	-- Title
	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Size = UDim2.new(1, 0, 0, 50)
	title.Position = UDim2.new(0, 0, 0, 0)
	title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	title.TextColor3 = Color3.fromRGB(255, 255, 0)
	title.TextSize = 32
	title.Font = Enum.Font.GothamBold
	title.Text = "💰 MONEY SIMULATOR 💰"
	title.Parent = screenGui
	
	-- Money Display
	local moneyLabel = Instance.new("TextLabel")
	moneyLabel.Name = "MoneyLabel"
	moneyLabel.Size = UDim2.new(1, 0, 0, 80)
	moneyLabel.Position = UDim2.new(0, 0, 0.08, 0)
	moneyLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	moneyLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
	moneyLabel.TextSize = 48
	moneyLabel.Font = Enum.Font.GothamBold
	moneyLabel.Text = "$0"
	moneyLabel.Parent = screenGui
	
	-- Click Bonus Display
	local bonusLabel = Instance.new("TextLabel")
	bonusLabel.Name = "BonusLabel"
	bonusLabel.Size = UDim2.new(1, 0, 0, 40)
	bonusLabel.Position = UDim2.new(0, 0, 0.18, 0)
	bonusLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	bonusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
	bonusLabel.TextSize = 20
	bonusLabel.Font = Enum.Font.Gotham
	bonusLabel.Text = "Per Click: $" .. (Config.ClickValue + playerClickBonus)
	bonusLabel.Parent = screenGui
	
	-- Click Button
	local clickButton = Instance.new("TextButton")
	clickButton.Name = "ClickButton"
	clickButton.Size = UDim2.new(0, 200, 0, 200)
	clickButton.Position = UDim2.new(0.5, -100, 0.35, 0)
	clickButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
	clickButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	clickButton.TextSize = 28
	clickButton.Font = Enum.Font.GothamBold
	clickButton.Text = "CLICK ME!"
	clickButton.Parent = screenGui
	
	-- Rounded corners
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 20)
	corner.Parent = clickButton
	
	-- Click handler
	clickButton.MouseButton1Click:Connect(function()
		ClickEvent:FireServer()
		
		-- Animate button
		clickButton:TweenSize(UDim2.new(0, 180, 0, 180), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true)
		game:GetService("Debris"):AddItem(Instance.new("Frame"), 0.1)
		clickButton:TweenSize(UDim2.new(0, 200, 0, 200), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
	end)
	
	-- Shop Frame
	local shopFrame = Instance.new("Frame")
	shopFrame.Name = "ShopFrame"
	shopFrame.Size = UDim2.new(0, 350, 0, 400)
	shopFrame.Position = UDim2.new(0, 10, 0.35, 0)
	shopFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	shopFrame.BorderSizePixel = 0
	shopFrame.Parent = screenGui
	
	local shopCorner = Instance.new("UICorner")
	shopCorner.CornerRadius = UDim.new(0, 10)
	shopCorner.Parent = shopFrame
	
	-- Shop Title
	local shopTitle = Instance.new("TextLabel")
	shopTitle.Name = "ShopTitle"
	shopTitle.Size = UDim2.new(1, 0, 0, 40)
	shopTitle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	shopTitle.TextColor3 = Color3.fromRGB(255, 200, 0)
	shopTitle.TextSize = 20
	shopTitle.Font = Enum.Font.GothamBold
	shopTitle.Text = "🛍️ SHOP"
	shopTitle.Parent = shopFrame
	
	-- Shop scroll frame
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Name = "ScrollFrame"
	scrollFrame.Size = UDim2.new(1, -10, 1, -50)
	scrollFrame.Position = UDim2.new(0, 5, 0, 45)
	scrollFrame.BackgroundTransparency = 1
	scrollFrame.ScrollBarThickness = 8
	scrollFrame.Parent = shopFrame
	
	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0, 5)
	listLayout.Parent = scrollFrame
	
	-- Create upgrade buttons
	for i, upgrade in ipairs(Config.Upgrades) do
		local upgradeButton = Instance.new("TextButton")
		upgradeButton.Name = "Upgrade_" .. i
		upgradeButton.Size = UDim2.new(1, -10, 0, 50)
		upgradeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
		upgradeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		upgradeButton.TextSize = 14
		upgradeButton.Font = Enum.Font.Gotham
		upgradeButton.Text = upgrade.name .. " - $" .. upgrade.cost .. " (+$" .. upgrade.clickBonus .. ")"
		upgradeButton.Parent = scrollFrame
		
		local upgradeCorner = Instance.new("UICorner")
		upgradeCorner.CornerRadius = UDim.new(0, 8)
		upgradeCorner.Parent = upgradeButton
		
		upgradeButton.MouseButton1Click:Connect(function()
			BuyUpgradeEvent:FireServer(i)
		end)
		
		upgradeButton.MouseEnter:Connect(function()
			upgradeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
		end)
		
		upgradeButton.MouseLeave:Connect(function()
			upgradeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
		end)
	end
	
	-- Update UI when data changes
	ClickEvent.OnClientEvent:Connect(function(data)
		playerMoney = data.Money
		playerClickBonus = data.ClickBonus
		moneyLabel.Text = "$" .. Utils.FormatMoney(playerMoney)
		bonusLabel.Text = "Per Click: $" .. (Config.ClickValue + playerClickBonus)
	end)
	
	BuyUpgradeEvent.OnClientEvent:Connect(function(data)
		playerMoney = data.Money
		playerClickBonus = data.ClickBonus
		moneyLabel.Text = "$" .. Utils.FormatMoney(playerMoney)
		bonusLabel.Text = "Per Click: $" .. (Config.ClickValue + playerClickBonus)
	end)
end

-- Initialize UI when script loads
CreateUI()
print("Client UI loaded!")
