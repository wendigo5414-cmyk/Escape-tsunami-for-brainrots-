local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

if player.PlayerGui:FindFirstChild("PRIMEHubGUI") then return end

-- KEY SYSTEM SETTINGS
local KeySystemEnabled = true
local KeySettings = {
    Title = "PRIME Hub",
    Subtitle = "Key System",
    Note = "Click 'Get Key' button to obtain the key",
    FileName = "PRIMEHub_Key",
    SaveKey = true,
    GrabKeyFromSite = true,
    Key = {"https://pastebin.com/raw/CD4DyVWc"}
}

local function getSavedKey()
    if readfile then
        local success, result = pcall(function()
            return readfile(KeySettings.FileName .. ".txt")
        end)
        if success and result then
            return result
        end
    end
    return nil
end

local function saveKeyToFile(key)
    if writefile then
        pcall(function()
            writefile(KeySettings.FileName .. ".txt", key)
        end)
    end
end

local function getKeyFromSite(url)
    local success, result = pcall(function()
        return game:HttpGet(url, true)
    end)
    if success and result then
        return result:gsub("%s+", ""):gsub("\n", ""):gsub("\r", "")
    end
    return nil
end

local savedKey = getSavedKey()

-- iOS Detection (Line 42 ke baad)
local isIOS = false
local function detectDevice()
    -- Check for iOS identifiers
    if not setclipboard or not writefile then
        isIOS = true
    end

    -- Additional iOS checks
    if identifyexecutor then
        local executor = identifyexecutor():lower()
        if executor:find("ios") or executor:find("ipad") or executor:find("iphone") then
            isIOS = true
        end
    end

    -- User Input Service check
    local UserInputService = game:GetService("UserInputService")
    if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
        isIOS = true
    end

    return isIOS
end

isIOS = detectDevice()
-- Key GUI
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "PRIMEHubKeyGUI"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = player:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 400, 0, 250)
KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = KeyGui

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Thickness = 2
KeyStroke.Color = Color3.fromRGB(255, 0, 0)
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 50)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = KeySettings.Title .. " - " .. KeySettings.Subtitle
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
KeyTitle.TextSize = 20
KeyTitle.Parent = KeyFrame

local KeyNote = Instance.new("TextLabel")
KeyNote.Size = UDim2.new(1, -20, 0, 30)
KeyNote.Position = UDim2.new(0, 10, 0, 50)
KeyNote.BackgroundTransparency = 1
KeyNote.Text = KeySettings.Note
KeyNote.Font = Enum.Font.Gotham
KeyNote.TextColor3 = Color3.fromRGB(200, 200, 200)
KeyNote.TextSize = 12
KeyNote.TextWrapped = true
KeyNote.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0, 350, 0, 40)
KeyBox.Position = UDim2.new(0.5, -175, 0, 90)
KeyBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "Enter Key Here..."
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 16
KeyBox.Parent = KeyFrame

Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 8)

local KeyBoxStroke = Instance.new("UIStroke")
KeyBoxStroke.Thickness = 1
KeyBoxStroke.Color = Color3.fromRGB(255, 0, 0)
KeyBoxStroke.Transparency = 0.5
KeyBoxStroke.Parent = KeyBox

KeyBox:GetPropertyChangedSignal("Text"):Connect(function()
    local text = KeyBox.Text
    local cleanText = text:gsub(" ", "")
    if text ~= cleanText then
        KeyBox.Text = cleanText
    end
end)

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0, 350, 0, 40)
GetKeyBtn.Position = UDim2.new(0.5, -175, 0, 145)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
GetKeyBtn.Text = "Get Key"
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
GetKeyBtn.TextSize = 18
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Parent = KeyFrame

Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 8)

local GetKeyStroke = Instance.new("UIStroke")
GetKeyStroke.Thickness = 1.5
GetKeyStroke.Color = Color3.fromRGB(255, 0, 0)
GetKeyStroke.Parent = GetKeyBtn

local SubmitKeyBtn = Instance.new("TextButton")
SubmitKeyBtn.Size = UDim2.new(0, 350, 0, 40)
SubmitKeyBtn.Position = UDim2.new(0.5, -175, 0, 200)
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SubmitKeyBtn.Text = "Submit Key"
SubmitKeyBtn.Font = Enum.Font.GothamBold
SubmitKeyBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
SubmitKeyBtn.TextSize = 18
SubmitKeyBtn.BorderSizePixel = 0
SubmitKeyBtn.Parent = KeyFrame

Instance.new("UICorner", SubmitKeyBtn).CornerRadius = UDim.new(0, 8)

local SubmitKeyStroke = Instance.new("UIStroke")
SubmitKeyStroke.Thickness = 1.5
SubmitKeyStroke.Color = Color3.fromRGB(255, 0, 0)
SubmitKeyStroke.Parent = SubmitKeyBtn

GetKeyBtn.MouseButton1Click:Connect(function()
    if isIOS then
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub - iOS",
            Text = "Just click Submit Key button!",
            Duration = 5
        })
    else
        if setclipboard then
            pcall(function() setclipboard("https://direct-link.net/1462308/RRaO8s6Woee8") end)
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub",
            Text = "Key link copied to clipboard!",
            Duration = 5
        })
    end
end)

local function verifyKey(inputKey)
    local cleanInput = inputKey:gsub("%s+", ""):gsub("\n", ""):gsub("\r", "")

    for _, keyValue in pairs(KeySettings.Key) do
        if KeySettings.GrabKeyFromSite then
            local siteKey = getKeyFromSite(keyValue)
            if siteKey and cleanInput == siteKey then
                return true
            end
        else
            local cleanKey = keyValue:gsub("%s+", ""):gsub("\n", ""):gsub("\r", "")
            if cleanInput == cleanKey then
                return true
            end
        end
    end

    return false
end

local keyVerified = false

if KeySettings.SaveKey and savedKey and verifyKey(savedKey) then
    keyVerified = true
    KeyGui:Destroy()
else
    SubmitKeyBtn.MouseButton1Click:Connect(function()
        SubmitKeyBtn.Text = "Checking..."
        SubmitKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 0)

        wait(0.3)

        local inputKey = KeyBox.Text

        -- iOS Auto-Approve
        if isIOS then
            keyVerified = true
            game.StarterGui:SetCore("SendNotification", {
                Title = "PRIME Hub",
                Text = "iOS Detected - Key Verified!",
                Duration = 3
            })
            wait(0.3)
            KeyGui:Destroy()
            return
        end

        -- Normal verification for other devices
        if verifyKey(inputKey) then
            keyVerified = true
            if KeySettings.SaveKey then
                saveKeyToFile(inputKey:gsub("%s+", ""))
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "PRIME Hub",
                Text = "Key Verified! Loading...",
                Duration = 3
            })
            wait(0.3)
            KeyGui:Destroy()
        else
            SubmitKeyBtn.Text = "Submit Key"
            SubmitKeyBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
            game.StarterGui:SetCore("SendNotification", {
                Title = "PRIME Hub",
                Text = "Invalid Key! Check Discord for help",
                Duration = 3
            })
        end
    end)

    repeat wait() until keyVerified
end

-- Main Script
game.StarterGui:SetCore("SendNotification", {
    Title = "PRIME Hub",
    Text = "Loaded | By WENDIGO",
    Duration = 7
})

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PRIMEHubGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(255, 0, 0)
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

-- Top Bar - Pure Black with Draggable Function
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local TopBarStroke = Instance.new("UIStroke")
TopBarStroke.Thickness = 1
TopBarStroke.Color = Color3.fromRGB(255, 0, 0)
TopBarStroke.Transparency = 0.6
TopBarStroke.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "PRIME Hub"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Minimize Button - Only Yellow Glow Effect
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -70, 0.5, -15)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinimizeBtn.Text = "-"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
MinimizeBtn.TextSize = 20
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Parent = TopBar

Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 6)

local MinimizeStroke = Instance.new("UIStroke")
MinimizeStroke.Thickness = 1.5
MinimizeStroke.Color = Color3.fromRGB(255, 255, 0)
MinimizeStroke.Transparency = 0.3
MinimizeStroke.Parent = MinimizeBtn

-- Close Button - Only Red Glow Effect
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.TextSize = 18
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TopBar

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Thickness = 1.5
CloseStroke.Color = Color3.fromRGB(255, 50, 50)
CloseStroke.Transparency = 0.3
CloseStroke.Parent = CloseBtn

-- Draggable Top Bar
local draggingMain = false
local dragInputMain
local dragStartMain
local startPosMain

local function updateMain(input)
    local delta = input.Position - dragStartMain
    MainFrame.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMain = true
        dragStartMain = input.Position
        startPosMain = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingMain = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputMain = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInputMain and draggingMain then
        updateMain(input)
    end
end)

local LeftSection = Instance.new("ScrollingFrame")
LeftSection.Size = UDim2.new(0, 150, 1, -50)
LeftSection.Position = UDim2.new(0, 5, 0, 45)
LeftSection.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
LeftSection.BorderSizePixel = 0
LeftSection.ScrollBarThickness = 6
LeftSection.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
LeftSection.CanvasSize = UDim2.new(0, 0, 0, 0)
LeftSection.Parent = MainFrame

Instance.new("UICorner", LeftSection).CornerRadius = UDim.new(0, 8)

