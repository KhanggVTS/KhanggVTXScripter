local Players = game:GetService("Players")

local TweenService = game:GetService("TweenService")

local RunService = game:GetService("RunService")

local TextService = game:GetService("TextService")

local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")

local function safeDestroy(name)

	local g = playerGui:FindFirstChild(name)	if g then g:Destroy() end

end

safeDestroy("AutoTypingOverlay")

safeDestroy("AxverHub")

local SaveFileName = "AxverHubNgonNgu.json"

local function saveLang(tbl)

	pcall(function()

		if writefile then

			writefile(SaveFileName, HttpService:JSONEncode(tbl))

		end

	end)

end

local function loadLang()

	local data = {lang = "en"}

	pcall(function()

		if readfile and isfile and isfile(SaveFileName) then

			local raw = readfile(SaveFileName)

			local ok, dec = pcall(function() return HttpService:JSONDecode(raw) end)

			if ok and type(dec) == "table" and dec.lang then

				data = dec

			end

		end

	end)

	return data

end

local savedLang = loadLang()

local currentLanguage = savedLang.lang or "en"

local gui = Instance.new("ScreenGui")

gui.Name = "AutoTypingOverlay"

gui.IgnoreGuiInset = true

gui.ResetOnSpawn = false

gui.Parent = playerGui

local bg = Instance.new("Frame")

bg.Size = UDim2.new(1,0,1,0)

bg.Position = UDim2.new(0,0,0,0)

bg.BackgroundColor3 = Color3.fromRGB(0,0,0)

bg.BackgroundTransparency = 0

bg.BorderSizePixel = 0

bg.Parent = gui

local textLabel = Instance.new("TextLabel")

textLabel.Size = UDim2.new(1, 0, 1, 0)

textLabel.Position = UDim2.new(0, 0, 0, 0)

textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

textLabel.BackgroundTransparency = 0

textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)

textLabel.Font = Enum.Font.Code

textLabel.TextSize = 20

textLabel.TextXAlignment = Enum.TextXAlignment.Left

textLabel.TextYAlignment = Enum.TextYAlignment.Top

textLabel.TextWrapped = true

textLabel.Text = "Axver Hub"

textLabel.Parent = bg

