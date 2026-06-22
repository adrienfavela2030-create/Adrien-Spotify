--// VxText Premuim - FINAL FULL BUILD

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

--------------------------------------------------
-- SETTINGS
--------------------------------------------------

local Settings = {
	TextSize = 28,
	TextColor = Color3.fromRGB(255,255,255),
	BackgroundColor = Color3.fromRGB(35,35,45),
	Folding = false,
	Multi = false,
	Pixel = false,
	FPSCorner = true
}

local Generated = {}
local activeDropdown

--------------------------------------------------
-- ZINDEX RULES
--------------------------------------------------
-- 1 main
-- 2 tabs
-- 3 content
-- 4 page
-- 5 controls
-- 20 generated
-- 50 dropdown
-- 100 reopen

--------------------------------------------------
-- THEME
--------------------------------------------------

local PurpleMain = Color3.fromRGB(28,18,45)
local PurpleDark = Color3.fromRGB(60,0,120)
local PurpleLight = Color3.fromRGB(170,100,255)

--------------------------------------------------
-- GUI ROOT
--------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player.PlayerGui

--------------------------------------------------
-- MAIN FRAME
--------------------------------------------------

local main = Instance.new("Frame",gui)
main.Size = UDim2.fromScale(0.55,0.8)
main.Position = UDim2.fromScale(0.22,0.1)
main.BackgroundColor3 = PurpleMain
main.Active = true
main.Draggable = true
main.ZIndex = 1
Instance.new("UICorner",main)

Instance.new("UIStroke",main).Color = PurpleLight

--------------------------------------------------
-- TITLE
--------------------------------------------------

local title = Instance.new("TextLabel",main)
title.Size = UDim2.new(1,0,0.08,0)
title.BackgroundTransparency = 1
title.Text = "VxText Premuim"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = PurpleLight
title.ZIndex = 5

--------------------------------------------------
-- CLOSE / REOPEN
--------------------------------------------------

local close = Instance.new("TextButton",main)
close.Size = UDim2.fromOffset(28,28)
close.Position = UDim2.new(1,-36,0,6)
close.Text = "X"
close.Font = Enum.Font.GothamBlack
close.TextScaled = true
close.BackgroundColor3 = PurpleDark
close.TextColor3 = Color3.new(1,1,1)
close.ZIndex = 6
Instance.new("UICorner",close)

local reopen = close:Clone()
reopen.Parent = gui
reopen.Text = "+"
reopen.Position = UDim2.new(1,-36,0,6)
reopen.Visible = false
reopen.ZIndex = 100

close.MouseButton1Click:Connect(function()
	main.Visible = false
	reopen.Visible = true
end)

reopen.MouseButton1Click:Connect(function()
	main.Visible = true
	reopen.Visible = false
end)

--------------------------------------------------
-- TABS
--------------------------------------------------

local tabs = {"Text","Customize","Performance","Images"}
local Pages = {}

local tabBar = Instance.new("Frame",main)
tabBar.Size = UDim2.new(1,0,0.08,0)
tabBar.Position = UDim2.new(0,0,0.08,0)
tabBar.BackgroundTransparency = 1
tabBar.ZIndex = 2

local content = Instance.new("Frame",main)
content.Size = UDim2.new(1,0,0.84,0)
content.Position = UDim2.new(0,0,0.16,0)
content.BackgroundTransparency = 1
content.ZIndex = 3

