# Roadmap Lua cho Roblox Game Development

## 🎯 Mục tiêu
Roadmap này giúp bạn trở thành Roblox developer chuyên nghiệp, từ cơ bản đến nâng cao.

---

## 📚 PHẦN 1: CƠ BẢN LUA (2-4 tuần)

### 1.1. Giới thiệu về Lua
- [ ] Lua là gì và tại sao Roblox sử dụng Lua
- [ ] Cài đặt Roblox Studio
- [ ] Giao diện Roblox Studio cơ bản
- [ ] Script Editor và Output window

### 1.2. Cú pháp cơ bản
```lua
-- Comments
print("Hello World")  -- In ra màn hình

-- Variables
local myNumber = 10
local myString = "Hello"
local myBoolean = true
```

- [ ] Biến (Variables): local, global
- [ ] Kiểu dữ liệu: string, number, boolean, nil
- [ ] Comments (chú thích)
- [ ] Print và Output debugging

### 1.3. Toán tử (Operators)
```lua
-- Arithmetic
local sum = 5 + 3
local product = 5 * 3
local power = 5 ^ 2

-- Comparison
local isEqual = (5 == 5)
local isGreater = (10 > 5)

-- Logical
local result = true and false
local result2 = true or false
local result3 = not true
```

- [ ] Toán tử số học: +, -, *, /, ^, %
- [ ] Toán tử so sánh: ==, ~=, <, >, <=, >=
- [ ] Toán tử logic: and, or, not

### 1.4. Điều kiện (Conditionals)
```lua
local score = 85

if score >= 90 then
    print("Grade A")
elseif score >= 80 then
    print("Grade B")
else
    print("Grade C")
end
```

- [ ] if, elseif, else statements
- [ ] Nested conditions
- [ ] Ternary-like operations

### 1.5. Vòng lặp (Loops)
```lua
-- For loop
for i = 1, 10 do
    print(i)
end

-- While loop
local count = 0
while count < 5 do
    print(count)
    count = count + 1
end

-- Repeat until
repeat
    print("Running")
until condition
```

- [ ] for loops (numeric, generic)
- [ ] while loops
- [ ] repeat-until loops
- [ ] break và continue

### 1.6. Tables (Bảng)
```lua
-- Array-like table
local fruits = {"Apple", "Banana", "Orange"}
print(fruits[1])  -- Apple (index bắt đầu từ 1)

-- Dictionary-like table
local player = {
    name = "John",
    health = 100,
    level = 5
}
print(player.name)  -- John

-- Nested tables
local inventory = {
    weapons = {"Sword", "Bow"},
    armor = {"Helmet", "Shield"}
}
```

- [ ] Array-style tables
- [ ] Dictionary-style tables
- [ ] Nested tables
- [ ] Table manipulation: insert, remove
- [ ] Iteration với pairs() và ipairs()

### 1.7. Functions (Hàm)
```lua
-- Basic function
local function greet(name)
    print("Hello, " .. name)
end
greet("Player")

-- Return values
local function add(a, b)
    return a + b
end
local result = add(5, 3)

-- Multiple returns
local function getStats()
    return 100, 50, 25  -- health, mana, stamina
end
local hp, mp, sp = getStats()
```

- [ ] Định nghĩa functions
- [ ] Parameters và arguments
- [ ] Return values
- [ ] Local vs global functions
- [ ] Anonymous functions

---

## 🎮 PHẦN 2: ROBLOX CƠ BẢN (3-5 tuần)

### 2.1. Roblox Object Model
```lua
-- Workspace
local part = Instance.new("Part")
part.Parent = workspace
part.Position = Vector3.new(0, 10, 0)

-- Getting objects
local myPart = workspace:FindFirstChild("PartName")
local player = game.Players.LocalPlayer
```

- [ ] Instance và Properties
- [ ] workspace, Players, ReplicatedStorage, ServerStorage
- [ ] Part, Model, Tool basics
- [ ] Parent-Child relationships
- [ ] Instance.new() và :Clone()

### 2.2. Vector3 và CFrame
```lua
-- Vector3 (Position)
local position = Vector3.new(10, 5, 10)
part.Position = position

-- CFrame (Position + Rotation)
local cframe = CFrame.new(0, 10, 0)
part.CFrame = cframe

-- Rotation
part.CFrame = CFrame.Angles(math.rad(45), 0, 0)

-- Moving objects
part.CFrame = part.CFrame + Vector3.new(0, 1, 0)
```