local textContents = {

[[
-- Axver/lua Script Gui
[NETWORK] Connecting to data node...
[NETWORK] Node found: 192.168.4.12
[NETWORK] Sending handshake request...
[AUTH] Session key granted.
[DOWNLOAD] Retrieving user memory package...
[DOWNLOAD] Chunk 1/5 complete (6.2 MB)
[DOWNLOAD] Chunk 2/5 complete (12.4 MB)
[DOWNLOAD] Chunk 3/5 complete (18.7 MB)
[DOWNLOAD] Chunk 4/5 complete (24.9 MB)
[DOWNLOAD] Chunk 5/5 complete (31.1 MB)
[CHECKSUM] Validating... OK
[INFO] Data download complete.
[INFO] Transferring to volatile storage...
[INFO] Transfer finished. Ready for execution.
[Wait] Waiting area to run data...
[DATA] Loading data from player.
[DATA] Loading functions...
]],

[[
-- Axver/lua Script Gui
[DOWNLOAD] :: ██░░░░░░░░░░░░    → 14%
[DOWNLOAD] :: ███░░░░░░░░░░░    → 27%
[DOWNLOAD] :: ████░░░░░░░░░░    → 41%
[DOWNLOAD] :: ██████░░░░░░░░    → 56%
[DOWNLOAD] :: ████████░░░░░░    → 63%
[DOWNLOAD] :: █████████░░░░░    → 71%
[DOWNLOAD] :: ███████████░░░    → 82%
[DOWNLOAD] :: ████████████░░    → 88%
[DOWNLOAD] :: ████████████░░    → 89%
[DOWNLOAD] :: ████████████░░    → 92%
[DOWNLOAD] :: ████████████░░    → 93%
[DOWNLOAD] :: ████████████░░    → 94%
[DOWNLOAD] :: █████████████░    → 95%
[DOWNLOAD] :: █████████████░    → 97%
[DOWNLOAD] :: █████████████░    → 98%
[DOWNLOAD] :: ██████████████    → 99%
[DOWNLOAD] :: ██████████████    → 100%
]],

[[
Axver/lua Script Gui
[LOADING]: 0101001010010101011010101010010111100101010100101010010101011010101
101010100101010010011010101010010111100101010100101010010101011010101
101010100101010010101011010101010010111100101010100101010010101011
101010100101010010101011010101010010111100101010100101010010101011010101
101010100101010010101011010101010011100101010100101010010101011010101
10101010010101011010101010010111100101010100101010010101011010101
1010101001010100101010110101010100101111010100101010010101011010101
101010100101010010101011010101010010111100101010100101010010101
101010100101010010101011010101010010111100101010100101010010101011010101
10101010010101001010101101010101001011110010101010010101001010101101
1010101001010100101010110101010100101111010101010010101001010101
10101010010101001010101101010101001011100101010100101010010110101
10101010010101001010101101010101001011110010101010010101001010101101
101010010101011010101010010111100101010100101010010101011010101
0100101010010101011010101010010111100101010100101010010101011010101
101010100101010010101011010101010010111100101010100101010010101011010
]],

[[
Axver/lua Script Gui
[LOADING]
0101011101001010011100101010110011010101011100101010010110101001100110
221/991/443/20/88/11/552/331/998/441/22/991/55/203/77/889/44/22/991/553
AF10EE2244B188AA33FA662191C301FA77BC11FE44B102219AC311EE0021F101
10101010011010101100101101010111001010101101001010111001010100101101
77/552/88/991/221/003/22/551/442/991/77/44/552/113/203/88/991/22/551/442
AC39FF22EE109AC311FE8877B144D122CE0021AF10FF2233FA6621F00177BC44
01101011100101101010100110101011100101011010100110101001101010010101
991/77/22/889/001/113/551/442/22/77/991/552/88/44/203/442/551/22/991/77
FA22C91122CE01FA11FE44AC77AB0021FF889A1144B101FA33FA662191C3AF10
11010010110101101010010110101100101101011100101011010110010110101001
203/552/88/12/991/445/113/552/22/889/003/77/221/551/442/991/22/33/552/88
FF22EE10002144B191C301FE6621AF1088AA33FA7777BCF001AA39EE1044B177
01010111100101011010100110101011001010110101100101111001010101011010
8/233/99/12/77/444/991/22/55/203/552/331/88/22/991/77/003/551/442/889
AF10AA39FF2244B111FE002191C377BC662133FA01C288AA002144B1F00111FE
1110100110101011010010110101110010101111001011010110010111001010101
]]

}

local rng = Random.new(player.UserId + math.floor(tick()))

local textContent = textContents[rng:NextInteger(1,#textContents)]

local chars = {}

for _, cp in utf8.codes(textContent) do table.insert(chars, utf8.char(cp)) end

local totalChars = #chars

if totalChars == 0 then

	if gui and gui.Parent then gui:Destroy() end

	return

end

repeat task.wait() until textLabel.AbsoluteSize.X > 0 and textLabel.AbsoluteSize.Y > 0

textLabel.TextTransparency = 1

TweenService:Create(textLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()

local lastIndex = 0

local startTime = tick()

local typeDuration = math.random(1,3)

local typeConn

local funcFrameRef = nil

local searchBoxRef = nil

local ContentRef = nil

local titleRef = nil

local guiRef = nil

local function getText(t)

	if type(t) == "table" then

		return t[currentLanguage] or t.en or next(t) and t[next(t)] or ""

	end

	return tostring(t or "")

end

local changeLanguage

local functions = {

{Text = {vn = "Trang Chủ", en = "Home"}, Scripts = {
{Text = {vn = "God Mode", en = "God Mode"}, Script = [[
 
loadstring(game:HttpGet("https://pastefy.app/0e68Mo2I/raw", true))()

]]},
{Text = {vn = "Tàng Hình", en = "Invisible"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/0Zpq02WG/raw", true))()

]]},

{Text = {vn = "Bay", en = "Fly"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/2h4uOI4u/raw", true))()

]]},

{Text = {vn = "Tốc Độ", en = "Speed"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/MuRMXXRN/raw", true))()

]]},

{Text = {vn = "Nhảy Cao", en = "JumpPower"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/1ltBn9nO/raw", true))()

]]},

{Text = {vn = "Nhảy Vô Hạn", en = "Infinite Jump"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/EBy2hp0a/raw", true))()

]]},

{Text = {vn = "Đi Trên Không V2", en = "Walking on Air V2"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/JK1fZSRf/raw", true))()

]]},

