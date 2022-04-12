local Part = Instance.new("Part", game.Workspace) Part.CFrame = CFrame.new(-1117.5, 28.5, 0) Part.Anchored = true Part.Size = Vector3.new(2030, 73, 160) Part.Transparency = 1 Part.CanCollide = false
local key = "\230\147\141\228\189\160\240\159\146\166\240\159\146\148\240\159\141\145\240\159\145\140\240\159\146\166\230\147\141\228\189\160\240\159\146\166\240\159\146\148\240\159\141\145\240\159\145\140\240\159\146\166\240\159\146\148\240\159\141\145\240\159\145\140\240\159\146\166\240\159\146\148\240\159\141\145\240\159\145\140\240\159\146\148\240\159\141\145\240\159\145\140\240\159\146\166\240\159\146\148\240\159\141\145\240\159\145\140"
local QuestFolder = game:GetService("Players").LocalPlayer.PlayerFolder.CurrentQuest
local Yoshitoki = game:GetService("Workspace").CCGBuilding.Yoshitoki
local tweenS = game:GetService("TweenService")
local Speed = 140
local DiedTimer = 6
local ClickSkill, ESkill,RSkill,FSkill,CSkill,GSSkill = false,false,false,false,false,false
local Stage = "one"
local NPCFarm = false
local AutoQuest = false
local AutoCorpse = false
local Stat = "Weapon"
local DistanceForFarm = 3 
local AutoSpentFocusPoints = false
local Training = false
local AutoCashOut = false
local AntiAFK = false
local AutoMask = false
local AutoArata = false
local BossPriority = false
local UpdateDelay = 5
local FarmKills = 0
local CorpseDelay = 0.4
local BoxEsp = false
local TeammateEsp, PlayersEsp, NPCEsp = false,false,false
local limit = 100000
local InstaUpdate = false
local TeammateColor, EnemyColor, NPCColor = Color3.fromRGB(0,255,0), Color3.fromRGB(255,0,0), Color3.fromRGB(0,0,255)
local NPCsToFarm = {}
if _G.Kills == nil then _G.Kills = 0 end
if not fireclickdetector then
    print("AutoCorpseNotAvaible!")
end
--Functions place
local function TargetList(Target, add) -- Function Of Target List For Farm
    if add then 
        if not table.find(NPCsToFarm, Target) then
            table.insert(NPCsToFarm, Target)
        else
            print("ADDTARGETTOFARMLISTFUNCTION: This Target Already exists!")
        end
    else
        if table.find(NPCsToFarm, Target) then
            table.remove(NPCsToFarm, table.find(NPCsToFarm, Target))
        else
            print("ADDTARGETTOFARMLISTFUNCTION: Target not found!")
        end
    end
end

local function AddESP(NPC) 
    pcall(function()
        if NPC:FindFirstChild("HumanoidRootPart") and not NPC:FindFirstChild("EspBox") then
            local ESPPART = Instance.new("BoxHandleAdornment", NPC)
            ESPPART.Name = "EspBox"
            ESPPART.Transparency = 0.3
            ESPPART.Adornee = NPC.HumanoidRootPart
            ESPPART.Size = NPC.HumanoidRootPart.Size
            if game:GetService("Players").LocalPlayer:WaitForChild("PlayerFolder").Allied:FindFirstChild(NPC.Name) then
                ESPPART.Color3 = TeammateColor
            else
                if game.Players:FindFirstChild(NPC.Name) then
                    ESPPART.Color3 = EnemyColor
                else
                    ESPPART.Color3 = NPCColor
                end
            end
            ESPPART.AlwaysOnTop = true
            ESPPART.ZIndex = 0
        elseif NPC:FindFirstChild("EspBox") then
            if game.Players.LocalPlayer.PlayerFolder.Allied:FindFirstChild(NPC.Name) and NPC:WaitForChild("EspBox").Color3 ~= TeammateColor then
                NPC:WaitForChild("EspBox").Color3 = TeammateColor
            elseif (not game.Players.LocalPlayer.PlayerFolder.Allied:FindFirstChild(NPC.Name)) and game.Players:FindFirstChild(NPC.Name) and NPC:WaitForChild("EspBox").Color3 ~= EnemyColor then
                NPC:WaitForChild("EspBox").Color3 = EnemyColor
            elseif (not game.Players:FindFirstChild(NPC.Name)) and NPC:WaitForChild("EspBox").Color3 ~= NPCColor then
                NPC:WaitForChild("EspBox").Color3 = NPCColor
            end
        end
    end)
