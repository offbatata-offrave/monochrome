-- OFFBATATA - Floating Button UI Script
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Prevent duplicate GUI
if CoreGui:FindFirstChild("OffbatataFloatingBtn") then
    CoreGui.OffbatataFloatingBtn:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OffbatataFloatingBtn"
ScreenGui.Parent = CoreGui

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0, 55, 0, 55)
TextButton.Position = UDim2.new(0, 50, 0, 200)
TextButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TextButton.BorderColor3 = Color3.fromRGB(0, 255, 128)
TextButton.BorderSizePixel = 2
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 14
TextButton.Font = Enum.Font.GothamBold
TextButton.Text = "OB"
TextButton.Parent = ScreenGui

-- Rounded corners for liquid glass aesthetic
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = TextButton

-- Glow effect
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 255, 128)
UIStroke.Thickness = 2
UIStroke.Parent = TextButton

-- Draggable functionality for mobile touch
local dragging, dragInput, dragStart, startPos

TextButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = TextButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        TextButton.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Button click action
TextButton.MouseButton1Click:Connect(function()
    print("OFFBATATA: Botão flutuante clicado!")
    -- Podes colocar a tua função de hack/script aqui em baixo
end)


