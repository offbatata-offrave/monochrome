-- OFFBATATA - Script otimizado para Delta Mobile
local success, errorMessage = pcall(function()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    -- Ajuste direto de velocidade e salto compatível com mobile
    humanoid.WalkSpeed = 50
    humanoid.JumpPower = 120
    
    print("OFFBATATA executado com sucesso no Delta!")
end)

if not success then
    warn("Erro na execução: " .. tostring(errorMessage))
end