local LeftStroke = Instance.new("UIStroke")
LeftStroke.Thickness = 1
LeftStroke.Color = Color3.fromRGB(255, 0, 0)
LeftStroke.Transparency = 0.6
LeftStroke.Parent = LeftSection

local LeftListLayout = Instance.new("UIListLayout")
LeftListLayout.Padding = UDim.new(0, 5)
LeftListLayout.Parent = LeftSection

local RightSection = Instance.new("Frame")
RightSection.Size = UDim2.new(0, 330, 1, -50)
RightSection.Position = UDim2.new(0, 160, 0, 45)
RightSection.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
RightSection.BorderSizePixel = 0
RightSection.Visible = false
RightSection.Parent = MainFrame

Instance.new("UICorner", RightSection).CornerRadius = UDim.new(0, 8)

local RightStroke = Instance.new("UIStroke")
RightStroke.Thickness = 1
RightStroke.Color = Color3.fromRGB(255, 0, 0)
RightStroke.Transparency = 0.6
RightStroke.Parent = RightSection

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -10, 1, -10)
ContentFrame.Position = UDim2.new(0, 5, 0, 5)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.Parent = RightSection

local ContentListLayout = Instance.new("UIListLayout")
ContentListLayout.Padding = UDim.new(0, 10)
ContentListLayout.Parent = ContentFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -30)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.Text = "P"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.TextSize = 28
ToggleButton.BorderSizePixel = 0
ToggleButton.Parent = ScreenGui

Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 30)

local ToggleBtnStroke = Instance.new("UIStroke")
ToggleBtnStroke.Thickness = 2
ToggleBtnStroke.Color = Color3.fromRGB(255, 0, 0)
ToggleBtnStroke.Transparency = 0.3
ToggleBtnStroke.Parent = ToggleButton

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local isMinimized = false
local originalSize = MainFrame.Size

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 500, 0, 40), "Out", "Quad", 0.3, true)
        wait(0.3)
        LeftSection.Visible = false
        RightSection.Visible = false
    else
        MainFrame:TweenSize(originalSize, "Out", "Quad", 0.3, true)
        wait(0.3)
        LeftSection.Visible = true
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local currentSection = nil

-- =========================
-- GAME SECTION
-- =========================

-- Game Button
local GameBtn = Instance.new("TextButton")
GameBtn.Size = UDim2.new(1, -10, 0, 35)
GameBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
GameBtn.Text = "Game"
GameBtn.Font = Enum.Font.GothamBold
GameBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
GameBtn.TextSize = 16
GameBtn.BorderSizePixel = 0
GameBtn.Parent = LeftSection

Instance.new("UICorner", GameBtn).CornerRadius = UDim.new(0, 6)

local GameBtnStroke = Instance.new("UIStroke")
GameBtnStroke.Thickness = 1
GameBtnStroke.Color = Color3.fromRGB(255, 0, 0)
GameBtnStroke.Transparency = 0.5
GameBtnStroke.Parent = GameBtn

-- Game Container
local GameContainer = Instance.new("Frame")
GameContainer.Size = UDim2.new(1, -20, 0, 0)
GameContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
GameContainer.BorderSizePixel = 0
GameContainer.Visible = false
GameContainer.Parent = ContentFrame

Instance.new("UICorner", GameContainer).CornerRadius = UDim.new(0, 8)

local GameStroke = Instance.new("UIStroke")
GameStroke.Thickness = 1.5
GameStroke.Color = Color3.fromRGB(255, 0, 0)
GameStroke.Transparency = 0.4
GameStroke.Parent = GameContainer

local GameTitle = Instance.new("TextLabel")
GameTitle.Size = UDim2.new(1, -20, 0, 35)
GameTitle.Position = UDim2.new(0, 10, 0, 10)
GameTitle.BackgroundTransparency = 1
GameTitle.Text = "🎮 Game Features"
GameTitle.Font = Enum.Font.GothamBold
GameTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
GameTitle.TextSize = 20
GameTitle.Parent = GameContainer

-- Game Features Container
local GameFeatures = Instance.new("Frame")
GameFeatures.Size = UDim2.new(1, -20, 0, 0)
GameFeatures.Position = UDim2.new(0, 10, 0, 50)
GameFeatures.BackgroundTransparency = 1
GameFeatures.Parent = GameContainer

local GameFeaturesLayout = Instance.new("UIListLayout")
GameFeaturesLayout.Padding = UDim.new(0, 15)
GameFeaturesLayout.Parent = GameFeatures

-- =========================
-- SPEED FEATURE
-- =========================

local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, 0, 0, 100)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
SpeedFrame.BorderSizePixel = 0
SpeedFrame.Parent = GameFeatures

Instance.new("UICorner", SpeedFrame).CornerRadius = UDim.new(0, 8)

local SpeedStroke = Instance.new("UIStroke")
SpeedStroke.Thickness = 1
SpeedStroke.Color = Color3.fromRGB(255, 0, 0)
SpeedStroke.Transparency = 0.5
SpeedStroke.Parent = SpeedFrame

-- Speed Header
local SpeedHeader = Instance.new("Frame")
SpeedHeader.Size = UDim2.new(1, 0, 0, 35)
SpeedHeader.BackgroundTransparency = 1
SpeedHeader.Parent = SpeedFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 120, 1, 0)
SpeedLabel.Position = UDim2.new(0, 10, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed"
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 16
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = SpeedHeader

-- Speed Value Display
local SpeedValueLabel = Instance.new("TextLabel")
SpeedValueLabel.Size = UDim2.new(0, 40, 0, 25)
SpeedValueLabel.Position = UDim2.new(1, -100, 0, 5)
SpeedValueLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SpeedValueLabel.Text = "16"
SpeedValueLabel.Font = Enum.Font.GothamBold
SpeedValueLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
SpeedValueLabel.TextSize = 14
SpeedValueLabel.BorderSizePixel = 0
SpeedValueLabel.Parent = SpeedHeader

Instance.new("UICorner", SpeedValueLabel).CornerRadius = UDim.new(0, 6)

-- Speed Toggle
local SpeedToggle = Instance.new("TextButton")
SpeedToggle.Size = UDim2.new(0, 50, 0, 25)
SpeedToggle.Position = UDim2.new(1, -50, 0, 5)
SpeedToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SpeedToggle.Text = "OFF"
SpeedToggle.Font = Enum.Font.GothamBold
SpeedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedToggle.TextSize = 12
SpeedToggle.BorderSizePixel = 0
SpeedToggle.Parent = SpeedHeader

Instance.new("UICorner", SpeedToggle).CornerRadius = UDim.new(0, 6)

-- Speed Slider Background
local SpeedSliderBg = Instance.new("Frame")
SpeedSliderBg.Size = UDim2.new(1, -20, 0, 8)
SpeedSliderBg.Position = UDim2.new(0, 10, 0, 50)
SpeedSliderBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedSliderBg.BorderSizePixel = 0
SpeedSliderBg.Parent = SpeedFrame

Instance.new("UICorner", SpeedSliderBg).CornerRadius = UDim.new(0, 4)

-- Speed Slider Fill
local SpeedSliderFill = Instance.new("Frame")
SpeedSliderFill.Size = UDim2.new(0, 0, 1, 0)
SpeedSliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SpeedSliderFill.BorderSizePixel = 0
SpeedSliderFill.Parent = SpeedSliderBg

Instance.new("UICorner", SpeedSliderFill).CornerRadius = UDim.new(0, 4)

-- Speed Slider Button
local SpeedSliderBtn = Instance.new("TextButton")
SpeedSliderBtn.Size = UDim2.new(0, 20, 0, 20)
SpeedSliderBtn.Position = UDim2.new(0, -10, 0.5, -10)
SpeedSliderBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SpeedSliderBtn.Text = ""
SpeedSliderBtn.BorderSizePixel = 0
SpeedSliderBtn.Parent = SpeedSliderBg

Instance.new("UICorner", SpeedSliderBtn).CornerRadius = UDim.new(1, 0)

local SpeedSliderStroke = Instance.new("UIStroke")
SpeedSliderStroke.Thickness = 2
SpeedSliderStroke.Color = Color3.fromRGB(255, 255, 255)
SpeedSliderStroke.Transparency = 0.5
SpeedSliderStroke.Parent = SpeedSliderBtn

-- Speed Description
local SpeedDesc = Instance.new("TextLabel")
SpeedDesc.Size = UDim2.new(1, -20, 0, 30)
SpeedDesc.Position = UDim2.new(0, 10, 0, 65)
SpeedDesc.BackgroundTransparency = 1
SpeedDesc.Text = "Adjust your walking speed (16-5000)"
SpeedDesc.Font = Enum.Font.Gotham
SpeedDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
SpeedDesc.TextSize = 12
SpeedDesc.TextXAlignment = Enum.TextXAlignment.Left
SpeedDesc.TextWrapped = true
SpeedDesc.Parent = SpeedFrame

-- Speed Variables
local speedEnabled = false
local currentSpeed = 16
local defaultSpeed = 16

-- Speed Slider Logic
local speedDragging = false

local function updateSpeedSlider(input)
    local sliderSize = SpeedSliderBg.AbsoluteSize.X
    local mousePos = input.Position.X - SpeedSliderBg.AbsolutePosition.X
    local percentage = math.clamp(mousePos / sliderSize, 0, 1)
    
    currentSpeed = math.floor(16 + (percentage * 4984)) -- 16 to 5000
    SpeedValueLabel.Text = tostring(currentSpeed)
    
    SpeedSliderFill.Size = UDim2.new(percentage, 0, 1, 0)
    SpeedSliderBtn.Position = UDim2.new(percentage, -10, 0.5, -10)
    
    -- Apply speed if enabled
    if speedEnabled then
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = currentSpeed
            end
        end)
    end
