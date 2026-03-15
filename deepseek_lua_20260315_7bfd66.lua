-- ===== SCRIPT BLOX FRUITS PRIVATE SERVER - FULL =====
-- Bản quyền: Dành cho mày chơi một mình

-- ===== KHỞI TẠO =====
print("🚀 ĐANG TẢI BLOX FRUITS PRIVATE SERVER...")
print("⭐ SPAWN TRÊN TRỜI + TOOL KHỞI ĐẦU + FULL MAP")

-- Xóa map cũ
for i, v in pairs(workspace:GetChildren()) do
    if v:IsA("Part") and v:GetAttribute("BloxFruits") then
        v:Destroy()
    end
end

-- ===== HÀM TẠO OBJECT =====
local function createPart(name, pos, size, color, material, transparency)
    local part = Instance.new("Part")
    part.Name = name
    part.Position = pos or Vector3.new(0, 10, 0)
    part.Size = size or Vector3.new(4, 1, 4)
    part.BrickColor = BrickColor.new(color or "Bright red")
    part.Material = material or Enum.Material.SmoothPlastic
    part.Anchored = true
    part.CanCollide = true
    part.Transparency = transparency or 0
    part:SetAttribute("BloxFruits", true)
    part.Parent = workspace
    return part
end

local function createClickDetector(part, callback)
    local click = Instance.new("ClickDetector")
    click.Parent = part
    click.MaxActivationDistance = 30
    
    click.MouseClick:Connect(function(player)
        if callback then
            callback(player)
        end
    end)
    
    -- BillboardGui hiển thị tên
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "NameGui"
    billboard.Parent = part
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    
    local text = Instance.new("TextLabel")
    text.Parent = billboard
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.new(1, 1, 1)
    text.TextStrokeTransparency = 0
    text.TextScaled = true
    text.Font = Enum.Font.GothamBold
    text.Text = "[" .. part.Name .. "]"
end

-- ===== TẠO LEADERSTATS CHO NGƯỜI CHƠI =====
game.Players.PlayerAdded:Connect(function(player)
    local folder = Instance.new("Folder")
    folder.Name = "Leaderstats"
    folder.Parent = player
    
    local level = Instance.new("NumberValue")
    level.Name = "Level"
    level.Value = 1
    level.Parent = folder
    
    local fruit = Instance.new("StringValue")
    fruit.Name = "Fruit"
    fruit.Value = "None"
    fruit.Parent = folder
    
    local beli = Instance.new("NumberValue")
    beli.Name = "Beli"
    beli.Value = 5000
    beli.Parent = folder
    
    -- Teleport người chơi lên spawn khi vào game
    player.CharacterAdded:Connect(function(char)
        wait(1)
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(0, 1000, 0)
        end
    end)
end)

-- ===========================================
-- ===== 1. KHU VỰC SPAWN TRÊN TRỜI =====
-- ===========================================
local spawnPos = Vector3.new(0, 1000, 0)
print("📍 SPAWN TRÊN TRỜI: " .. tostring(spawnPos))

-- Nền spawn
local spawnPlatform = createPart("Spawn Platform", 
    spawnPos, 
    Vector3.new(40, 2, 40), 
    "Bright yellow", 
    Enum.Material.Neon,
    0.2
)

-- Viền spawn phát sáng
for i = 1, 360, 30 do
    local rad = math.rad(i)
    local x = math.cos(rad) * 22
    local z = math.sin(rad) * 22
    createPart("Spawn Light", 
        spawnPos + Vector3.new(x, 3, z), 
        Vector3.new(1, 1, 1), 
        "Cyan", 
        Enum.Material.Neon,
        0.1
    )
end

-- Cổng teleport xuống đảo chính
local teleportGate = createPart("⏩ TELEPORT TO MAIN ISLAND", 
    spawnPos + Vector3.new(0, 5, 15), 
    Vector3.new(8, 10, 2), 
    "Bright blue", 
    Enum.Material.Neon,
    0.2
)

createClickDetector(teleportGate, function(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 500, 0)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Teleport",
            Text = "Đã đến đảo chính!",
            Duration = 2
        })
    end
end)