- [ ] Vector3: Position, Size, Velocity
- [ ] CFrame: Position + Orientation
- [ ] CFrame math operations
- [ ] Rotation và angles

### 2.3. Scripts vs LocalScripts vs ModuleScripts
```lua
-- Script (Server-side)
print("Running on server")

-- LocalScript (Client-side)
local player = game.Players.LocalPlayer
print("Running on " .. player.Name)

-- ModuleScript
local module = {}
function module.MyFunction()
    return "Hello"
end
return module
```

- [ ] Server-side Scripts
- [ ] Client-side LocalScripts
- [ ] ModuleScripts và require()
- [ ] Client-Server architecture

### 2.4. Events (Sự kiện)
```lua
-- Touched event
part.Touched:Connect(function(hit)
    print(hit.Name .. " touched the part")
end)

-- Player events
game.Players.PlayerAdded:Connect(function(player)
    print(player.Name .. " joined!")
end)

-- Custom events
local event = Instance.new("BindableEvent")
event.Event:Connect(function(data)
    print(data)
end)
event:Fire("Hello")
```

- [ ] :Connect() và event handlers
- [ ] Common events: Touched, PlayerAdded, Died
- [ ] BindableEvents và BindableFunctions
- [ ] :Disconnect() events

### 2.5. Player và Character
```lua
-- Get player
local player = game.Players.LocalPlayer

-- Get character
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Modify health
humanoid.Health = 50

-- Detect death
humanoid.Died:Connect(function()
    print(player.Name .. " died")
end)
```

- [ ] Player object và properties
- [ ] Character model
- [ ] Humanoid: Health, WalkSpeed, JumpPower
- [ ] CharacterAdded event
- [ ] Respawning

### 2.6. GUI (Giao diện người dùng)
```lua
-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

-- TextLabel
local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 200, 0, 50)
label.Position = UDim2.new(0.5, -100, 0, 10)
label.Text = "Hello Player"
label.Parent = screenGui

-- Button
local button = Instance.new("TextButton")
button.MouseButton1Click:Connect(function()
    print("Button clicked!")
end)
```

- [ ] ScreenGui, BillboardGui, SurfaceGui
- [ ] Frames, TextLabels, TextButtons
- [ ] UDim2 positioning và sizing
- [ ] GUI events: MouseButton1Click
- [ ] Tweening GUI elements

---

## 🚀 PHẦN 3: ROBLOX TRUNG CẤP (4-6 tuần)

### 3.1. RemoteEvents và RemoteFunctions
```lua
-- Server Script
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage.RemoteEvent

remote.OnServerEvent:Connect(function(player, message)
    print(player.Name .. " said: " .. message)
end)

-- LocalScript (Client)
local remote = ReplicatedStorage.RemoteEvent
remote:FireServer("Hello Server!")

-- RemoteFunction (with return)
local remoteFunc = ReplicatedStorage.RemoteFunction
remoteFunc.OnServerInvoke = function(player, amount)
    return amount * 2
end

-- Client calling
local result = remoteFunc:InvokeServer(10)
```

- [ ] Client-Server communication
- [ ] RemoteEvent:FireServer(), :FireClient(), :FireAllClients()
- [ ] RemoteFunction:InvokeServer(), :InvokeClient()
- [ ] Security best practices

### 3.2. DataStores (Lưu dữ liệu)
```lua
local DataStoreService = game:GetService("DataStoreService")
local playerData = DataStoreService:GetDataStore("PlayerData")

-- Save data
game.Players.PlayerRemoving:Connect(function(player)
    local success, error = pcall(function()
        playerData:SetAsync(player.UserId, {
            coins = 1000,
            level = 5
        })
    end)
end)

-- Load data
game.Players.PlayerAdded:Connect(function(player)
    local data = playerData:GetAsync(player.UserId)
    if data then
        print(player.Name .. " has " .. data.coins .. " coins")
    end
end)
```

- [ ] GetDataStore(), OrderedDataStore
- [ ] :SetAsync(), :GetAsync(), :UpdateAsync()
- [ ] pcall() cho error handling
- [ ] Data limits và best practices
- [ ] Auto-save systems