end

SpeedSliderBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        speedDragging = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        speedDragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if speedDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSpeedSlider(input)
    end
end)

SpeedSliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        updateSpeedSlider(input)
    end
end)

-- Speed Toggle Logic
SpeedToggle.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    
    if speedEnabled then
        SpeedToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        SpeedToggle.Text = "ON"
        
        -- Set speed immediately
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = currentSpeed
            end
        end)
        
        -- Keep updating speed continuously
        spawn(function()
            while speedEnabled do
                pcall(function()
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid.WalkSpeed = currentSpeed
                    end
                end)
                wait(0.1)
            end
        end)
        
        -- Handle respawn
        player.CharacterAdded:Connect(function(char)
            if speedEnabled then
                wait(0.5)
                char:WaitForChild("Humanoid").WalkSpeed = currentSpeed
            end
        end)
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub",
            Text = "Speed enabled: " .. currentSpeed,
            Duration = 2
        })
    else
        SpeedToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        SpeedToggle.Text = "OFF"
        
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = 16
            end
        end)
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub",
            Text = "Speed disabled",
            Duration = 2
        })
    end
end)

-- =========================
-- PICKUP DELAY FEATURE
-- =========================

local PickupFrame = Instance.new("Frame")
PickupFrame.Size = UDim2.new(1, 0, 0, 70)
PickupFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
PickupFrame.BorderSizePixel = 0
PickupFrame.Parent = GameFeatures

Instance.new("UICorner", PickupFrame).CornerRadius = UDim.new(0, 8)

local PickupStroke = Instance.new("UIStroke")
PickupStroke.Thickness = 1
PickupStroke.Color = Color3.fromRGB(255, 0, 0)
PickupStroke.Transparency = 0.5
PickupStroke.Parent = PickupFrame

-- Pickup Header
local PickupHeader = Instance.new("Frame")
PickupHeader.Size = UDim2.new(1, 0, 0, 35)
PickupHeader.BackgroundTransparency = 1
PickupHeader.Parent = PickupFrame

local PickupLabel = Instance.new("TextLabel")
PickupLabel.Size = UDim2.new(0, 200, 1, 0)
PickupLabel.Position = UDim2.new(0, 10, 0, 0)
PickupLabel.BackgroundTransparency = 1
PickupLabel.Text = "Pickup Delay"
PickupLabel.Font = Enum.Font.GothamBold
PickupLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PickupLabel.TextSize = 16
PickupLabel.TextXAlignment = Enum.TextXAlignment.Left
PickupLabel.Parent = PickupHeader

-- Pickup Toggle
local PickupToggle = Instance.new("TextButton")
PickupToggle.Size = UDim2.new(0, 50, 0, 25)
PickupToggle.Position = UDim2.new(1, -50, 0, 5)
PickupToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
PickupToggle.Text = "OFF"
PickupToggle.Font = Enum.Font.GothamBold
PickupToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
PickupToggle.TextSize = 12
PickupToggle.BorderSizePixel = 0
PickupToggle.Parent = PickupHeader

Instance.new("UICorner", PickupToggle).CornerRadius = UDim.new(0, 6)

-- Pickup Description
local PickupDesc = Instance.new("TextLabel")
PickupDesc.Size = UDim2.new(1, -20, 0, 30)
PickupDesc.Position = UDim2.new(0, 10, 0, 38)
PickupDesc.BackgroundTransparency = 1
PickupDesc.Text = "Instant proximity prompts [need good executor]"
PickupDesc.Font = Enum.Font.Gotham
PickupDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
PickupDesc.TextSize = 12
PickupDesc.TextXAlignment = Enum.TextXAlignment.Left
PickupDesc.TextWrapped = true
PickupDesc.Parent = PickupFrame

-- Pickup Variables
local pickupEnabled = false
local originalProximitySettings = {}

-- Pickup Toggle Logic
PickupToggle.MouseButton1Click:Connect(function()
    pickupEnabled = not pickupEnabled
    
    if pickupEnabled then
        PickupToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        PickupToggle.Text = "ON"
        
        -- Remove proximity prompt limits
        pcall(function()
            for _, prompt in pairs(game:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    if not originalProximitySettings[prompt] then
                        originalProximitySettings[prompt] = {
                            HoldDuration = prompt.HoldDuration,
                            MaxActivationDistance = prompt.MaxActivationDistance
                        }
                    end
                    prompt.HoldDuration = 0
                    prompt.MaxActivationDistance = 999999
                end
            end
        end)
        
        -- Handle new proximity prompts
        game.DescendantAdded:Connect(function(descendant)
            if pickupEnabled and descendant:IsA("ProximityPrompt") then
                wait()
                originalProximitySettings[descendant] = {
                    HoldDuration = descendant.HoldDuration,
                    MaxActivationDistance = descendant.MaxActivationDistance
                }
                descendant.HoldDuration = 0
                descendant.MaxActivationDistance = 999999
            end
        end)
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub",
            Text = "Instant Pickup enabled",
            Duration = 2
        })
    else
        PickupToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        PickupToggle.Text = "OFF"
        
        -- Restore original settings
        pcall(function()
            for prompt, settings in pairs(originalProximitySettings) do
                if prompt and prompt.Parent then
                    prompt.HoldDuration = settings.HoldDuration
                    prompt.MaxActivationDistance = settings.MaxActivationDistance
                end
            end
        end)
        
        originalProximitySettings = {}
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub",
            Text = "Instant Pickup disabled",
            Duration = 2
        })
    end
end)

-- =========================
-- SECRET STAGE FEATURE
-- =========================

local SecretFrame = Instance.new("Frame")
SecretFrame.Size = UDim2.new(1, 0, 0, 70)
SecretFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
SecretFrame.BorderSizePixel = 0
SecretFrame.Parent = GameFeatures

Instance.new("UICorner", SecretFrame).CornerRadius = UDim.new(0, 8)

local SecretStroke = Instance.new("UIStroke")
SecretStroke.Thickness = 1
SecretStroke.Color = Color3.fromRGB(255, 0, 0)
SecretStroke.Transparency = 0.5
SecretStroke.Parent = SecretFrame

-- Secret Header
local SecretHeader = Instance.new("Frame")
SecretHeader.Size = UDim2.new(1, 0, 0, 35)
SecretHeader.BackgroundTransparency = 1
SecretHeader.Parent = SecretFrame

local SecretLabel = Instance.new("TextLabel")
SecretLabel.Size = UDim2.new(0, 200, 1, 0)
SecretLabel.Position = UDim2.new(0, 10, 0, 0)
SecretLabel.BackgroundTransparency = 1
SecretLabel.Text = "Secret Stage"
SecretLabel.Font = Enum.Font.GothamBold
SecretLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SecretLabel.TextSize = 16
SecretLabel.TextXAlignment = Enum.TextXAlignment.Left
SecretLabel.Parent = SecretHeader

-- Secret Toggle
local SecretToggle = Instance.new("TextButton")
SecretToggle.Size = UDim2.new(0, 50, 0, 25)
SecretToggle.Position = UDim2.new(1, -50, 0, 5)
SecretToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SecretToggle.Text = "OFF"
SecretToggle.Font = Enum.Font.GothamBold
SecretToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SecretToggle.TextSize = 12
SecretToggle.BorderSizePixel = 0
SecretToggle.Parent = SecretHeader

Instance.new("UICorner", SecretToggle).CornerRadius = UDim.new(0, 6)

-- Secret Description
local SecretDesc = Instance.new("TextLabel")
SecretDesc.Size = UDim2.new(1, -20, 0, 30)
SecretDesc.Position = UDim2.new(0, 10, 0, 38)
SecretDesc.BackgroundTransparency = 1
SecretDesc.Text = "Teleport to secret stage"
SecretDesc.Font = Enum.Font.Gotham
SecretDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
SecretDesc.TextSize = 12
SecretDesc.TextXAlignment = Enum.TextXAlignment.Left
SecretDesc.TextWrapped = true
SecretDesc.Parent = SecretFrame

-- Secret Variables
local secretEnabled = false