{Text = {vn = "Tăng Tầm Xa Camera(Client)", en = "Increase Camera Range(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/fGBgPLHu/raw", true))()

]]},

{Text = {vn = "Xuyên Tường", en = "No clips"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/Wr5US7vh/raw", true))()

]]},

{Text = {vn = "Nhìn Trong Bóng Tối(Client)", en = "Night Vission(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/pMYszXDv/raw", true))()

]]},

{Text = {vn = "Tốc Biến", en = "Flash"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/2OEC9SvA/raw", true))()

]]},

{Text = {vn = "Tua Ngược", en = "Reverse"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/hWw2uzeh/raw", true))()

]]},

{Text = {vn = "Nhân Đôi Tool(Client)", en = "Dupe Tool(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/JqBhjgQP/raw", true))()

]]},

}},

{Text = {vn = "Bầu Trời", en = "Sky"}, Scripts = {

{Text = {vn = "Tím(Client)", en = "Purple(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/OzMbwM6R/raw", true))()

]]},

{Text = {vn = "Hồng(Client)", en = "Pink(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/5ZfHKxpn/raw", true))()

]]},

{Text = {vn = "Đỏ(Client)", en = "Red(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/384ep7A7/raw", true))()

]]},

{Text = {vn = "Cam(Client)", en = "Orange(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/txTKOULw/raw", true))()

]]},

{Text = {vn = "Trắng(Client)", en = "White(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/XFyGbhjs/raw", true))()

]]},

{Text = {vn = "Vàng(Client)", en = "Yellow(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/5aeOfLjr/raw", true))()

]]},

{Text = {vn = "Xanh Dương(Client)", en = "Blue(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/1rojDnHp/raw", true))()

]]},

{Text = {vn = "Xanh Lá(Client)", en = "Green(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/exRkmaVT/raw", true))()

]]},

{Text = {vn = "666(Client)", en = "666(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/nOY2bEOL/raw", true))()

]]},

}},

{Text = {vn = "Người Chơi", en = "Player"}, Scripts = {

{Text = {vn = "Amibot Người Chơi", en = "Amibot Player"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/OOdhJ3ps/raw", true))()

]]},

{Text = {vn = "HitBox Người Chơi", en = "HitBox Player"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/FJuxfI4V/raw", true))()

]]},

{Text = {vn = "Theo Dõi Người Chơi", en = "Track Player"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/M5EgY9A3/raw", true))()

]]},

{Text = {vn = "Dịch Chuyển Đến Người Chơi", en = "Teleport To Player"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/TidFDUc4/raw", true))()

]]},

{Text = {vn = "Dịch Chuyển Đến Người Chơi Gần Nhất", en = "Teleport To Nearest Player"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/8IwA24ZI/raw", true))()

]]},

{Text = {vn = "Định Vị Người Chơi", en = "ESP Player"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/BA1T2aUX/raw", true))()

]]},

{Text = {vn = "Né Người Chơi", en = "Avoid Player"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/LHZw8nVj/raw", true))()

]]},
{Text = {vn = "Sao Chép Avatar (Client)", en = "Copy Avatar (Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/j3nmtUIh/raw", true))()

]]},
}},

{Text = {vn = "Thế Giới", en = "World"}, Scripts = {

{Text = {vn = "X-ray(Client)", en = "X-ray(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/w3aSZQMu/raw", true))()

]]},

{Text = {vn = "Xoá Sương Mù(Client)", en = "Remove Fog(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/ZDuGVeAP/raw", true))()

]]},