### 3.3. TweenService (Animations)
```lua
local TweenService = game:GetService("TweenService")

local part = workspace.Part
local tweenInfo = TweenInfo.new(
    2,  -- Time
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.Out
)

local goal = {Position = Vector3.new(10, 10, 10)}
local tween = TweenService:Create(part, tweenInfo, goal)
tween:Play()

-- Tween events
tween.Completed:Connect(function()
    print("Tween finished")
end)
```

- [ ] TweenInfo parameters
- [ ] EasingStyles và EasingDirections
- [ ] Tweening properties
- [ ] Tween events: Completed, Paused
- [ ] GUI tweening

### 3.4. Sound và Music
```lua
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://1234567890"
sound.Parent = workspace
sound.Volume = 0.5
sound:Play()

-- 3D Sound
sound.RollOffMaxDistance = 100
sound.RollOffMinDistance = 10

-- Music loop
sound.Looped = true
```

- [ ] Sound properties: Volume, Pitch, TimePosition
- [ ] 3D sound và attenuation
- [ ] SoundGroups
- [ ] Playing/Stopping sounds
- [ ] Audio assets

### 3.5. Lighting và Atmosphere
```lua
local Lighting = game:GetService("Lighting")

-- Time of day
Lighting.ClockTime = 12

-- Fog
Lighting.FogEnd = 500
Lighting.FogColor = Color3.new(1, 1, 1)

-- Atmosphere
local atmosphere = Instance.new("Atmosphere")
atmosphere.Density = 0.3
atmosphere.Parent = Lighting

-- ColorCorrection
local cc = Instance.new("ColorCorrectionEffect")
cc.Brightness = 0.1
cc.Parent = Lighting
```

- [ ] Day/Night cycle
- [ ] Fog, Bloom, SunRays
- [ ] Atmosphere effects
- [ ] ColorCorrection, Blur effects

### 3.6. Raycasting
```lua
-- Simple raycast
local origin = workspace.Camera.CFrame.Position
local direction = workspace.Camera.CFrame.LookVector * 100

local raycastResult = workspace:Raycast(origin, direction)

if raycastResult then
    local hitPart = raycastResult.Instance
    print("Hit: " .. hitPart.Name)
    
    -- Create marker
    local marker = Instance.new("Part")
    marker.Position = raycastResult.Position
    marker.Parent = workspace
end

-- RaycastParams
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Blacklist
params.FilterDescendantsInstances = {character}

local result = workspace:Raycast(origin, direction, params)
```

- [ ] workspace:Raycast()
- [ ] RaycastParams filtering
- [ ] Hit detection
- [ ] Mouse raycasting
- [ ] Laser beams

---

## 💎 PHẦN 4: ROBLOX NÂNG CAO (6-8 tuần)

### 4.1. Object-Oriented Programming (OOP)
```lua
-- Class definition
local Player = {}
Player.__index = Player

function Player.new(name, health)
    local self = setmetatable({}, Player)
    self.name = name
    self.health = health
    return self
end

function Player:TakeDamage(amount)
    self.health = self.health - amount
    if self.health <= 0 then
        self:Die()
    end
end

function Player:Die()
    print(self.name .. " died")
end

-- Usage
local player1 = Player.new("John", 100)
player1:TakeDamage(30)
```

- [ ] Metatables và __index
- [ ] Creating classes
- [ ] Methods và self
- [ ] Inheritance
- [ ] Encapsulation

### 4.2. Advanced DataStores
```lua
-- UpdateAsync for concurrent updates
playerData:UpdateAsync(player.UserId, function(oldData)
    local data = oldData or {coins = 0}
    data.coins = data.coins + 10
    return data
end)

-- Versioning
local function saveData(player, data)
    data.version = 2
    playerData:SetAsync(player.UserId, data)
end

-- Session locking
local sessionData = {}

local function loadData(player)
    if sessionData[player.UserId] then
        player:Kick("Data session already active")
        return
    end
    
    sessionData[player.UserId] = true
    local data = playerData:GetAsync(player.UserId)
    return data
end
```

- [ ] :UpdateAsync() cho safe updates
- [ ] Session locking
- [ ] Data versioning
- [ ] Retry logic
- [ ] Data backup strategies