end

local function SafeZoneChecker(Part)
    for i,Zone in pairs(game:GetService("Workspace").SafeZones:GetChildren()) do
        local MinX = Zone.Position.X - Zone.Size.X / 2
        local MinZ = Zone.Position.Z - Zone.Size.Z / 2 
        local MaxX = Zone.Position.X + Zone.Size.X / 2 
        local MaxZ = Zone.Position.Z + Zone.Size.Z / 2 
        if Part.Position.X > MinX and Part.Position.X < MaxX and Part.Position.Z > MinZ and Part.Position.Z < MaxZ then
            return true
        end
    end
    return false
end

local Human, Athlete, HighRankA, MidRankA, LowRankA, Rank1I, Rank2I, FirstClassI,NishikiBoss,AmonBoss,EtoBoss = false,false,false,false,false,false,false,false,false,false,false
local function didQuestCompleted() if tonumber(QuestFolder.Complete["Aogiri Member"].Value) == tonumber(QuestFolder.Complete["Aogiri Member"].Max.Value) then return true else return false end end
local library = loadstring(game:HttpGet("https://pastebin.com/raw/aJbGMHHn"))()
local FarmUI = library:Window("Farm UI")
local HumanToggle = FarmUI:Toggle("Human", false, function(value) TargetList("Human", value) end)
local AthleteToggle = FarmUI:Toggle("Athlete", false, function(value) TargetList("Athlete", value) end)
local HighRankAToggle = FarmUI:Toggle("HR Aogiri",false,function(value) TargetList("High Rank Aogiri Member", value) end)
local MidRankAToggle = FarmUI:Toggle("MR Aogiri",false,function(value) TargetList("Mid Rank Aogiri Member", value) end)
local LowRankAToggle = FarmUI:Toggle("LR Aogiri",false,function(value) TargetList("Low Rank Aogiri Member", value) end)
local Rank1IToggle = FarmUI:Toggle("Rank1 Invest",false,function(value) TargetList("Rank 1 Investigator", value) end)
local Rank2IToggle = FarmUI:Toggle("Rank2 Invest",false,function(value) TargetList("Rank 2 Investigator", value) end)
local FirstClassIToggle = FarmUI:Toggle("1stClass Invest",false,function(value) TargetList("First Class Investigator", value) end)
local NishikiBossToggle = FarmUI:Toggle("Nishiki Boss", false, function(value) TargetList("Nishiki Nishio", value) end)
local AmonBossToggle = FarmUI:Toggle("Amon Boss",false, function(value) TargetList("Koutarou Amon", value) end)
local EtoBossToggle = FarmUI:Toggle("Eto Boss", false, function(value) TargetList("Eto Yoshimura",value) end)
local FarmSpeedSlider = FarmUI:Slider("Farm Speed",50,200,Speed, function(value) Speed = value end)
local ESkillToggle = FarmUI:Toggle("E Skill", false, function(value) ESkill = value end)
local RSkillToggle = FarmUI:Toggle("R Skill", false, function(value) RSkill = value end)
local FSkillToggle = FarmUI:Toggle("F Skill", false, function(value) FSkill = value end)
local CSkillToggle = FarmUI:Toggle("C SKill", false, function(value) CSkill = value end)
local GSkillToggle = FarmUI:Toggle("G SKill", false, function(value) GSSkill = value end)
local ClickSkillToggle = FarmUI:Toggle("Click Skill", false, function(value) ClickSkill = value end)
local StageDropdown = FarmUI:Dropdown("Farm Stage", {"One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Zero"}, function(value) Stage = value end)
local DistanceForFarmSlider = FarmUI:Slider("Distance",0,80,DistanceForFarm,function(value) DistanceForFarm = value end)
local FarmUI2 = library:Window("Farm UI2")
local AutoQuestToggle = FarmUI2:Toggle("Auto Quest", false, function(value) AutoQuest = value end)
local AutoCashOutToggle = FarmUI2:Toggle("Auto CashOut", false, function(value) AutoCashOut=value end)
local CorpseDelaySlider = FarmUI2:Slider("Auto Corpse Speed(ms)", 0, 200, 40, function(value) CorpseDelay = value / 100 end)
local AutoCorpseToggle = FarmUI2:Toggle("Auto Corpse", false, function(value) AutoCorpse = value end)
local AutoMaskToggle = FarmUI2:Toggle("Auto Mask", false, function(value) AutoMask = value end)
local AutoArataToggle = FarmUI2:Toggle("Auto Arata", false, function(value) AutoArata = value end)