{Text = {vn = "Định Vị NPC(Client)", en = "ESP NPC(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/eAKK1tbP/raw", true))()

]]},

{Text = {vn = "Tương Tác Nhanh", en = "Fast Interaction"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/WVVgm6mw/raw", true))()

]]},

{Text = {vn = "Kéo Về", en = "Pull Back"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/JozMrWIq/raw", true))()

]]},
{Text = {vn = "Kéo Về 2", en = "Pull Back 2"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/yoJhQwG2/raw", true))()

]]},

{Text = {vn = "Disco Tacos(Client)", en = "Disco Tacos(Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/082TCgJQ/raw", true))()

]]},

{Text = {vn = "Quan Sát Thế Giới", en = "World View"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/vbDxD0Xx/raw", true))()

]]},

{Text = {vn = "Ring", en = "Ring"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/lqCME5Hx/raw", true))()

]]},

}},

{Text = {vn = "Giải Trí", en = "Fun"}, Scripts = {

{Text = {vn = "Đá Bay", en = "Fling"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/3l7M8rCk/raw", true))()

]]},

{Text = {vn = "Fake Lag", en = "Fake Lag"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/lW6r1Opw/raw", true))()

]]},

{Text = {vn = "Fake Lag 2", en = "Fake Lag 2"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/Ard4gH6c/raw", true))()

]]},

{Text = {vn = "Xoay Khi Di Chuyển", en = "Spin While Moving"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/IpojfWHy/raw", true))()

]]},

{Text = {vn = "Animation Siêu Tốc", en = "Ultra Fast Animation"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/5Dm06wpu/raw", true))()

]]},

{Text = {vn = "Di Chuyển Xoay Ngang 360⁰", en = "360 Horizontal Spin Move"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/02hmLoB6/raw", true))()

]]},

{Text = {vn = "Trọng Lực Tự Do", en = "Free Gravity"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/jTCQl56Z/raw", true))()

]]},
{Text = {vn = "Hành Động R15", en = "Animation R15"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/xiJfxKZ4/raw", true))()

]]},
}},

{Text = {vn = "Máy Chủ", en = "Sever"}, Scripts = {

{Text = {vn = "Chuyển Server Khác", en = "Change Server"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/wgQD3R5E/raw", true))()

]]},

{Text = {vn = "Tham Gia Lại Máy Chủ", en = "Rejoin Server"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/OWAuyqqP/raw", true))()

]]},

{Text = {vn = "Tìm Máy Chủ Ít Người", en = "Find Low Player Server"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/SXuBkIw0/raw", true))()

]]},

}},

{Text = {vn = "Khác", en = "Other"}, Scripts = {

{Text = {vn = "Chỉnh Sửa(Client)", en = "Edit (Client)"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/Sdkk1dAG/raw", true))()

]]},

{Text = {vn = "Obfucaste Lua", en = "Obfucaste Lua"}, Script = [[

loadstring(game:HttpGet("https://pastefy.app/i7KikDUe/raw", true))()

]]},

}},

{Text = {vn = "Ngôn Ngữ", en = "Language"}, Scripts = {

{Text = {vn = "Tiếng Việt", en = "Vietnamese"}, Script = [[

_G.changeLanguage("vn")

]]},

{ Text = {vn = "Tiếng Anh", en = "English"}, Script = [[

_G.changeLanguage("en")

]]},

}},

}

local allScripts = {}

local function regenerateAllScripts()

	allScripts = {}

	for _, f in ipairs(functions) do

		for _, s in ipairs(f.Scripts) do

			table.insert(allScripts, {Text = s.Text, Script = s.Script, ParentFunc = f.Text})

		end

	end

end

regenerateAllScripts()

local function runScriptEntry(entry)

	if type(entry) == "function" then

		pcall(entry)

		return

	end

	if type(entry) == "string" then

		if loadstring then

			local chunk = loadstring(entry)

			if chunk then

				local ok, ret = pcall(chunk)

				if ok and type(ret) == "function" then

					pcall(ret)

				end

				return

			end

			local wrapper = loadstring("return function()\n" .. entry .. "\nend")

			if wrapper then

				local ok2, f = pcall(wrapper)

				if ok2 and type(f) == "function" then

					pcall(f)

					return

				end

			end

		end

		return

	end