### 4.3. ProfileService (Better DataStore)
```lua
local ProfileService = require(ReplicatedStorage.ProfileService)

local ProfileTemplate = {
    Coins = 0,
    Level = 1,
    Inventory = {}
}

local ProfileStore = ProfileService.GetProfileStore(
    "PlayerData",
    ProfileTemplate
)

local Profiles = {}

game.Players.PlayerAdded:Connect(function(player)
    local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
    
    if profile then
        profile:AddUserId(player.UserId)
        profile:Reconcile()
        
        profile:ListenToRelease(function()
            Profiles[player] = nil
            player:Kick()
        end)
        
        if player:IsDescendantOf(game.Players) then
            Profiles[player] = profile
        else
            profile:Release()
        end
    end
end)
```

- [ ] ProfileService installation
- [ ] Session locking tự động
- [ ] Data reconciliation
- [ ] Release handling
- [ ] Best practices

### 4.4. Advanced Combat System
```lua
-- Damage calculation
local function calculateDamage(attacker, defender)
    local baseDamage = attacker.Weapon.Damage
    local defense = defender.Armor.Defense
    local critChance = attacker.Stats.CritChance
    
    local damage = baseDamage - defense
    
    if math.random() < critChance then
        damage = damage * 2
        print("Critical hit!")
    end
    
    return math.max(damage, 1)
end

-- Hitbox system
local function createHitbox(character, size, duration)
    local rootPart = character.HumanoidRootPart
    local hitbox = Instance.new("Part")
    hitbox.Size = size
    hitbox.CFrame = rootPart.CFrame
    hitbox.Transparency = 1
    hitbox.CanCollide = false
    hitbox.Parent = workspace
    
    local hitPlayers = {}
    
    local connection = hitbox.Touched:Connect(function(hit)
        local enemyHumanoid = hit.Parent:FindFirstChild("Humanoid")
        if enemyHumanoid and not hitPlayers[hit.Parent] then
            hitPlayers[hit.Parent] = true
            -- Deal damage
        end
    end)
    
    task.wait(duration)
    connection:Disconnect()
    hitbox:Destroy()
end
```

- [ ] Weapon systems
- [ ] Hitbox detection
- [ ] Damage calculation
- [ ] Status effects
- [ ] Cooldown systems
- [ ] Combo systems

### 4.5. Inventory System
```lua
local InventorySystem = {}
InventorySystem.Inventories = {}

function InventorySystem.CreateInventory(player, size)
    InventorySystem.Inventories[player] = {
        MaxSlots = size,
        Items = {}
    }
end

function InventorySystem.AddItem(player, itemId, amount)
    local inventory = InventorySystem.Inventories[player]
    
    -- Check if item exists
    for i, item in pairs(inventory.Items) do
        if item.Id == itemId then
            item.Amount = item.Amount + amount
            return true
        end
    end
    
    -- Add new item
    if #inventory.Items < inventory.MaxSlots then
        table.insert(inventory.Items, {
            Id = itemId,
            Amount = amount
        })
        return true
    end
    
    return false  -- Inventory full
end

function InventorySystem.RemoveItem(player, itemId, amount)
    local inventory = InventorySystem.Inventories[player]
    
    for i, item in pairs(inventory.Items) do
        if item.Id == itemId then
            if item.Amount >= amount then
                item.Amount = item.Amount - amount
                if item.Amount == 0 then
                    table.remove(inventory.Items, i)
                end
                return true
            end
        end
    end
    
    return false
end

return InventorySystem
```

- [ ] Inventory structure
- [ ] Adding/removing items
- [ ] Item stacking
- [ ] Item rarity
- [ ] GUI integration
- [ ] Drag and drop