-- Secret Toggle Logic
SecretToggle.MouseButton1Click:Connect(function()
    secretEnabled = not secretEnabled
    
    if secretEnabled then
        SecretToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        SecretToggle.Text = "ON"
        
        -- Teleport to Secret coordinates
        local success = pcall(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(2430, 3, 0)
                game.StarterGui:SetCore("SendNotification", {
                    Title = "PRIME Hub",
                    Text = "Teleported to Secret Stage!",
                    Duration = 2
                })
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "PRIME Hub",
                    Text = "Character not found!",
                    Duration = 2
                })
                secretEnabled = false
                SecretToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
                SecretToggle.Text = "OFF"
            end
        end)
        
        if not success then
            game.StarterGui:SetCore("SendNotification", {
                Title = "PRIME Hub",
                Text = "Teleport failed!",
                Duration = 2
            })
            secretEnabled = false
            SecretToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
            SecretToggle.Text = "OFF"
        end
    else
        SecretToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        SecretToggle.Text = "OFF"
        
        -- First teleport to coordinates
        local success = pcall(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(151, 3, 16)
                game.StarterGui:SetCore("SendNotification", {
                    Title = "PRIME Hub",
                    Text = "Returning to spawn...",
                    Duration = 1
                })
                
                -- Wait 1 second then teleport to Ground
                wait(1)
                
                local groundLocation = workspace.Misc:FindFirstChild("Ground")
                if groundLocation and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = groundLocation.CFrame
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "PRIME Hub",
                        Text = "Returned to Ground!",
                        Duration = 2
                    })
                else
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "PRIME Hub",
                        Text = "Ground location not found!",
                        Duration = 2
                    })
                end
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "PRIME Hub",
                    Text = "Character not found!",
                    Duration = 2
                })
            end
        end)
        
        if not success then
            game.StarterGui:SetCore("SendNotification", {
                Title = "PRIME Hub",
                Text = "Teleport failed!",
                Duration = 2
            })
        end
    end
end)

-- Update GameContainer Size
GameFeaturesLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    local contentHeight = GameFeaturesLayout.AbsoluteContentSize.Y
    GameFeatures.Size = UDim2.new(1, -20, 0, contentHeight)
    GameContainer.Size = UDim2.new(1, -20, 0, contentHeight + 60)
end)

-- =========================
-- MISC SECTION
-- =========================

-- Misc Button
local MiscBtn = Instance.new("TextButton")
MiscBtn.Size = UDim2.new(1, -10, 0, 35)
MiscBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MiscBtn.Text = "Misc"
MiscBtn.Font = Enum.Font.GothamBold
MiscBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
MiscBtn.TextSize = 16
MiscBtn.BorderSizePixel = 0
MiscBtn.Parent = LeftSection

Instance.new("UICorner", MiscBtn).CornerRadius = UDim.new(0, 6)

local MiscBtnStroke = Instance.new("UIStroke")
MiscBtnStroke.Thickness = 1
MiscBtnStroke.Color = Color3.fromRGB(255, 0, 0)
MiscBtnStroke.Transparency = 0.5
MiscBtnStroke.Parent = MiscBtn

-- Misc Container
local MiscContainer = Instance.new("Frame")
MiscContainer.Size = UDim2.new(1, -20, 0, 0)
MiscContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MiscContainer.BorderSizePixel = 0
MiscContainer.Visible = false
MiscContainer.Parent = ContentFrame

Instance.new("UICorner", MiscContainer).CornerRadius = UDim.new(0, 8)

local MiscStroke = Instance.new("UIStroke")
MiscStroke.Thickness = 1.5
MiscStroke.Color = Color3.fromRGB(255, 0, 0)
MiscStroke.Transparency = 0.4
MiscStroke.Parent = MiscContainer

local MiscTitle = Instance.new("TextLabel")
MiscTitle.Size = UDim2.new(1, -20, 0, 35)
MiscTitle.Position = UDim2.new(0, 10, 0, 10)
MiscTitle.BackgroundTransparency = 1
MiscTitle.Text = "🛠️ Miscellaneous"
MiscTitle.Font = Enum.Font.GothamBold
MiscTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
MiscTitle.TextSize = 20
MiscTitle.Parent = MiscContainer

-- Misc Features Container
local MiscFeatures = Instance.new("Frame")
MiscFeatures.Size = UDim2.new(1, -20, 0, 0)
MiscFeatures.Position = UDim2.new(0, 10, 0, 50)
MiscFeatures.BackgroundTransparency = 1
MiscFeatures.Parent = MiscContainer

local MiscFeaturesLayout = Instance.new("UIListLayout")
MiscFeaturesLayout.Padding = UDim.new(0, 15)
MiscFeaturesLayout.Parent = MiscFeatures

-- =========================
-- KILL TSUNAMI FEATURE
-- =========================

local KillTsunamiFrame = Instance.new("Frame")
KillTsunamiFrame.Size = UDim2.new(1, 0, 0, 70)
KillTsunamiFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
KillTsunamiFrame.BorderSizePixel = 0
KillTsunamiFrame.Parent = MiscFeatures

Instance.new("UICorner", KillTsunamiFrame).CornerRadius = UDim.new(0, 8)

local KillTsunamiStroke = Instance.new("UIStroke")
KillTsunamiStroke.Thickness = 1
KillTsunamiStroke.Color = Color3.fromRGB(255, 0, 0)
KillTsunamiStroke.Transparency = 0.5
KillTsunamiStroke.Parent = KillTsunamiFrame

-- Kill Tsunami Header
local KillTsunamiHeader = Instance.new("Frame")
KillTsunamiHeader.Size = UDim2.new(1, 0, 0, 35)
KillTsunamiHeader.BackgroundTransparency = 1
KillTsunamiHeader.Parent = KillTsunamiFrame

local KillTsunamiLabel = Instance.new("TextLabel")
KillTsunamiLabel.Size = UDim2.new(0, 200, 1, 0)
KillTsunamiLabel.Position = UDim2.new(0, 10, 0, 0)
KillTsunamiLabel.BackgroundTransparency = 1
KillTsunamiLabel.Text = "Kill Tsunami"
KillTsunamiLabel.Font = Enum.Font.GothamBold
KillTsunamiLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KillTsunamiLabel.TextSize = 16
KillTsunamiLabel.TextXAlignment = Enum.TextXAlignment.Left
KillTsunamiLabel.Parent = KillTsunamiHeader

-- Run Code Button
local RunCodeBtn = Instance.new("TextButton")
RunCodeBtn.Size = UDim2.new(0, 60, 0, 25)
RunCodeBtn.Position = UDim2.new(1, -60, 0, 5)
RunCodeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
RunCodeBtn.Text = "RUN"
RunCodeBtn.Font = Enum.Font.GothamBold
RunCodeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunCodeBtn.TextSize = 12
RunCodeBtn.BorderSizePixel = 0
RunCodeBtn.Parent = KillTsunamiHeader

Instance.new("UICorner", RunCodeBtn).CornerRadius = UDim.new(0, 6)

local RunCodeStroke = Instance.new("UIStroke")
RunCodeStroke.Thickness = 1
RunCodeStroke.Color = Color3.fromRGB(255, 0, 0)
RunCodeStroke.Transparency = 0.3
RunCodeStroke.Parent = RunCodeBtn

-- Kill Tsunami Description
local KillTsunamiDesc = Instance.new("TextLabel")
KillTsunamiDesc.Size = UDim2.new(1, -20, 0, 30)
KillTsunamiDesc.Position = UDim2.new(0, 10, 0, 38)
KillTsunamiDesc.BackgroundTransparency = 1
KillTsunamiDesc.Text = "Delete all active tsunamis"
KillTsunamiDesc.Font = Enum.Font.Gotham
KillTsunamiDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
KillTsunamiDesc.TextSize = 12
KillTsunamiDesc.TextXAlignment = Enum.TextXAlignment.Left
KillTsunamiDesc.TextWrapped = true
KillTsunamiDesc.Parent = KillTsunamiFrame

-- Run Code Button Logic
RunCodeBtn.MouseButton1Click:Connect(function()
    local originalText = RunCodeBtn.Text
    RunCodeBtn.Text = "RUNNING..."
    RunCodeBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    
    local success = pcall(function()
        local activeTsunamis = workspace:FindFirstChild("ActiveTsunamis")
        if activeTsunamis then
            activeTsunamis:Destroy()
            game.StarterGui:SetCore("SendNotification", {
                Title = "PRIME Hub",
                Text = "Tsunami deleted successfully!",
                Duration = 3
            })
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "PRIME Hub",
                Text = "No active tsunamis found!",
                Duration = 3
            })
        end
    end)
    
    wait(0.5)
    
    if success then
        RunCodeBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        RunCodeBtn.Text = "SUCCESS"
        wait(2)
    else
        RunCodeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        RunCodeBtn.Text = "FAILED"
        wait(2)
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub",
            Text = "Failed to delete tsunami!",
            Duration = 3
        })
    end
    
    RunCodeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    RunCodeBtn.Text = originalText
end)

-- =========================
-- FREE VIP WALLS FEATURE
-- =========================

local VIPWallsFrame = Instance.new("Frame")
VIPWallsFrame.Size = UDim2.new(1, 0, 0, 70)
VIPWallsFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
VIPWallsFrame.BorderSizePixel = 0
VIPWallsFrame.Parent = MiscFeatures

Instance.new("UICorner", VIPWallsFrame).CornerRadius = UDim.new(0, 8)

local VIPWallsStroke = Instance.new("UIStroke")
VIPWallsStroke.Thickness = 1
VIPWallsStroke.Color = Color3.fromRGB(255, 0, 0)
VIPWallsStroke.Transparency = 0.5
VIPWallsStroke.Parent = VIPWallsFrame

local VIPWallsHeader = Instance.new("Frame")
VIPWallsHeader.Size = UDim2.new(1, 0, 0, 35)
VIPWallsHeader.BackgroundTransparency = 1
VIPWallsHeader.Parent = VIPWallsFrame

