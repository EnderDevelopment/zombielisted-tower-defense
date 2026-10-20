-- TowerDefenseSimulator.client.lua

local players = game:GetService("Players")
local player = players.LocalPlayer
local mouse = player:GetMouse()

local function onMouseClick()
    local mouseHit = mouse.Hit
    local towerType = "Basic Tower"
    
    -- Send the click event to the server
    local remoteEvent = Instance.new("RemoteEvent")
    remoteEvent.Name = "TowerPlacementEvent"
    remoteEvent.Parent = player
    
    remoteEvent:FireServer(mouseHit, towerType)
end

mouse.Button1Down:Connect(onMouseClick)