### 4.6. Quest System
```lua
local QuestSystem = {}
QuestSystem.ActiveQuests = {}

local Quests = {
    ["Quest1"] = {
        Name = "Defeat Enemies",
        Description = "Defeat 10 enemies",
        Objectives = {
            {Type = "Kill", Target = "Enemy", Amount = 10, Current = 0}
        },
        Rewards = {Coins = 100, XP = 50}
    }
}

function QuestSystem.StartQuest(player, questId)
    local quest = Quests[questId]
    if not quest then return end
    
    if not QuestSystem.ActiveQuests[player] then
        QuestSystem.ActiveQuests[player] = {}
    end
    
    QuestSystem.ActiveQuests[player][questId] = {
        Objectives = table.clone(quest.Objectives),
        StartTime = tick()
    }
end

function QuestSystem.UpdateProgress(player, objectiveType, target, amount)
    local playerQuests = QuestSystem.ActiveQuests[player]
    if not playerQuests then return end
    
    for questId, questData in pairs(playerQuests) do
        for _, objective in ipairs(questData.Objectives) do
            if objective.Type == objectiveType and objective.Target == target then
                objective.Current = math.min(objective.Current + amount, objective.Amount)
                
                -- Check completion
                if QuestSystem.IsQuestComplete(player, questId) then
                    QuestSystem.CompleteQuest(player, questId)
                end
            end
        end
    end
end

return QuestSystem
```

- [ ] Quest structure
- [ ] Objective tracking
- [ ] Quest progression
- [ ] Rewards system
- [ ] Multiple quests

### 4.7. Pathfinding AI
```lua
local PathfindingService = game:GetService("PathfindingService")

local function findPath(npc, target)
    local humanoid = npc:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    local path = PathfindingService:CreatePath({
        AgentRadius = 3,
        AgentHeight = 5,
        AgentCanJump = true,
        AgentCanClimb = true
    })
    
    local success, errorMessage = pcall(function()
        path:ComputeAsync(npc.HumanoidRootPart.Position, target.Position)
    end)
    
    if success and path.Status == Enum.PathStatus.Success then
        local waypoints = path:GetWaypoints()
        
        for i, waypoint in ipairs(waypoints) do
            if waypoint.Action == Enum.PathWaypointAction.Jump then
                humanoid.Jump = true
            end
            
            humanoid:MoveTo(waypoint.Position)
            humanoid.MoveToFinished:Wait()
        end
    end
end

-- Chase AI
local function chasePlayer(npc, player)
    while true do
        local character = player.Character
        if character then
            findPath(npc, character.HumanoidRootPart)
        end
        task.wait(2)
    end
end
```

- [ ] PathfindingService
- [ ] Computing paths
- [ ] Following waypoints
- [ ] Jump và climb handling
- [ ] AI states (Idle, Chase, Attack)
- [ ] Patrol systems

### 4.8. Advanced Animation
```lua
-- Animation loading
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")

local animationId = "rbxassetid://123456789"
local animation = Instance.new("Animation")
animation.AnimationId = animationId

local animTrack = animator:LoadAnimation(animation)

-- Playing animations
animTrack:Play()
animTrack:AdjustSpeed(1.5)
animTrack:AdjustWeight(2)

-- Animation events
animTrack:GetMarkerReachedSignal("Shoot"):Connect(function()
    print("Shoot marker reached")
end)

animTrack.Stopped:Connect(function()
    print("Animation stopped")
end)

-- Blending animations
local idleAnim = animator:LoadAnimation(idleAnimation)
local walkAnim = animator:LoadAnimation(walkAnimation)

idleAnim:Play()
walkAnim:Play()
walkAnim:AdjustWeight(0.5)  -- Blend
```

- [ ] Animation loading
- [ ] Animation priority
- [ ] Animation blending
- [ ] Animation events/markers
- [ ] Custom animations
- [ ] Animation controllers

### 4.9. Procedural Generation
```lua
-- Terrain generation
local function generateTerrain(size)
    for x = -size, size do
        for z = -size, size do
            local height = math.noise(x/20, z/20) * 10
            local part = Instance.new("Part")
            part.Size = Vector3.new(4, height, 4)
            part.Position = Vector3.new(x*4, height/2, z*4)
            part.Anchored = true
            part.Parent = workspace.Terrain
        end
    end
end

-- Dungeon generation
local function generateDungeon(width, height)
    local grid = {}
    
    -- Initialize grid
    for x = 1, width do
        grid[x] = {}
        for y = 1, height do
            grid[x][y] = "wall"
        end
    end
    
    -- Carve rooms
    local function carveRoom(startX, startY, roomWidth, roomHeight)
        for x = startX, startX + roomWidth do
            for y = startY, startY + roomHeight do
                if grid[x] and grid[x][y] then
                    grid[x][y] = "floor"
                end
            end
        end
    end
    
    -- Generate random rooms
    for i = 1, 10 do
        local x = math.random(2, width - 10)
        local y = math.random(2, height - 10)
        local w = math.random(4, 8)
        local h = math.random(4, 8)
        carveRoom(x, y, w, h)
    end
    
    return grid
end
```