local VIPWallsLabel = Instance.new("TextLabel")
VIPWallsLabel.Size = UDim2.new(0, 200, 1, 0)
VIPWallsLabel.Position = UDim2.new(0, 10, 0, 0)
VIPWallsLabel.BackgroundTransparency = 1
VIPWallsLabel.Text = "Free VIP Walls"
VIPWallsLabel.Font = Enum.Font.GothamBold
VIPWallsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
VIPWallsLabel.TextSize = 16
VIPWallsLabel.TextXAlignment = Enum.TextXAlignment.Left
VIPWallsLabel.Parent = VIPWallsHeader

local VIPWallsBtn = Instance.new("TextButton")
VIPWallsBtn.Size = UDim2.new(0, 60, 0, 25)
VIPWallsBtn.Position = UDim2.new(1, -60, 0, 5)
VIPWallsBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
VIPWallsBtn.Text = "RUN"
VIPWallsBtn.Font = Enum.Font.GothamBold
VIPWallsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VIPWallsBtn.TextSize = 12
VIPWallsBtn.BorderSizePixel = 0
VIPWallsBtn.Parent = VIPWallsHeader

Instance.new("UICorner", VIPWallsBtn).CornerRadius = UDim.new(0, 6)

local VIPWallsBtnStroke = Instance.new("UIStroke")
VIPWallsBtnStroke.Thickness = 1
VIPWallsBtnStroke.Color = Color3.fromRGB(255, 0, 0)
VIPWallsBtnStroke.Transparency = 0.3
VIPWallsBtnStroke.Parent = VIPWallsBtn

local VIPWallsDesc = Instance.new("TextLabel")
VIPWallsDesc.Size = UDim2.new(1, -20, 0, 30)
VIPWallsDesc.Position = UDim2.new(0, 10, 0, 38)
VIPWallsDesc.BackgroundTransparency = 1
VIPWallsDesc.Text = "Remove VIP walls"
VIPWallsDesc.Font = Enum.Font.Gotham
VIPWallsDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
VIPWallsDesc.TextSize = 12
VIPWallsDesc.TextXAlignment = Enum.TextXAlignment.Left
VIPWallsDesc.TextWrapped = true
VIPWallsDesc.Parent = VIPWallsFrame

VIPWallsBtn.MouseButton1Click:Connect(function()
    local originalText = VIPWallsBtn.Text
    VIPWallsBtn.Text = "RUNNING..."
    VIPWallsBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    
    local success = pcall(function()
        local vipWalls = workspace:FindFirstChild("VIPWalls")
        if vipWalls then
            vipWalls:Destroy()
            game.StarterGui:SetCore("SendNotification", {
                Title = "PRIME Hub",
                Text = "VIP Walls removed!",
                Duration = 3
            })
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "PRIME Hub",
                Text = "VIP Walls not found!",
                Duration = 3
            })
        end
    end)
    
    wait(0.5)
    
    if success then
        VIPWallsBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        VIPWallsBtn.Text = "SUCCESS"
        wait(2)
    else
        VIPWallsBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        VIPWallsBtn.Text = "FAILED"
        wait(2)
    end
    
    VIPWallsBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    VIPWallsBtn.Text = originalText
end)

-- =========================
-- SELL HAND FEATURE
-- =========================

local SellHandFrame = Instance.new("Frame")
SellHandFrame.Size = UDim2.new(1, 0, 0, 70)
SellHandFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
SellHandFrame.BorderSizePixel = 0
SellHandFrame.Parent = MiscFeatures

Instance.new("UICorner", SellHandFrame).CornerRadius = UDim.new(0, 8)

local SellHandStroke = Instance.new("UIStroke")
SellHandStroke.Thickness = 1
SellHandStroke.Color = Color3.fromRGB(255, 0, 0)
SellHandStroke.Transparency = 0.5
SellHandStroke.Parent = SellHandFrame

local SellHandHeader = Instance.new("Frame")
SellHandHeader.Size = UDim2.new(1, 0, 0, 35)
SellHandHeader.BackgroundTransparency = 1
SellHandHeader.Parent = SellHandFrame

local SellHandLabel = Instance.new("TextLabel")
SellHandLabel.Size = UDim2.new(0, 200, 1, 0)
SellHandLabel.Position = UDim2.new(0, 10, 0, 0)
SellHandLabel.BackgroundTransparency = 1
SellHandLabel.Text = "Sell Hand"
SellHandLabel.Font = Enum.Font.GothamBold
SellHandLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SellHandLabel.TextSize = 16
SellHandLabel.TextXAlignment = Enum.TextXAlignment.Left
SellHandLabel.Parent = SellHandHeader

local SellHandBtn = Instance.new("TextButton")
SellHandBtn.Size = UDim2.new(0, 60, 0, 25)
SellHandBtn.Position = UDim2.new(1, -60, 0, 5)
SellHandBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SellHandBtn.Text = "RUN"
SellHandBtn.Font = Enum.Font.GothamBold
SellHandBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SellHandBtn.TextSize = 12
SellHandBtn.BorderSizePixel = 0
SellHandBtn.Parent = SellHandHeader

Instance.new("UICorner", SellHandBtn).CornerRadius = UDim.new(0, 6)

local SellHandBtnStroke = Instance.new("UIStroke")
SellHandBtnStroke.Thickness = 1
SellHandBtnStroke.Color = Color3.fromRGB(255, 0, 0)
SellHandBtnStroke.Transparency = 0.3
SellHandBtnStroke.Parent = SellHandBtn

local SellHandDesc = Instance.new("TextLabel")
SellHandDesc.Size = UDim2.new(1, -20, 0, 30)
SellHandDesc.Position = UDim2.new(0, 10, 0, 38)
SellHandDesc.BackgroundTransparency = 1
SellHandDesc.Text = "Sell tool in hand"
SellHandDesc.Font = Enum.Font.Gotham
SellHandDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
SellHandDesc.TextSize = 12
SellHandDesc.TextXAlignment = Enum.TextXAlignment.Left
SellHandDesc.TextWrapped = true
SellHandDesc.Parent = SellHandFrame

SellHandBtn.MouseButton1Click:Connect(function()
    local originalText = SellHandBtn.Text
    SellHandBtn.Text = "RUNNING..."
    SellHandBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    
    local success = pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("SellTool"):InvokeServer()
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub",
            Text = "Sold tool in hand!",
            Duration = 3
        })
    end)
    
    wait(0.5)
    
    if success then
        SellHandBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        SellHandBtn.Text = "SUCCESS"
        wait(2)
    else
        SellHandBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        SellHandBtn.Text = "FAILED"
        wait(2)
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub",
            Text = "Failed to sell!",
            Duration = 3
        })
    end
    
    SellHandBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    SellHandBtn.Text = originalText
end)

-- =========================
-- SELL INVENTORY FEATURE
-- =========================

local SellInvFrame = Instance.new("Frame")
SellInvFrame.Size = UDim2.new(1, 0, 0, 70)
SellInvFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
SellInvFrame.BorderSizePixel = 0
SellInvFrame.Parent = MiscFeatures

Instance.new("UICorner", SellInvFrame).CornerRadius = UDim.new(0, 8)

local SellInvStroke = Instance.new("UIStroke")
SellInvStroke.Thickness = 1
SellInvStroke.Color = Color3.fromRGB(255, 0, 0)
SellInvStroke.Transparency = 0.5
SellInvStroke.Parent = SellInvFrame

local SellInvHeader = Instance.new("Frame")
SellInvHeader.Size = UDim2.new(1, 0, 0, 35)
SellInvHeader.BackgroundTransparency = 1
SellInvHeader.Parent = SellInvFrame

local SellInvLabel = Instance.new("TextLabel")
SellInvLabel.Size = UDim2.new(0, 200, 1, 0)
SellInvLabel.Position = UDim2.new(0, 10, 0, 0)
SellInvLabel.BackgroundTransparency = 1
SellInvLabel.Text = "Sell Inventory"
SellInvLabel.Font = Enum.Font.GothamBold
SellInvLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SellInvLabel.TextSize = 16
SellInvLabel.TextXAlignment = Enum.TextXAlignment.Left
SellInvLabel.Parent = SellInvHeader

local SellInvBtn = Instance.new("TextButton")
SellInvBtn.Size = UDim2.new(0, 60, 0, 25)
SellInvBtn.Position = UDim2.new(1, -60, 0, 5)
SellInvBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SellInvBtn.Text = "RUN"
SellInvBtn.Font = Enum.Font.GothamBold
SellInvBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SellInvBtn.TextSize = 12
SellInvBtn.BorderSizePixel = 0
SellInvBtn.Parent = SellInvHeader

Instance.new("UICorner", SellInvBtn).CornerRadius = UDim.new(0, 6)

local SellInvBtnStroke = Instance.new("UIStroke")
SellInvBtnStroke.Thickness = 1
SellInvBtnStroke.Color = Color3.fromRGB(255, 0, 0)
SellInvBtnStroke.Transparency = 0.3
SellInvBtnStroke.Parent = SellInvBtn

