local player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")

if game.PlaceId == 6839171747 then
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MSlolcat"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -125, 0, 0)
    MainFrame.Size = UDim2.new(0, 250, 0, 25)
    MainFrame.ClipsDescendants = true

    local TitleFrame = Instance.new("Frame")
    TitleFrame.Parent = MainFrame
    TitleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TitleFrame.BorderSizePixel = 0
    TitleFrame.Size = UDim2.new(1, 0, 0, 25)

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = TitleFrame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "MSlolcat v1.1 | DOORS (Game)"
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

    local WalkspeedButton = createButton("Walkspeed", UDim2.new(0, 10, 0, 35), "Walkspeed (not bypassing)")
    local FullbrightButton = createButton("Fullbright", UDim2.new(0, 10, 0, 55), "Fullbright")
    local InstantPromptButton = createButton("InstantPrompt", UDim2.new(0, 10, 0, 75), "Instant ProximityPrompt")
    local AutoPromptButton = createButton("AutoPrompt", UDim2.new(0, 10, 0, 95), "Auto ProximityPrompt (Might Not Work)")
    local ExtendProxButton = createButton("ExtendProx", UDim2.new(0, 10, 0, 115), "Extend Prox (Alpha)")

    Title.MouseEnter:Connect(function()
        MainFrame.Size = UDim2.new(0, 250, 0, 400)
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

    local WalkspeedGui = Instance.new("Frame")
    WalkspeedGui.Name = "WalkspeedGui"
    WalkspeedGui.Parent = ScreenGui
    WalkspeedGui.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    WalkspeedGui.BorderSizePixel = 0
    WalkspeedGui.Position = UDim2.new(0, 10, 1, -250)
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
        game.Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        game.Lighting.Brightness = 2
        game.Lighting.ShadowSoftness = 0

        spawn(function()
            while true do
                wait(1)
                game.Lighting.Ambient = Color3.new(1, 1, 1)
                game.Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
                game.Lighting.Brightness = 2
                game.Lighting.ShadowSoftness = 0
            end
        end)
    end)

    local function setInstantProximityPrompt()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                obj.HoldDuration = 0
            end
        end
        print("All ProximityPrompts have been set to instant!")
    end

    InstantPromptButton.MouseButton1Click:Connect(function()
        setInstantProximityPrompt()
    end)

    workspace.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("ProximityPrompt") then
            descendant.HoldDuration = 0
        end
    end)

    setInstantProximityPrompt()

    local function autoPressProximityPrompt()
        local function pressPromptKey()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then
                    local distance = (player.Character.HumanoidRootPart.Position - obj.Parent.HumanoidRootPart.Position).Magnitude
                    if distance <= obj.MaxActivationDistance then
                        obj:InputBegan(Enum.UserInputType.Keyboard)
                    end
                end
            end
        end

        while true do
            wait(0.1)
            pressPromptKey()
        end
    end

    AutoPromptButton.MouseButton1Click:Connect(function()
        autoPressProximityPrompt()
    end)

    local function extendProximityPrompt()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                obj.MaxActivationDistance = 20
            end
        end
        print("ProximityPrompt eyesight extended!")
    end

    ExtendProxButton.MouseButton1Click:Connect(function()
        extendProximityPrompt()
    end)
end