- [ ] Perlin noise terrain
- [ ] Dungeon generation
- [ ] Random structures
- [ ] Biomes
- [ ] Procedural meshes

### 4.10. Network Optimization
```lua
-- Batching remote calls
local remoteQueue = {}
local UPDATE_INTERVAL = 0.1

local function queueRemote(eventName, ...)
    table.insert(remoteQueue, {eventName, {...}})
end

task.spawn(function()
    while true do
        if #remoteQueue > 0 then
            RemoteEvent:FireServer(remoteQueue)
            remoteQueue = {}
        end
        task.wait(UPDATE_INTERVAL)
    end
end)

-- Object pooling
local ObjectPool = {}
ObjectPool.Pool = {}

function ObjectPool.Get(template)
    if #ObjectPool.Pool > 0 then
        local obj = table.remove(ObjectPool.Pool)
        obj.Parent = workspace
        return obj
    else
        return template:Clone()
    end
end

function ObjectPool.Return(obj)
    obj.Parent = nil
    table.insert(ObjectPool.Pool, obj)
end

-- Streaming optimization
workspace.StreamingEnabled = true
workspace.StreamingTargetRadius = 512
workspace.StreamingMinRadius = 128
```

- [ ] Remote batching
- [ ] Object pooling
- [ ] Streaming enabled
- [ ] LOD (Level of Detail)
- [ ] Culling techniques
- [ ] Memory management

---

## 🏆 PHẦN 5: CHUYÊN NGHIỆP (8+ tuần)

### 5.1. Anti-Cheat Systems
```lua
-- Server-side validation
RemoteEvent.OnServerEvent:Connect(function(player, action, data)
    -- Validate player exists
    if not player or not player.Parent then return end
    
    -- Rate limiting
    if isRateLimited(player) then
        warnPlayer(player, "Too many requests")
        return
    end
    
    -- Sanity checks
    if action == "BuyItem" then
        local price = ItemDatabase[data.itemId].Price
        if player.Coins.Value < price then
            return  -- Not enough coins
        end
    end
    
    -- Position validation
    if action == "Move" then
        local distance = (data.position - player.Character.HumanoidRootPart.Position).Magnitude
        if distance > 100 then  -- Teleport hack
            kickPlayer(player, "Invalid movement")
            return
        end
    end
end)

-- Speed check
local lastPositions = {}
game:GetService("RunService").Heartbeat:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character then
            local rootPart = player.Character.HumanoidRootPart
            local lastPos = lastPositions[player]
            
            if lastPos then
                local distance = (rootPart.Position - lastPos).Magnitude
                local speed = distance / 0.03  -- Heartbeat interval
                
                if speed > 100 then  -- Too fast
                    kickPlayer(player, "Speed hack detected")
                end
            end
            
            lastPositions[player] = rootPart.Position
        end
    end
end)
```

- [ ] Input validation
- [ ] Rate limiting
- [ ] Server authority
- [ ] Speed checks
- [ ] Exploit detection
- [ ] Logging suspicious activity

### 5.2. Advanced Framework Architecture
```lua
-- Service pattern
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Services = ReplicatedStorage.Services

local CombatService = require(Services.CombatService)
local DataService = require(Services.DataService)
local UIService = require(Services.UIService)

-- Controllers (client)
local Controllers = ReplicatedStorage.Controllers
local InputController = require(Controllers.InputController)

-- Dependency injection
local ServiceContainer = {}

function ServiceContainer:Register(name, service)
    self[name] = service
end

function ServiceContainer:Get(name)
    return self[name]
end

ServiceContainer:Register("Combat", CombatService)
ServiceContainer:Register("Data", DataService)

-- Usage
local combat = ServiceContainer:Get("Combat")
combat:DealDamage(player, target, 50)
```

- [ ] Service architecture
- [ ] Dependency injection
- [ ] Event aggregator
- [ ] State management
- [ ] Modular systems
- [ ] Testing frameworks

