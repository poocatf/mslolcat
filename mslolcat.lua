local repo = 'https://raw.githubusercontent.com/deividcomsono/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local scriptName = "MSLOLCAT - Lobby"
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
    Default = false
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

local CreditsGroupBox = Tabs.Main:AddRightGroupbox("Credits")

CreditsGroupBox:AddLabel("Script by: Aquabeary & lolcat.")
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