local SellInvDesc = Instance.new("TextLabel")
SellInvDesc.Size = UDim2.new(1, -20, 0, 30)
SellInvDesc.Position = UDim2.new(0, 10, 0, 38)
SellInvDesc.BackgroundTransparency = 1
SellInvDesc.Text = "Sell all inventory items"
SellInvDesc.Font = Enum.Font.Gotham
SellInvDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
SellInvDesc.TextSize = 12
SellInvDesc.TextXAlignment = Enum.TextXAlignment.Left
SellInvDesc.TextWrapped = true
SellInvDesc.Parent = SellInvFrame

SellInvBtn.MouseButton1Click:Connect(function()
    local originalText = SellInvBtn.Text
    SellInvBtn.Text = "RUNNING..."
    SellInvBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    
    local success = pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("SellAll"):InvokeServer()
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub",
            Text = "Sold all inventory!",
            Duration = 3
        })
    end)
    
    wait(0.5)
    
    if success then
        SellInvBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        SellInvBtn.Text = "SUCCESS"
        wait(2)
    else
        SellInvBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        SellInvBtn.Text = "FAILED"
        wait(2)
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub",
            Text = "Failed to sell!",
            Duration = 3
        })
    end
    
    SellInvBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    SellInvBtn.Text = originalText
end)

-- =========================
-- AUTO COLLECT FEATURE
-- =========================

local AutoCollectFrame = Instance.new("Frame")
AutoCollectFrame.Size = UDim2.new(1, 0, 0, 70)
AutoCollectFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
AutoCollectFrame.BorderSizePixel = 0
AutoCollectFrame.Parent = MiscFeatures

Instance.new("UICorner", AutoCollectFrame).CornerRadius = UDim.new(0, 8)

local AutoCollectStroke = Instance.new("UIStroke")
AutoCollectStroke.Thickness = 1
AutoCollectStroke.Color = Color3.fromRGB(255, 0, 0)
AutoCollectStroke.Transparency = 0.5
AutoCollectStroke.Parent = AutoCollectFrame

local AutoCollectHeader = Instance.new("Frame")
AutoCollectHeader.Size = UDim2.new(1, 0, 0, 35)
AutoCollectHeader.BackgroundTransparency = 1
AutoCollectHeader.Parent = AutoCollectFrame

local AutoCollectLabel = Instance.new("TextLabel")
AutoCollectLabel.Size = UDim2.new(0, 200, 1, 0)
AutoCollectLabel.Position = UDim2.new(0, 10, 0, 0)
AutoCollectLabel.BackgroundTransparency = 1
AutoCollectLabel.Text = "Auto Collect"
AutoCollectLabel.Font = Enum.Font.GothamBold
AutoCollectLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoCollectLabel.TextSize = 16
AutoCollectLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoCollectLabel.Parent = AutoCollectHeader

local AutoCollectToggle = Instance.new("TextButton")
AutoCollectToggle.Size = UDim2.new(0, 50, 0, 25)
AutoCollectToggle.Position = UDim2.new(1, -50, 0, 5)
AutoCollectToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
AutoCollectToggle.Text = "OFF"
AutoCollectToggle.Font = Enum.Font.GothamBold
AutoCollectToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoCollectToggle.TextSize = 12
AutoCollectToggle.BorderSizePixel = 0
AutoCollectToggle.Parent = AutoCollectHeader

Instance.new("UICorner", AutoCollectToggle).CornerRadius = UDim.new(0, 6)

local AutoCollectDesc = Instance.new("TextLabel")
AutoCollectDesc.Size = UDim2.new(1, -20, 0, 30)
AutoCollectDesc.Position = UDim2.new(0, 10, 0, 38)
AutoCollectDesc.BackgroundTransparency = 1
AutoCollectDesc.Text = "Auto collect money from all slots (1-100)"
AutoCollectDesc.Font = Enum.Font.Gotham
AutoCollectDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
AutoCollectDesc.TextSize = 12
AutoCollectDesc.TextXAlignment = Enum.TextXAlignment.Left
AutoCollectDesc.TextWrapped = true
AutoCollectDesc.Parent = AutoCollectFrame

local autoCollectEnabled = false

AutoCollectToggle.MouseButton1Click:Connect(function()
    autoCollectEnabled = not autoCollectEnabled
    
    if autoCollectEnabled then
        AutoCollectToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        AutoCollectToggle.Text = "ON"
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub",
            Text = "Auto Collect enabled!",
            Duration = 2
        })
        
        -- Start auto collecting
        spawn(function()
            while autoCollectEnabled do
                for i = 1, 100 do
                    if not autoCollectEnabled then break end
                    
                    pcall(function()
                        local args = {
                            "Slot" .. tostring(i)
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("CollectMoney"):FireServer(unpack(args))
                    end)
                end
                wait(1)
            end
        end)
    else
        AutoCollectToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        AutoCollectToggle.Text = "OFF"
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "PRIME Hub",
            Text = "Auto Collect disabled!",
            Duration = 2
        })
    end
end)

-- Update MiscContainer Size
MiscFeaturesLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    local contentHeight = MiscFeaturesLayout.AbsoluteContentSize.Y
    MiscFeatures.Size = UDim2.new(1, -20, 0, contentHeight)
    MiscContainer.Size = UDim2.new(1, -20, 0, contentHeight + 60)
end)

-- UI THEMES SECTION
local ThemesBtn = Instance.new("TextButton")
ThemesBtn.Size = UDim2.new(1, -10, 0, 35)
ThemesBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ThemesBtn.Text = "UI Themes"
ThemesBtn.Font = Enum.Font.GothamBold
ThemesBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
ThemesBtn.TextSize = 16
ThemesBtn.BorderSizePixel = 0
ThemesBtn.Parent = LeftSection

Instance.new("UICorner", ThemesBtn).CornerRadius = UDim.new(0, 6)

local ThemesBtnStroke = Instance.new("UIStroke")
ThemesBtnStroke.Thickness = 1
ThemesBtnStroke.Color = Color3.fromRGB(255, 0, 0)
ThemesBtnStroke.Transparency = 0.5
ThemesBtnStroke.Parent = ThemesBtn

local ThemesContainer = Instance.new("Frame")
ThemesContainer.Size = UDim2.new(1, -20, 0, 0)
ThemesContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ThemesContainer.BorderSizePixel = 0
ThemesContainer.Visible = false
ThemesContainer.Parent = ContentFrame

Instance.new("UICorner", ThemesContainer).CornerRadius = UDim.new(0, 8)

local ThemesStroke = Instance.new("UIStroke")
ThemesStroke.Thickness = 1.5
ThemesStroke.Color = Color3.fromRGB(255, 0, 0)
ThemesStroke.Transparency = 0.4
ThemesStroke.Parent = ThemesContainer

local ThemesTitle = Instance.new("TextLabel")
ThemesTitle.Size = UDim2.new(1, -20, 0, 35)
ThemesTitle.Position = UDim2.new(0, 10, 0, 10)
ThemesTitle.BackgroundTransparency = 1
ThemesTitle.Text = "🎨 Select Theme"
ThemesTitle.Font = Enum.Font.GothamBold
ThemesTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
ThemesTitle.TextSize = 20
ThemesTitle.Parent = ThemesContainer

-- Theme Data
local ThemesList = {
    {
        Name = "Red Theme",
        Primary = Color3.fromRGB(255, 0, 0),
        Secondary = Color3.fromRGB(180, 0, 0),
        Background = Color3.fromRGB(8, 8, 8),
        Icon = "🔴",
        BorderColor = Color3.fromRGB(255, 0, 0)
    },
    {
        Name = "Blue Theme",
        Primary = Color3.fromRGB(0, 200, 255),
        Secondary = Color3.fromRGB(0, 150, 255),
        Background = Color3.fromRGB(5, 10, 15),
        Icon = "🔵",
        BorderColor = Color3.fromRGB(0, 200, 255)
    },
    {
        Name = "Green Theme",
        Primary = Color3.fromRGB(0, 255, 100),
        Secondary = Color3.fromRGB(0, 200, 80),
        Background = Color3.fromRGB(5, 15, 8),
        Icon = "🟢",
        BorderColor = Color3.fromRGB(0, 255, 100)
    },
    {
        Name = "Purple Theme",
        Primary = Color3.fromRGB(200, 0, 255),
        Secondary = Color3.fromRGB(150, 0, 200),
        Background = Color3.fromRGB(12, 5, 15),
        Icon = "🟣",
        BorderColor = Color3.fromRGB(200, 0, 255)
    },
    {
        Name = "Orange Theme",
        Primary = Color3.fromRGB(255, 120, 0),
        Secondary = Color3.fromRGB(255, 80, 0),
        Background = Color3.fromRGB(15, 8, 5),
        Icon = "🟠",
        BorderColor = Color3.fromRGB(255, 120, 0)
    },
    {
        Name = "Pink Theme",
        Primary = Color3.fromRGB(255, 0, 150),
        Secondary = Color3.fromRGB(255, 50, 180),
        Background = Color3.fromRGB(15, 5, 12),
        Icon = "🌸",
        BorderColor = Color3.fromRGB(255, 0, 150)
    }
}

local currentTheme = ThemesList[1]