-- Bảng hướng dẫn
local guideBoard = createPart("📋 GUIDE BOARD", 
    spawnPos + Vector3.new(0, 8, -10), 
    Vector3.new(12, 6, 1), 
    "Brown", 
    Enum.Material.Wood
)

local guideTexts = {
    "📌 HƯỚNG DẪN SPAWN",
    "1. Click vào vũ khí để nhận",
    "2. Thử nghiệm combat ở đây",
    "3. Qua cổng xanh xuống đảo chính",
    "4. Mua đồ nâng cấp ở shop",
    "5. Đánh boss kiếm đồ hiếm"
}

for i, text in ipairs(guideTexts) do
    local yPos = 3 - (i-1) * 0.8
    local textPart = createPart("Guide Line " .. i, 
        guideBoard.Position + Vector3.new(0, yPos, 0.6), 
        Vector3.new(11, 0.5, 0.2), 
        "White", 
        Enum.Material.Neon,
        0.5
    )
end

-- ===== TOOL COMBAT KHỞI ĐẦU =====
print("⚔️ ĐANG TẠO TOOL KHỞI ĐẦU...")

-- === KIẾM KHỞI ĐẦU ===
local starterSwordPos = spawnPos + Vector3.new(-8, 4, -5)
local swordPedestal = createPart("Sword Pedestal", 
    starterSwordPos - Vector3.new(0, 2, 0), 
    Vector3.new(3, 1, 3), 
    "Dark stone grey", 
    Enum.Material.Stone
)

local starterSword = createPart("🗡️ STARTER SWORD", 
    starterSwordPos, 
    Vector3.new(1, 4, 1), 
    "Silver", 
    Enum.Material.Metal
)

local swordBlade = createPart("Sword Blade", 
    starterSwordPos + Vector3.new(0, 2.5, 0), 
    Vector3.new(0.4, 3, 0.4), 
    "Cyan", 
    Enum.Material.Neon,
    0.1
)

createClickDetector(starterSword, function(player)
    -- Kiểm tra đã có chưa
    for _, tool in pairs(player.Backpack:GetChildren()) do
        if tool.Name == "Starter Sword" then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Thông báo",
                Text = "Bạn đã có kiếm rồi!",
                Duration = 2
            })
            return
        end
    end
    
    -- Tạo tool kiếm
    local tool = Instance.new("Tool")
    tool.Name = "Starter Sword"
    tool.Parent = player.Backpack
    tool.Grip = CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 0)
    tool.CanBeDropped = false
    tool.RequiresHandle = true
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 4, 1)
    handle.BrickColor = BrickColor.new("Silver")
    handle.Material = Enum.Material.Metal
    handle.Parent = tool
    
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.4, 3, 0.4)
    blade.BrickColor = BrickColor.new("Cyan")
    blade.Material = Enum.Material.Neon
    blade.Parent = tool
    
    -- Sát thương
    tool.Activated:Connect(function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- Hiệu ứng chém
            local slash = Instance.new("Part")
            slash.Size = Vector3.new(4, 1, 4)
            slash.Position = char.HumanoidRootPart.Position + char.HumanoidRootPart.CFrame.LookVector * 6
            slash.BrickColor = BrickColor.new("Cyan")
            slash.Material = Enum.Material.Neon
            slash.Anchored = true
            slash.Transparency = 0.3
            slash.Parent = workspace
            game:GetService("Debris"):AddItem(slash, 0.2)
            
            -- Tìm enemy gần nhất
            for _, obj in pairs(workspace:GetChildren()) do
                if obj:IsA("Part") and obj.Name:find("Enemy") then
                    local dist = (obj.Position - char.HumanoidRootPart.Position).Magnitude
                    if dist < 15 then
                        obj:Destroy()
                        if player:FindFirstChild("Leaderstats") then
                            player.Leaderstats.Beli.Value = player.Leaderstats.Beli.Value + 30
                        end
                        break
                    end
                end
            end
        end
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Nhận Starter Sword",
        Text = "Sát thương 30 | FREE",
        Duration = 2
    })
end)