### 5.3. Matchmaking System
```lua
local MatchmakingService = {}
MatchmakingService.Queue = {}
MatchmakingService.Matches = {}

function MatchmakingService:JoinQueue(player, skill)
    table.insert(self.Queue, {
        Player = player,
        Skill = skill,
        JoinTime = tick()
    })
end

function MatchmakingService:FindMatch()
    if #self.Queue < 2 then return end
    
    -- Sort by skill
    table.sort(self.Queue, function(a, b)
        return a.Skill < b.Skill
    end)
    
    -- Find compatible players
    for i = 1, #self.Queue - 1 do
        local player1 = self.Queue[i]
        local player2 = self.Queue[i + 1]
        
        local skillDiff = math.abs(player1.Skill - player2.Skill)
        local waitTime = tick() - math.min(player1.JoinTime, player2.JoinTime)
        
        -- Expand skill range over time
        local maxSkillDiff = 100 + (waitTime * 10)
        
        if skillDiff <= maxSkillDiff then
            self:CreateMatch(player1.Player, player2.Player)
            table.remove(self.Queue, i + 1)
            table.remove(self.Queue, i)
            break
        end
    end
end

return MatchmakingService
```

- [ ] Queue systems
- [ ] Skill-based matching
- [ ] Party systems
- [ ] Lobby management
- [ ] Match creation

### 5.4. Trading System
```lua
local TradingSystem = {}
TradingSystem.ActiveTrades = {}

function TradingSystem:InitiateTrade(player1, player2)
    local tradeId = game:GetService("HttpService"):GenerateGUID()
    
    self.ActiveTrades[tradeId] = {
        Player1 = player1,
        Player2 = player2,
        Player1Offer = {},
        Player2Offer = {},
        Player1Accepted = false,
        Player2Accepted = false,
        Locked = false
    }
    
    return tradeId
end

function TradingSystem:AddOffer(tradeId, player, item)
    local trade = self.ActiveTrades[tradeId]
    if trade.Locked then return false end
    
    -- Reset acceptances
    trade.Player1Accepted = false
    trade.Player2Accepted = false
    
    if player == trade.Player1 then
        table.insert(trade.Player1Offer, item)
    else
        table.insert(trade.Player2Offer, item)
    end
    
    return true
end

function TradingSystem:AcceptTrade(tradeId, player)
    local trade = self.ActiveTrades[tradeId]
    
    if player == trade.Player1 then
        trade.Player1Accepted = true
    else
        trade.Player2Accepted = true
    end
    
    if trade.Player1Accepted and trade.Player2Accepted then
        self:ExecuteTrade(tradeId)
    end
end

function TradingSystem:ExecuteTrade(tradeId)
    local trade = self.ActiveTrades[tradeId]
    trade.Locked = true
    
    -- Transfer items
    -- ... item transfer logic
    
    self.ActiveTrades[tradeId] = nil
end

return TradingSystem
```

- [ ] Trade requests
- [ ] Offer management
- [ ] Acceptance system
- [ ] Scam prevention
- [ ] Transaction logging

### 5.5. Analytics và Metrics
```lua
local AnalyticsService = {}

function AnalyticsService:TrackEvent(player, eventName, data)
    local httpService = game:GetService("HttpService")
    
    local eventData = {
        UserId = player.UserId,
        Username = player.Name,
        Event = eventName,
        Data = data,
        Timestamp = os.time(),
        PlaceId = game.PlaceId
    }
    
    -- Send to external analytics
    -- httpService:PostAsync(ANALYTICS_URL, httpService:JSONEncode(eventData))
    
    -- Local tracking
    self:SaveToDataStore(eventData)
end

function AnalyticsService:TrackPlayerSession(player)
    local joinTime = tick()
    
    player.AncestryChanged:Connect(function()
        if not player:IsDescendantOf(game) then
            local sessionLength = tick() - joinTime
            self:TrackEvent(player, "SessionEnd", {
                Duration = sessionLength
            })
        end
    end)
end

return AnalyticsService
```

- [ ] Event tracking
- [ ] Player metrics
- [ ] Session analytics
- [ ] Conversion funnels
- [ ] A/B testing
- [ ] External API integration

---

## 🛠️ CÔNG CỤ & THƯ VIỆN QUAN TRỌNG

### Frameworks
- [ ] **Knit** - Game framework
- [ ] **ProfileService** - Data management
- [ ] **Roact** - UI framework (React-like)
- [ ] **Rodux** - State management (Redux-like)