end

local createButtons, buildFuncButtons

createButtons = function(scripts)

	if not ContentRef then return end

	for _, child in ipairs(ContentRef:GetChildren()) do

		if child:IsA("TextButton") or child:IsA("UIStroke") or child:IsA("UICorner") then child:Destroy() end

	end

	local xOffset, yOffset = 0, 0

	local contentWidth = ContentRef.AbsoluteSize.X

	local paddingX, paddingY, spacingX, spacingY = 8, 4, 6, 6

	for _, v in ipairs(scripts) do

		local labelText = getText(v.Text)

		local textSize = TextService:GetTextSize(labelText, 18, Enum.Font.GothamBold, Vector2.new(math.huge, math.huge))

		local btnW = textSize.X + paddingX * 3

		local btnH = textSize.Y + paddingY * 2

		if xOffset + btnW > contentWidth then

			xOffset = 0

			yOffset = yOffset + btnH + spacingY

		end

		local btn = Instance.new("TextButton")

		btn.Size = UDim2.new(0, btnW, 0, btnH)

		btn.Position = UDim2.new(0, xOffset, 0, yOffset)

		btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)

		btn.BorderSizePixel = 0

		btn.Font = Enum.Font.GothamBold

		btn.TextScaled = true

		btn.Text = labelText

		btn.TextColor3 = Color3.fromRGB(220, 255, 250)

		btn.Parent = ContentRef

		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

		local stroke = Instance.new("UIStroke", btn)

		stroke.Thickness = 2

		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

		task.spawn(function()

			local h = 0

			while btn.Parent do

				h = (h + 0.005) % 1

				stroke.Color = Color3.fromHSV(h, 1, 1)

				task.wait(0.02)

			end

		end)

		btn.Activated:Connect(function()

			pcall(function()

				if v and v.Script then

					runScriptEntry(v.Script)

				end

			end)

		end)

		xOffset = xOffset + btnW + spacingX

	end

	ContentRef.CanvasSize = UDim2.new(0, 0, 0, yOffset + 50)

end

buildFuncButtons = function()

	if not funcFrameRef then return end

	for _, child in ipairs(funcFrameRef:GetChildren()) do

		if child:IsA("TextButton") or child:IsA("UIStroke") or child:IsA("UICorner") then child:Destroy() end

	end

	for _, f in ipairs(functions) do

		local btn = Instance.new("TextButton")

		btn.Size = UDim2.new(1, 0, 0, 30)

		btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)

		btn.BorderSizePixel = 0

		btn.Font = Enum.Font.GothamBold

		btn.TextScaled = true

		btn.Text = getText(f.Text)

		btn.TextColor3 = Color3.fromRGB(220, 255, 250)

		btn.Parent = funcFrameRef

		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

		btn.MouseButton1Click:Connect(function()

			if searchBoxRef then searchBoxRef.Text = "" end

			local scripts = f.Scripts or {}

			createButtons(scripts)

		end)

	end

end

local function filterScripts(query)

	if not query or query == "" then return {} end

	query = string.lower(query)

	local out = {}

	for _, v in ipairs(allScripts) do

		local txt = string.lower(getText(v.Text))

		if string.find(txt, query, 1, true) then

			table.insert(out, {Text = v.Text, Script = v.Script})

		end

	end

	return out

end

changeLanguage = function(lang)

	currentLanguage = lang or currentLanguage

	saveLang({lang = currentLanguage})

	if searchBoxRef then

		searchBoxRef.PlaceholderText = (currentLanguage == "vn") and "Tìm Script" or "Search Script"

	end

	regenerateAllScripts()

	buildFuncButtons()

	if functions[1] and functions[1].Scripts and ContentRef then

		createButtons(functions[1].Scripts)

	end

end

_G.changeLanguage = changeLanguage

