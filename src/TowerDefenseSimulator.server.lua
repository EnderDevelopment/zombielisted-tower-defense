-- Tower Defense Simulator for Roblox
-- Main game logic

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Game settings
local WAVE_INTERVAL = 30 -- seconds between waves
local ENEMY_SPEED = 5
local TOWER_RANGE = 10
local TOWER_DAMAGE = 10

-- Game state
local currentWave = 0
local enemies = {}
local towers = {}

-- Path for enemies to follow
local path = {}

-- Function to spawn enemies
local function spawnEnemy()
    local enemy = Instance.new("Model")
    enemy.Name = "Enemy"
    
    -- Add parts and other components to the enemy model
    -- This is a simplified example
    local part = Instance.new("Part")
    part.Size = Vector3.new(2, 2, 2)
    part.Position = path[1].Position
    part.Anchored = false
    part.CanCollide = false
    part.Parent = enemy
    
    enemy.Parent = workspace
    
    -- Move the enemy along the path
    local waypointIndex = 1
    
    local function moveToNextWaypoint()
        if waypointIndex <= #path then
            local targetPosition = path[waypointIndex].Position
            local direction = (targetPosition - part.Position).Unit
            part.CFrame = part.CFrame + (direction * ENEMY_SPEED * workspace:GetServerTimeNow())
            
            if (part.Position - targetPosition).Magnitude < 1 then
                waypointIndex = waypointIndex + 1
                moveToNextWaypoint()
            end
        else
            -- Enemy reached the end
            enemy:Destroy()
        end
    end
    
    moveToNextWaypoint()
    
    table.insert(enemies, enemy)
end

-- Function to start a new wave
local function startWave()
    currentWave = currentWave + 1
    
    -- Spawn enemies for the current wave
    for i = 1, currentWave * 5 do
        spawnEnemy()
    end
    
    -- Schedule the next wave
    task.wait(WAVE_INTERVAL)
    startWave()
end

-- Function to create a tower
local function createTower(position)
    local tower = Instance.new("Model")
    tower.Name = "Tower"
    
    -- Add parts and other components to the tower model
    -- This is a simplified example
    local part = Instance.new("Part")
    part.Size = Vector3.new(3, 3, 3)
    part.Position = position
    part.Anchored = true
    part.CanCollide = false
    part.Parent = tower
    
    tower.Parent = workspace
    
    -- Tower targeting and attacking logic
    local function targetEnemy()
        for _, enemy in ipairs(enemies) do
            if enemy and enemy:FindFirstChild("Humanoid") then
                local distance = (enemy.PrimaryPart.Position - part.Position).Magnitude
                if distance <= TOWER_RANGE then
                    -- Attack the enemy
                    local humanoid = enemy:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.Health = humanoid.Health - TOWER_DAMAGE
                        if humanoid.Health <= 0 then
                            enemy:Destroy()
                        end
                    end
                end
            end
        end
    end
    
    -- Schedule the tower to target enemies
    while true do
        targetEnemy()
        task.wait(1)
    end
    
    table.insert(towers, tower)
end

-- Function to handle player tower placement
local function onPlayerTowerPlacement(player, position)
    createTower(position)
end

-- Connect player tower placement event
ReplicatedStorage:WaitForChild("TowerPlacementEvent"):Connect(onPlayerTowerPlacement)

-- Start the first wave
startWave()
