for i,v in pairs(game.Players:GetPlayers()) do
    v.CharacterAdded:Connect(function()
        while wait() do
            if v.Character:FindFirstChild("Head") then
                break
            end
        end
        if v.Name ~= game.Players.LocalPlayer.Name then
            local bgui = Instance.new("BillboardGui", v.Character.Head)
            bgui.Name = "EXOLUTION::NAMETAG"
            bgui.AlwaysOnTop = true
            bgui.ExtentsOffset = Vector3.new(0,2,0)
            bgui.Size = UDim2.new(0,200,0,50)
            local NameTag = Instance.new("TextLabel",bgui)
            NameTag.Text = v.Name
            NameTag.BackgroundTransparency = 1
            NameTag.TextSize = 14
            NameTag.Font = ("Arial")
            NameTag.TextColor3 = Color3.fromRGB(11, 173, 0)
            NameTag.TextStrokeTransparency = 0
            NameTag.Size = UDim2.new(1,0,1,0)
            
            if v:FindFirstChild("Backpack") and v.Character then
                if v.Backpack:FindFirstChild("Gun") then
                    NameTag.TextColor3 = Color3.fromRGB(50,50,255)
                elseif v.Character:FindFirstChild("Gun") then
                    NameTag.TextColor3 = Color3.fromRGB(50,50,255)
                end
                
                if v.Backpack:FindFirstChild("Knife") then
                    NameTag.TextColor3 = Color3.fromRGB(255,100,100)
                elseif v.Character:FindFirstChild("Knife") then
                    NameTag.TextColor3 = Color3.fromRGB(255,100,100)
                end 

                v.Backpack.ChildAdded:Connect(function(tool)
                    if tool.Name == "Gun" then
                        NameTag.TextColor3 = Color3.fromRGB(50,50,255)
                    elseif tool.Name == "Knife" then
                        NameTag.TextColor3 = Color3.fromRGB(255,100,100)
                    end
                end)
                v.Character.ChildAdded:Connect(function(tool)
                    if tool.Name == "Gun" then
                        NameTag.TextColor3 = Color3.fromRGB(50,50,255)
                    elseif tool.Name == "Knife" then
                        NameTag.TextColor3 = Color3.fromRGB(255,100,100)
                    end
                end)
            end
            
        end
    end)
    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and not v.Character.Head:FindFirstChild("EXOLUTION::NAMETAG") then
        local bgui = Instance.new("BillboardGui", v.Character.Head)
        bgui.Name = "EXOLUTION::NAMETAG"
        bgui.AlwaysOnTop = true
        bgui.ExtentsOffset = Vector3.new(0,2,0)
        bgui.Size = UDim2.new(0,200,0,50)
        local NameTag = Instance.new("TextLabel",bgui)
        NameTag.Text = v.Name
        NameTag.BackgroundTransparency = 1
        NameTag.TextSize = 14
        NameTag.Font = ("Arial")
        NameTag.TextColor3 = Color3.fromRGB(11, 173, 0)
        NameTag.TextStrokeTransparency = 0
        NameTag.Size = UDim2.new(1,0,1,0)
            
        if v:FindFirstChild("Backpack") and v.Character then
            if v.Backpack:FindFirstChild("Gun") then
                NameTag.TextColor3 = Color3.fromRGB(50,50,255)
            elseif v.Character:FindFirstChild("Gun") then
                NameTag.TextColor3 = Color3.fromRGB(50,50,255)
            end
                
            if v.Backpack:FindFirstChild("Knife") then
                NameTag.TextColor3 = Color3.fromRGB(255,100,100)
            elseif v.Character:FindFirstChild("Knife") then
                NameTag.TextColor3 = Color3.fromRGB(255,100,100)
            end 

            v.Backpack.ChildAdded:Connect(function(tool)
                if tool.Name == "Gun" then
                    NameTag.TextColor3 = Color3.fromRGB(50,50,255)
                elseif tool.Name == "Knife" then
                    NameTag.TextColor3 = Color3.fromRGB(255,100,100)
                end
            end)
            v.Character.ChildAdded:Connect(function(tool)
                if tool.Name == "Gun" then
                    NameTag.TextColor3 = Color3.fromRGB(50,50,255)
                elseif tool.Name == "Knife" then
                    NameTag.TextColor3 = Color3.fromRGB(255,100,100)
                end
            end)
        end
    end
end

game.Players.ChildAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        while wait() do
            if plr.Character:FindFirstChild("Head") then
                break
            end
        end
        if plr.Name ~= game.Players.LocalPlayer.Name then
            local bgui = Instance.new("BillboardGui", plr.Character.Head)
            bgui.Name = "EXOLUTION::NAMETAG"
            bgui.AlwaysOnTop = true
            bgui.ExtentsOffset = Vector3.new(0,2,0)
            bgui.Size = UDim2.new(0,200,0,50)
            local NameTag = Instance.new("TextLabel",bgui)
            NameTag.Text = plr.Name
            NameTag.BackgroundTransparency = 1
            NameTag.TextSize = 14
            NameTag.Font = ("Arial")
            NameTag.TextColor3 = Color3.fromRGB(11, 173, 0)
            NameTag.TextStrokeTransparency = 0
            NameTag.Size = UDim2.new(1,0,1,0)
            
            if plr:FindFirstChild("Backpack") and plr.Character then
                if plr.Backpack:FindFirstChild("Gun") then
                    NameTag.TextColor3 = Color3.fromRGB(50,50,255)
                elseif plr.Character:FindFirstChild("Gun") then
                    NameTag.TextColor3 = Color3.fromRGB(50,50,255)
                end
                
                if plr.Backpack:FindFirstChild("Knife") then
                    NameTag.TextColor3 = Color3.fromRGB(255,100,100)
                elseif plr.Character:FindFirstChild("Knife") then
                    NameTag.TextColor3 = Color3.fromRGB(255,100,100)
                end 

                plr.Backpack.ChildAdded:Connect(function(tool)
                    if tool.Name == "Gun" then
                        NameTag.TextColor3 = Color3.fromRGB(50,50,255)
                    elseif tool.Name == "Knife" then
                        NameTag.TextColor3 = Color3.fromRGB(255,100,100)
                    end
                end)
                plr.Character.ChildAdded:Connect(function(tool)
                    if tool.Name == "Gun" then
                        NameTag.TextColor3 = Color3.fromRGB(50,50,255)
                    elseif tool.Name == "Knife" then
                        NameTag.TextColor3 = Color3.fromRGB(255,100,100)
                    end
                end)
            end
        end
    end)
end)