local function startBom2devGUI()

	safeDestroy("Bom2Dev")

	local gui2 = Instance.new("ScreenGui")

	gui2.Name = "Axver Hub"

	gui2.Parent = playerGui

	gui2.IgnoreGuiInset = true

	gui2.ResetOnSpawn = false

	guiRef = gui2

   

    local toggle = Instance.new("ImageButton")

    toggle.Size = UDim2.new(0, 50, 0, 50)

    toggle.Position = UDim2.new(0, 10, 0.5, -18)

    toggle.AnchorPoint = Vector2.new(0,0.5)

    toggle.BackgroundTransparency = 1

    toggle.Image = "rbxassetid://77542906567215"

    toggle.Parent = gui2

    toggle.Active = true

    toggle.Draggable = true

   

    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 14)

	local glow = Instance.new("UIStroke", toggle)	glow.Thickness = 2

	glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	glow.Transparency = 0.3

	task.spawn(function()

		while gui2.Parent do

			for h = 0, 1, 0.008 do

				glow.Color = Color3.fromHSV(h, 0.8, 1)

				task.wait(0.05)

			end

		end

	end)

	local frame = Instance.new("Frame")

	frame.Size = UDim2.new(0, 420, 0, 260)

	frame.Position = UDim2.new(0.5, -210, 0.5, -130)

	frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)

	frame.BackgroundTransparency = 0.08

	frame.BorderSizePixel = 0

	frame.Visible = false

	frame.Parent = gui2

	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

	local glow = Instance.new("UIStroke", frame)

	glow.Thickness = 2.5

	glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	glow.Transparency = 0.2

	task.spawn(function()

		while gui2.Parent do

			for h = 0, 1, 0.008 do

				glow.Color = Color3.fromHSV(h, 0.85, 1)

				task.wait(0.02)

			end

		end

	end)

	local header = Instance.new("Frame", frame)

	header.Size = UDim2.new(1, 0, 0, 40)

	header.BackgroundColor3 = Color3.fromRGB(0, 255, 200)

	header.BackgroundTransparency = 0.75

	header.BorderSizePixel = 0

	Instance.new("UICorner", header).CornerRadius = UDim.new(0, 14)

	local title = Instance.new("TextLabel", header)

	title.Text = "Axver Hub v1.0"

	title.Font = Enum.Font.GothamBold

	title.TextScaled = true

	title.TextColor3 = Color3.fromRGB(255, 0, 0)

	title.BackgroundTransparency = 1

	title.Position = UDim2.new(0, 40, 0, 0)

	title.Size = UDim2.new(1, -280, 1, 0)

	title.TextXAlignment = Enum.TextXAlignment.Left

	titleRef = title

	local avatar = Instance.new("ImageLabel", header)

	avatar.Size = UDim2.new(0, 30, 0, 30)

	avatar.Position = UDim2.new(0, 5, 0, 5)

    avatar.BackgroundTransparency = 1

	avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150"

	Instance.new("UICorner", avatar).CornerRadius = UDim.new(0, 15)

	local close = Instance.new("TextButton", header)

	close.Text = "×"

	close.Font = Enum.Font.GothamBold

	close.TextSize = 22

	close.TextColor3 = Color3.fromRGB(255, 0, 0)

	close.BackgroundTransparency = 1

	close.Size = UDim2.new(0, 30, 1, 0)

	close.Position = UDim2.new(1, -35, 0, 0)

	close.MouseEnter:Connect(function()

		TweenService:Create(close, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 100, 100)}):Play()

	end)

	close.MouseLeave:Connect(function()

		TweenService:Create(close, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(0, 255, 200)}):Play()

	end)

	funcFrameRef = Instance.new("ScrollingFrame", frame)

	funcFrameRef.Size = UDim2.new(0, 70, 1, -50)

	funcFrameRef.Position = UDim2.new(0, 5, 0, 45)

	funcFrameRef.BackgroundTransparency = 1

	funcFrameRef.ScrollBarThickness = 4

	funcFrameRef.CanvasSize = UDim2.new(0, 0, 0, 0)

	local funcLayout = Instance.new("UIListLayout", funcFrameRef)

	funcLayout.Padding = UDim.new(0, 5)

	funcLayout.SortOrder = Enum.SortOrder.LayoutOrder

	searchBoxRef = Instance.new("TextBox", header)

	searchBoxRef.Size = UDim2.new(0, 200, 0, 24)

	searchBoxRef.Position = UDim2.new(1, -245, 0, 8)

	searchBoxRef.BackgroundColor3 = Color3.fromRGB(18, 18, 22)

	searchBoxRef.BackgroundTransparency = 0.5

	searchBoxRef.PlaceholderText = (currentLanguage == "vn") and "Tìm Script" or "Search Script"

	searchBoxRef.Text = ""

	searchBoxRef.ClearTextOnFocus = false

	searchBoxRef.Font = Enum.Font.Gotham

	searchBoxRef.TextSize = 14

	searchBoxRef.TextColor3 = Color3.fromRGB(255,0,0)

	searchBoxRef.ZIndex = 2

	Instance.new("UICorner", searchBoxRef).CornerRadius = UDim.new(0, 6)

	ContentRef = Instance.new("ScrollingFrame", frame)

	ContentRef.Size = UDim2.new(1, -85, 1, -50)

	ContentRef.Position = UDim2.new(0, 80, 0, 45)

	ContentRef.BackgroundTransparency = 1

	ContentRef.ScrollBarThickness = 6

	ContentRef.CanvasSize = UDim2.new(0, 0, 0, 0)

	ContentRef:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()

		if functions[1] and functions[1].Scripts then

			createButtons(functions[1].Scripts)

		end

	end)

	funcLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()

		funcFrameRef.CanvasSize = UDim2.new(0, 0, 0, funcLayout.AbsoluteContentSize.Y + 10)

	end)

	searchBoxRef:GetPropertyChangedSignal("Text"):Connect(function()

		local q = searchBoxRef.Text or ""

		if q == "" then

			if functions[1] and functions[1].Scripts then

				createButtons(functions[1].Scripts)

			end

		else

			local matches = filterScripts(q)

			createButtons(matches)

		end

	end)

	buildFuncButtons()

	if functions[1] and functions[1].Scripts then

		createButtons(functions[1].Scripts)

	end

	local function showFrame()

		frame.Visible = true

		frame.Size = UDim2.new(0, 0, 0, 0)

		frame.Position = UDim2.new(0.5, 0, 0.5, 0)

		TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {

			Size = UDim2.new(0, 420, 0, 260),

			Position = UDim2.new(0.5, -210, 0.5, -130),

		}):Play()

	end

	local function hideFrame()

		local tween = TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {

			Size = UDim2.new(0, 0, 0, 0),

			Position = UDim2.new(0.5, 0, 0.5, 0),

		})

		tween:Play()

		tween.Completed:Connect(function()

			frame.Visible = false

		end)

	end

	local function openOrClose()

		if not frame.Visible then

			showFrame()

		else

			hideFrame()

		end

	end

	local UserInputService = game:GetService("UserInputService")

	local isDragging = false

	local dragStartPos = nil

	local startPos = nil

	local CLICK_THRESHOLD = 6

	toggle.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then

			dragStartPos = input.Position

			startPos = toggle.Position

			isDragging = false

			local conn

			conn = input.Changed:Connect(function()

				if input.UserInputState == Enum.UserInputState.End then

					conn:Disconnect()

					if not isDragging then

						openOrClose()

					end

					dragStartPos = nil

					startPos = nil

				end

			end)

		end

	end)

	toggle.InputChanged:Connect(function(input)

		if not dragStartPos then return end

		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then

			local delta = input.Position - dragStartPos

			if math.abs(delta.X) > CLICK_THRESHOLD or math.abs(delta.Y) > CLICK_THRESHOLD then

				isDragging = true

				toggle.Position = UDim2.new(

					startPos.X.Scale,

					startPos.X.Offset + delta.X,

					startPos.Y.Scale,

					startPos.Y.Offset + delta.Y

				)

			end

		end

	end)

	close.Activated:Connect(hideFrame)

	close.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then

			hideFrame()

		end

	end)

