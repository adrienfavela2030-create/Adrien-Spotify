local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

------------------------------------------------
-- GUI
------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

------------------------------------------------
-- SOUND
------------------------------------------------
local sound = Instance.new("Sound")
sound.Volume = 0.7
sound.PlaybackSpeed = 1
sound.Parent = SoundService

------------------------------------------------
-- SIMPLE BASS EFFECT
------------------------------------------------
local eq = Instance.new("EqualizerSoundEffect")
eq.LowGain = 0
eq.MidGain = 0
eq.HighGain = 0
eq.Parent = sound

------------------------------------------------
-- SONGS
------------------------------------------------
local songs = {
	"Minecraft Music","OMFG","EEYuh","Low Cortisol",
	"My Granny Got Hit By A Bazooka","Do that thang",
	"Unamed EDM","Big guy","It's raining tacos","Macarena"
}

local ids = {
	["Minecraft Music"]="rbxassetid://130672051659118",
	["OMFG"]="rbxassetid://110788401793874",
	["EEYuh"]="rbxassetid://16190782181",
	["Low Cortisol"]="rbxassetid://110919228823",
	["My Granny Got Hit By A Bazooka"]="rbxassetid://121252909004354",
	["Do that thang"]="rbxassetid://87444008651767",
	["Unamed EDM"]="rbxassetid://71388243586169",
	["Big guy"]="rbxassetid://84677981674776",
	["It's raining tacos"]="rbxassetid://142376088",
	["Macarena"]="rbxassetid://93497396408206"
}

local index = 1

local function playSong(i)
	index = i
	sound.SoundId = ids[songs[i]]
	sound.TimePosition = 0
	sound:Play()
end

------------------------------------------------
-- OPEN BUTTON
------------------------------------------------
local open = Instance.new("TextButton")
open.Size = UDim2.new(0, 54, 0, 54)
open.Position = UDim2.new(0, 241, 0, 12)

open.Text = "🎵"
open.TextSize = 26
open.Font = Enum.Font.GothamBold
open.TextColor3 = Color3.fromRGB(255,255,255)

open.BackgroundColor3 = Color3.fromRGB(20,20,20)
open.BorderSizePixel = 0
open.Parent = gui

Instance.new("UICorner", open)

------------------------------------------------
-- MAIN MENU
------------------------------------------------
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 560, 0, 440)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)

main.BackgroundColor3 = Color3.fromRGB(12,12,12)
main.Visible = false
main.Parent = gui

Instance.new("UICorner", main)

------------------------------------------------
-- TITLE
------------------------------------------------
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,55)
title.Text = "Adrien’s Spotify"
title.TextSize = 28
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(30,215,96)
title.BackgroundTransparency = 1
title.Parent = main

------------------------------------------------
-- SONG LIST
------------------------------------------------
local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(0.58, -10, 1, -70)
list.Position = UDim2.new(0, 10, 0, 60)

list.CanvasSize = UDim2.new(0,0,0,#songs*46)
list.ScrollBarThickness = 6
list.BackgroundColor3 = Color3.fromRGB(18,18,18)
list.Parent = main

Instance.new("UICorner", list)

local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0,6)

for i,v in ipairs(songs) do
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1,-10,0,42)
	b.Text = "▶ "..v
	b.Font = Enum.Font.GothamBold
	b.TextSize = 18
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.BackgroundColor3 = Color3.fromRGB(35,35,35)
	b.Parent = list
	Instance.new("UICorner", b)

	b.MouseButton1Click:Connect(function()
		playSong(i)
	end)
end

------------------------------------------------
-- CONTROLS
------------------------------------------------
local controls = Instance.new("Frame")
controls.Size = UDim2.new(0.38,0,1,-70)
controls.Position = UDim2.new(0.6,0,0,60)
controls.BackgroundColor3 = Color3.fromRGB(18,18,18)
controls.Parent = main

Instance.new("UICorner", controls)

------------------------------------------------
-- SLIDER (FIXED INPUT)
------------------------------------------------
local function slider(name, y, default, callback)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,-20,0,18)
	label.Position = UDim2.new(0,10,0,y)
	label.Text = name
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamBold
	label.TextSize = 14
	label.Parent = controls

	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(0.9,0,0,6)
	bar.Position = UDim2.new(0.05,0,0,y+20)
	bar.BackgroundColor3 = Color3.fromRGB(60,60,60)
	bar.Parent = controls
	Instance.new("UICorner", bar)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(default,0,1,0)
	fill.BackgroundColor3 = Color3.fromRGB(30,215,96)
	fill.Parent = bar
	Instance.new("UICorner", fill)

	local dragging = false

	local function set(x)
		local p = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X,0,1)
		fill.Size = UDim2.new(p,0,1,0)
		callback(p)
	end

	bar.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			set(i.Position.X)
		end
	end)

	UserInputService.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
		or i.UserInputType == Enum.UserInputType.Touch) then
			set(i.Position.X)
		end
	end)

	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

------------------------------------------------
-- SLIDERS
------------------------------------------------

-- Volume
slider("Volume", 25, 0.7, function(v)
	sound.Volume = v
end)

-- Speed
slider("Speed", 95, 0.5, function(v)
	sound.PlaybackSpeed = 0.3 + (v * 1.7)
end)

-- BASS (NEW)
slider("Bass", 165, 0.5, function(v)
	eq.LowGain = (v * 24) - 12
	eq.MidGain = (v * 6) - 3
	eq.HighGain = (v * -6)
end)

------------------------------------------------
-- TOGGLE MENU
------------------------------------------------
open.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)