-- === SÚNG KHỞI ĐẦU ===
local starterGunPos = spawnPos + Vector3.new(0, 4, -5)
local gunPedestal = createPart("Gun Pedestal", 
    starterGunPos - Vector3.new(0, 2, 0), 
    Vector3.new(3, 1, 3), 
    "Dark stone grey", 
    Enum.Material.Stone
)

local starterGun = createPart("🔫 STARTER GUN", 
    starterGunPos, 
    Vector3.new(1.2, 0.8, 3), 
    "Dark grey", 
    Enum.Material.Metal
)

local gunBarrel = createPart("Gun Barrel", 
    starterGunPos + Vector3.new(0, 0, 2), 
    Vector3.new(0.5, 0.5, 1.5), 
    "Black", 
    Enum.Material.Metal
)

createClickDetector(starterGun, function(player)
    for _, tool in pairs(player.Backpack:GetChildren()) do
        if tool.Name == "Starter Gun" then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Thông báo",
                Text = "Bạn đã có súng rồi!",
                Duration = 2
            })
            return
        end
    end
    
    local tool = Instance.new("Tool")
    tool.Name = "Starter Gun"
    tool.Parent = player.Backpack
    tool.Grip = CFrame.new(0, 0, 0)
    tool.CanBeDropped = false
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1.2, 0.8, 3)
    handle.BrickColor = BrickColor.new("Dark grey")
    handle.Material = Enum.Material.Metal
    handle.Parent = tool
    
    tool.Activated:Connect(function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local dir = char.HumanoidRootPart.CFrame.LookVector
            
            local bullet = Instance.new("Part")
            bullet.Size = Vector3.new(0.3, 0.3, 0.3)
            bullet.Position = char.HumanoidRootPart.Position + dir * 3 + Vector3.new(0, 1, 0)
            bullet.BrickColor = BrickColor.new("Bright yellow")
            bullet.Material = Enum.Material.Neon
            bullet.Anchored = false
            bullet.CanCollide = false
            bullet.Velocity = dir * 200
            bullet.Parent = workspace
            game:GetService("Debris"):AddItem(bullet, 2)
            
            bullet.Touched:Connect(function(hit)
                if hit.Name:find("Enemy") then
                    hit:Destroy()
                    bullet:Destroy()
                    if player:FindFirstChild("Leaderstats") then
                        player.Leaderstats.Beli.Value = player.Leaderstats.Beli.Value + 30
                    end
                end
            end)
        end
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Nhận Starter Gun",
        Text = "Súng bắn xa | FREE",
        Duration = 2
    })
end)

-- === NẮM ĐẤM KHỞI ĐẦU ===
local starterFistPos = spawnPos + Vector3.new(8, 4, -5)
local fistPedestal = createPart("Fist Pedestal", 
    starterFistPos - Vector3.new(0, 2, 0), 
    Vector3.new(3, 1, 3), 
    "Dark stone grey", 
    Enum.Material.Stone
)

local starterFist = createPart("👊 STARTER FIST", 
    starterFistPos, 
    Vector3.new(2, 2, 2), 
    "Bright red", 
    Enum.Material.Neon,
    0.1
)

createClickDetector(starterFist, function(player)
    for _, tool in pairs(player.Backpack:GetChildren()) do
        if tool.Name == "Starter Fist" then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Thông báo",
                Text = "Bạn đã có nắm đấm rồi!",
                Duration = 2
            })
            return
        end
    end
    
    local tool = Instance.new("Tool")
    tool.Name = "Starter Fist"
    tool.Parent = player.Backpack
    tool.Grip = CFrame.new(0, 0, 0)
    tool.CanBeDropped = false
    
    local fist = Instance.new("Part")
    fist.Name = "Handle"
    fist.Size = Vector3.new(2, 2, 2)
    fist.BrickColor = BrickColor.new("Bright red")
    fist.Material = Enum.Material.Neon
    fist.Parent = tool
    
    local combo = 0
    tool.Activated:Connect(function()
        combo = combo + 1
        if combo > 3 then combo = 1 end
        
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local punch = Instance.new("Part")
            punch.Size = Vector3.new(3, 3, 3)
            punch.Position = char.HumanoidRootPart.Position + char.HumanoidRootPart.CFrame.LookVector * 5
            punch.BrickColor = BrickColor.new("Bright red")
            punch.Material = Enum.Material.Neon
            punch.Anchored = true
            punch.Transparency = 0.3
            punch.Parent = workspace
            game:GetService("Debris"):AddItem(punch, 0.1)
            
            for _, obj in pairs(workspace:GetChildren()) do
                if obj:IsA("Part") and obj.Name:find("Enemy") then
                    local dist = (obj.Position - char.HumanoidRootPart.Position).Magnitude
                    if dist < 10 then
                        obj:Destroy()
                        if player:FindFirstChild("Leaderstats") then
                            player.Leaderstats.Beli.Value = player.Leaderstats.Beli.Value + 20 * combo
                        end
                        break
                    end
                end
            end
        end
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Nhận Starter Fist",
        Text = "Combo x3 sát thương tăng dần | FREE",
        Duration = 3
    })
