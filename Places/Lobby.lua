local repo = 'https://raw.githubusercontent.com/sxlent404/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local scriptName = "MSLOLCAT - Lobby | ".. identifyexecutor()
local Window = Library:CreateWindow({
    Title = scriptName,
    Center = true,
    AutoShow = true,
    Resizable = true,
    NotifySide = "Right",
    ShowCustomCursor = true,
    TabPadding = 2,
    MenuFadeTime = 0
})

Library.ShowCustomCursor = false

local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Utilities')

LeftGroupBox:AddSlider('WalkspeedSlider', {
    Text = 'Set Walkspeed',
    Default = 16,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        if Toggles.WalkspeedToggle.Value then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

LeftGroupBox:AddToggle('WalkspeedToggle', {
    Text = 'Enable Walkspeed',
    Default = false,
    Callback = function(Value)
        if Value then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Options.WalkspeedSlider.Value
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})

LeftGroupBox:AddToggle('FullbrightToggle', {
    Text = 'Fullbright',
    Default = false,
    Callback = function(Value)
        if Value then
            game.Lighting.Ambient = Color3.new(1, 1, 1)
        else
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end
})

LeftGroupBox:AddToggle('NoclipToggle', {
    Text = 'Noclip',
    Default = false,
    Callback = function(Value)
        if Value then
            game:GetService('RunService').Stepped:Connect(function()
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA('BasePart') then
                        part.CanCollide = false
                    end
                end
            end)
        else
            for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA('BasePart') then
                    part.CanCollide = true
                end
            end
        end
    end
})

local SniperGroupbox = Tabs.Main:AddLeftGroupbox("Sniper")

SniperGroupbox:AddToggle("ElevatorSniper", {
    Text = "Elevator Sniper",
    Default = false,
    Tooltip = "Doesn't work on all elevators, use at your own risk.",
    Risky = true
})

local playerDropdown = SniperGroupbox:AddDropdown("ElevatorSniperTarget", {
    SpecialType = "Player",
    Multi = false,
    Text = "Target"
})

playerDropdown:OnChanged(function()
    local players = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(players, player.Name)
        end
    end
    playerDropdown:SetValues(players)
end)

game:GetService('RunService').RenderStepped:Connect(function()
    if Toggles.ElevatorSniper.Value and Options.ElevatorSniperTarget.Value then
        local targetCharacter = workspace:FindFirstChild(Options.ElevatorSniperTarget.Value)
        if not targetCharacter then return end

        local targetElevatorID = targetCharacter:GetAttribute("InGameElevator")
        local currentElevatorID = game.Players.LocalPlayer.Character:GetAttribute("InGameElevator")
        if currentElevatorID == targetElevatorID then return end

        if targetElevatorID ~= nil then    
            local targetElevator = workspace.Lobby.LobbyElevators:FindFirstChild("LobbyElevator-" .. targetElevatorID) 

            if not targetElevator then
                for _, elevator in pairs(workspace.Lobby.LobbyElevators:GetChildren()) do
                    if elevator.Name:match("LobbyElevator") then
                        targetElevator = elevator
                    end
                end
            end

            if targetElevator then
                local remotesFolder = game:GetService("ReplicatedStorage"):FindFirstChild("RemotesFolder")
                if remotesFolder then
                    local elevatorJoin = remotesFolder:FindFirstChild("ElevatorJoin")
                    if elevatorJoin then
                        elevatorJoin:FireServer(targetElevator)
                    end
                end
            end
        elseif currentElevatorID ~= nil then
            local remotesFolder = game:GetService("ReplicatedStorage"):FindFirstChild("RemotesFolder")
            if remotesFolder then
                local elevatorExit = remotesFolder:FindFirstChild("ElevatorExit")
                if elevatorExit then
                    elevatorExit:FireServer()
                end
            end
        end
    end
end)

local MiscGroupBox = Tabs.Main:AddRightGroupbox("Miscellaneous")

MiscGroupBox:AddButton("Rejoin", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

MiscGroupBox:AddButton("Seek Plush", function()
        local plr = game.Players.LocalPlayer
        local hum = plr.Character:WaitForChild("Humanoid")

        local plush = game:GetObjects("rbxassetid://13613269677")[1]
        plush.Parent = plr.Backpack
        local anim = hum:LoadAnimation(plush.A.Hold)

        plush.Equipped:Connect(function()
        anim:Play()
        end)
        plush.Unequipped:Connect(function()
        anim:Stop()
        end)

        plush.Activated:Connect(function()
        plush.Toy:Play()
        end)
end)

local CreditsGroupBox = Tabs.Main:AddRightGroupbox("Credits")

CreditsGroupBox:AddLabel("Script by: Aquabeary & poocat.")
CreditsGroupBox:AddButton("Copy Discord Link", function()
    setclipboard("https://discord.gg/jw8G89KDMQ")
    Library:Notify("Discord link copied to clipboard!", 5)
end)

local AchievementsGroupbox = Tabs.Main:AddLeftGroupbox("Achievements")

local function showAchievement(title, desc, reason, imageId)
    if not imageId then return end

    local holder = game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainUI")
    if not holder or not holder:FindFirstChild("AchievementsHolder") then return end
    holder = holder.AchievementsHolder
    local originalAchievement = holder:FindFirstChild("Achievement")
    if not originalAchievement then return end

    local newAchievement = originalAchievement:Clone()
    newAchievement.Name = "Achievement_" .. #holder:GetChildren()
    newAchievement.Parent = holder

    newAchievement.Frame.Details.Title.Text = title
    newAchievement.Frame.Details.Desc.Text = desc
    newAchievement.Frame.Details.Reason.Text = reason
    newAchievement.Frame.ImageLabel.Image = "rbxassetid://" .. imageId
    newAchievement.Sound:Play()

    newAchievement.Size = UDim2.new(0, 0, 0, 0)
    newAchievement.Frame.Position = UDim2.new(1.1, 0, 0, 0)
    newAchievement.Visible = true

    newAchievement:TweenSize(UDim2.new(1, 0, 0.2, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.8, true)
    task.wait(0.8)
    newAchievement.Frame:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)

    game:GetService("TweenService"):Create(newAchievement.Frame.Glow, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ImageTransparency = 1
    }):Play()

    task.wait(4)

    newAchievement.Frame:TweenPosition(UDim2.new(1.1, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.5, true)
    task.wait(0.5)
    newAchievement:TweenSize(UDim2.new(1, 0, -0.1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.5, true)
    task.wait(0.5)

    newAchievement:Destroy()
end

local achievements = {
    QATester = {
        Title = "QA Tester",
        Desc = "Get back to work! I said get back to work!",
        Reason = "Test stuff.",
        ImageId = 12309073114
    },
    EscapeFools = {
        Title = "Survival The Jeff The Killer",
        Desc = "That was a weird dream.",
        Reason = "Beat SUPER HARD MODE!! (April Fools 2023)",
        ImageId = 1599599335
    },
    SurviveGlitchTrial = {
        Title = "Trial And Error",
        Desc = "I.. I think I'm seeing things.",
        Reason = "Encounter and survive an activated Glitch Fragment.",
        ImageId = 120455443165145
    },
    TrickOrTreat2024_100 = {
        Title = "Sugar Rush",
        Desc = "WHOOO!!!",
        Reason = "Eat 100 Candy during the 2024 Trick Or Treat.",
        ImageId = 108636352480928
    },
    TrickOrTreat2024_500 = {
        Title = "Sugar Crash",
        Desc = "Maybe I've had too much... What do you think?",
        Reason = "Eat 500 Candy during the 2024 Trick Or Treat.",
        ImageId = 73546447955187
    },
    GweenSoda = {
        Title = "You Finally Turn Green",
        Desc = "Yaayyy!",
        Reason = "Drink a Gween Soda and finally turn green.",
        ImageId = 72669735229148 -- GweenSoda: rbxassetid://72669735229148
    },
    EscapeHotelMod2 = {
        Title = "Hotel Hell",
        Desc = "This is the worst hotel I've ever stayed at.",
        Reason = "Escape The Hotel with at least a 150% bonus using Modifiers.",
        ImageId = 14573237895 -- EscapeHotelMod2: rbxassetid://14573237895
    },
    A1000 = {
        Title = "A-1000",
        Desc = "I can't feel my legs.",
        Reason = "Reach the end of The Rooms.",
        ImageId = 12307813676
    }
}

for name, achievement in pairs(achievements) do
    AchievementsGroupbox:AddButton(achievement.Title, function()
        showAchievement(achievement.Title, achievement.Desc, achievement.Reason, achievement.ImageId)
    end)
end

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('MSLOLCAT')
SaveManager:SetFolder('MSLOLCAT/Lobby')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()
