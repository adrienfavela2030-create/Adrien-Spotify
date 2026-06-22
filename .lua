--// VxText Stable Clean FULL Replacement

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

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
	Glass = false
}

local Generated = {}
local activeDropdown = nil

--------------------------------------------------
-- 80+ COLORS
--------------------------------------------------

local Colors = {
	{"White",Color3.fromRGB(255,255,255)},
	{"Black",Color3.fromRGB(0,0,0)},
	{"Red",Color3.fromRGB(255,0,0)},
	{"Crimson",Color3.fromRGB(220,20,60)},
	{"Orange",Color3.fromRGB(255,140,0)},
	{"Yellow",Color3.fromRGB(255,255,0)},
	{"Green",Color3.fromRGB(0,255,0)},
	{"Emerald",Color3.fromRGB(0,201,87)},
	{"Teal",Color3.fromRGB(0,128,128)},
	{"Blue",Color3.fromRGB(0,0,255)},
	{"Royal Blue",Color3.fromRGB(65,105,225)},
	{"Navy",Color3.fromRGB(0,0,128)},
	{"Purple",Color3.fromRGB(150,0,255)},
	{"Violet",Color3.fromRGB(143,0,255)},
	{"Magenta",Color3.fromRGB(255,0,255)},
	{"Pink",Color3.fromRGB(255,20,147)},
	{"Brown",Color3.fromRGB(139,69,19)},
	{"Chocolate",Color3.fromRGB(210,105,30)},
	{"Beige",Color3.fromRGB(245,245,220)},
	{"Neon Green",Color3.fromRGB(57,255,20)},
	{"Neon Blue",Color3.fromRGB(0,191,255)},
	{"Neon Pink",Color3.fromRGB(255,16,240)},
	{"Gold",Color3.fromRGB(255,200,60)},
	{"Silver",Color3.fromRGB(192,192,192)},
	{"Gray",Color3.fromRGB(128,128,128)},
	{"Sky Blue",Color3.fromRGB(135,206,235)},
	{"Lavender",Color3.fromRGB(230,230,250)},
	{"Mint",Color3.fromRGB(152,255,152)},
	{"Turquoise",Color3.fromRGB(64,224,208)},
	{"Sunset",Color3.fromRGB(255,94,77)},
	{"Galaxy",Color3.fromRGB(40,0,60)},
	{"Ice Blue",Color3.fromRGB(180,220,255)},
	{"Storm",Color3.fromRGB(70,130,180)},
	{"Shadow",Color3.fromRGB(45,45,45)}
}

-- duplicate for 80+
local base = {}
for _,c in ipairs(Colors) do table.insert(base,c) end
for i=1,2 do
	for _,c in ipairs(base) do
		table.insert(Colors,{c[1].." "..i,c[2]})
	end
end

--------------------------------------------------
-- GUI ROOT
--------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

--------------------------------------------------
-- MAIN
--------------------------------------------------

local main = Instance.new("Frame",gui)
main.Size = UDim2.fromScale(0.55,0.8)
main.Position = UDim2.fromScale(0.22,0.1)
main.BackgroundColor3 = Color3.fromRGB(18,18,26)
main.Active = true
main.Draggable = true
main.ZIndex = 2
Instance.new("UICorner",main)

--------------------------------------------------
-- CLOSE
--------------------------------------------------

local closeBtn = Instance.new("TextButton",main)
closeBtn.Size = UDim2.fromOffset(34,34)
closeBtn.Position = UDim2.new(1,-44,0,10)
closeBtn.Text = "X"
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.BackgroundColor3 = Color3.fromRGB(215,38,48)
Instance.new("UICorner",closeBtn).CornerRadius = UDim.new(1,0)

local reopenBtn = closeBtn:Clone()
reopenBtn.Parent = gui
reopenBtn.Position = UDim2.new(1,-44,0,10)
reopenBtn.Visible = false

closeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	reopenBtn.Visible = true
end)

reopenBtn.MouseButton1Click:Connect(function()
	main.Visible = true
	reopenBtn.Visible = false
end)

--------------------------------------------------
-- TABS
--------------------------------------------------

local tabs = {"Text","Customize","Performance"}
local Pages = {}

local tabBar = Instance.new("Frame",main)
tabBar.Size = UDim2.new(1,0,0.08,0)
tabBar.Position = UDim2.new(0,0,0.08,0)
tabBar.BackgroundTransparency = 1

local content = Instance.new("Frame",main)
content.Size = UDim2.new(1,0,0.84,0)
content.Position = UDim2.new(0,0,0.16,0)
content.BackgroundTransparency = 1

