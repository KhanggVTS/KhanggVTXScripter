local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

if game.PlaceId ~= 4924922222 then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚠️ SAI GAME",
        Text = "Vào Brookhaven mới xài được!",
        Duration = 5
    })
    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local VirtualInput = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents")
local CarRemote = RemoteEvents and RemoteEvents:FindFirstChild("Car")
local ToolsRemote = RemoteEvents and RemoteEvents:FindFirstChild("Tools")
local PlayerTriggerEvent = RemoteEvents and RemoteEvents:FindFirstChild("PlayerTriggerEvent")
local PlayersHouse = RemoteEvents and RemoteEvents:FindFirstChild("PlayersHouse")
local PlayersCar = RemoteEvents and RemoteEvents:FindFirstChild("PlayersCar")
local JobsRemote = RemoteEvents and RemoteEvents:FindFirstChild("Jobs")
local UpdateAvatar = RemoteEvents and RemoteEvents:FindFirstChild("UpdateAvatar")
local GunSounds = ReplicatedStorage:FindFirstChild("GunSounds")

local Toggles = {
    Fly = false,
    Noclip = false,
    Godmode = false,
    RainbowCar = false,
    RainbowHouse = false,
    LoopKill = false,
    LoopAnnoy = false,
    BrickSpam = false,
    AntiAFK = false
}

local Settings = {
    FlySpeed = 70,
    WalkSpeed = 32,
    JumpPower = 70
}

local SelectedPlayer = nil
local LoopConnections = {}

local function Notify(Title, Text, Duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = Title,
        Text = Text,
        Duration = Duration or 3
    })
end

local function GetCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function GetHumanoid()
    return GetCharacter():WaitForChild("Humanoid")
end

local function GetRootPart()
    return GetCharacter():WaitForChild("HumanoidRootPart")
end

local function GetAllPlayers()
    local list = {}
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            table.insert(list, v.Name)
        end
    end
    return list
end

local FlyBV = nil
local FlyConnection = nil

