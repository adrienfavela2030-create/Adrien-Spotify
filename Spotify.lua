-- StarterPlayerScripts LocalScript

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

------------------------------------------------
-- GUI
------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "MusicUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

------------------------------------------------
-- SOUND
------------------------------------------------
local sound = Instance.new("Sound")
sound.Volume = 0.7
sound.Parent = SoundService

local eq = Instance.new("EqualizerSoundEffect")
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
local looping = false
local seeking = false

local function formatTime(t)
	t = math.max(0, math.floor(t))
	return string.format("%02d:%02d", math.floor(t/60), t%60)
end

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
open.Size = UDim2.new(0,54,0,54)
open.Position = UDim2.new(0,241,0,12)
open.Text = "🎵"
open.TextSize = 26
open.Font = Enum.Font.GothamBold
open.TextColor3 = Color3.new(1,1,1)
open.BackgroundColor3 = Color3.fromRGB(20,20,20)
open.BorderSizePixel = 0
open.Parent = gui
Instance.new("UICorner", open)

------------------------------------------------
-- MAIN MENU
------------------------------------------------
local main = Instance.new("Frame")
main.Size = UDim2.new(0,560,0,420)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(12,12,12)
main.Visible = false
main.Parent = gui
Instance.new("UICorner", main)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "Adrien’s Spotify"
title.TextColor3 = Color3.fromRGB(30,215,96)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.Parent = main

------------------------------------------------
-- SONG LIST
------------------------------------------------
local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(0.55,0,0,360)
list.Position = UDim2.new(0,10,0,55)
list.CanvasSize = UDim2.new(0,0,0,#songs*46)
list.ScrollBarThickness = 5
list.BackgroundColor3 = Color3.fromRGB(18,18,18)
list.BorderSizePixel = 0
list.Parent = main
Instance.new("UICorner", list)

local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0,6)

for i,v in ipairs(songs) do
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1,-10,0,40)
	b.Text = "▶ "..v
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.BackgroundColor3 = Color3.fromRGB(30,30,30)
	b.BorderSizePixel = 0
	b.Parent = list
	Instance.new("UICorner", b)

	b.MouseButton1Click:Connect(function()
		playSong(i)
	end)
end

------------------------------------------------
-- SETTINGS PANEL
------------------------------------------------
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0,260,0,360)
panel.Position = UDim2.new(0.57,0,0,55)
panel.BackgroundColor3 = Color3.fromRGB(18,18,18)
panel.BorderSizePixel = 0
panel.Parent = main
Instance.new("UICorner", panel)

