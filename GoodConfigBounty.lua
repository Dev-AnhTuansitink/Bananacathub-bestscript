task.spawn(function() 
    local VirtualInputManager = game:GetService("VirtualInputManager")
    _G.AntiStuckLoop = true 
    
    while _G.AntiStuckLoop do
        
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.D, false, game)
        task.wait(0.5)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.D, false, game)
        
        
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.A, false, game)
        task.wait(0.5)
        
        
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.A, false, game)
        
        
        task.wait(0.7) 
    end
end)
task.spawn(function() 
    while task.wait(0.5) do
        if getgenv().Setting["Hitbox"].Enabled then
            local s = getgenv().Setting["Hitbox"].Size
            local t = getgenv().Setting["Hitbox"].Transparency
            pcall(function()
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") then
                        v.HumanoidRootPart.Size = Vector3.new(s, s, s)
                        v.HumanoidRootPart.Transparency = t
                        v.HumanoidRootPart.CanCollide = false
                    end
                end
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        p.Character.HumanoidRootPart.Size = Vector3.new(s, s, s)
                        p.Character.HumanoidRootPart.Transparency = t
                        p.Character.HumanoidRootPart.CanCollide = false
                    end
                end
            end)
        end
    end
end)


spawn(function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local lp = Players.LocalPlayer
    local lastJump = 0

    RunService.RenderStepped:Connect(function()
        local char = lp.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChild("Humanoid")
        if not root or not humanoid then return end

        local cam = workspace.CurrentCamera
        local goal = CFrame.new(root.Position + Vector3.new(0, 4.5, 0)) * root.CFrame.Rotation * CFrame.new(0, 10, 30)
        cam.CFrame = cam.CFrame:Lerp(goal, 0.2)

        if tick() - lastJump >= 3 then
            humanoid.Jump = true
            lastJump = tick()
        end
    end)
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/SkibidiHub111/.lua/refs/heads/main/moudlefastattack"))() 