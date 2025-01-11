if game.PlaceId ~= 110258689672367 then
    return
end

-- Create ScreenGui and Main Frame
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "MSlolcat"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -125, 0, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 25)
MainFrame.ClipsDescendants = true

TitleFrame.Name = "TitleFrame"
TitleFrame.Parent = MainFrame
TitleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TitleFrame.BorderSizePixel = 0
TitleFrame.Size = UDim2.new(1, 0, 0, 25)

Title.Name = "Title"
Title.Parent = TitleFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "MSlolcat v3 | Pre-Hotel+"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Buttons Array
local Buttons = {}
local desiredWalkspeed = 16

-- Function to create a button
local function createButton(name, position, text, link)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Parent = MainFrame
    Button.BackgroundTransparency = 1
    Button.BorderSizePixel = 0
    Button.Position = position
    Button.Size = UDim2.new(0, 230, 0, 20)
    Button.Font = Enum.Font.SourceSans
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 16
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.Visible = false
    table.insert(Buttons, Button)

    if link then
        Button.MouseButton1Click:Connect(function()
            setclipboard(link)
            print("Link copied to clipboard: " .. link)
        end)
    end

    return Button
end

-- Creating the buttons
local WalkspeedButton = createButton("Walkspeed", UDim2.new(0, 10, 0, 35), "Walkspeed")
local FullbrightButton = createButton("Fullbright", UDim2.new(0, 10, 0, 55), "Fullbright")
local InstantProximityPromptButton = createButton("InstantProximityPrompt", UDim2.new(0, 10, 0, 75), "Instant Proximityprompt")
local DeleteSeekButton = createButton("DeleteSeek", UDim2.new(0, 10, 0, 95), "Delete Seek Client-side (buggy)")
local HideMSlolButton = createButton("Hidemslol", UDim2.new(0, 10, 0, 115), "Hidemslol")
local CrucifixButton = createButton("CrucifixButton", UDim2.new(0, 10, 0, 135), "Give Crucifix (200 Knobs)")
local InfiniteHealthButton = createButton("InfiniteHealth", UDim2.new(0, 10, 0, 155), "Infinite Health")

local DiscordButton = createButton("Discord", UDim2.new(0, 10, 0, 175), "Discord", "https://discord.gg/jw8G89KDMQ")
local TwitterButton = createButton("Twitter", UDim2.new(0, 10, 0, 195), "X/Twitter", "https://x.com/pooca2t")

-- MainFrame Hover Behavior
Title.MouseEnter:Connect(function()
    MainFrame.Size = UDim2.new(0, 250, 0, 250)
    for _, button in ipairs(Buttons) do
        button.Visible = true
    end
end)

MainFrame.MouseLeave:Connect(function()
    wait(0.2)
    if not MainFrame:IsMouseOver() then
        MainFrame.Size = UDim2.new(0, 250, 0, 25)
        for _, button in ipairs(Buttons) do
            button.Visible = false
        end
    end
end)

-- Hide the GUI
HideMSlolButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

-- Show GUI when Semicolon is pressed
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Semicolon then
        ScreenGui.Enabled = true
    end
end)

-- Instant Proximity Prompt
InstantProximityPromptButton.MouseButton1Click:Connect(function()
    local function setInstantProximityPrompt()
        for _, prompt in pairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                prompt.HoldDuration = 0
            end
        end
    end

    setInstantProximityPrompt()

    workspace.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("ProximityPrompt") then
            descendant.HoldDuration = 0
        end
    end)
end)

-- Fullbright Button
FullbrightButton.MouseButton1Click:Connect(function()
    game.Lighting.Ambient = Color3.new(1, 1, 1)
end)

-- Delete Seek Button
DeleteSeekButton.MouseButton1Click:Connect(function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "SeekMoving" then
            obj:Destroy()
        end
    end
end)

-- Walkspeed Button
WalkspeedButton.MouseButton1Click:Connect(function()
    local WalkspeedFrame = Instance.new("Frame")
    WalkspeedFrame.Parent = ScreenGui
    WalkspeedFrame.Size = UDim2.new(0, 200, 0, 100)
    WalkspeedFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
    WalkspeedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    WalkspeedFrame.BorderSizePixel = 0

    local TextBox = Instance.new("TextBox")
    TextBox.Parent = WalkspeedFrame
    TextBox.Size = UDim2.new(0, 180, 0, 40)
    TextBox.Position = UDim2.new(0, 10, 0, 10)
    TextBox.PlaceholderText = "Enter Walkspeed"
    TextBox.Text = ""
    TextBox.Font = Enum.Font.SourceSans
    TextBox.TextSize = 20
    TextBox.TextColor3 = Color3.new(1, 1, 1)
    TextBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)

    local SetButton = Instance.new("TextButton")
    SetButton.Parent = WalkspeedFrame
    SetButton.Size = UDim2.new(0, 180, 0, 40)
    SetButton.Position = UDim2.new(0, 10, 0, 55)
    SetButton.Text = "Set Walkspeed"
    SetButton.Font = Enum.Font.SourceSans
    SetButton.TextSize = 20
    SetButton.TextColor3 = Color3.new(1, 1, 1)
    SetButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)

    SetButton.MouseButton1Click:Connect(function()
        local speed = tonumber(TextBox.Text)
        if speed then
            desiredWalkspeed = speed
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = desiredWalkspeed
            end
        end
        WalkspeedFrame:Destroy()
    end)
end)

-- Continuous Walkspeed Update
spawn(function()
    while true do
        wait(0.1)
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            if player.Character.Humanoid.WalkSpeed ~= desiredWalkspeed then
                player.Character.Humanoid.WalkSpeed = desiredWalkspeed
            end
        end
    end
end)

-- Crucifix Button
CrucifixButton.MouseButton1Click:Connect(function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local bricks = replicatedStorage:WaitForChild("Bricks")
    local preRunShop = bricks:WaitForChild("PreRunShop")
    preRunShop:FireServer({"Crucifix"})
end)

-- Infinite Health Button
InfiniteHealthButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Health = humanoid.MaxHealth
        humanoid.HealthChanged:Connect(function()
            humanoid.Health = humanoid.MaxHealth
        end)
    end
end)