end)

-- ===== ENEMY TẬP LUYỆN Ở SPAWN =====
for i = 1, 5 do
    local enemyPos = spawnPos + Vector3.new(math.random(-15, 15), 3, math.random(5, 20))
    local enemy = createPart("Enemy Training Dummy", 
        enemyPos, 
        Vector3.new(2, 3, 1.5), 
        "Bright red", 
        Enum.Material.SmoothPlastic
    )
    
    local enemyHead = createPart("Enemy Head", 
        enemyPos + Vector3.new(0, 2.5, 0), 
        Vector3.new(1.5, 1.5, 1.5), 
        "Pastel yellow", 
        Enum.Material.SmoothPlastic
    )
end

-- ===========================================
-- ===== 2. ĐẢO CHÍNH =====
-- ===========================================
local mainPos = Vector3.new(0, 500, 0)
print("📍 ĐẢO CHÍNH: " .. tostring(mainPos))

-- Nền đảo chính
createPart("Main Island", 
    mainPos, 
    Vector3.new(150, 20, 150), 
    "Earth green", 
    Enum.Material.Grass
)

-- Núi
createPart("Mountain", 
    mainPos + Vector3.new(40, 25, 30), 
    Vector3.new(30, 40, 30), 
    "Dark stone grey", 
    Enum.Material.Slate
)

createPart("Mountain", 
    mainPos + Vector3.new(-30, 20, -40), 
    Vector3.new(25, 30, 25), 
    "Dark stone grey", 
    Enum.Material.Slate
)

-- Biển xung quanh (mây)
for i = 1, 12 do
    local angle = (i / 12) * math.pi * 2
    local x = math.cos(angle) * 100
    local z = math.sin(angle) * 100
    createPart("Cloud", 
        mainPos + Vector3.new(x, 10, z), 
        Vector3.new(30, 2, 30), 
        "White", 
        Enum.Material.Snow,
        0.4
    )
end

-- ===== SHOP =====
local shopPos = mainPos + Vector3.new(50, 25, 40)
local shop = createPart("🏪 SHOP", 
    shopPos, 
    Vector3.new(10, 10, 10), 
    "Bright green", 
    Enum.Material.Neon
)

-- Shop 1: Kiếm nâng cấp
local swordShop = createPart("Sword Shop", 
    shopPos + Vector3.new(-8, 5, 8), 
    Vector3.new(4, 4, 4), 
    "Silver", 
    Enum.Material.Metal
)

local swords = {
    {name = "Iron Katana", dmg = 50, price = 2000, pos = shopPos + Vector3.new(-12, 5, 12)},
    {name = "Steel Saber", dmg = 100, price = 5000, pos = shopPos + Vector3.new(-12, 5, 8)},
    {name = "Dragon Slayer", dmg = 200, price = 15000, pos = shopPos + Vector3.new(-12, 5, 4)}
}

