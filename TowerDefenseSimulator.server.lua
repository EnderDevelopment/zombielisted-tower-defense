-- TowerDefenseSimulator.server.lua

local generateTower = require(script.Parent.TowerGenerator)
local generateEnemy = require(script.Parent.EnemyGenerator)

local gameService = game:GetService("RunService")
local players = game:GetService("Players")

local towers = {}
local enemies = {}
local enemyPath = {
    Vector3.new(0, 0, 0),
    Vector3.new(10, 0, 0),
    Vector3.new(20, 0, 0),
    Vector3.new(30, 0, 0)
}

local function spawnEnemy()
    local enemy = generateEnemy("Enemy", enemyPath)
    table.insert(enemies, enemy)
    enemy.Parent = workspace

    -- Move the enemy along the path
    local pathIndex = 1
    gameService.Heartbeat:Connect(function()
        if pathIndex <= #enemyPath then
            enemy.Position = enemyPath[pathIndex]
            pathIndex = pathIndex + 1
        else
            enemy:Destroy()
            table.remove(enemies, table.find(enemies, enemy))
        end
    end)
end

local function onPlayerClick(player, mouseHit, towerType)
    local tower = generateTower(towerType, mouseHit.Position)
    table.insert(towers, tower)
    tower.Parent = workspace

    -- Add a click detector to the tower
    local clickDetector = tower:FindFirstChildOfClass("ClickDetector")
    clickDetector.MouseClick:Connect(function(clickedPlayer)
        -- Handle tower interaction
    end)
end

-- Spawn enemies periodically
while true do
    wait(5)
    spawnEnemy()
end

-- Connect to player clicks
players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local mouse = player:GetMouse()
        mouse.Button1Down:Connect(function()
            onPlayerClick(player, mouse.Hit, "Basic Tower")
        end)
    end)
end)