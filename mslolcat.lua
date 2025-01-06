local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "MSlolcat"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(1, -250, 1, -150)
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
Title.Text = "MSlolcat v1.1 | Lobby Editor "
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left

local Buttons = {}

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
    Buttons[#Buttons + 1] = Button
    
    if link then
        Button.MouseButton1Click:Connect(function()
            setclipboard(link)
            print("Link copied to clipboard: " .. link)
        end)
    end
    
    return Button
end

local WalkspeedButton = createButton("Walkspeed", UDim2.new(0, 10, 0, 35), "Walkspeed")
local FullbrightButton = createButton("Fullbright", UDim2.new(0, 10, 0, 55), "Fullbright")
local HotelButton = createButton("Hotel", UDim2.new(0, 10, 0, 75), "Hotel")
local BackdoorButton = createButton("Backdoor", UDim2.new(0, 10, 0, 95), "Backdoor")
local CutbarriersButton = createButton("Cutbarriers", UDim2.new(0, 10, 0, 115), "Cutbarriers")
local HideMSlolButton = createButton("Hidemslol", UDim2.new(0, 10, 0, 135), "Hidemslol")

local DiscordButton = createButton("Discord", UDim2.new(0, 10, 0, 155), "Discord", "https://discord.gg/ZJR8Mdb54n")
local TwitterButton = createButton("Twitter", UDim2.new(0, 10, 0, 175), "X/Twitter", "https://x.com/pooca2t")

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

HideMSlolButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Semicolon then
        ScreenGui.Enabled = true
    end
end)

local WalkspeedGui = Instance.new("Frame")
WalkspeedGui.Name = "WalkspeedGui"
WalkspeedGui.Parent = ScreenGui
WalkspeedGui.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
WalkspeedGui.BorderSizePixel = 0
WalkspeedGui.Position = UDim2.new(1, -500, 1, -150)
WalkspeedGui.Size = UDim2.new(0, 250, 0, 100)
WalkspeedGui.Visible = false

local WalkspeedTitle = Instance.new("TextLabel")
WalkspeedTitle.Parent = WalkspeedGui
WalkspeedTitle.BackgroundTransparency = 1
WalkspeedTitle.Size = UDim2.new(1, 0, 0, 20)
WalkspeedTitle.Font = Enum.Font.SourceSansBold
WalkspeedTitle.Text = "Set Walkspeed"
WalkspeedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkspeedTitle.TextSize = 18

local WalkspeedTextbox = Instance.new("TextBox")
WalkspeedTextbox.Parent = WalkspeedGui
WalkspeedTextbox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
WalkspeedTextbox.BorderSizePixel = 0
WalkspeedTextbox.Position = UDim2.new(0, 10, 0, 40)
WalkspeedTextbox.Size = UDim2.new(1, -20, 0, 25)
WalkspeedTextbox.Font = Enum.Font.SourceSans
WalkspeedTextbox.Text = ""
WalkspeedTextbox.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkspeedTextbox.TextSize = 16
WalkspeedTextbox.PlaceholderText = "Enter speed"

WalkspeedButton.MouseButton1Click:Connect(function()
    WalkspeedGui.Visible = not WalkspeedGui.Visible
end)

WalkspeedTextbox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local speed = tonumber(WalkspeedTextbox.Text)
        if speed then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
        end
    end
end)

FullbrightButton.MouseButton1Click:Connect(function()
    game.Lighting.Ambient = Color3.new(1, 1, 1)
end)

HotelButton.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-1010, 5, 685))
end)

BackdoorButton.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-1105, 6, 656))
end)

CutbarriersButton.MouseButton1Click:Connect(function()
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Name == "PlayerBarrier" then
            part:Destroy()
        end
    end
end)

local function modifyBadgeForPlayer(player)
    local playerName = player.Name
    local playerUI = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("NameUI" .. playerName)
    
    if playerUI then
        local stuff = playerUI:FindFirstChild("Stuff")
        if stuff then
            local textBadge = stuff:FindFirstChild("TextBadge")
            if textBadge then
                textBadge.Text = "Special Badge"
            end

            local iconBadge = stuff:FindFirstChild("IconBadge")
            if iconBadge then
                iconBadge.Image = "rbxassetid://107738231127754"
            end
        end
    end
end

game.Players.PlayerAdded:Connect(function(player)
    modifyBadgeForPlayer(player)
end)