### Libraries
- [ ] **Spring** - Smooth animations
- [ ] **Promise** - Async operations
- [ ] **Signal** - Event system
- [ ] **Fusion** - Modern UI framework

### Tools
- [ ] **Rojo** - VS Code integration
- [ ] **Selene** - Lua linter
- [ ] **StyLua** - Code formatter
- [ ] **TestEZ** - Unit testing

---

## 📦 DỰ ÁN THỰC HÀNH

### Beginner Projects
1. **Obby Game** - Basic movement, checkpoints
2. **Coin Collector** - GUI, basic scripting
3. **Simple Tycoon** - Money system, buttons

### Intermediate Projects
4. **Fighting Game** - Combat system, health bars
5. **Simulator Game** - Pet system, rebirth, shop
6. **Tower Defense** - Pathfinding, waves, towers

### Advanced Projects
7. **RPG Game** - Quests, inventory, skills, NPCs
8. **Battle Royale** - Matchmaking, zone shrinking
9. **MMORPG** - Server architecture, economy

---

## 📖 TÀI NGUYÊN HỌC TẬP

### Official Resources
- [ ] Roblox Developer Hub
- [ ] Roblox Creator Documentation
- [ ] DevForum
- [ ] API Reference

### YouTube Channels
- [ ] AlvinBlox
- [ ] TheDevKing
- [ ] Peaspod Productions
- [ ] GnomeCode

### Community
- [ ] Hidden Developers (Discord)
- [ ] Roblox OSS Community
- [ ] DevForum

---

## ✅ LỘ TRÌNH THEO THỜI GIAN

### Tháng 1-2: Foundation
- Lua cơ bản hoàn chỉnh
- Roblox Studio basics
- Script đầu tiên

### Tháng 3-4: Core Skills
- RemoteEvents mastery
- DataStore implementation
- GUI systems
- Basic game mechanics

### Tháng 5-6: Game Systems
- Combat systems
- Inventory management
- Quest systems
- AI basics

### Tháng 7-8: Advanced Topics
- OOP patterns
- Framework usage
- Optimization
- Security

### Tháng 9-12: Professional
- Complete game projects
- Monetization
- Publishing
- Portfolio building

---

## 💡 TIPS & BEST PRACTICES

### Code Quality
```lua
-- ✅ GOOD
local function calculateDamage(attacker, defender)
    local baseDamage = attacker.Weapon.Damage
    local defense = defender.Armor.Defense
    return math.max(baseDamage - defense, 1)
end

-- ❌ BAD
function dmg(a, d)
    return a.Weapon.Damage - d.Armor.Defense
end
```

### Security
- Never trust client input
- Always validate on server
- Use RemoteEvents properly
- Implement rate limiting

### Performance
- Use local variables
- Cache references
- Avoid :GetChildren() in loops
- Use object pooling
- Enable streaming

### Organization
```
ReplicatedStorage/
├── Modules/
│   ├── CombatSystem.lua
│   ├── InventorySystem.lua
│   └── QuestSystem.lua
├── RemoteEvents/
│   ├── DamageEvent
│   └── ShopEvent
└── Assets/
    ├── Sounds/
    └── UI/

ServerScriptService/
├── Services/
│   ├── DataService.lua
│   ├── PlayerService.lua
│   └── MatchmakingService.lua
└── Server.lua
```

---

## 🎯 CHECKLIST HOÀN THÀNH

- [ ] Hoàn thành tất cả cú pháp Lua cơ bản
- [ ] Tạo được 3 game đơn giản
- [ ] Hiểu rõ RemoteEvents
- [ ] Implement DataStore thành công
- [ ] Tạo combat system hoàn chỉnh
- [ ] Build inventory system
- [ ] Implement quest system
- [ ] Tối ưu hóa performance
- [ ] Thêm anti-cheat
- [ ] Publish game lên Roblox

---

## 🚀 BƯỚC TIẾP THEO SAU ROADMAP

1. **Specialize** - Chọn chuyên ngành (Combat, UI, Systems, AI)
2. **Collaborate** - Tham gia teams để làm game lớn
3. **Monetize** - Học về GamePasses, DevProducts
4. **Scale** - Học server infrastructure cho massive games
5. **Portfolio** - Build portfolio và showcase games

---

**Chúc bạn thành công trên con đường trở thành Roblox Developer! 🎮✨**