for _, sword in ipairs(swords) do
    local s = createPart(sword.name, 
        sword.pos, 
        Vector3.new(0.8, 3, 0.8), 
        "Bright red", 
        Enum.Material.Metal
    )
    
    createClickDetector(s, function(player)
        if player.Leaderstats.Beli.Value >= sword.price then
            player.Leaderstats.Beli.Value = player.Leaderstats.Beli.Value - sword.price
            
            -- Tạo tool
            local tool = Instance.new("Tool")
            tool.Name = sword.name
            tool.Parent = player.Backpack
            tool.Grip = CFrame.new(0, -1.5, 0)
            tool.CanBeDropped = false
            
            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(0.8, 3, 0.8)
            handle.BrickColor = BrickColor.new("Bright red")
            handle.Material = Enum.Material.Metal
            handle.Parent = tool
            
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Mua thành công",
                Text = sword.name .. " - DMG: " .. sword.dmg,
                Duration = 3
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Không đủ tiền",
                Text = "Cần $" .. sword.price,
                Duration = 2
            })
        end
    end)
end

-- Shop 2: Súng nâng cấp
local gunShop = createPart("Gun Shop", 
    shopPos + Vector3.new(8, 5, 8), 
    Vector3.new(4, 4, 4), 
    "Dark grey", 
    Enum.Material.Metal
)

local guns = {
    {name = "Musket", dmg = 80, price = 4000, pos = shopPos + Vector3.new(12, 5, 12)},
    {name = "Flintlock", dmg = 150, price = 10000, pos = shopPos + Vector3.new(12, 5, 8)},
    {name = "Dragon Cannon", dmg = 300, price = 30000, pos = shopPos + Vector3.new(12, 5, 4)}
}

for _, gun in ipairs(guns) do
    local g = createPart(gun.name, 
        gun.pos, 
        Vector3.new(1, 0.8, 2.5), 
        "Black", 
        Enum.Material.Metal
    )
    
    createClickDetector(g, function(player)
        if player.Leaderstats.Beli.Value >= gun.price then
            player.Leaderstats.Beli.Value = player.Leaderstats.Beli.Value - gun.price
            
            local tool = Instance.new("Tool")
            tool.Name = gun.name
            tool.Parent = player.Backpack
            tool.CanBeDropped = false
            
            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(1, 0.8, 2.5)
            handle.BrickColor = BrickColor.new("Black")
            handle.Material = Enum.Material.Metal
            handle.Parent = tool
            
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Mua thành công",
                Text = gun.name .. " - DMG: " .. gun.dmg,
                Duration = 3
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Không đủ tiền",
                Text = "Cần $" .. gun.price,
                Duration = 2
            })
        end
    end)
end

-- ===== BOSS =====
local bossPos = mainPos + Vector3.new(-40, 25, -40)
local boss = createPart("👑 SABER BOSS", 
    bossPos, 
    Vector3.new(4, 8, 3), 
    "Really black", 
    Enum.Material.Slate
)

local bossHead = createPart("Boss Head", 
    bossPos + Vector3.new(0, 5, 0), 
    Vector3.new(2.5, 2.5, 2.5), 
    "Dark orange", 
    Enum.Material.SmoothPlastic
)

local bossSword = createPart("Boss Sword", 
    bossPos + Vector3.new(3, 4, 0), 
    Vector3.new(4, 1, 0.5), 
    "Bright red", 
    Enum.Material.Neon
)

local bossHealth = 5000
local bossHealthBar = createPart("Boss Health", 
    bossPos + Vector3.new(0, 10, 0), 
    Vector3.new(10, 1, 1), 
    "Bright red", 
    Enum.Material.Neon
)

createClickDetector(boss, function(player)
    local dmg = math.random(100, 300)
    bossHealth = bossHealth - dmg
    bossHealthBar.Size = Vector3.new((bossHealth/5000)*10, 1, 1)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Đánh Boss",
        Text = "Gây " .. dmg .. " sát thương!",
        Duration = 1
    })
    
    if bossHealth <= 0 then
        bossHealth = 5000
        bossHealthBar.Size = Vector3.new(10, 1, 1)
        
        local drop = createPart("Saber Sword Drop", 
            bossPos + Vector3.new(0, 3, 5), 
            Vector3.new(1, 1, 1), 
            "Bright red", 
            Enum.Material.Neon
        )
        
        player.Leaderstats.Beli.Value = player.Leaderstats.Beli.Value + 5000
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "BOSS DIE",
            Text = "Nhận 5000 Beli + Saber Sword",
            Duration = 3
        })
    end
end)

