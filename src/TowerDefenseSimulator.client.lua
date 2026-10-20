-- Tower Defense Simulator for Roblox
-- Client-side script for tower placement

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Function to handle mouse click for tower placement
local function onMouseClick()
    local position = mouse.Hit.p
    
    -- Send the tower placement request to the server
    ReplicatedStorage:WaitForChild("TowerPlacementEvent"):FireServer(position)
end

-- Connect mouse click event
mouse.Button1Down:Connect(onMouseClick)