local function applyTheme(theme)
    currentTheme = theme

    -- Update Main Frame
    MainStroke.Color = theme.Primary
    MainFrame.BackgroundColor3 = theme.Background

    -- Update Top Bar
    TopBarStroke.Color = theme.Primary
    Title.TextColor3 = theme.Primary
    CloseStroke.Color = Color3.fromRGB(255, 50, 50)
    MinimizeStroke.Color = Color3.fromRGB(255, 255, 0)

    -- Update Left Section
    LeftStroke.Color = theme.Primary
    LeftSection.ScrollBarImageColor3 = theme.Primary

    -- Update Right Section
    RightStroke.Color = theme.Primary
    ContentFrame.ScrollBarImageColor3 = theme.Primary

    -- Update Toggle Button
    ToggleBtnStroke.Color = theme.Primary
    ToggleButton.TextColor3 = theme.Primary

    -- Update Menu Buttons
    ThemesBtnStroke.Color = theme.Primary
    ThemesBtn.TextColor3 = theme.Primary
    GameBtnStroke.Color = theme.Primary
    GameBtn.TextColor3 = theme.Primary
    MiscBtnStroke.Color = theme.Primary
    MiscBtn.TextColor3 = theme.Primary
    AboutBtnStroke.Color = theme.Primary
    AboutBtn.TextColor3 = theme.Primary

    -- Update Container Strokes
    ThemesStroke.Color = theme.Primary
    ThemesTitle.TextColor3 = theme.Primary
    GameStroke.Color = theme.Primary
    GameTitle.TextColor3 = theme.Primary
    MiscStroke.Color = theme.Primary
    MiscTitle.TextColor3 = theme.Primary
    AboutStroke.Color = theme.Primary
    AboutTitle.TextColor3 = theme.Primary

    -- Update Game Features
    SpeedStroke.Color = theme.Primary
    PickupStroke.Color = theme.Primary
    SecretStroke.Color = theme.Primary
    SpeedValueLabel.TextColor3 = theme.Primary
    SpeedSliderFill.BackgroundColor3 = theme.Primary
    SpeedSliderBtn.BackgroundColor3 = theme.Primary
    
    -- Update Misc Features
    KillTsunamiStroke.Color = theme.Primary
    RunCodeStroke.Color = theme.Primary
    VIPWallsStroke.Color = theme.Primary
    VIPWallsBtnStroke.Color = theme.Primary
    SellHandStroke.Color = theme.Primary
    SellHandBtnStroke.Color = theme.Primary
    SellInvStroke.Color = theme.Primary
    SellInvBtnStroke.Color = theme.Primary
    AutoCollectStroke.Color = theme.Primary
    
    -- Update About Section Colors
    AboutHeader.BackgroundColor3 = theme.Background
    StoreStroke.Color = theme.Primary
    SupportStroke.Color = theme.Primary
    StoreIcon.TextColor3 = theme.Primary
    SupportIcon.TextColor3 = theme.Primary

    game.StarterGui:SetCore("SendNotification", {
        Title = "PRIME Hub",
        Text = "Theme changed to " .. theme.Name,
        Duration = 2
    })
end



-- Theme Selection Container (No inner scrolling - just a Frame)
local ThemeScroll = Instance.new("Frame")
ThemeScroll.Size = UDim2.new(1, -20, 0, 0)
ThemeScroll.Position = UDim2.new(0, 10, 0, 50)
ThemeScroll.BackgroundTransparency = 1
ThemeScroll.BorderSizePixel = 0
ThemeScroll.Parent = ThemesContainer

local ThemeScrollLayout = Instance.new("UIListLayout")
ThemeScrollLayout.Padding = UDim.new(0, 10)
ThemeScrollLayout.Parent = ThemeScroll

-- Create Theme Buttons
for i, theme in ipairs(ThemesList) do
    local ThemeBtn = Instance.new("TextButton")
    ThemeBtn.Size = UDim2.new(1, -10, 0, 60)
    ThemeBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    ThemeBtn.BorderSizePixel = 0
    ThemeBtn.Text = ""
    ThemeBtn.AutoButtonColor = false
    ThemeBtn.Parent = ThemeScroll

    Instance.new("UICorner", ThemeBtn).CornerRadius = UDim.new(0, 8)

    -- Individual Border that won't change with theme
    local ThemeBtnStroke = Instance.new("UIStroke")
    ThemeBtnStroke.Thickness = 2
    ThemeBtnStroke.Color = theme.BorderColor
    ThemeBtnStroke.Transparency = 0.4
    ThemeBtnStroke.Parent = ThemeBtn

    local ThemeIcon = Instance.new("TextLabel")
    ThemeIcon.Size = UDim2.new(0, 40, 1, 0)
    ThemeIcon.Position = UDim2.new(0, 10, 0, 0)
    ThemeIcon.BackgroundTransparency = 1
    ThemeIcon.Text = theme.Icon
    ThemeIcon.Font = Enum.Font.GothamBold
    ThemeIcon.TextSize = 28
    ThemeIcon.Parent = ThemeBtn

    local ThemeNameLabel = Instance.new("TextLabel")
    ThemeNameLabel.Size = UDim2.new(1, -60, 0, 25)
    ThemeNameLabel.Position = UDim2.new(0, 55, 0, 10)
    ThemeNameLabel.BackgroundTransparency = 1
    ThemeNameLabel.Text = theme.Name
    ThemeNameLabel.Font = Enum.Font.GothamBold
    ThemeNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ThemeNameLabel.TextSize = 16
    ThemeNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    ThemeNameLabel.Parent = ThemeBtn

    local ThemeDesc = Instance.new("TextLabel")
    ThemeDesc.Size = UDim2.new(1, -60, 0, 20)
    ThemeDesc.Position = UDim2.new(0, 55, 0, 32)
    ThemeDesc.BackgroundTransparency = 1
    ThemeDesc.Text = "Click to apply this theme"
    ThemeDesc.Font = Enum.Font.Gotham
    ThemeDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
    ThemeDesc.TextSize = 12
    ThemeDesc.TextXAlignment = Enum.TextXAlignment.Left
    ThemeDesc.Parent = ThemeBtn

    -- Hover Effects (doesn't change border color)
    ThemeBtn.MouseEnter:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(ThemeBtn, tweenInfo, {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}):Play()
        TweenService:Create(ThemeBtnStroke, tweenInfo, {Transparency = 0.1}):Play()
    end)

    ThemeBtn.MouseLeave:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(ThemeBtn, tweenInfo, {BackgroundColor3 = Color3.fromRGB(12, 12, 12)}):Play()
        TweenService:Create(ThemeBtnStroke, tweenInfo, {Transparency = 0.4}):Play()
    end)

    -- Apply Theme on Click
    ThemeBtn.MouseButton1Click:Connect(function()
        applyTheme(theme)
    end)
end

-- Update Canvas Size for ThemeScroll
ThemeScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    local contentHeight = ThemeScrollLayout.AbsoluteContentSize.Y
    ThemeScroll.Size = UDim2.new(1, -20, 0, contentHeight)
    ThemesContainer.Size = UDim2.new(1, -20, 0, contentHeight + 60)
end)

-- ABOUT US SECTION
local AboutBtn = Instance.new("TextButton")
AboutBtn.Size = UDim2.new(1, -10, 0, 35)
AboutBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
AboutBtn.Text = "About Us"
AboutBtn.Font = Enum.Font.GothamBold
AboutBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
AboutBtn.TextSize = 16
AboutBtn.BorderSizePixel = 0
AboutBtn.Parent = LeftSection

Instance.new("UICorner", AboutBtn).CornerRadius = UDim.new(0, 6)

local AboutBtnStroke = Instance.new("UIStroke")
AboutBtnStroke.Thickness = 1
AboutBtnStroke.Color = Color3.fromRGB(255, 0, 0)
AboutBtnStroke.Transparency = 0.5
AboutBtnStroke.Parent = AboutBtn

local AboutContainer = Instance.new("Frame")
AboutContainer.Size = UDim2.new(1, -20, 0, 280)
AboutContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
AboutContainer.BorderSizePixel = 0
AboutContainer.Visible = false
AboutContainer.Parent = ContentFrame

Instance.new("UICorner", AboutContainer).CornerRadius = UDim.new(0, 10)

local AboutStroke = Instance.new("UIStroke")
AboutStroke.Thickness = 1.5
AboutStroke.Color = Color3.fromRGB(255, 0, 0)
AboutStroke.Transparency = 0.4
AboutStroke.Parent = AboutContainer

local AboutHeader = Instance.new("Frame")
AboutHeader.Size = UDim2.new(1, 0, 0, 45)
AboutHeader.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
AboutHeader.BorderSizePixel = 0
AboutHeader.Parent = AboutContainer

Instance.new("UICorner", AboutHeader).CornerRadius = UDim.new(0, 10)

local AboutTitle = Instance.new("TextLabel")
AboutTitle.Size = UDim2.new(1, -20, 1, 0)
AboutTitle.Position = UDim2.new(0, 10, 0, 0)
AboutTitle.BackgroundTransparency = 1
AboutTitle.Text = "📋 PRIME Hub Information"
AboutTitle.Font = Enum.Font.GothamBold
AboutTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
AboutTitle.TextSize = 15
AboutTitle.TextXAlignment = Enum.TextXAlignment.Left
AboutTitle.Parent = AboutHeader

