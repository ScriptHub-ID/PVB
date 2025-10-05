local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local Backpack = player:WaitForChild("Backpack")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CloneUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 140)
frame.Position = UDim2.new(0.35, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Drop shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.4
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.ZIndex = 0
shadow.Parent = frame

local cornerFrame = Instance.new("UICorner")
cornerFrame.CornerRadius = UDim.new(0, 15)
cornerFrame.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Duplicate Tool"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.85, 0, 0, 45)
button.Position = UDim2.new(0.075, 0, 0.45, 0)
button.Text = "Duplicate"
button.Font = Enum.Font.GothamBold
button.TextSize = 18
button.TextColor3 = Color3.fromRGB(255,255,255)
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.AutoButtonColor = true
button.Parent = frame

local cornerBtn = Instance.new("UICorner")
cornerBtn.CornerRadius = UDim.new(0, 12)
cornerBtn.Parent = button

local strokeBtn = Instance.new("UIStroke")
strokeBtn.Thickness = 1.5
strokeBtn.Color = Color3.fromRGB(0, 200, 255)
strokeBtn.Parent = button

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 120, 255))
}
gradient.Rotation = 45
gradient.Parent = button

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 20)
status.Position = UDim2.new(0, 10, 0.8, 0)
status.BackgroundTransparency = 1
status.Text = "Ready"
status.Font = Enum.Font.Gotham
status.TextSize = 16
status.TextColor3 = Color3.fromRGB(200,200,200)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = frame

local function cloneHeldTool()
    local char = player.Character
    if not char then return end

    local tool = nil
    for _, item in ipairs(char:GetChildren()) do
        if item:IsA("Tool") then
            tool = item
            break
        end
    end

    if not tool then
        status.Text = "You are not holding a tool"
        return
    end

    local fake = tool:Clone()

    for _,desc in ipairs(fake:GetDescendants()) do
        if desc:IsA("Script") or desc:IsA("LocalScript") then
            desc:Destroy()
        end
    end

    fake.Parent = Backpack 
    status.Text = "Duplicated: " .. tool.Name
end

button.MouseButton1Click:Connect(cloneHeldTool)
