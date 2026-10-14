-- OFFBATATA - Mobile Hack Menu UI (Updated Multipliers)
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer

-- Prevent duplicate GUI
if CoreGui:FindFirstChild("OffbatataModMenu") then
    CoreGui.OffbatataModMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OffbatataModMenu"
ScreenGui.Parent = CoreGui

-- Floating Button (OFF)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 50, 0, 200)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ToggleButton.BorderColor3 = Color3.fromRGB(0, 255, 128)
ToggleButton.BorderSizePixel = 2
ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 128)
ToggleButton.TextSize = 16
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "OFF"
ToggleButton.Parent = ScreenGui

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(1, 0)
BtnCorner.Parent = ToggleButton

local BtnStroke = Instance.new("UIStroke")
BtnStroke.Color = Color3.fromRGB(0, 255, 128)
BtnStroke.Thickness = 2
BtnStroke.Parent = ToggleButton

-- Main Menu Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 380)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 128)
MainFrame.BorderSizePixel = 2
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Title Bar
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 45)
TitleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "OFFBATATA // HACK MENU"
TitleLabel.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleLabel

-- Container for toggles
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -20, 1, -65)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 55)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ScrollingFrame

-- Function to create toggle buttons inside the menu
local function createToggle(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamMedium
    btn.Text = name .. ": OFF"
    btn.Parent = ScrollingFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            btn.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
            btn.Text = name .. ": ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
            btn.Text = name .. ": OFF"
        end
        callback(enabled)
    end)
end

-- Toggle Menu Visibility
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Draggable Floating Button for Mobile
local dragging, dragStart, startPos
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Hack Features Implementation (10x Speed = 160, 5x Jump = 250)
createToggle("Velocidade 10x (160)", function(state)
    local char = localPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = state and 160 or 16
    end
end)

createToggle("Super Pulo 5x (250)", function(state)
    local char = localPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = state and 250 or 50
    end
end)

createToggle("ESP Jogadores", function(state)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= localPlayer and p.Character then
            if state then
                if not p.Character:FindFirstChild("OffESP") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "OffESP"
                    hl.Adornee = p.Character
                    hl.FillColor = Color3.fromRGB(0, 255, 128)
                    hl.Parent = p.Character
                end
            else
                if p.Character:FindFirstChild("OffESP") then
                    p.Character.OffESP:Destroy()
                end
            end
        end
    end
end)

-- True Noclip (Removes physics collision on all parts continuously)
local noclipConnection = nil
createToggle("Noclip (Sem Física nas Paredes)", function(state)
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            local char = localPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        local char = localPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
end)

print("OFFBATATA Mod Menu atualizado carregado com sucesso!")