end

typeConn = RunService.RenderStepped:Connect(function()

	local elapsed = tick() - startTime

	local progress = math.clamp(elapsed / typeDuration, 0, 1)

	local target = math.floor(progress * totalChars)

	if target > lastIndex then

		lastIndex = target

		textLabel.Text = table.concat(chars, "", 1, target)

	end

	if progress >= 1 then

		typeConn:Disconnect()

		task.wait(math.random(100,200)/100)

		textLabel.Text = ""

		local loadingLabel = Instance.new("TextLabel")

		loadingLabel.Size = UDim2.new(0,300,0,22)

		loadingLabel.AnchorPoint = Vector2.new(0.5,1)

		loadingLabel.Position = UDim2.new(0.5,0,0.5,-18)

		loadingLabel.BackgroundTransparency = 1

		loadingLabel.TextColor3 = Color3.fromRGB(255,0,0)

		loadingLabel.Font = Enum.Font.Code

		loadingLabel.TextSize = 18

		loadingLabel.TextXAlignment = Enum.TextXAlignment.Center

		loadingLabel.TextYAlignment = Enum.TextYAlignment.Center

		loadingLabel.Text = (currentLanguage == "vn") and "Đang tải: 0%" or "Loading: 0%"

		loadingLabel.Parent = bg

		local container = Instance.new("Frame")

		container.Size = UDim2.new(0.66,0,0,12)

		container.AnchorPoint = Vector2.new(0.5,0.5)

		container.Position = UDim2.new(0.5,0,0.5,0)

		container.BackgroundTransparency = 1

		container.Parent = bg

		local stroke = Instance.new("UIStroke")

		stroke.Parent = container

		stroke.Color = Color3.new(255,0,0)

		stroke.Thickness = 2

		stroke.Transparency = 0

		local fill = Instance.new("Frame")

		fill.Size = UDim2.new(0,0,1,0)

		fill.Position = UDim2.new(0,0,0,0)

		fill.AnchorPoint = Vector2.new(0,0)

		fill.BackgroundColor3 = Color3.new(255,0,0)

		fill.BorderSizePixel = 0

		fill.Parent = container

		local scan = Instance.new("Frame")

		scan.Size = UDim2.new(0,2,1,0)

		scan.Position = UDim2.new(0,0,0,0)

		scan.BackgroundColor3 = Color3.new(255,0,0)

		scan.BorderSizePixel = 0

		scan.Parent = container

		local percent = 0

		local pauseTimes = math.random(0,3)

		local pausePoints = {}

		for i = 1, pauseTimes do table.insert(pausePoints, math.random(10,95)) end

		table.sort(pausePoints)

		local usedPauses = 0

		local totalTime = math.random(1,3)

		local lastUpdate = tick()

		local loadingConn

		loadingConn = RunService.RenderStepped:Connect(function()

			if percent >= 100 then

				loadingConn:Disconnect()

				local tweenBg = TweenService:Create(bg, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})

				local tweenText = TweenService:Create(textLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {TextTransparency = 1})

				local tweenLoading = TweenService:Create(loadingLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {TextTransparency = 1})

				local tweenFill = TweenService:Create(fill, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})

				local tweenScan = TweenService:Create(scan, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})

				tweenBg:Play(); tweenText:Play(); tweenLoading:Play(); tweenFill:Play(); tweenScan:Play()

				tweenBg.Completed:Wait()

				if gui and gui.Parent then gui:Destroy() end

				startBom2devGUI()

				return

			end

			if usedPauses < #pausePoints and percent == pausePoints[usedPauses+1] then

				usedPauses = usedPauses + 1

				task.wait(math.random(1,2))

			end

			local now = tick()

			local delta = now - lastUpdate

			local step = math.max(1, math.ceil((delta / totalTime) * 100))

			percent = math.min(100, percent + step)

			loadingLabel.Text = ((currentLanguage == "vn") and "Đang tải: " or "Loading: ")..percent.."%"

			fill.Size = UDim2.new(percent/100, 0, 1, 0)

			scan.Position = UDim2.new(percent/100, 0, 0, 0)

			lastUpdate = now

		end)

	end

end)