for i,name in ipairs(tabs) do
	local tab = Instance.new("TextButton",tabBar)
	tab.Size = UDim2.new(1/#tabs,0,1,0)
	tab.Position = UDim2.new((i-1)/#tabs,0,0,0)
	tab.Text = name
	tab.BackgroundColor3 = PurpleDark
	tab.TextColor3 = Color3.new(1,1,1)
	tab.Font = Enum.Font.GothamBold
	tab.TextScaled = true
	tab.ZIndex = 3
	Instance.new("UICorner",tab)

	local page = Instance.new("Frame",content)
	page.Size = UDim2.new(1,0,1,0)
	page.BackgroundTransparency = 1
	page.Visible = (i==1)
	page.ZIndex = 4
	Pages[name] = page

	tab.MouseButton1Click:Connect(function()
		for _,p in pairs(Pages) do p.Visible = false end
		page.Visible = true
	end)
end

--------------------------------------------------
-- 80+ COLORS
--------------------------------------------------

local Colors = {
{"White",Color3.fromRGB(255,255,255)},{"Black",Color3.fromRGB(0,0,0)},
{"Red",Color3.fromRGB(255,0,0)},{"Crimson",Color3.fromRGB(220,20,60)},
{"Orange",Color3.fromRGB(255,140,0)},{"Gold",Color3.fromRGB(255,200,60)},
{"Yellow",Color3.fromRGB(255,255,0)},{"Lime",Color3.fromRGB(50,205,50)},
{"Green",Color3.fromRGB(0,255,0)},{"Emerald",Color3.fromRGB(0,201,87)},
{"Teal",Color3.fromRGB(0,128,128)},{"Cyan",Color3.fromRGB(0,255,255)},
{"Blue",Color3.fromRGB(0,0,255)},{"Royal Blue",Color3.fromRGB(65,105,225)},
{"Navy",Color3.fromRGB(0,0,128)},{"Purple",Color3.fromRGB(150,0,255)},
{"Violet",Color3.fromRGB(143,0,255)},{"Magenta",Color3.fromRGB(255,0,255)},
{"Pink",Color3.fromRGB(255,20,147)},{"Hot Pink",Color3.fromRGB(255,105,180)},
{"Brown",Color3.fromRGB(139,69,19)},{"Chocolate",Color3.fromRGB(210,105,30)},
{"Beige",Color3.fromRGB(245,245,220)},{"Gray",Color3.fromRGB(128,128,128)},
{"Silver",Color3.fromRGB(192,192,192)},{"Charcoal",Color3.fromRGB(54,69,79)},
{"Midnight",Color3.fromRGB(25,25,40)},{"Neon Green",Color3.fromRGB(57,255,20)},
{"Neon Pink",Color3.fromRGB(255,16,240)},{"Neon Cyan",Color3.fromRGB(0,255,255)},
{"Neon Yellow",Color3.fromRGB(255,255,33)},{"Sky Blue",Color3.fromRGB(135,206,235)},
{"Baby Blue",Color3.fromRGB(137,207,240)},{"Lavender",Color3.fromRGB(230,230,250)},
{"Indigo",Color3.fromRGB(75,0,130)},{"Plum",Color3.fromRGB(142,69,133)},
{"Orchid",Color3.fromRGB(218,112,214)},{"Blush",Color3.fromRGB(222,93,131)},
{"Mocha",Color3.fromRGB(112,66,20)},{"Storm",Color3.fromRGB(70,130,180)}
}

--------------------------------------------------
-- DROPDOWN FUNCTION
--------------------------------------------------

local function CreateDropdown(button,key)
	if activeDropdown then activeDropdown:Destroy() end

	local frame = Instance.new("Frame",gui)
	frame.Size = UDim2.fromOffset(220,250)
	frame.Position = UDim2.fromOffset(button.AbsolutePosition.X,
		button.AbsolutePosition.Y + button.AbsoluteSize.Y)
	frame.BackgroundColor3 = PurpleDark
	frame.ZIndex = 50
	Instance.new("UICorner",frame)
	activeDropdown = frame

	local scroll = Instance.new("ScrollingFrame",frame)
	scroll.Size = UDim2.new(1,0,1,0)
	scroll.CanvasSize = UDim2.new(0,0,0,#Colors*28)
	scroll.ScrollBarThickness = 6
	scroll.BackgroundTransparency = 1
	scroll.ZIndex = 51

	for i,data in ipairs(Colors) do
		local opt = Instance.new("TextButton",scroll)
		opt.Size = UDim2.new(1,0,0,25)
		opt.Position = UDim2.new(0,0,0,(i-1)*28)
		opt.Text = data[1]
		opt.BackgroundColor3 = data[2]
		opt.TextColor3 = Color3.new(1,1,1)
		opt.Font = Enum.Font.GothamBold
		opt.TextScaled = true
		opt.ZIndex = 52
		Instance.new("UICorner",opt)

		opt.MouseButton1Click:Connect(function()
			Settings[key] = data[2]
			button.Text = key.." : "..data[1]
			frame:Destroy()
		end)
	end
end
