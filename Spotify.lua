local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer

------------------------------------------------
-- SONGS
------------------------------------------------
local songs = {
	"Minecraft Music",
	"OMFG",
	"EEYuh",
	"Low Cortisol",
	"My Granny Got Hit By A Bazooka",
	"Do that thang",
	"Unamed EDM",
	"Big guy",
	"It's raining tacos",

	"Montagem xonada",
	"I like the way you kiss me"
}

local ids = {
	["Minecraft Music"] = "rbxassetid://130672051659118",
	["OMFG"] = "rbxassetid://110788401793874",
	["EEYuh"] = "rbxassetid://16190782181",
	["Low Cortisol"] = "rbxassetid://110919401228823",
	["My Granny Got Hit By A Bazooka"] = "rbxassetid://121252909004354",
	["Do that thang"] = "rbxassetid://87444008651767",
	["Unamed EDM"] = "rbxassetid://71388243586169",
	["Big guy"] = "rbxassetid://84677981674776",
	["It's raining tacos"] = "rbxassetid://142376088",

	["Montagem xonada"] = "rbxassetid://112820802253117",
	["I like the way you kiss me"] = "rbxassetid://121052103423342"
}


local index = 1
local playing = false

------------------------------------------------
-- SOUND
------------------------------------------------
local sound = Instance.new("Sound")
sound.Volume = 0.7
sound.Parent = SoundService

------------------------------------------------
-- GUI (FIXED RESET)
------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "AdrienSpotify"
gui.ResetOnSpawn = false -- 🔥 IMPORTANT FIX
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 500, 0, 320)
frame.Position = UDim2.new(0.5, -250, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Visible = false
frame.Parent = gui
Instance.new("UICorner", frame)

------------------------------------------------
-- TITLE
------------------------------------------------
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "Adrien’s Spotify"
title.TextColor3 = Color3.fromRGB(30,215,96)
title.Font = Enum.Font.GothamBold
title.TextSize = 30
title.Parent = frame

------------------------------------------------
-- NOW PLAYING
------------------------------------------------
local nowPlaying = Instance.new("TextLabel")
nowPlaying.Size = UDim2.new(1,0,0,30)
nowPlaying.Position = UDim2.new(0,0,0,55)
nowPlaying.BackgroundTransparency = 1
nowPlaying.TextColor3 = Color3.fromRGB(255,255,255)
nowPlaying.Font = Enum.Font.Gotham
nowPlaying.TextSize = 22
nowPlaying.Text = "Not playing"
nowPlaying.Parent = frame

------------------------------------------------
-- PLAY FUNCTION
------------------------------------------------
local function playSong(i)
	index = i
	local name = songs[index]
	local id = ids[name]

	sound.SoundId = id
	sound:Stop()
	sound.TimePosition = 0
	sound:Play()
	playing = true

	nowPlaying.Text = "Now Playing: " .. name
end

------------------------------------------------
-- PLAY / PAUSE
------------------------------------------------
local playBtn = Instance.new("TextButton")
playBtn.Size = UDim2.new(0.4,0,0,45)
playBtn.Position = UDim2.new(0.05,0,0.75,0)
playBtn.Text = "PLAY / PAUSE"
playBtn.TextSize = 22
playBtn.BackgroundColor3 = Color3.fromRGB(30,215,96)
playBtn.Parent = frame
Instance.new("UICorner", playBtn)

playBtn.MouseButton1Click:Connect(function()
	if playing then
		sound:Pause()
		playing = false
	else
		sound:Play()
		playing = true
	end
end)

------------------------------------------------
-- SKIP
------------------------------------------------
local skipBtn = Instance.new("TextButton")
skipBtn.Size = UDim2.new(0.25,0,0,45)
skipBtn.Position = UDim2.new(0.5,0,0.75,0)
skipBtn.Text = "SKIP"
skipBtn.TextSize = 22
skipBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
skipBtn.Parent = frame
Instance.new("UICorner", skipBtn)

skipBtn.MouseButton1Click:Connect(function()
	index += 1
	if index > #songs then
		index = 1
	end
	playSong(index)
end)

------------------------------------------------
-- BACK
------------------------------------------------
local backBtn = Instance.new("TextButton")
backBtn.Size = UDim2.new(0.25,0,0,45)
backBtn.Position = UDim2.new(0.75,0,0.75,0)
backBtn.Text = "BACK"
backBtn.TextSize = 22
backBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
backBtn.Parent = frame
Instance.new("UICorner", backBtn)

backBtn.MouseButton1Click:Connect(function()
	index -= 1
	if index < 1 then
		index = #songs
	end
	playSong(index)
end)

------------------------------------------------
-- OPEN BUTTON
------------------------------------------------
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0,160,0,40)
openBtn.Position = UDim2.new(0.5,-80,0.9,0)
openBtn.Text = "Music"
openBtn.TextSize = 20
openBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
openBtn.TextColor3 = Color3.fromRGB(30,215,96)
openBtn.Parent = gui
Instance.new("UICorner", openBtn)

openBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)
