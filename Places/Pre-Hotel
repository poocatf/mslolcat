local repo = 'https://raw.githubusercontent.com/sxlent404/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local scriptName = "MSLOLCAT - Pre-Hotel | " .. identifyexecutor()
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
    Settings = Window:AddTab('UI Settings'),
}

local PlayerGroupBox = Tabs.Main:AddLeftGroupbox('Player')
local VisualsGroupBox = Tabs.Main:AddRightGroupbox('Visuals')

PlayerGroupBox:AddToggle('EnableSpeedHack', {
    Text = 'Enable Speed Hack',
    Default = false
})

PlayerGroupBox:AddSlider('WalkSpeed', {
    Text = 'Walk Speed',
    Default = 16,
    Min = 0,
    Max = 75,
    Rounding = 0,
    Compact = true
})

PlayerGroupBox:AddToggle('Noclip', {
    Text = 'Noclip',
    Default = false
}):AddKeyPicker('NoclipKey', {
    Mode = 'Toggle',
    Default = 'N',
    Text = 'Noclip',
    SyncToggleState = true
})

PlayerGroupBox:AddToggle('NoCooldownProximityPrompts', {
    Text = 'No Cooldown',
    Default = false
})

VisualsGroupBox:AddToggle('Fullbright', {
    Text = 'Fullbright',
    Default = false
})

VisualsGroupBox:AddToggle('NoAccel', {
    Text = 'No Acceleration',
    Default = false
})

VisualsGroupBox:AddToggle('NoCutscenes', {
    Text = 'No Cutscenes',
    Default = false
})

Toggles.EnableSpeedHack:OnChanged(function(value)
    if value then
        while Toggles.EnableSpeedHack.Value do
            wait(0.1)
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = Options.WalkSpeed.Value
            end
        end
    else
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

local noclipEnabled = false
local noclipConnection

Toggles.Noclip:OnChanged(function(value)
    noclipEnabled = value
    if noclipEnabled then
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            local player = game.Players.LocalPlayer
            if player and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
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
    end
end)

local originalDurations = {}

local function saveOriginalDurations()
    for _, prompt in pairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            originalDurations[prompt] = prompt.HoldDuration
        end
    end
end

local function setDurationsToZero()
    for _, prompt in pairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            prompt.HoldDuration = 0
        end
    end
end

local function restoreOriginalDurations()
    for prompt, duration in pairs(originalDurations) do
        if prompt and prompt:IsA("ProximityPrompt") then
            prompt.HoldDuration = duration
        end
    end
end

Toggles.NoCooldownProximityPrompts:OnChanged(function(value)
    if value then
        saveOriginalDurations()
        setDurationsToZero()
    else
        restoreOriginalDurations()
    end
end)

Toggles.NoAccel:OnChanged(function(value)
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            if value then
                if not rootPart:GetAttribute("OriginalDensity") then
                    rootPart:SetAttribute("OriginalDensity", rootPart.CustomPhysicalProperties.Density)
                end
                local existingProperties = rootPart.CustomPhysicalProperties
                rootPart.CustomPhysicalProperties = PhysicalProperties.new(100, existingProperties.Friction, existingProperties.Elasticity, existingProperties.FrictionWeight, existingProperties.ElasticityWeight)
            else
                local originalDensity = rootPart:GetAttribute("OriginalDensity") or 1
                local existingProperties = rootPart.CustomPhysicalProperties
                rootPart.CustomPhysicalProperties = PhysicalProperties.new(originalDensity, existingProperties.Friction, existingProperties.Elasticity, existingProperties.FrictionWeight, existingProperties.ElasticityWeight)
            end
        end
    end
end)

Toggles.Fullbright:OnChanged(function(value)
    local lighting = game:GetService("Lighting")
    if value then
        lighting.Ambient = Color3.new(1, 1, 1)
    else
        local player = game.Players.LocalPlayer
        if player and player:GetAttribute("CurrentRoom") then
            local currentRoom = workspace.CurrentRooms[player:GetAttribute("CurrentRoom")]
            if currentRoom then
                lighting.Ambient = currentRoom:GetAttribute("Ambient")
            end
        else
            lighting.Ambient = Color3.new(0, 0, 0)
        end
    end
end)

Toggles.NoCutscenes:OnChanged(function(value)
    local mainGame = game:GetService("ReplicatedStorage"):FindFirstChild("MainGame")
    if mainGame then
        local cutscenes = mainGame:FindFirstChild("Cutscenes", true)
        if cutscenes then
            for _, cutscene in pairs(cutscenes:GetChildren()) do
                local defaultName = cutscene.Name:gsub("_", "")
                cutscene.Name = value and "_" .. defaultName or defaultName
            end
        end
    end
end)

local MenuGroup = Tabs.Settings:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)

MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind

MenuGroup:AddToggle('KeybindsFrame', {
    Text = 'Toggle Keybinds Frame',
    Default = false,
    Callback = function(Value)
        Library.KeybindFrame.Visible = Value
    end
})

MenuGroup:AddToggle("ExecuteOnTeleport", {
    Default = false,
    Text = "Execute On Teleport",
    Callback = function(Value)
        shared.Toggles.ExecuteOnTeleport = { Value = Value }
    end
})

if queue_on_teleport then
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(state)
        if state == Enum.TeleportState.Started then
            if Toggles.ExecuteOnTeleport.Value then
                queue_on_teleport([[ loadstring(game:HttpGet("https://raw.githubusercontent.com/poocatf/mslolcat/main/loader.lua"))() ]])
            end
        end
    end)
else
    Library:Notify("Your executor does not support queue_on_teleport.", 5)
end

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('MSLOLCAT')
SaveManager:SetFolder('MSLOLCAT/specific-game')
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
SaveManager:LoadAutoloadConfig()