-- ===== ENEMIES TRÊN ĐẢO CHÍNH =====
local enemyTypes = {"Enemy Pirate", "Enemy Marine", "Enemy Bandit", "Enemy Monk"}
for i = 1, 15 do
    local enemyType = enemyTypes[math.random(1, #enemyTypes)]
    local enemyPos = mainPos + Vector3.new(math.random(-60, 60), 25, math.random(-60, 60))
    
    local enemy = createPart(enemyType .. " " .. i, 
        enemyPos, 
        Vector3.new(2, 4, 1.5), 
        "Bright red", 
        Enum.Material.SmoothPlastic
    )
    
    local enemyHead = createPart("Enemy Head", 
        enemyPos + Vector3.new(0, 2.5, 0), 
        Vector3.new(1.5, 1.5, 1.5), 
        "Pastel yellow", 
        Enum.Material.SmoothPlastic
    )
end

-- ===== TRÁI ÁC QUỶ =====
local fruitPos = mainPos + Vector3.new(0, 30, 50)
local fruitShop = createPart("🍎 FRUIT SHOP", 
    fruitPos, 
    Vector3.new(6, 6, 6), 
    "Bright purple", 
    Enum.Material.Neon
)

local fruits = {
    {name = "Flame", color = "Bright red", price = 5000, pos = fruitPos + Vector3.new(-5, 5, 8)},
    {name = "Ice", color = "Cyan", price = 8000, pos = fruitPos + Vector3.new(0, 5, 8)},
    {name = "Light", color = "Bright yellow", price = 15000, pos = fruitPos + Vector3.new(5, 5, 8)},
    {name = "Dark", color = "Really black", price = 20000, pos = fruitPos + Vector3.new(-5, 5, -8)},
    {name = "Magma", color = "Bright orange", price = 30000, pos = fruitPos + Vector3.new(0, 5, -8)},
    {name = "Rumble", color = "Bright violet", price = 40000, pos = fruitPos + Vector3.new(5, 5, -8)}
}

for _, fruit in ipairs(fruits) do
    local f = createPart(fruit.name .. " Fruit", 
        fruit.pos, 
        Vector3.new(1.5, 1.5, 1.5), 
        fruit.color, 
        Enum.Material.Neon,
        0.1
    )
    
    createClickDetector(f, function(player)
        if player.Leaderstats.Beli.Value >= fruit.price then
            player.Leaderstats.Beli.Value = player.Leaderstats.Beli.Value - fruit.price
            player.Leaderstats.Fruit.Value = fruit.name
            
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Ăn trái " .. fruit.name,
                Text = "Đã kích hoạt năng lực!",
                Duration = 3
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Không đủ tiền",
                Text = "Cần $" .. fruit.price,
                Duration = 2
            })
        end
    end)
end

-- ===== CỔNG VỀ SPAWN =====
local returnGate = createPart("⏪ RETURN TO SPAWN", 
    mainPos + Vector3.new(0, 30, -70), 
    Vector3.new(8, 10, 2), 
    "Bright green", 
    Enum.Material.Neon,
    0.2
)

createClickDetector(returnGate, function(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(spawnPos)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Teleport",
            Text = "Đã về spawn!",
            Duration = 2
        })
    end
end)

-- ===========================================
-- ===== 3. THÔNG BÁO HOÀN TẤT =====
-- ===========================================
print("✅====================================")
print("✅ TẠO MAP HOÀN TẤT 100%!")
print("✅====================================")
print("📍 SPAWN: " .. tostring(spawnPos))
print("📍 ĐẢO CHÍNH: " .. tostring(mainPos))
print("⚔️ TOOL KHỞI ĐẦU: 3 cái")
print("🏪 SHOP: Kiếm, Súng, Trái ác quỷ")
print("👑 BOSS: Saber Boss (5000 máu)")
print("👥 ENEMY: 20 con")
print("🚪 TELEPORT: 2 cổng")
print("✅====================================")

-- Teleport người chơi hiện tại lên spawn
wait(1)
local player = game.Players.LocalPlayer
if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
    player.Character.HumanoidRootPart.CFrame = CFrame.new(spawnPos)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Chào mừng!",
        Text = "Click vào vũ khí để nhận đồ khởi đầu",
        Duration = 5
    })
end