------------------------------------------------
-- FIXED SLIDER (NO CAMERA BUG)
------------------------------------------------
local function slider(name,y,default,callback)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,-20,0,18)
	label.Position = UDim2.new(0,10,0,y)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.new(1,1,1)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 15
	label.Parent = panel

	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(0.9,0,0,8)
	bar.Position = UDim2.new(0.05,0,0,y+24)
	bar.BackgroundColor3 = Color3.fromRGB(40,40,40)
	bar.BorderSizePixel = 0
	bar.Parent = panel
	Instance.new("UICorner", bar)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(default,0,1,0)
	fill.BackgroundColor3 = Color3.fromRGB(30,215,96)
	fill.BorderSizePixel = 0
	fill.Parent = bar
	Instance.new("UICorner", fill)

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0,16,0,16)
	knob.AnchorPoint = Vector2.new(0.5,0.5)
	knob.Position = UDim2.new(default,0,0.5,0)
	knob.BackgroundColor3 = Color3.new(1,1,1)
	knob.BorderSizePixel = 0
	knob.Parent = bar
	Instance.new("UICorner", knob)

	-- IMPORTANT FIX (stops camera movement)
	local hitbox = Instance.new("TextButton")
	hitbox.Size = UDim2.new(1,0,1,10)
	hitbox.Position = UDim2.new(0,0,0,-5)
	hitbox.BackgroundTransparency = 1
	hitbox.Text = ""
	hitbox.AutoButtonColor = false
	hitbox.Parent = bar

	local dragging = false

	local function update(x)
		local p = math.clamp((x - bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
		fill.Size = UDim2.new(p,0,1,0)
		knob.Position = UDim2.new(p,0,0.5,0)
		callback(p)
	end

	hitbox.MouseButton1Down:Connect(function()
		dragging = true
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
			update(input.Position.X)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

------------------------------------------------
-- SLIDERS (FIXED)
------------------------------------------------
slider("Volume",40,0.7,function(v)
	sound.Volume = v
end)

slider("Speed",120,0.5,function(v)
	sound.PlaybackSpeed = 0.3 + v*1.7
end)

slider("Bass",200,0.5,function(v)
	eq.LowGain = (v*24)-12
	eq.MidGain = (v*6)-3
end)

------------------------------------------------
-- HUD
------------------------------------------------
local hud = Instance.new("Frame")
hud.Size = UDim2.new(0,560,0,90)
hud.Position = UDim2.new(0.5,0,1,-120)
hud.AnchorPoint = Vector2.new(0.5,0)
hud.BackgroundColor3 = Color3.fromRGB(10,10,10)
hud.BorderSizePixel = 0
hud.Parent = gui
Instance.new("UICorner", hud)

local songLabel = Instance.new("TextLabel")
songLabel.Size = UDim2.new(0.7,0,0,24)
songLabel.Position = UDim2.new(0,10,0,5)
songLabel.BackgroundTransparency = 1
songLabel.TextColor3 = Color3.new(1,1,1)
songLabel.Font = Enum.Font.GothamBold
songLabel.TextSize = 16
songLabel.TextXAlignment = Enum.TextXAlignment.Left
songLabel.Parent = hud

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(0,100,0,24)
timeLabel.Position = UDim2.new(1,-110,0,5)
timeLabel.BackgroundTransparency = 1
timeLabel.TextColor3 = Color3.fromRGB(200,200,200)
timeLabel.Font = Enum.Font.Gotham
timeLabel.TextSize = 14
timeLabel.TextXAlignment = Enum.TextXAlignment.Right
timeLabel.Parent = hud

------------------------------------------------
-- SEEK BAR
------------------------------------------------
local seekBar = Instance.new("Frame")
seekBar.Size = UDim2.new(0.95,0,0,6)
seekBar.Position = UDim2.new(0.025,0,0,35)
seekBar.BackgroundColor3 = Color3.fromRGB(40,40,40)
seekBar.Parent = hud
Instance.new("UICorner", seekBar)

local seekFill = Instance.new("Frame")
seekFill.Size = UDim2.new(0,0,1,0)
seekFill.BackgroundColor3 = Color3.fromRGB(30,215,96)
seekFill.Parent = seekBar
Instance.new("UICorner", seekFill)

------------------------------------------------
-- BUTTONS
------------------------------------------------
local function btn(txt,x)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,60,0,28)
	b.Position = UDim2.new(0,x,0,55)
	b.Text = txt
	b.TextSize = 16
	b.Font = Enum.Font.GothamBold
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(25,25,25)
	b.BorderSizePixel = 0
	b.Parent = hud
	Instance.new("UICorner", b)
	return b
end

local prev = btn("⏮",120)
local play = btn("⏯",200)
local loop = btn("🔁",280)
local nextB = btn("⏭",360)

prev.MouseButton1Click:Connect(function()
	index -= 1
	if index < 1 then index = #songs end
	playSong(index)
end)

nextB.MouseButton1Click:Connect(function()
	index += 1
	if index > #songs then index = 1 end
	playSong(index)
end)

play.MouseButton1Click:Connect(function()
	if sound.IsPlaying then sound:Pause() else sound:Resume() end
end)

loop.MouseButton1Click:Connect(function()
	looping = not looping
	sound.Looped = looping
end)

------------------------------------------------
-- UPDATE LOOP
------------------------------------------------
RunService.RenderStepped:Connect(function()
	songLabel.Text = songs[index] or "No Song"

	if sound.TimeLength > 0 then
		local p = sound.TimePosition / sound.TimeLength
		seekFill.Size = UDim2.new(p,0,1,0)
		timeLabel.Text = formatTime(sound.TimeLength - sound.TimePosition)
	end
end)

------------------------------------------------
-- TOGGLE
------------------------------------------------
open.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)