local function StartFly()
    local root = GetRootPart()
    if FlyBV then FlyBV:Destroy() end
    FlyBV = Instance.new("BodyVelocity")
    FlyBV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    FlyBV.Parent = root
    
    if FlyConnection then FlyConnection:Disconnect() end
    FlyConnection = RunService.RenderStepped:Connect(function()
        if not Toggles.Fly then return end
        local move = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.new(0, 0, -1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move + Vector3.new(0, 0, 1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move + Vector3.new(-1, 0, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.new(1, 0, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move + Vector3.new(0, -1, 0) end
        
        local camera = workspace.CurrentCamera
        FlyBV.Velocity = (camera.CFrame:VectorToWorldSpace(move) * Settings.FlySpeed)
    end)
end

local NoclipConnection = nil
local function StartNoclip()
    if NoclipConnection then NoclipConnection:Disconnect() end
    NoclipConnection = RunService.Stepped:Connect(function()
        if not Toggles.Noclip then return end
        local char = GetCharacter()
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end)
end

local function SetGodmode(enable)
    local hum = GetHumanoid()
    if enable then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        pcall(function()
            local head = GetCharacter():FindFirstChild("Head")
            if head then head:Destroy() end
        end)
    else
        hum.MaxHealth = 100
        hum.Health = 100
        hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
    end
end

local function SetSpeed(speed)
    GetHumanoid().WalkSpeed = speed
end

local function SetJumpPower(power)
    GetHumanoid().JumpPower = power
end

local function LagServer()
    Notify("🔥 LAG SERVER", "Đang spawn xe...", 3)
    local cars = {
        "RV", "FordGT", "FoodTruck", "CopSUV", "Van", "FireTruck", 
        "Ambulance", "Bus", "CopUnderCoverSUV", "QuadStock", "Challenger", 
        "Jeep", "CopChallenger", "Cadillac", "GolfCart", "NPHarleyDavison", 
        "Horse", "ScooterVehicle", "SmartCar", "CopMotor"
    }
    for i = 1, 50 do
        for _, car in pairs(cars) do
            pcall(function()
                CarRemote:FireServer("PickingCar", car)
            end)
        end
        task.wait()
    end
    Notify("✅ LAG SERVER", "Đã spawn 1000+ xe!", 3)
end

local function KillAllV1()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            pcall(function()
                PlayerTriggerEvent:FireServer("Client2Client", "Request: Piggyback!", player)
                task.wait(0.05)
                PlayerTriggerEvent:FireServer("BothWantPiggyBackRide", player)
            end)
        end
    end
    Notify("💀 KILL ALL", "Đã kill tất cả!", 2)
end

local function KillAllV2()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            pcall(function()
                local head = player.Character:FindFirstChild("Head")
                if head then head:Destroy() end
            end)
        end
    end
    Notify("💀 KILL ALL", "Đã headshot tất cả!", 2)
end

local function KillAllV3()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            pcall(function()
                PlayerTriggerEvent:FireServer("Client2Client", "Request: Carry!", player)
                task.wait(0.05)
                PlayerTriggerEvent:FireServer("BothWantCarryHurt", player)
                task.wait(0.05)
                PlayerTriggerEvent:FireServer("DropButtonStopAll", player)
            end)
        end
    end
    Notify("💀 KILL ALL", "Đã kill bằng carry!", 2)
end

local function KillPlayer(target)
    if not target then return end
    pcall(function()
        PlayerTriggerEvent:FireServer("Client2Client", "Request: Piggyback!", target)
        task.wait(0.05)
        PlayerTriggerEvent:FireServer("BothWantPiggyBackRide", target)
    end)
    Notify("💀 KILL", "Đã kill " .. target.Name, 2)
end

local function FreezePlayer(target)
    if not target then return end
    pcall(function()
        PlayerTriggerEvent:FireServer("Client2Client", "Request: Piggyback!", target)
        task.wait(0.05)
        PlayerTriggerEvent:FireServer("BothWantPiggyBackRide", target)
        task.wait(0.05)
        PlayerTriggerEvent:FireServer("BothWantPiggyBackRide", target)
        task.wait(0.05)
        PlayerTriggerEvent:FireServer("DropButtonStopAll", target)
        if target.Character then
            target.Character.HumanoidRootPart.Anchored = true
        end
    end)
    Notify("❄️ FREEZE", "Đã freeze " .. target.Name, 2)
end

local function BringPlayer(target)
    if not target or not target.Character then return end
    local oldPos = GetRootPart().Position
    pcall(function()
        PlayerTriggerEvent:FireServer("Client2Client", "Request: Carry!", target)
        task.wait(0.05)
        PlayerTriggerEvent:FireServer("BothWantCarryHurt", target)
        task.wait(0.05)
        PlayerTriggerEvent:FireServer("DropButtonStopAll", target)
        task.wait(0.05)
        PlayerTriggerEvent:FireServer("BothWantCarryHurt", LocalPlayer)
        task.wait(0.05)
        PlayerTriggerEvent:FireServer("DropButtonStopAll", LocalPlayer)
        GetRootPart().CFrame = CFrame.new(oldPos)
    end)
    Notify("📦 BRING", "Đã kéo " .. target.Name, 2)
end

local function SkydivePlayer(target)
    if not target or not target.Character then return end
    pcall(function()
        PlayerTriggerEvent:FireServer("Client2Client", "Request: Carry!", target)
        task.wait(0.05)
        PlayerTriggerEvent:FireServer("BothWantCarryHurt", target)
        task.wait(0.05)
        PlayerTriggerEvent:FireServer("DropButtonStopAll", target)
        task.wait(0.05)
        PlayerTriggerEvent:FireServer("BothWantCarryHurt", LocalPlayer)
        task.wait(0.05)
        PlayerTriggerEvent:FireServer("DropButtonStopAll", LocalPlayer)
        task.wait(0.1)
        if target.Character then
            target.Character.Humanoid:Destroy()
            target.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 20000, 0)
        end
    end)
    Notify("🪂 SKYDIVE", "Đã ném " .. target.Name .. " lên trời!", 2)
end

local function StartLoopKill(target)
    if not target then return end
    Toggles.LoopKill = true
    local conn = RunService.RenderStepped:Connect(function()
        if Toggles.LoopKill and target and target.Character then
            pcall(function()
                PlayerTriggerEvent:FireServer("Client2Client", "Request: Piggyback!", target)
                task.wait(0.05)
                PlayerTriggerEvent:FireServer("BothWantPiggyBackRide", target)
            end)
        end
    end)
    table.insert(LoopConnections, conn)
    Notify("🔁 LOOP KILL", "Đang loop kill " .. target.Name, 2)
end

local function StopLoopKill()
    Toggles.LoopKill = false
    Notify("🔁 LOOP KILL", "Đã dừng loop kill", 2)
end

local function StartLoopAnnoy()
    Toggles.LoopAnnoy = true
    local conn = RunService.RenderStepped:Connect(function()
        if Toggles.LoopAnnoy then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    pcall(function()
                        PlayerTriggerEvent:FireServer("Client2Client", "Request: Piggyback!", player)
                        task.wait(0.05)
                        PlayerTriggerEvent:FireServer("BothWantPiggyBackRide", player)
                    end)
                end
            end
        end
    end)
    table.insert(LoopConnections, conn)
    Notify("🔁 LOOP ANNOY", "Đang làm phiền tất cả!", 2)
end

local function StopLoopAnnoy()
    Toggles.LoopAnnoy = false
    Notify("🔁 LOOP ANNOY", "Đã dừng làm phiền", 2)
end

local Tools = {
    "Money", "DuffleBagMoney", "Coke", "Stroller", "Hairbrush", "Sign", 
    "Roses", "SoccerBall", "Assault", "Bomb", "Shovel", "Iphone", 
    "Camcorder", "BabyBoy", "BabyGirl", "Wagon", "Syringe", "Ear", 
    "Trophy", "Taser", "SWATShield", "Cuffs", "Glock", "Shotgun", 
    "Sniper", "CreditCardBoy", "CreditCardGirl", "Umbrella", "Present", 
    "Apple", "Chips", "Bloxaide", "Milk"
}

local ToolIDs = {
    Money = "4535110571",
    DuffleBagMoney = "4587924680",
    Coke = "4548052009",
    Stroller = "4529218345",
    Hairbrush = "5480682123",
    Sign = "6001822792",
    Roses = "5211788490",
    SoccerBall = "4598172149",
    Assault = "4529288610",
    Bomb = "4587924290",
    Shovel = "4617189079"
}

local function GiveToolToAll(toolName)
    for _, player in pairs(Players:GetPlayers()) do
        pcall(function()
            PlayerTriggerEvent:FireServer("ToolGiveToServer", player, "http://www.roblox.com/asset/?id=" .. ToolIDs[toolName], toolName)
        end)
    end
    Notify("🎁 GIVE TOOL", "Đã give " .. toolName .. " cho tất cả!", 2)
end

local function GiveToolToSelf(toolName)
    pcall(function()
        ToolsRemote:InvokeServer("PickingTools", toolName)
    end)
    Notify("🎁 GIVE TOOL", "Đã lấy " .. toolName, 2)
end

local Cars = {
    "ScooterVehicle", "NPHarleyDavison", "Cadillac", "CopChallenger", 
    "Challenger", "Bus", "Jeep", "FireTruck", "CopUnderCoverSUV", 
    "GolfCart", "Van", "FordGT", "CopSUV", "RV", "FoodTruck", 
    "Ambulance", "QuadStock", "SmartCar", "CopMotor", "Horse"
}

local function SpawnCar(carName)
    pcall(function()
        CarRemote:FireServer("PickingCar", carName)
    end)
    Notify("🚗 SPAWN CAR", "Đã spawn " .. carName, 2)
end

local RainbowColors = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 127, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(75, 0, 130),
    Color3.fromRGB(148, 0, 211)
}

local RainbowCarConnection = nil
local function StartRainbowCar()
    if RainbowCarConnection then RainbowCarConnection:Disconnect() end
    local colorIndex = 1
    RainbowCarConnection = RunService.RenderStepped:Connect(function()
        if Toggles.RainbowCar then
            pcall(function()
                PlayersCar:FireServer("PickingCarColor", RainbowColors[colorIndex])
            end)
            colorIndex = colorIndex % #RainbowColors + 1
            task.wait(0.1)
        end
    end)
end

local RainbowHouseConnection = nil
local function StartRainbowHouse()
    if RainbowHouseConnection then RainbowHouseConnection:Disconnect() end
    local colorIndex = 1
    RainbowHouseConnection = RunService.RenderStepped:Connect(function()
        if Toggles.RainbowHouse then
            pcall(function()
                PlayersHouse:FireServer("PickingHouseColor", RainbowColors[colorIndex])
            end)
            colorIndex = colorIndex % #RainbowColors + 1
            task.wait(0.1)
        end
    end)
end

local Tags = {
    {name = "Admin Tag", id = "782790468"},
    {name = "Admin Tag 2", id = "105095367"},
    {name = "VIP Tag", id = "1292335373"},
    {name = "Mega VIP", id = "1255544221"},
    {name = "Ultra VIP", id = "1292342698"},
    {name = "VIP", id = "32578003"},
    {name = "Moderator", id = "415986666"},
    {name = "Owner", id = "2980546857"},
    {name = "Creator", id = "2497143214"},
    {name = "Brookhaven Logo", id = "6336646536"},
    {name = "Pikachu", id = "1473416194"},
    {name = "Hacker Face", id = "3284478282"},
    {name = "Scary Pikachu", id = "127039538"},
    {name = "HD Tag", id = "2821573888"},
    {name = "Old Roblox Logo", id = "148012526"},
    {name = "Roblox Admin", id = "1151106808"},
    {name = "Diamond", id = "4424298"},
    {name = "Hacking", id = "626372353"},
    {name = "Nascar Car", id = "463277467"},
    {name = "Girl Face", id = "555878469"},
    {name = "Wall Tag", id = "1844422643"},
    {name = "Meme", id = "261677904"},
    {name = "Coffee Meme", id = "261676710"},
    {name = "Scary Face", id = "1243374078"},
    {name = "2 Eye", id = "5839301773"},
    {name = "Scary Tag", id = "2120834873"},
    {name = "Smiley Face", id = "333476199"},
    {name = "Scary Dog", id = "5817435822"},
    {name = "Scary Cat", id = "23355113"}
}

local function SetTag(tagId)
    pcall(function()
        JobsRemote:FireServer("GiveJobUIMenu", tagId, "Made by You", true)
    end)
    Notify("🏷️ TAG", "Đã đặt tag ID: " .. tagId, 2)
end

local BrickSpamConnection = nil
local function StartBrickSpam()
    if BrickSpamConnection then BrickSpamConnection:Disconnect() end
    BrickSpamConnection = RunService.RenderStepped:Connect(function()
        if Toggles.BrickSpam then
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                pcall(function()
                    GetCharacter().Humanoid:EquipTool(tool)
                    if tool:FindFirstChild("Handle") then
                        tool.Handle.Mesh:Destroy()
                    end
                    tool.Parent = workspace
                end)
            end
        end
    end)
end

local function StartAntiAFK()
    LocalPlayer.Idled:Connect(function()
        if Toggles.AntiAFK then
            VirtualInput:SendKeyEvent(true, "W", false, game)
            task.wait(0.1)
            VirtualInput:SendKeyEvent(false, "W", false, game)
        end
    end)
end

local function SpawnItemSpam()
    for i = 1, 100 do
        pcall(function()
            ToolsRemote:InvokeServer("PickingTools", "Taser")
        end)
        task.wait()
    end
    Notify("🔫 SPAWN ITEM", "Đã spawn 100 item!", 2)
end

local Window = Rayfield:CreateWindow({
    Name = "🔥 BROOKHAVEN ULTIMATE",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Mày",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BrookhavenUltimate",
        FileName = "Config"
    }
})

local MainTab = Window:CreateTab("🏠 MAIN")
MainTab:CreateSection("🚀 Movement")
MainTab:CreateToggle({Name = "Fly", CurrentValue = false, Callback = function(v) Toggles.Fly = v if v then StartFly() end end})
MainTab:CreateSlider({Name = "Fly Speed", Range = {10, 200}, CurrentValue = 70, Callback = function(v) Settings.FlySpeed = v end})
MainTab:CreateToggle({Name = "Noclip", CurrentValue = false, Callback = function(v) Toggles.Noclip = v StartNoclip() end})
MainTab:CreateToggle({Name = "Godmode", CurrentValue = false, Callback = function(v) Toggles.Godmode = v SetGodmode(v) end})
MainTab:CreateSlider({Name = "Walk Speed", Range = {16, 120}, CurrentValue = 32, Callback = function(v) Settings.WalkSpeed = v SetSpeed(v) end})
MainTab:CreateSlider({Name = "Jump Power", Range = {50, 300}, CurrentValue = 70, Callback = function(v) Settings.JumpPower = v SetJumpPower(v) end})

local CombatTab = Window:CreateTab("⚔️ COMBAT")
CombatTab:CreateSection("👥 Player Select")
local playerOptions = GetAllPlayers()
local PlayerDropdown = CombatTab:CreateDropdown({Name = "Select Player", Options = playerOptions, Callback = function(v)
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name == v then SelectedPlayer = p break end
    end
end})
CombatTab:CreateSection("💀 Kill Options")
CombatTab:CreateButton({Name = "Kill Player", Callback = function() if SelectedPlayer then KillPlayer(SelectedPlayer) end end})
CombatTab:CreateButton({Name = "Kill All V1", Callback = function() KillAllV1() end})
CombatTab:CreateButton({Name = "Kill All V2", Callback = function() KillAllV2() end})
CombatTab:CreateButton({Name = "Kill All V3", Callback = function() KillAllV3() end})
CombatTab:CreateSection("❄️ Control Options")
CombatTab:CreateButton({Name = "Freeze Player", Callback = function() if SelectedPlayer then FreezePlayer(SelectedPlayer) end end})
CombatTab:CreateButton({Name = "Bring Player", Callback = function() if SelectedPlayer then BringPlayer(SelectedPlayer) end end})
CombatTab:CreateButton({Name = "Skydive Player", Callback = function() if SelectedPlayer then SkydivePlayer(SelectedPlayer) end end})
CombatTab:CreateSection("🔄 Loop Options")
CombatTab:CreateToggle({Name = "Loop Kill Player", CurrentValue = false, Callback = function(v) if v then StartLoopKill(SelectedPlayer) else StopLoopKill() end end})
CombatTab:CreateToggle({Name = "Loop Annoy All", CurrentValue = false, Callback = function(v) if v then StartLoopAnnoy() else StopLoopAnnoy() end end})

local ToolsTab = Window:CreateTab("🔧 TOOLS")
ToolsTab:CreateSection("🎁 Give Tools")
ToolsTab:CreateDropdown({Name = "Select Tool", Options = Tools, Callback = function(v) GiveToolToSelf(v) end})
ToolsTab:CreateButton({Name = "Spawn Item Spam", Callback = function() SpawnItemSpam() end})
ToolsTab:CreateButton({Name = "Brick Spam", Callback = function() Toggles.BrickSpam = not Toggles.BrickSpam StartBrickSpam() end})

local CarsTab = Window:CreateTab("🚗 CARS")
CarsTab:CreateSection("🚙 Spawn Cars")
CarsTab:CreateDropdown({Name = "Select Car", Options = Cars, Callback = function(v) SpawnCar(v) end})
CarsTab:CreateButton({Name = "Lag Server", Callback = function() LagServer() end})
CarsTab:CreateSection("🌈 Rainbow")
CarsTab:CreateToggle({Name = "Rainbow Car", CurrentValue = false, Callback = function(v) Toggles.RainbowCar = v if v then StartRainbowCar() end end})
CarsTab:CreateToggle({Name = "Rainbow House", CurrentValue = false, Callback = function(v) Toggles.RainbowHouse = v if v then StartRainbowHouse() end end})

local TagsTab = Window:CreateTab("🏷️ TAGS")
TagsTab:CreateSection("✨ Tags")
for _, tag in pairs(Tags) do
    TagsTab:CreateButton({Name = tag.name, Callback = function() SetTag(tag.id) end})
end
TagsTab:CreateSection("🎨 Custom Tag")
TagsTab:CreateInput({Name = "Custom Image ID", PlaceholderText = "Nhập ID...", Callback = function(v) if v ~= "" then SetTag(v) end end})

local UtilityTab = Window:CreateTab("🛠️ UTILITY")
UtilityTab:CreateSection("💰 Gamepass")
UtilityTab:CreateButton({Name = "Unlock All Gamepasses", Callback = function()
    local passes = {"Premium", "Horse", "Fire", "Speed", "Estate", "Land Unlocked", "Vehicle Upgrades"}
    for _, pass in pairs(passes) do
        pcall(function() RemoteEvents.PlayersHouse:FireServer("PickingGamepass", pass) end)
    end
    Notify("✅ GAMEPASS", "Đã mở tất cả!", 3)
end})
UtilityTab:CreateSection("🔄 Server")
UtilityTab:CreateButton({Name = "Rejoin", Callback = function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end})
UtilityTab:CreateButton({Name = "Reset Character", Callback = function() GetHumanoid():Destroy() end})
UtilityTab:CreateSection("🎨 Avatar")
UtilityTab:CreateButton({Name = "Clown Head", Callback = function() pcall(function() UpdateAvatar:FireServer("wear", 4272833564) end) end})
UtilityTab:CreateSection("🛡️ Anti")
UtilityTab:CreateToggle({Name = "Anti AFK", CurrentValue = false, Callback = function(v) Toggles.AntiAFK = v if v then StartAntiAFK() end end})

local MusicTab = Window:CreateTab("🎵 MUSIC")
MusicTab:CreateSection("🔫 Gun Music")
MusicTab:CreateInput({Name = "Play Song (ID)", PlaceholderText = "Nhập music ID...", Callback = function(v)
    if v ~= "" then
        pcall(function()
            ToolsRemote:InvokeServer("PickingTools", "Sniper")
            task.wait(0.1)
            local tool = GetCharacter():FindFirstChild("Sniper")
            if tool and tool:FindFirstChild("Handle") then
                GunSounds:FireServer(tool.Handle, v, 1)
            end
        end)
    end
end})
MusicTab:CreateSection("🏠 House Music")
MusicTab:CreateInput({Name = "House Song (ID)", PlaceholderText = "Nhập music ID...", Callback = function(v)
    if v ~= "" then
        pcall(function() PlayersHouse:FireServer("PickingHouseMusicText", v) end)
    end
end})

Players.PlayerAdded:Connect(function()
    PlayerDropdown:SetOptions(GetAllPlayers())
end)
Players.PlayerRemoving:Connect(function()
    PlayerDropdown:SetOptions(GetAllPlayers())
end)

Notify("✅ BROOKHAVEN ULTIMATE", "Đã load! Nhấn Insert để mở menu", 5)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        Rayfield:Toggle()
    end
end)

print("✅ Brookhaven Ultimate - Da chay!")