-- TowerGenerator.server.lua

local function generateTower(towerType, position)
    local tower = Instance.new("Part")
    tower.Name = towerType
    tower.Size = Vector3.new(2, 2, 2)
    tower.Position = position
    tower.Anchored = true
    tower.BrickColor = BrickColor.new("Bright blue")
    
    -- Add a click detector to the tower
    local clickDetector = Instance.new("ClickDetector", tower)
    
    -- Add a billboard GUI to display tower information
    local billboardGui = Instance.new("BillboardGui", tower)
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    
    local textLabel = Instance.new("TextLabel", billboardGui)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Text = towerType
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.BackgroundTransparency = 1
    
    return tower
end

return generateTower