local AboutContent = Instance.new("TextLabel")
AboutContent.Size = UDim2.new(1, -30, 0, 90)
AboutContent.Position = UDim2.new(0, 15, 0, 55)
AboutContent.BackgroundTransparency = 1
AboutContent.TextColor3 = Color3.fromRGB(255, 255, 255)
AboutContent.TextSize = 13
AboutContent.Font = Enum.Font.Gotham
AboutContent.TextWrapped = true
AboutContent.TextXAlignment = Enum.TextXAlignment.Left
AboutContent.TextYAlignment = Enum.TextYAlignment.Top
AboutContent.Text = "Version: 1.0\nDeveloper: WENDIGO\n\nCustomizable UI with modern design.\n\nJoin our Discord community:"
AboutContent.Parent = AboutContainer

local DiscordContainer = Instance.new("Frame")
DiscordContainer.Size = UDim2.new(1, -30, 0, 120)
DiscordContainer.Position = UDim2.new(0, 15, 0, 155)
DiscordContainer.BackgroundTransparency = 1
DiscordContainer.Parent = AboutContainer

local StoreDiscordBtn = Instance.new("TextButton")
StoreDiscordBtn.Size = UDim2.new(1, 0, 0, 45)
StoreDiscordBtn.Position = UDim2.new(0, 0, 0, 0)
StoreDiscordBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
StoreDiscordBtn.BorderSizePixel = 0
StoreDiscordBtn.AutoButtonColor = false
StoreDiscordBtn.Text = ""
StoreDiscordBtn.Parent = DiscordContainer

Instance.new("UICorner", StoreDiscordBtn).CornerRadius = UDim.new(0, 8)

local StoreStroke = Instance.new("UIStroke")
StoreStroke.Thickness = 1
StoreStroke.Color = Color3.fromRGB(255, 0, 0)
StoreStroke.Transparency = 0.5
StoreStroke.Parent = StoreDiscordBtn

local StoreIcon = Instance.new("TextLabel")
StoreIcon.Size = UDim2.new(0, 35, 1, 0)
StoreIcon.Position = UDim2.new(0, 8, 0, 0)
StoreIcon.BackgroundTransparency = 1
StoreIcon.Text = "🛒"
StoreIcon.Font = Enum.Font.GothamBold
StoreIcon.TextSize = 20
StoreIcon.TextColor3 = Color3.fromRGB(255, 0, 0)
StoreIcon.Parent = StoreDiscordBtn

local StoreLabel = Instance.new("TextLabel")
StoreLabel.Size = UDim2.new(1, -50, 0, 18)
StoreLabel.Position = UDim2.new(0, 45, 0, 6)
StoreLabel.BackgroundTransparency = 1
StoreLabel.Text = "Store Server"
StoreLabel.Font = Enum.Font.GothamBold
StoreLabel.TextSize = 14
StoreLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StoreLabel.TextXAlignment = Enum.TextXAlignment.Left
StoreLabel.Parent = StoreDiscordBtn

local StoreSubtext = Instance.new("TextLabel")
StoreSubtext.Size = UDim2.new(1, -50, 0, 14)
StoreSubtext.Position = UDim2.new(0, 45, 0, 24)
StoreSubtext.BackgroundTransparency = 1
StoreSubtext.Text = "Premium scripts & products"
StoreSubtext.Font = Enum.Font.Gotham
StoreSubtext.TextSize = 11
StoreSubtext.TextColor3 = Color3.fromRGB(200, 200, 200)
StoreSubtext.TextXAlignment = Enum.TextXAlignment.Left
StoreSubtext.Parent = StoreDiscordBtn

StoreDiscordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/CzbW5fKcKS")
    StoreLabel.Text = "✓ Link Copied!"
    StoreLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    wait(2)
    StoreLabel.Text = "Store Server"
    StoreLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

local SupportDiscordBtn = Instance.new("TextButton")
SupportDiscordBtn.Size = UDim2.new(1, 0, 0, 45)
SupportDiscordBtn.Position = UDim2.new(0, 0, 0, 55)
SupportDiscordBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
SupportDiscordBtn.BorderSizePixel = 0
SupportDiscordBtn.AutoButtonColor = false
SupportDiscordBtn.Text = ""
SupportDiscordBtn.Parent = DiscordContainer

Instance.new("UICorner", SupportDiscordBtn).CornerRadius = UDim.new(0, 8)

local SupportStroke = Instance.new("UIStroke")
SupportStroke.Thickness = 1
SupportStroke.Color = Color3.fromRGB(255, 0, 0)
SupportStroke.Transparency = 0.5
SupportStroke.Parent = SupportDiscordBtn

local SupportIcon = Instance.new("TextLabel")
SupportIcon.Size = UDim2.new(0, 35, 1, 0)
SupportIcon.Position = UDim2.new(0, 8, 0, 0)
SupportIcon.BackgroundTransparency = 1
SupportIcon.Text = "🛠️"
SupportIcon.Font = Enum.Font.GothamBold
SupportIcon.TextSize = 20
SupportIcon.TextColor3 = Color3.fromRGB(255, 0, 0)
SupportIcon.Parent = SupportDiscordBtn

local SupportLabel = Instance.new("TextLabel")
SupportLabel.Size = UDim2.new(1, -50, 0, 18)
SupportLabel.Position = UDim2.new(0, 45, 0, 6)
SupportLabel.BackgroundTransparency = 1
SupportLabel.Text = "Support & Bug Report"
SupportLabel.Font = Enum.Font.GothamBold
SupportLabel.TextSize = 14
SupportLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SupportLabel.TextXAlignment = Enum.TextXAlignment.Left
SupportLabel.Parent = SupportDiscordBtn

local SupportSubtext = Instance.new("TextLabel")
SupportSubtext.Size = UDim2.new(1, -50, 0, 14)
SupportSubtext.Position = UDim2.new(0, 45, 0, 24)
SupportSubtext.BackgroundTransparency = 1
SupportSubtext.Text = "Get help & report issues"
SupportSubtext.Font = Enum.Font.Gotham
SupportSubtext.TextSize = 11
SupportSubtext.TextColor3 = Color3.fromRGB(200, 200, 200)
SupportSubtext.TextXAlignment = Enum.TextXAlignment.Left
SupportSubtext.Parent = SupportDiscordBtn

SupportDiscordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/nUhMevHxCZ")
    SupportLabel.Text = "✓ Link Copied!"
    SupportLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    wait(2)
    SupportLabel.Text = "Support & Bug Report"
    SupportLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

-- Auto-update canvas sizes
LeftListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    LeftSection.CanvasSize = UDim2.new(0, 0, 0, LeftListLayout.AbsoluteContentSize.Y + 10)
end)

ContentListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentListLayout.AbsoluteContentSize.Y + 10)
end)

-- Toggle Game Section
GameBtn.MouseButton1Click:Connect(function()
    if currentSection == "Game" then
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 0, 1, -50)})
        tween:Play()
        wait(0.3)
        RightSection.Visible = false
        RightSection.Size = UDim2.new(0, 330, 1, -50)
        currentSection = nil
    else
        for _, child in pairs(ContentFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                child.Visible = false
            end
        end
        GameContainer.Visible = true
        RightSection.Size = UDim2.new(0, 0, 1, -50)
        RightSection.Visible = true
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 330, 1, -50)})
        tween:Play()
        currentSection = "Game"
    end
end)

-- Toggle Misc Section
MiscBtn.MouseButton1Click:Connect(function()
    if currentSection == "Misc" then
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 0, 1, -50)})
        tween:Play()
        wait(0.3)
        RightSection.Visible = false
        RightSection.Size = UDim2.new(0, 330, 1, -50)
        currentSection = nil
    else
        for _, child in pairs(ContentFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                child.Visible = false
            end
        end
        MiscContainer.Visible = true
        RightSection.Size = UDim2.new(0, 0, 1, -50)
        RightSection.Visible = true
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 330, 1, -50)})
        tween:Play()
        currentSection = "Misc"
    end
end)

-- Toggle Themes Section
ThemesBtn.MouseButton1Click:Connect(function()
    if currentSection == "Themes" then
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 0, 1, -50)})
        tween:Play()
        wait(0.3)
        RightSection.Visible = false
        RightSection.Size = UDim2.new(0, 330, 1, -50)
        currentSection = nil
    else
        for _, child in pairs(ContentFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                child.Visible = false
            end
        end
        ThemesContainer.Visible = true
        RightSection.Size = UDim2.new(0, 0, 1, -50)
        RightSection.Visible = true
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 330, 1, -50)})
        tween:Play()
        currentSection = "Themes"
    end
end)

-- Toggle About Section
AboutBtn.MouseButton1Click:Connect(function()
    if currentSection == "About" then
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 0, 1, -50)})
        tween:Play()
        wait(0.3)
        RightSection.Visible = false
        RightSection.Size = UDim2.new(0, 330, 1, -50)
        currentSection = nil
    else
        for _, child in pairs(ContentFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                child.Visible = false
            end
        end
        AboutContainer.Visible = true
        RightSection.Size = UDim2.new(0, 0, 1, -50)
        RightSection.Visible = true
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(RightSection, tweenInfo, {Size = UDim2.new(0, 330, 1, -50)})
        tween:Play()
        currentSection = "About"
    end
end)