local BossPriorityToggle = FarmUI2:Toggle("Boss Priority", false ,function(value) BossPriority = value end)
local NPCFarmToggle = FarmUI2:Toggle("Farm", false, function(value) NPCFarm = value Part.CanCollide = value end)
local VisualUI = library:Window("Visual UI")
local WallHackLabel = VisualUI:Label("WallHack", true)
local TeammateColorBox = VisualUI:ColorPicker("Teammate Color", TeammateColor, function(value) TeammateColor = value end)
local EnemyColorBox = VisualUI:ColorPicker("Enemy Color", EnemyColor, function(value) EnemyColor = value end)
local NPCColorBox = VisualUI:ColorPicker("NPC Color", NPCColor, function(value) NPCColor = value end)
local UpdateDelaySlider = VisualUI:Slider("Update Delay", 0, 25, UpdateDelay, function(value) UpdateDelay = value end)
local PlayersEspToggle = VisualUI:Toggle("Enemy Esp", PlayersEsp, function(value) PlayersEsp = value end)
local NPCEspToggle = VisualUI:Toggle("NPC Esp", NPCEsp, function(value) NPCEsp = value end)
local BoxEspToggle = VisualUI:Toggle("BoxEsp", false, function(value) BoxEsp = value end)

local MiscUI = library:Window("Misc UI")
local SkillSelectionDropdown = MiscUI:Dropdown("Stat", {"Physical","Weapon", "Durability", "Speed"}, function(value) Stat = value end)
local AutoSpentFocus = MiscUI:Toggle("Auto Spent Focus", false, function(value) AutoSpentFocusPoints=value end)
local AntiAFKToggle = MiscUI:Toggle("AntiAFK", false, function(value) AntiAFK = value end)

local StatsUI = library:Window("Farm Stats")
local KilledLabel = StatsUI:Label("Kills: " .. _G.Kills, Color3.new(255,255,255), "LabelOfKills")
local InstantUpdate = StatsUI:Toggle("Insta Update", false, function(value) InstaUpdate = value end)

local KeyBind = library:Keybind("P")
spawn(function()
    while wait(.3) do
        StatsUI:UpdateLabel("Farm Stats", "LabelOfKills", "Kills: " .. _G.Kills, false)
    end 
end)

spawn(function()
    while wait() do
        pcall(function()
            if AutoSpentFocusPoints then
                if tonumber(game:GetService("Players").LocalPlayer:WaitForChild("PlayerFolder").Stats.Focus.Value) ~= 0 then
                    game:GetService("Players").LocalPlayer:WaitForChild("PlayerFolder").StatsFunction:InvokeServer("Focus", Stat.."AddButton", tonumber(game:GetService("Players").LocalPlayer.PlayerFolder.Stats.Focus.Value))
                end
            end
        end)
    end
end)