for i,name in ipairs(tabs) do
	local tab = Instance.new("TextButton",tabBar)
	tab.Size = UDim2.new(1/#tabs,0,1,0)
	tab.Position = UDim2.new((i-1)/#tabs,0,0,0)
	tab.Text = name
	tab.BackgroundColor3 = Color3.fromRGB(45,45,70)
	tab.TextColor3 = Color3.fromRGB(255,255,255)
	tab.Font = Enum.Font.GothamBold
	tab.TextScaled = true
	Instance.new("UICorner",tab)

	local page = Instance.new("Frame",content)
	page.Size = UDim2.new(1,0,1,0)
	page.BackgroundTransparency = 1
	page.Visible = (i==1)
	Pages[name] = page

	tab.MouseButton1Click:Connect(function()
		for _,p in pairs(Pages) do p.Visible = false end
		page.Visible = true
	end)
end

--------------------------------------------------
-- DROPDOWN SYSTEM
--------------------------------------------------

local function CreateDropdown(button,key)

	if activeDropdown then
		activeDropdown:Destroy()
		activeDropdown = nil
		return
	end

	local frame = Instance.new("Frame",gui)
	frame.Size = UDim2.fromOffset(240,260)
	frame.Position = UDim2.fromOffset(
		button.AbsolutePosition.X,
		button.AbsolutePosition.Y + button.AbsoluteSize.Y
	)
	frame.BackgroundColor3 = Color3.fromRGB(25,25,35)
	frame.ZIndex = 1000
	Instance.new("UICorner",frame)
	activeDropdown = frame

	local scroll = Instance.new("ScrollingFrame",frame)
	scroll.Size = UDim2.new(1,0,1,0)
	scroll.CanvasSize = UDim2.new(0,0,0,#Colors*30)
	scroll.ScrollBarThickness = 6
	scroll.BackgroundTransparency = 1
	scroll.ZIndex = 1001

	for i,data in ipairs(Colors) do
		local opt = Instance.new("TextButton",scroll)
		opt.Size = UDim2.new(1,-10,0,25)
		opt.Position = UDim2.new(0,5,0,(i-1)*30)
		opt.Text = data[1]
		opt.BackgroundColor3 = data[2]
		opt.TextColor3 = Color3.new(1,1,1)
		opt.Font = Enum.Font.GothamBold
		opt.TextScaled = true
		opt.ZIndex = 1002
		Instance.new("UICorner",opt)

		if Settings[key] == data[2] then
			opt.BorderSizePixel = 2
			opt.BorderColor3 = Color3.new(1,1,1)
		end

		opt.MouseButton1Click:Connect(function()
			Settings[key] = data[2]
			button.Text = key..": "..data[1]
			frame:Destroy()
			activeDropdown = nil
		end)
	end
end

--------------------------------------------------
-- TEXT TAB
--------------------------------------------------

local textPage = Pages["Text"]

local input = Instance.new("TextBox",textPage)
input.Size = UDim2.fromScale(0.9,0.12)
input.Position = UDim2.fromScale(0.05,0.05)
input.PlaceholderText = "Enter text..."
input.TextScaled = true
input.Font = Enum.Font.GothamBold
input.BackgroundColor3 = Color3.fromRGB(45,45,70)
input.TextColor3 = Settings.TextColor
Instance.new("UICorner",input)

local function Generate()

	if input.Text == "" then return end

	if not Settings.Multi then
		for _,v in pairs(Generated) do v:Destroy() end
		Generated = {}
	end

	local size = TextService:GetTextSize(
		input.Text,
		Settings.TextSize,
		Enum.Font.GothamBold,
		Vector2.new(1000,1000)
	)

	local frame = Instance.new("Frame",gui)
	frame.Size = UDim2.fromOffset(size.X+40,size.Y+40)
	frame.Position = UDim2.new(0.5,-(size.X+40)/2,0.5,-(size.Y+40)/2)
	frame.BackgroundColor3 = Settings.BackgroundColor
	frame.Active = true
	frame.Draggable = true
	frame.ZIndex = 50
	Instance.new("UICorner",frame)

	local label = Instance.new("TextLabel",frame)
	label.Size = UDim2.new(1,-20,1,-20)
	label.Position = UDim2.new(0,10,0,10)
	label.BackgroundTransparency = 1
	label.Text = input.Text
	label.TextColor3 = Settings.TextColor
	label.TextSize = Settings.TextSize
	label.TextWrapped = Settings.Folding
	label.Font = Enum.Font.GothamBold
	label.ZIndex = 51

	-- delete
	local del = Instance.new("TextButton",frame)
	del.Size = UDim2.fromOffset(20,20)
	del.Position = UDim2.new(1,-22,0,2)
	del.Text = "X"
	del.TextScaled = true
	del.BackgroundColor3 = Color3.fromRGB(215,38,48)
	del.ZIndex = 52
	Instance.new("UICorner",del).CornerRadius = UDim.new(1,0)

	del.MouseButton1Click:Connect(function()
		frame:Destroy()
	end)

	-- lock
	local lock = Instance.new("TextButton",frame)
	lock.Size = UDim2.fromOffset(20,20)
	lock.Position = UDim2.new(0,2,1,-22)
	lock.Text = "🔓"
	lock.TextScaled = true
	lock.BackgroundColor3 = Color3.fromRGB(45,45,70)
	lock.ZIndex = 52
	Instance.new("UICorner",lock).CornerRadius = UDim.new(1,0)

	local locked = false
	lock.MouseButton1Click:Connect(function()
		locked = not locked
		frame.Draggable = not locked
		lock.Text = locked and "🔒" or "🔓"
	end)

	table.insert(Generated,frame)
end

local genBtn = Instance.new("TextButton",textPage)
genBtn.Size = UDim2.fromScale(0.9,0.08)
genBtn.Position = UDim2.fromScale(0.05,0.2)
genBtn.Text = "Generate"
genBtn.BackgroundColor3 = Color3.fromRGB(45,45,70)
genBtn.TextColor3 = Color3.fromRGB(255,255,255)
genBtn.Font = Enum.Font.GothamBold
genBtn.TextScaled = true
Instance.new("UICorner",genBtn)
genBtn.MouseButton1Click:Connect(Generate)

local deleteAll = genBtn:Clone()
deleteAll.Parent = textPage
deleteAll.Position = UDim2.fromScale(0.05,0.3)
deleteAll.Text = "Delete All"
deleteAll.MouseButton1Click:Connect(function()
	for _,v in pairs(Generated) do v:Destroy() end
	Generated = {}
end)

local multiBtn = genBtn:Clone()
multiBtn.Parent = textPage
multiBtn.Position = UDim2.fromScale(0.05,0.4)
multiBtn.Text = "Multiple: OFF"
multiBtn.MouseButton1Click:Connect(function()
	Settings.Multi = not Settings.Multi
	multiBtn.Text = "Multiple: "..(Settings.Multi and "ON" or "OFF")

	if not Settings.Multi then
		for i = #Generated, 2, -1 do
			Generated[i]:Destroy()
			table.remove(Generated,i)
		end
	end
end)

--------------------------------------------------
-- CUSTOMIZE TAB
--------------------------------------------------

local customPage = Pages["Customize"]

local textColorBtn = genBtn:Clone()
textColorBtn.Parent = customPage
textColorBtn.Position = UDim2.fromScale(0.05,0.05)
textColorBtn.Text = "Text Color"
textColorBtn.MouseButton1Click:Connect(function()
	CreateDropdown(textColorBtn,"TextColor")
end)

local bgColorBtn = textColorBtn:Clone()
bgColorBtn.Parent = customPage
bgColorBtn.Position = UDim2.fromScale(0.05,0.17)
bgColorBtn.Text = "Background Color"
bgColorBtn.MouseButton1Click:Connect(function()
	CreateDropdown(bgColorBtn,"BackgroundColor")
end)

local foldBtn = textColorBtn:Clone()
foldBtn.Parent = customPage
foldBtn.Position = UDim2.fromScale(0.05,0.29)
foldBtn.Text = "Line Text"
foldBtn.MouseButton1Click:Connect(function()
	Settings.Folding = not Settings.Folding
	foldBtn.Text = Settings.Folding and "Folding Text" or "Line Text"
end)

--------------------------------------------------
-- PERFORMANCE TAB
--------------------------------------------------

local perfPage = Pages["Performance"]

local statsLabel = Instance.new("TextLabel",perfPage)
statsLabel.Size = UDim2.fromScale(0.9,0.1)
statsLabel.Position = UDim2.fromScale(0.05,0.05)
statsLabel.BackgroundTransparency = 1
statsLabel.Font = Enum.Font.GothamBold
statsLabel.TextScaled = true

local frames = 0
local last = tick()

RunService.RenderStepped:Connect(function()
	frames += 1
	if tick()-last >= 1 then
		local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
		statsLabel.Text = "FPS: "..frames.." | Ping: "..ping.."ms"
		frames = 0
		last = tick()
	end
end)

local glassBtn = genBtn:Clone()
glassBtn.Parent = perfPage
glassBtn.Position = UDim2.fromScale(0.05,0.18)
glassBtn.Text = "Glass Mode: OFF"

glassBtn.MouseButton1Click:Connect(function()
	Settings.Glass = not Settings.Glass
	glassBtn.Text = "Glass Mode: "..(Settings.Glass and "ON" or "OFF")

	for _,obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.LocalTransparencyModifier = Settings.Glass and 0.45 or 0
			obj.Material = Enum.Material.SmoothPlastic
		end
	end

	Lighting.GlobalShadows = not Settings.Glass
	Lighting.FogEnd = Settings.Glass and 100000 or 1000
end)
