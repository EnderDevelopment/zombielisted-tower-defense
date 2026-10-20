-- EnemyGenerator.server.lua

local function generateEnemy(enemyType, path)
    local enemy = Instance.new("Part")
    enemy.Name = enemyType
    enemy.Size = Vector3.new(1, 1, 1)
    enemy.Position = path[1]
    enemy.Anchored = true
    enemy.BrickColor = BrickColor.new("Bright red")
    
    -- Add a billboard GUI to display enemy information
    local billboardGui = Instance.new("BillboardGui", enemy)
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 1, 0)
    
    local textLabel = Instance.new("TextLabel", billboardGui)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Text = enemyType
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.BackgroundTransparency = 1
    
    return enemy
end

return generateEnemy