spawn(function()
    wait(3) 
    local VirtualUser=game:GetService'VirtualUser' 
    game:GetService('Players').LocalPlayer.Idled:Connect(function() 
        if AntiAFK then
            VirtualUser:CaptureController() 
            VirtualUser:ClickButton2(Vector2.new()) 
        end
    end) 
end)
spawn(function()
    while wait() do
        pcall(function()
            if game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y < 0.7 then
                game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health = 0
                print("Killed!")
                wait(2)
            end
        end)
    end
end)
spawn(function()
    while wait() do
        local MinDistance = 9999999999
        local TargetCharacterForFarm = nil
        local ParentOfTarget = nil
        --search Nearest Aogiri

        for i,v in pairs(game.Workspace.NPCSpawns:GetChildren()) do
            if v:FindFirstChildOfClass("Model") and table.find(NPCsToFarm, v:FindFirstChildOfClass("Model").Name) and v:FindFirstChildOfClass("Model"):FindFirstChild("Humanoid") and v:FindFirstChildOfClass("Model"):FindFirstChild("Humanoid").Health ~= 0 then
                if game.Players.LocalPlayer:DistanceFromCharacter(v:FindFirstChildOfClass("Model").HumanoidRootPart.Position) <= MinDistance then
                    if SafeZoneChecker(v:FindFirstChildOfClass("Model").HumanoidRootPart) then continue end
                    if v:FindFirstChildOfClass("Model").Name == "Nishiki Nishio" and tonumber(game:GetService("Players").LocalPlayer.PlayerFolder.Stats.Level.Value) < 250 then continue end
                    if v:FindFirstChildOfClass("Model").Name == "Koutarou Amon" and tonumber(game:GetService("Players").LocalPlayer.PlayerFolder.Stats.Level.Value) < 750 then continue end
                    if v:FindFirstChildOfClass("Model").Name == "Eto Yoshimura" and tonumber(game:GetService("Players").LocalPlayer.PlayerFolder.Stats.Level.Value) < 1250 then continue end
                    MinDistance = game.Players.LocalPlayer:DistanceFromCharacter(v:FindFirstChildOfClass("Model").HumanoidRootPart.Position)
                    TargetCharacterForFarm = v:FindFirstChildOfClass("Model")
                    ParentOfTarget = TargetCharacterForFarm.Parent
                end
            end
        end
        if BossPriority then
            for i,v in pairs(game.Workspace.NPCSpawns:GetChildren()) do
                if v:FindFirstChildOfClass("Model") and table.find(NPCsToFarm, v:FindFirstChildOfClass("Model").Name) and v:FindFirstChildOfClass("Model"):FindFirstChild("Humanoid") and v:FindFirstChildOfClass("Model"):FindFirstChild("Humanoid").Health ~= 0 then
                    if v:FindFirstChild("Nishiki Nishio") or v:FindFirstChild("Koutarou Amon") or v:FindFirstChild("Eto Yoshimura") then
                        if SafeZoneChecker(v:FindFirstChildOfClass("Model").HumanoidRootPart) then continue end
                        if v:FindFirstChildOfClass("Model").Name == "Nishiki Nishio" and tonumber(game:GetService("Players").LocalPlayer.PlayerFolder.Stats.Level.Value) < 250 then continue end
                        if v:FindFirstChildOfClass("Model").Name == "Koutarou Amon" and tonumber(game:GetService("Players").LocalPlayer.PlayerFolder.Stats.Level.Value) < 750 then continue end
                        if v:FindFirstChildOfClass("Model").Name == "Eto Yoshimura" and tonumber(game:GetService("Players").LocalPlayer.PlayerFolder.Stats.Level.Value) < 1250 then continue end
                        MinDistance = game.Players.LocalPlayer:DistanceFromCharacter(v:FindFirstChildOfClass("Model").HumanoidRootPart.Position)
                        TargetCharacterForFarm = v:FindFirstChildOfClass("Model")
                        ParentOfTarget = TargetCharacterForFarm.Parent
                    end
                end
            end
        end
        --game:GetService("Players").Morph9x.PlayerFolder.CurrentQuest.Complete["Aogiri Member"].Max
        pcall(function()
            while NPCFarm do   
                if ParentOfTarget:FindFirstChildOfClass("Model") and TargetCharacterForFarm:FindFirstChild("Humanoid") and TargetCharacterForFarm:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health ~= 0 and not SafeZoneChecker(TargetCharacterForFarm.HumanoidRootPart) then
                    if not game.Players.LocalPlayer.Character:FindFirstChild("Mask") and AutoMask then game:GetService("Players").LocalPlayer.Character.Remotes.KeyEvent:FireServer(key, "M", "Down", CFrame.new(), CFrame.new()) end 
                    if AutoArata and game:GetService("Players").LocalPlayer.PlayerFolder.Customization.Team.Value == "CCG" then
                        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Humanoid and game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 then
                            if game.Players.LocalPlayer.Character:FindFirstChild("Arata") then
                                if game.Players.LocalPlayer.PlayerGui.ArataStamina and game:GetService("Players").LocalPlayer.PlayerGui.ArataStamina.Back.Main.Bar.Size.Y.Scale == 0 then
                                    game:GetService("Players").LocalPlayer.Character.Remotes.KeyEvent:FireServer(key, "Zero", "Down", CFrame.new(), CFrame.new())
                                end
                            else
                                game:GetService("Players").LocalPlayer.Character.Remotes.KeyEvent:FireServer(key, "Zero", "Down", CFrame.new(), CFrame.new())
                            end
                        end
                    end

                    if AutoQuest and ((not QuestFolder:FindFirstChild("QuestType")) or didQuestCompleted()) then
                        while wait() do
                            if AutoQuest and not QuestFolder:FindFirstChild("QuestType") or didQuestCompleted() then 
                                local Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Yoshitoki.HumanoidRootPart.Position).Magnitude
                                local FarmInfo = TweenInfo.new(Distance/Speed)
                                local FarmGoal = {}
                                FarmGoal.CFrame = Yoshitoki.HumanoidRootPart.CFrame
                                local Farm = tweenS:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, FarmInfo, FarmGoal)
                                if Distance <= 3 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Yoshitoki.HumanoidRootPart.CFrame
                                    wait(0.2)
                                    if AutoCashOut then game:GetService("ReplicatedStorage").Remotes.ReputationCashOut:InvokeServer() end
                                    game:GetService("ReplicatedStorage").Remotes.Yoshitoki.Task:InvokeServer();
                                elseif game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then
                                    break
                                elseif not AutoQuest or not NPCFarm then
                                    break
                                else
                                    Farm:Play()
                                end
                            elseif QuestFolder:FindFirstChild("QuestType") then
                                break
                            elseif didQuestCompleted() then
                                break
                            elseif game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then
                                --wait(DiedTimer)
                                break
                            else
                                break
                            end
                        end
                    end
                    local TarHum = TargetCharacterForFarm:FindFirstChild("Humanoid")
                    local TarHumPart = TargetCharacterForFarm:FindFirstChild("HumanoidRootPart")
                    local TargetPos = TarHumPart.CFrame
                    local Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - TargetPos.Position).Magnitude
                    local FarmInfo = TweenInfo.new(Distance/Speed)
                    local FarmGoal = {}
                    FarmGoal.CFrame = TargetPos*CFrame.new(0,0,DistanceForFarm)
                    local Farm = tweenS:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, FarmInfo, FarmGoal)
                    if Distance <= DistanceForFarm+3 then
                        if game.Players.LocalPlayer.Character:FindFirstChild("Quinque") or game.Players.LocalPlayer.Character:FindFirstChild("Kagune") then
                            if SafeZoneChecker(TarHumPart) then break end
                            if ESkill then game:GetService("Players").LocalPlayer.Character.Remotes.KeyEvent:FireServer(key, "E", "Down", CFrame.new(), CFrame.new()) end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TarHumPart.CFrame * CFrame.new(0,0,DistanceForFarm)-- * CFrame.new(0, 0, -1.5)
                            if RSkill then game:GetService("Players").LocalPlayer.Character.Remotes.KeyEvent:FireServer(key, "R", "Down", CFrame.new(), CFrame.new()) end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TarHumPart.CFrame * CFrame.new(0,0,DistanceForFarm)-- * CFrame.new(0, 0, -1.5)
                            if FSkill then game:GetService("Players").LocalPlayer.Character.Remotes.KeyEvent:FireServer(key, "F", "Down", CFrame.new(), CFrame.new()) end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TarHumPart.CFrame * CFrame.new(0,0,DistanceForFarm)
                            if CSkill then game:GetService("Players").LocalPlayer.Character.Remotes.KeyEvent:FireServer(key, "С", "Down", CFrame.new(), CFrame.new()) end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TarHumPart.CFrame * CFrame.new(0,0,DistanceForFarm)
                            if GSSkill then game:GetService("Players").LocalPlayer.Character.Remotes.KeyEvent:FireServer(key, "G", "Down", CFrame.new(), CFrame.new()) end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TarHumPart.CFrame * CFrame.new(0,0,DistanceForFarm)
                            if ClickSkill then game:GetService("Players").LocalPlayer.Character.Remotes.KeyEvent:FireServer(key, "Mouse1", "Down", CFrame.new(), CFrame.new()) end
                        else
                            game:GetService("Players").LocalPlayer.Character.Remotes.KeyEvent:FireServer(key, Stage, "Down", CFrame.new(), CFrame.new())
                        end
                    elseif game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then
                        --wait(DiedTimer)
                        break
                    elseif SafeZoneChecker(TarHumPart) then
                        break
                    elseif not NPCFarm then
                        break
                    else
                        Farm:Play()
                    end
                elseif not ParentOfTarget:FindFirstChildOfClass("Model") then
                    break
                elseif not ParentOfTarget:FindFirstChildOfClass("Model"):FindFirstChild("Humanoid") then
                    pcall(function()
                        if AutoCorpse and fireclickdetector ~= nil then
                            repeat
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ParentOfTarget:FindFirstChildOfClass("Model"):FindFirstChildOfClass("Model").ClickPart.CFrame
                                fireclickdetector(ParentOfTarget:FindFirstChildOfClass("Model"):FindFirstChildOfClass("Model").ClickPart:FindFirstChildOfClass("ClickDetector"))
                                wait()
                            until not ParentOfTarget:FindFirstChildOfClass("Model"):FindFirstChildOfClass("Model") or game.Players.LocalPlayer.Character.Humanoid.Health == 0 or not ParentOfTarget:FindFirstChildOfClass("Model"):FindFirstChildOfClass("Model"):FindFirstChild("ClickPart") or not ParentOfTarget:FindFirstChildOfClass("Model"):FindFirstChildOfClass("Model"):FindFirstChild("ClickPart"):FindFirstChildOfClass("ClickDetector")
                            wait(CorpseDelay)
                        end
                    end)
                    _G.Kills = _G.Kills + 1
                    if InstaUpdate then
                        StatsUI:UpdateLabel("Farm Stats", "LabelOfKills", "Kills: " .. _G.Kills, false)
                    end

                    break
                elseif game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then
                    wait(DiedTimer)
                end
            wait()
            end
        end)
    end
end)

spawn(function()
    while wait(UpdateDelay) do
        if BoxEsp then
            if PlayersEsp then
                for i,v in pairs(game.Players:GetPlayers()) do
                    pcall(function()
                        if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:WaitForChild("Humanoid").Health ~= 0 and v.Name ~= game.Players.LocalPlayer.Name then
                            AddESP(v.Character)
                        end 
                    end)
                end
            end
            if NPCEsp then
                for i,v in pairs(game.Workspace.NPCSpawns:GetChildren()) do
                    pcall(function()
                        if v:FindFirstChildOfClass("Model") and v:FindFirstChildOfClass("Model"):FindFirstChild("Humanoid") and v:FindFirstChildOfClass("Model"):FindFirstChild("HumanoidRootPart") and v:FindFirstChildOfClass("Model"):WaitForChild("Humanoid").Health ~= 0  then
                            AddESP(v:FindFirstChildOfClass("Model"))
                        end 
                    end)
                end
            end
        end
    end
end)
