local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local libary = {}
local KeybindList = {}
local Windows = {}
local CurrentWindow = nil
local CurrentTab = nil
local Sections = {left = {}, right = {}}
local ActiveKeybinds = {}
local Dragging = false
local DragStart = nil
local DragStartPosition = nil

local libary_config = {
    ToggleState = {},
    SliderProgress = {},
    TextInputValue = {},
    DropdownSelectedValues = {},
    DropdownValue = {},
    ConfigName = {},
    ConfigDate = {},
    KeybindValue = {},
    ColorPickerValue = {},
    MasterSwitchState = {},
    UIDPIScaleValue = {},
    KeybindListState = {}
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- Detached popup layer for elements that must render outside sections (e.g., dropdown lists)
local DropdownLayer = Instance.new("ScreenGui")
DropdownLayer.Name = "AllusiveDropdownLayer"
DropdownLayer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
DropdownLayer.ResetOnSpawn = false
DropdownLayer.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Name = "MainFrame"
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.Size = UDim2.new(0, 615, 0, 382)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(25, 25, 25)
UIStroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.BackgroundTransparency = 1
Header.Name = "Header"
Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
Header.Size = UDim2.new(0, 615, 0, 32)
Header.BorderSizePixel = 0
Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Header.Parent = MainFrame

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(0, 1)
Inline.Name = "Inline"
Inline.Position = UDim2.new(0, 0, 1, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(1, 1, 0, 1)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Inline.Parent = Header

local Libary_Name = Instance.new("TextLabel")
Libary_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Libary_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Libary_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Libary_Name.Text = "YourLibary"
Libary_Name.Name = "Libary_Name"
Libary_Name.AnchorPoint = Vector2.new(0, 0.5)
Libary_Name.Size = UDim2.new(0, 1, 0, 1)
Libary_Name.BackgroundTransparency = 1
Libary_Name.Position = UDim2.new(0, 50, 0.5, 0)
Libary_Name.BorderSizePixel = 0
Libary_Name.AutomaticSize = Enum.AutomaticSize.XY
Libary_Name.TextSize = 12
Libary_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Libary_Name.Parent = Header

-- Exit Button
local Exit_Button = Instance.new("ImageLabel")
Exit_Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
Exit_Button.Name = "Exit_Button"
Exit_Button.AnchorPoint = Vector2.new(1, 0.5)
Exit_Button.Image = "rbxassetid://112974212472592"
Exit_Button.BackgroundTransparency = 1
Exit_Button.Position = UDim2.new(0.9804878234863281, 0, 0.5, 0)
Exit_Button.Size = UDim2.new(0, 15, 0, 15)
Exit_Button.BorderSizePixel = 0
Exit_Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Exit_Button.Parent = Header

-- Minus Button
local Minus_Button = Instance.new("ImageLabel")
Minus_Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
Minus_Button.Name = "Minus_Button"
Minus_Button.AnchorPoint = Vector2.new(1, 0.5)
Minus_Button.Image = "rbxassetid://76709387357398"
Minus_Button.BackgroundTransparency = 1
Minus_Button.Position = UDim2.new(0.9447154402732849, 0, 0.5, 0)
Minus_Button.Size = UDim2.new(0, 15, 0, 15)
Minus_Button.BorderSizePixel = 0
Minus_Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Minus_Button.Parent = Header

-- Icon Holder
local Holder = Instance.new("Frame")
Holder.BackgroundTransparency = 1
Holder.Name = "Holder"
Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Holder.Size = UDim2.new(0, 39, 0, 31)
Holder.BorderSizePixel = 0
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.Parent = MainFrame

local Libary_Icon = Instance.new("ImageLabel")
Libary_Icon.ScaleType = Enum.ScaleType.Fit
Libary_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Libary_Icon.Name = "Libary_Icon"
Libary_Icon.AnchorPoint = Vector2.new(0.5, 0.5)
Libary_Icon.Image = "rbxassetid://130833403023050"
Libary_Icon.BackgroundTransparency = 1
Libary_Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
Libary_Icon.Size = UDim2.new(0, 15, 0, 15)
Libary_Icon.BorderSizePixel = 0
Libary_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Libary_Icon.Parent = Holder

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(1, 0)
Inline.Name = "Inline"
Inline.Position = UDim2.new(1, 0, 0, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(0, 1, 1, 1)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Inline.Parent = Holder

-- Side Bar
local Side_Bar = Instance.new("Frame")
Side_Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
Side_Bar.AnchorPoint = Vector2.new(0, 1)
Side_Bar.BackgroundTransparency = 1
Side_Bar.Position = UDim2.new(0, 0, 1, 0)
Side_Bar.Name = "Side_Bar"
Side_Bar.Size = UDim2.new(0, 126, 0, 351)
Side_Bar.BorderSizePixel = 0
Side_Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Side_Bar.Parent = MainFrame

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(1, 0)
Inline.Name = "Inline"
Inline.Position = UDim2.new(1, 0, 0, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(0, 1, 1, 1)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Inline.Parent = Side_Bar

-- Player Info Holder
local PlayerHolder = Instance.new("Frame")
PlayerHolder.AnchorPoint = Vector2.new(0.5, 1)
PlayerHolder.Name = "PlayerHolder"
PlayerHolder.Position = UDim2.new(0.488095223903656, 0, 1, -8)
PlayerHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
PlayerHolder.Size = UDim2.new(0, 114, 0, 35)
PlayerHolder.BorderSizePixel = 0
PlayerHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PlayerHolder.Parent = Side_Bar

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = PlayerHolder

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(25, 25, 25)
UIStroke.Parent = PlayerHolder

local Player_Icon = Instance.new("ImageLabel")
Player_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Player_Icon.AnchorPoint = Vector2.new(0, 0.5)
Player_Icon.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=150&height=150&format=png"
Player_Icon.Name = "Player_Icon"
Player_Icon.Position = UDim2.new(0.061403509229421616, 0, 0.5, 0)
Player_Icon.Size = UDim2.new(0, 22, 0, 22)
Player_Icon.BorderSizePixel = 0
Player_Icon.BackgroundTransparency = 1
Player_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Player_Icon.Parent = PlayerHolder

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 50)
UICorner.Parent = Player_Icon

local Player_User = Instance.new("TextLabel")
Player_User.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Player_User.TextColor3 = Color3.fromRGB(255, 255, 255)
Player_User.BorderColor3 = Color3.fromRGB(0, 0, 0)
Player_User.Text = string.len(game.Players.LocalPlayer.Name) > 8 and string.sub(game.Players.LocalPlayer.Name, 1, 7) .. "." or game.Players.LocalPlayer.Name
Player_User.Name = "Player_User"
Player_User.Size = UDim2.new(0, 1, 0, 1)
Player_User.BackgroundTransparency = 1
Player_User.Position = UDim2.new(0.280456006526947, 3, 0.17157156765460968, 0)
Player_User.BorderSizePixel = 0
Player_User.AutomaticSize = Enum.AutomaticSize.XY
Player_User.TextSize = 12
Player_User.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Player_User.Parent = PlayerHolder

local Player_Membership = Instance.new("TextLabel")
Player_Membership.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Player_Membership.TextColor3 = Color3.fromRGB(75, 75, 75)
Player_Membership.BorderColor3 = Color3.fromRGB(0, 0, 0)
Player_Membership.Text = "Owner"
Player_Membership.Name = "Player_Membership"
Player_Membership.Size = UDim2.new(0, 1, 0, 1)
Player_Membership.BorderSizePixel = 0
Player_Membership.BackgroundTransparency = 1
Player_Membership.Position = UDim2.new(0.2982456088066101, 0, 0.5142857432365417, 0)
Player_Membership.RichText = true
Player_Membership.AutomaticSize = Enum.AutomaticSize.XY
Player_Membership.TextSize = 12
Player_Membership.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Player_Membership.Parent = PlayerHolder

-- Tab Container
local TabContainer = Instance.new("Frame")
TabContainer.BackgroundTransparency = 1
TabContainer.Name = "TabContainer"
TabContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
TabContainer.Size = UDim2.new(0, 125, 0, 352)
TabContainer.BorderSizePixel = 0
TabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TabContainer.Parent = Side_Bar

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = TabContainer

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.PaddingLeft = UDim.new(0, 8)
UIPadding.Parent = TabContainer

-- Main Content Area
local Page = Instance.new("Frame")
Page.Name = "Page"
Page.BackgroundTransparency = 1
Page.Position = UDim2.new(0.20596517622470856, 0, 0.08496125787496567, 0)
Page.BorderColor3 = Color3.fromRGB(0, 0, 0)
Page.Size = UDim2.new(0, 489, 0, 350)
Page.BorderSizePixel = 0
Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Page.Parent = MainFrame

local Container = Instance.new("ScrollingFrame")
Container.Active = true
Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
Container.ScrollBarThickness = 0
Container.BackgroundTransparency = 1
Container.Name = "Container"
Container.Size = UDim2.new(0, 488, 0, 349)
Container.BorderSizePixel = 0
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.Parent = Page

local UIListLayout2 = Instance.new("UIListLayout")
UIListLayout2.Wraps = true
UIListLayout2.Padding = UDim.new(0, 12)
UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout2.FillDirection = Enum.FillDirection.Horizontal
UIListLayout2.Parent = Container

local UIPadding2 = Instance.new("UIPadding")
UIPadding2.PaddingTop = UDim.new(0, 10)
UIPadding2.PaddingLeft = UDim.new(0, 10)
UIPadding2.Parent = Container

-- Shadow effect
local Shadow = Instance.new("Frame")
Shadow.AnchorPoint = Vector2.new(0, 1)
Shadow.Name = "Shadow"
Shadow.Position = UDim2.new(0, 0, 1, 0)
Shadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
Shadow.Size = UDim2.new(0, 488, 0, 83)
Shadow.BorderSizePixel = 0
Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Shadow.Parent = Page

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 90
UIGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.291, 0.28125),
    NumberSequenceKeypoint.new(0.915, 0.012499988079071045),
    NumberSequenceKeypoint.new(0.928, 0),
    NumberSequenceKeypoint.new(1, 0)
}
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
}
UIGradient.Parent = Shadow

-- Drag handle
local Scalable_Dragge = Instance.new("ImageLabel")
Scalable_Dragge.ImageColor3 = Color3.fromRGB(88, 88, 88)
Scalable_Dragge.ScaleType = Enum.ScaleType.Fit
Scalable_Dragge.BorderColor3 = Color3.fromRGB(0, 0, 0)
Scalable_Dragge.Name = "Scalable_Dragge"
Scalable_Dragge.AnchorPoint = Vector2.new(1, 1)
Scalable_Dragge.Image = "rbxassetid://74600870587278"
Scalable_Dragge.BackgroundTransparency = 1
Scalable_Dragge.Position = UDim2.new(0.9856557250022888, 0, 0.891566276550293, 0)
Scalable_Dragge.Size = UDim2.new(0, 10, 0, 10)
Scalable_Dragge.BorderSizePixel = 0
Scalable_Dragge.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Scalable_Dragge.Parent = Shadow

-- Window class
local Window = {}
Window.__index = Window

-- Tab class
local Tab = {}
Tab.__index = Tab

-- Section class
local Section = {}
Section.__index = Section

-- CreateWindow function
function libary:CreateWindow(config)
    local window = setmetatable({}, Window)
    window.config = config.library_config or {}
    window.tabs = {}
    window.currentTab = nil
    
    -- Update library name and icon
    if window.config.Cheat_Name then
        Libary_Name.Text = window.config.Cheat_Name
    end
    
    if window.config.Cheat_Icon then
        Libary_Icon.Image = window.config.Cheat_Icon
    end
    
    -- Update player info
    if window.config.Player_Membership then
        Player_Membership.Text = window.config.Player_Membership
    end
    
    -- Set up keybind
    if window.config.interface_keybind then
        local keybind = Enum.KeyCode[window.config.interface_keybind]
        if keybind then
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if not gameProcessed and input.KeyCode == keybind then
                    MainFrame.Visible = not MainFrame.Visible
                end
            end)
        end
    end
    
    -- Set up exit button
    Exit_Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            MainFrame.Visible = false
        end
    end)
    
    Minus_Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            MainFrame.Visible = false
        end
    end)
    
    -- Set up dragging
    local dragging = false
    local dragStart = nil
    local startPosition = nil
    
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPosition = MainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    CurrentWindow = window
    return window
end

-- CreateTab function
function Window:CreateTab(config)
    local tab = setmetatable({}, Tab)
    tab.config = config
    tab.sections = {left = {}, right = {}}
    
    -- Create tab button (inactive state by default)
    local TabButton = Instance.new("Frame")
    TabButton.Name = "Tab_" .. config.TabText
    TabButton.BackgroundTransparency = 1
    TabButton.Position = UDim2.new(0.0873015895485878, 0, 0.022522522136569023, 0)
    TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabButton.Size = UDim2.new(0, 107, 0, 25)
    TabButton.BorderSizePixel = 0
    TabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabButton.Parent = TabContainer

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = TabButton

local Icon = Instance.new("ImageLabel")
Icon.ScaleType = Enum.ScaleType.Fit
Icon.ImageColor3 = Color3.fromRGB(78, 78, 78)
Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Icon.Name = "Icon"
Icon.AnchorPoint = Vector2.new(0, 0.5)
    Icon.Image = config.icon or "rbxassetid://103009339613412"
Icon.BackgroundTransparency = 1
Icon.Position = UDim2.new(0, 6, 0.5, 0)
Icon.Size = UDim2.new(0, 15, 0, 15)
Icon.BorderSizePixel = 0
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icon.Parent = TabButton

local Tab_Name = Instance.new("TextLabel")
Tab_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Tab_Name.TextColor3 = Color3.fromRGB(78, 78, 78)
Tab_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tab_Name.Text = config.TabText
Tab_Name.Name = "Tab_Name"
Tab_Name.AnchorPoint = Vector2.new(0, 0.5)
Tab_Name.Size = UDim2.new(0, 1, 0, 1)
Tab_Name.BackgroundTransparency = 1
Tab_Name.Position = UDim2.new(0, 25, 0.5, 0)
Tab_Name.BorderSizePixel = 0
Tab_Name.AutomaticSize = Enum.AutomaticSize.XY
Tab_Name.TextSize = 14
Tab_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tab_Name.Parent = TabButton
    
    -- Helper to activate this tab: hide all sections, then show only this tab's sections
    local function activateThisTab()
        for _, child in ipairs(Container:GetChildren()) do
            if child:IsA("Frame") and child.Name:sub(1,8) == "Section_" then
                child.Visible = false
            end
        end
        for _, s in ipairs(tab.sections.left) do
            if s.frame then s.frame.Visible = true end
        end
        for _, s in ipairs(tab.sections.right) do
            if s.frame then s.frame.Visible = true end
        end
    end
    
    -- Tab click functionality with smooth animations
    TabButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            -- Smooth fade out animation for all sections
            for _, child in ipairs(Container:GetChildren()) do
                if child:IsA("Frame") and child.Name:sub(1,8) == "Section_" then
                    child.Visible = false
                end
            end
            
            -- Show this tab's sections with smooth fade in
            for _, section in pairs(tab.sections.left) do
                if section.frame then
                    section.frame.Visible = true
                    section.frame.BackgroundTransparency = 1
                    local fadeInInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    TweenService:Create(section.frame, fadeInInfo, {BackgroundTransparency = 0}):Play()
                end
            end
            for _, section in pairs(tab.sections.right) do
                if section.frame then
                    section.frame.Visible = true
                    section.frame.BackgroundTransparency = 1
                    local fadeInInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    TweenService:Create(section.frame, fadeInInfo, {BackgroundTransparency = 0}):Play()
                end
            end
            
            -- Smooth tab appearance animations
            for _, child in pairs(TabContainer:GetChildren()) do
                if child:IsA("Frame") and child.Name:find("Tab_") then
                    -- Smooth fade to inactive state
                    local fadeOutInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local fadeOutTween = TweenService:Create(child, fadeOutInfo, {BackgroundTransparency = 1})
                    fadeOutTween:Play()
                    
                    local textFadeOutInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local textFadeOutTween = TweenService:Create(child:FindFirstChild("Tab_Name"), textFadeOutInfo, {TextColor3 = Color3.fromRGB(78, 78, 78)})
                    textFadeOutTween:Play()
                    
                    local iconFadeOutInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local iconFadeOutTween = TweenService:Create(child:FindFirstChild("Icon"), iconFadeOutInfo, {ImageColor3 = Color3.fromRGB(78, 78, 78)})
                    iconFadeOutTween:Play()
                    
                    -- Remove UIStroke if it exists
                    local existingStroke = child:FindFirstChild("UIStroke")
                    if existingStroke then
                        existingStroke:Destroy()
                    end
                end
            end
            
            -- Remove UIStroke from current tab button before adding new one
            local currentStroke = TabButton:FindFirstChild("UIStroke")
            if currentStroke then
                currentStroke:Destroy()
            end
            
            -- Smooth fade to active state
            local fadeInInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local fadeInTween = TweenService:Create(TabButton, fadeInInfo, {BackgroundTransparency = 0})
            fadeInTween:Play()
            
            local textFadeInInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local textFadeInTween = TweenService:Create(Tab_Name, textFadeInInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)})
            textFadeInTween:Play()
            
            local iconFadeInInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local iconFadeInTween = TweenService:Create(Icon, iconFadeInInfo, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
            iconFadeInTween:Play()
            
            -- Add UIStroke for active tab
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(25, 25, 25)
            UIStroke.Parent = TabButton
            
            CurrentTab = tab
        end
    end)
    
    -- Set as first tab if none selected
    if not CurrentTab then
        TabButton.BackgroundTransparency = 0
        TabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Tab_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
        Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Color = Color3.fromRGB(25, 25, 25)
        UIStroke.Parent = TabButton
        CurrentTab = tab
        activateThisTab()
    end
    
    table.insert(self.tabs, tab)
    return tab
end

-- CreateSection function
function Tab:CreateSection(config)
    local section = setmetatable({}, Section)
    section.config = config
    section.components = {}
    
    -- Create section frame
    local SectionFrame = Instance.new("Frame")
    SectionFrame.ClipsDescendants = true
    SectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SectionFrame.Name = "Section_" .. config.SectionText
    SectionFrame.Size = UDim2.new(0, 228, 0, 65)
    SectionFrame.BorderSizePixel = 0
    SectionFrame.AutomaticSize = Enum.AutomaticSize.Y
    SectionFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
    SectionFrame.Visible = false
    SectionFrame.Parent = Container

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = SectionFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(26, 26, 26)
    UIStroke.Parent = SectionFrame

    -- Header
local Header = Instance.new("Frame")
Header.AnchorPoint = Vector2.new(0.5, 0)
Header.Name = "Header"
Header.Position = UDim2.new(0.5, 0, 0, 0)
Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
Header.Size = UDim2.new(0, 228, 0, 35)
Header.BorderSizePixel = 0
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Header.Parent = SectionFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Header

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(0, 1)
Inline.Name = "Inline"
Inline.Position = UDim2.new(0, 0, 1, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(1, 1, 0, 1)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
Inline.Parent = Header

local Icon = Instance.new("ImageLabel")
Icon.ScaleType = Enum.ScaleType.Fit
Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Icon.Name = "Icon"
Icon.AnchorPoint = Vector2.new(0, 0.5)
    Icon.Image = config.SectionIcon or "rbxassetid://78055370910689"
Icon.BackgroundTransparency = 1
Icon.Position = UDim2.new(0, 8, 0.5, 0)
Icon.Size = UDim2.new(0, 15, 0, 15)
Icon.BorderSizePixel = 0
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.Parent = Header

local Section_Name = Instance.new("TextLabel")
Section_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Section_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Section_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Section_Name.Text = config.SectionText
Section_Name.Name = "Section_Name"
Section_Name.AnchorPoint = Vector2.new(0, 0.5)
Section_Name.Size = UDim2.new(0, 1, 0, 1)
Section_Name.BackgroundTransparency = 1
Section_Name.Position = UDim2.new(0, 30, 0.5, 0)
Section_Name.BorderSizePixel = 0
Section_Name.AutomaticSize = Enum.AutomaticSize.XY
Section_Name.TextSize = 14
Section_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Section_Name.Parent = Header

    -- Master Switch (if enabled)
    local masterSwitchState = false
    if config.MasterSwitchState then
local Master_Switch = Instance.new("Frame")
Master_Switch.AnchorPoint = Vector2.new(1, 0.5)
Master_Switch.Name = "Master_Switch"
Master_Switch.Position = UDim2.new(1, -10, 0.5, 0)
Master_Switch.BorderColor3 = Color3.fromRGB(0, 0, 0)
Master_Switch.Size = UDim2.new(0, 30, 0, 18)
Master_Switch.BorderSizePixel = 0
Master_Switch.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
Master_Switch.Parent = Header

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 100)
UICorner.Parent = Master_Switch

local Pointer = Instance.new("Frame")
Pointer.AnchorPoint = Vector2.new(0, 0.5)
Pointer.Name = "Pointer"
Pointer.Position = UDim2.new(0, 3, 0.5, 0)
Pointer.BorderColor3 = Color3.fromRGB(20, 20, 20)
Pointer.Size = UDim2.new(0, 12, 0, 12)
Pointer.BorderSizePixel = 0
Pointer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Pointer.Parent = Master_Switch

        local UICorner2 = Instance.new("UICorner")
        UICorner2.CornerRadius = UDim.new(0, 100)
        UICorner2.Parent = Pointer
        
        -- Master Switch functionality
        Master_Switch.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                masterSwitchState = not masterSwitchState
                
                -- Animate master switch
                if masterSwitchState then
                    Master_Switch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    local moveInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local moveTween = TweenService:Create(Pointer, moveInfo, {Position = UDim2.new(0, 15, 0.5, 0)})
                    moveTween:Play()
                else
                    Master_Switch.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
                    local moveInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local moveTween = TweenService:Create(Pointer, moveInfo, {Position = UDim2.new(0, 3, 0.5, 0)})
                    moveTween:Play()
                end
                
                -- Toggle all components in this section
                for _, component in pairs(section.components) do
                    if component.state ~= nil then
                        component.state = masterSwitchState
                        if component.toggle then
                            if masterSwitchState then
                                -- Keep the dark toggle look when active
                                component.toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                                component.toggle:FindFirstChild("UIStroke").Color = Color3.fromRGB(26, 26, 26)
                                component.text.TextColor3 = Color3.fromRGB(255, 255, 255)
                                component.check.Visible = true
                            else
                                component.toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                                component.toggle:FindFirstChild("UIStroke").Color = Color3.fromRGB(26, 26, 26)
                                component.text.TextColor3 = Color3.fromRGB(76, 76, 76)
                                component.check.Visible = false
                            end
                        end
                        if component.config.Callback then
                            component.config.Callback(component.state)
                        end
                    end
                end
            end
        end)
    end
    
    -- Keybind display
local Keybind = Instance.new("TextLabel")
Keybind.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
Keybind.Text = "Space"
Keybind.BorderSizePixel = 0
Keybind.AnchorPoint = Vector2.new(1, 0.5)
Keybind.Size = UDim2.new(0, 1, 0, 1)
Keybind.Name = "Keybind"
Keybind.Position = UDim2.new(1, -45, 0.5, 0)
Keybind.AutomaticSize = Enum.AutomaticSize.XY
Keybind.TextYAlignment = Enum.TextYAlignment.Bottom
Keybind.TextSize = 14
Keybind.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
Keybind.Parent = Header

    -- Keybind functionality
    local keybindConnection = nil
    local currentKeybind : Enum.KeyCode? = nil
    local currentMouseButton : string? = nil
    local currentControllerKey : Enum.KeyCode? = nil
    local currentControllerNumber : number? = nil

    local function disconnectKeybind()
        if keybindConnection then keybindConnection:Disconnect() keybindConnection = nil end
    end

    local function updateKB(keyCode)
        currentKeybind = keyCode
        Keybind.Text = keyCode and keyCode.Name or "None"
        disconnectKeybind()
        keybindConnection = UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.UserInputType == Enum.UserInputType.Keyboard and currentKeybind and input.KeyCode == currentKeybind then
                -- toggle behavior by default
                applyActiveState(not keybind.active)
            end
        end)
    end

    local function updateMouse(mouseButton)
        currentMouseButton = mouseButton
        Keybind.Text = mouseButton
        disconnectKeybind()
        keybindConnection = UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            local hit = (mouseButton == "LMB" and input.UserInputType == Enum.UserInputType.MouseButton1)
                or (mouseButton == "RMB" and input.UserInputType == Enum.UserInputType.MouseButton2)
                or (mouseButton == "MMB" and input.UserInputType == Enum.UserInputType.MouseButton3)
            if hit then
                applyActiveState(not keybind.active)
            end
        end)
    end

    local function updateController(gamepadKey, controllerNumber)
        currentControllerKey = gamepadKey
        currentControllerNumber = controllerNumber
        Keybind.Text = "P" .. tostring(controllerNumber) .. "_" .. gamepadKey.Name
        disconnectKeybind()
        keybindConnection = UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if currentControllerNumber and input.UserInputType == Enum.UserInputType["Gamepad" .. currentControllerNumber] and currentControllerKey and input.KeyCode == currentControllerKey then
                applyActiveState(not keybind.active)
            end
        end)
    end

    -- replace earlier default
    updateKB(Enum.KeyCode.Space)
    
    -- Set up keybind listening with typewriter animation
    Keybind.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            -- Smooth typewriter animation for "..."
            local dots = ""
            local typewriterConnection
            local lastUpdate = 0
            typewriterConnection = RunService.Heartbeat:Connect(function()
                local currentTime = tick()
                if currentTime - lastUpdate >= 0.5 then -- Slower, smoother timing
                    dots = dots .. "."
                    if #dots > 3 then
                        dots = ""
                    end
                    Keybind.Text = dots
                    lastUpdate = currentTime
                end
            end)
            
            Keybind.TextColor3 = Color3.fromRGB(255, 255, 0)
            
            -- Smooth scale animation
            local scaleInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local scaleTween = TweenService:Create(Keybind, scaleInfo, {Size = UDim2.new(0, Keybind.Size.X.Offset * 1.1, 0, Keybind.Size.Y.Offset * 1.1)})
            scaleTween:Play()
            
            local connection
            connection = UserInputService.InputBegan:Connect(function(input2, gameProcessed)
                if not gameProcessed then
                    -- Stop typewriter animation
                    typewriterConnection:Disconnect()
                    
                    -- Smooth scale back animation
                    local scaleBackInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local scaleBackTween = TweenService:Create(Keybind, scaleBackInfo, {Size = UDim2.new(0, Keybind.Size.X.Offset / 1.1, 0, Keybind.Size.Y.Offset / 1.1)})
                    scaleBackTween:Play()
                    
                    -- Handle different input types properly
                    if input2.UserInputType == Enum.UserInputType.Keyboard then
                        updateKB(input2.KeyCode)
                    elseif input2.UserInputType == Enum.UserInputType.MouseButton1 then
                        updateMouse("LMB")
                    elseif input2.UserInputType == Enum.UserInputType.MouseButton2 then
                        updateMouse("RMB")
                    elseif input2.UserInputType == Enum.UserInputType.MouseButton3 then
                        updateMouse("MMB")
                    elseif input2.UserInputType == Enum.UserInputType.Gamepad1 then
                        updateController(input2.KeyCode, 1)
                    elseif input2.UserInputType == Enum.UserInputType.Gamepad2 then
                        updateController(input2.KeyCode, 2)
                    elseif input2.UserInputType == Enum.UserInputType.Gamepad3 then
                        updateController(input2.KeyCode, 3)
                    elseif input2.UserInputType == Enum.UserInputType.Gamepad4 then
                        updateController(input2.KeyCode, 4)
                    elseif input2.UserInputType == Enum.UserInputType.Gamepad5 then
                        updateController(input2.KeyCode, 5)
                    elseif input2.UserInputType == Enum.UserInputType.Gamepad6 then
                        updateController(input2.KeyCode, 6)
                    elseif input2.UserInputType == Enum.UserInputType.Gamepad7 then
                        updateController(input2.KeyCode, 7)
                    elseif input2.UserInputType == Enum.UserInputType.Gamepad8 then
                        updateController(input2.KeyCode, 8)
                    end
                    
Keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    -- Right-click context menu for keybind modes
    Keybind.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            -- Create context menu
            local Container = Instance.new("Frame")
            Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Container.Size = UDim2.new(0, 82, 0, 73)
            Container.Name = "Container"
            Container.Position = UDim2.new(0.5972850322723389, 0, 0.8358209133148193, 0)
            Container.BorderSizePixel = 0
            Container.ZIndex = 50
            Container.AutomaticSize = Enum.AutomaticSize.XY
            Container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            Container.Parent = ScreenGui

            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Parent = Container

local UIPadding = Instance.new("UIPadding")
            UIPadding.PaddingBottom = UDim.new(0, 8)
            UIPadding.PaddingTop = UDim.new(0, 5)
            UIPadding.Parent = Container

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Container

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(26, 26, 26)
            UIStroke.Parent = Container

            -- Hold option
            local HoldFrame = Instance.new("Frame")
            HoldFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            HoldFrame.Position = UDim2.new(0.3027423918247223, 0, 0.1666666716337204, 0)
            HoldFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            HoldFrame.Size = UDim2.new(0, 82, 0, 20)
            HoldFrame.BorderSizePixel = 0
            HoldFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            HoldFrame.Parent = Container

            local HoldText = Instance.new("TextLabel")
            HoldText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            HoldText.TextColor3 = Color3.fromRGB(255, 255, 255)
            HoldText.BorderColor3 = Color3.fromRGB(0, 0, 0)
            HoldText.Text = "Hold"
            HoldText.AnchorPoint = Vector2.new(0.5, 0.5)
            HoldText.Size = UDim2.new(0, 1, 0, 1)
            HoldText.BackgroundTransparency = 1
            HoldText.Position = UDim2.new(0.5, 0, 0.5, 0)
            HoldText.BorderSizePixel = 0
            HoldText.AutomaticSize = Enum.AutomaticSize.XY
            HoldText.TextSize = 16
            HoldText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            HoldText.Parent = HoldFrame

            -- Toggle option
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            ToggleFrame.Position = UDim2.new(0.2998863160610199, 0, 0.5, 0)
            ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleFrame.Size = UDim2.new(0, 82, 0, 20)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            ToggleFrame.Parent = Container

            local ToggleText = Instance.new("TextLabel")
            ToggleText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            ToggleText.TextColor3 = Color3.fromRGB(76, 76, 76)
            ToggleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleText.Text = "Toggle"
            ToggleText.AnchorPoint = Vector2.new(0.5, 0.5)
            ToggleText.Size = UDim2.new(0, 1, 0, 1)
            ToggleText.BackgroundTransparency = 1
            ToggleText.Position = UDim2.new(0.5, 0, 0.5, 0)
            ToggleText.BorderSizePixel = 0
            ToggleText.AutomaticSize = Enum.AutomaticSize.XY
            ToggleText.TextSize = 16
            ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleText.Parent = ToggleFrame

            -- Always On option
            local AlwaysFrame = Instance.new("Frame")
            AlwaysFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            AlwaysFrame.Position = UDim2.new(0.2998863160610199, 0, 0.8333333134651184, 0)
            AlwaysFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            AlwaysFrame.Size = UDim2.new(0, 82, 0, 20)
            AlwaysFrame.BorderSizePixel = 0
            AlwaysFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            AlwaysFrame.Parent = Container

            local AlwaysText = Instance.new("TextLabel")
            AlwaysText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            AlwaysText.TextColor3 = Color3.fromRGB(76, 76, 76)
            AlwaysText.BorderColor3 = Color3.fromRGB(0, 0, 0)
            AlwaysText.Text = "Always On"
            AlwaysText.AnchorPoint = Vector2.new(0.5, 0.5)
            AlwaysText.Size = UDim2.new(0, 1, 0, 1)
            AlwaysText.BackgroundTransparency = 1
            AlwaysText.Position = UDim2.new(0.5, 0, 0.5, 0)
            AlwaysText.BorderSizePixel = 0
            AlwaysText.AutomaticSize = Enum.AutomaticSize.XY
            AlwaysText.TextSize = 16
            AlwaysText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            AlwaysText.Parent = AlwaysFrame

            -- Close context menu when clicking outside
            local closeConnection
            closeConnection = UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
                    Container:Destroy()
                    closeConnection:Disconnect()
                end
            end)
        end
    end)
    
    -- Initialize keybind
    updateKB(Enum.KeyCode.Space)

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 3)
UIPadding.PaddingBottom = UDim.new(0, 3)
UIPadding.PaddingRight = UDim.new(0, 6)
UIPadding.PaddingLeft = UDim.new(0, 6)
UIPadding.Parent = Keybind

    local UICorner3 = Instance.new("UICorner")
    UICorner3.CornerRadius = UDim.new(0, 4)
    UICorner3.Parent = Keybind
    
    -- Content holder
local Holder = Instance.new("Frame")
Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Holder.AnchorPoint = Vector2.new(0.5, 0)
Holder.Name = "Holder"
Holder.BackgroundTransparency = 1
Holder.Position = UDim2.new(0.5, 0, 1, 0)
Holder.Size = UDim2.new(0, 1, 0, 1)
Holder.BorderSizePixel = 0
Holder.AutomaticSize = Enum.AutomaticSize.XY
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.Parent = Header

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Holder

    local UIPadding2 = Instance.new("UIPadding")
    UIPadding2.PaddingBottom = UDim.new(0, 25)
    UIPadding2.PaddingTop = UDim.new(0, 4)
    UIPadding2.Parent = Holder
    
    local UIPadding3 = Instance.new("UIPadding")
    UIPadding3.PaddingBottom = UDim.new(0, 10)
    UIPadding3.Parent = SectionFrame
    
    section.frame = SectionFrame
    section.header = Header
    section.holder = Holder
    
    -- Add to appropriate side
    if config.position == "left" then
        table.insert(self.sections.left, section)
    else
        table.insert(self.sections.right, section)
    end
    
    -- If this tab is currently active, ensure the new section is visible immediately
    if CurrentTab == self then
        SectionFrame.Visible = true
    end

    return section
end

-- Working Toggle function with animations
function Section:CreateToggle(config)
    local toggle = {}
    toggle.config = config
    toggle.state = false
    
    -- Create toggle component
    local ToggleComponent = Instance.new("Frame")
    ToggleComponent.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ToggleComponent.AnchorPoint = Vector2.new(0.5, 0)
    ToggleComponent.BackgroundTransparency = 1
    ToggleComponent.Position = UDim2.new(0.5, 0, 0, 0)
    ToggleComponent.Name = "Toggle_" .. config.ToggleText
    ToggleComponent.Size = UDim2.new(0, 228, 0, 30)
    ToggleComponent.BorderSizePixel = 0
    ToggleComponent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleComponent.Parent = self.holder
    
    local ToggleText = Instance.new("TextLabel")
    ToggleText.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    ToggleText.TextColor3 = Color3.fromRGB(76, 76, 76)
    ToggleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ToggleText.Text = config.ToggleText
    ToggleText.Name = "Toggle_Text"
    ToggleText.AnchorPoint = Vector2.new(0, 0.5)
    ToggleText.Size = UDim2.new(0, 1, 0, 1)
    ToggleText.BackgroundTransparency = 1
    ToggleText.Position = UDim2.new(0.035087719559669495, 0, 0.5, 0)
    ToggleText.BorderSizePixel = 0
    ToggleText.AutomaticSize = Enum.AutomaticSize.XY
    ToggleText.TextSize = 14
    ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleText.Parent = ToggleComponent

local Toggle = Instance.new("Frame")
Toggle.AnchorPoint = Vector2.new(1, 0.5)
Toggle.Name = "Toggle"
Toggle.Position = UDim2.new(0.9649122953414917, 0, 0.5, 0)
Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle.Size = UDim2.new(0, 16, 0, 16)
Toggle.BorderSizePixel = 0
Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Toggle.Parent = ToggleComponent

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Toggle

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(26, 26, 26)
UIStroke.Parent = Toggle

local Check = Instance.new("ImageLabel")
Check.BorderColor3 = Color3.fromRGB(0, 0, 0)
Check.Name = "Check"
Check.AnchorPoint = Vector2.new(0.5, 0.5)
Check.Image = "rbxassetid://103083009202465"
Check.BackgroundTransparency = 1
Check.Position = UDim2.new(0.5, 0, 0.5, 0)
Check.Size = UDim2.new(0, 10, 0, 12)
Check.BorderSizePixel = 0
Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Check.Parent = Toggle
    Check.Visible = false
    
    -- Toggle click functionality
    ToggleComponent.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggle.state = not toggle.state
            
            -- Animate toggle
            if toggle.state then
                -- Turn on animation - keep original colors as specified
                Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
UIStroke.Color = Color3.fromRGB(26, 26, 26)
                ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
                Check.Visible = true
                
                -- Smooth scale animation
                local scaleInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local scaleTween = TweenService:Create(Check, scaleInfo, {Size = UDim2.new(0, 10, 0, 12)})
                scaleTween:Play()
            else
                -- Turn off animation
                Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
UIStroke.Color = Color3.fromRGB(26, 26, 26)
                ToggleText.TextColor3 = Color3.fromRGB(76, 76, 76)
                
                -- Smooth scale out animation
                local scaleInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local scaleTween = TweenService:Create(Check, scaleInfo, {Size = UDim2.new(0, 0, 0, 0)})
                scaleTween:Play()
                
                -- Hide check after animation
                scaleTween.Completed:Connect(function()
                    Check.Visible = false
                end)
            end
            
            -- Call callback
            if config.Callback then
                config.Callback(toggle.state)
            end
        end
    end)
    
    toggle.component = ToggleComponent
    toggle.toggle = Toggle
    toggle.check = Check
    toggle.text = ToggleText
    
    -- Register with section
    table.insert(self.components, toggle)
    
    return toggle
end

function Section:CreateSlider(config)
    local slider = {}
    slider.config = config or {}
    slider.text = slider.config.SliderText or "Slider"
    slider.min = slider.config.Min or 0
    slider.max = slider.config.Max or 100
    slider.default = slider.config.Default or 50
    slider.precision = slider.config.Precision or 1
    slider.callback = slider.config.Callback
    
    slider.value = slider.default

local Slider_Componenet = Instance.new("Frame")
Slider_Componenet.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider_Componenet.AnchorPoint = Vector2.new(0.5, 0)
Slider_Componenet.BackgroundTransparency = 1
    Slider_Componenet.Position = UDim2.new(0.5, 0, 0, 0)
Slider_Componenet.Name = "Slider_Componenet"
Slider_Componenet.Size = UDim2.new(0, 228, 0, 35)
Slider_Componenet.BorderSizePixel = 0
Slider_Componenet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Slider_Componenet.Parent = self.holder

local Slider_Label = Instance.new("TextLabel")
Slider_Label.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Slider_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Slider_Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Slider_Label.Text = slider.text
Slider_Label.Name = "Slider_Label"
Slider_Label.Size = UDim2.new(0, 1, 0, 1)
Slider_Label.BackgroundTransparency = 1
Slider_Label.Position = UDim2.new(0, 8, 0, 0)
Slider_Label.BorderSizePixel = 0
Slider_Label.AutomaticSize = Enum.AutomaticSize.XY
Slider_Label.TextSize = 14
Slider_Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider_Label.Parent = Slider_Componenet

local Slider_BG = Instance.new("Frame")
Slider_BG.AnchorPoint = Vector2.new(0.5, 1)
Slider_BG.Name = "Slider_BG"
Slider_BG.Position = UDim2.new(0.5, 0, 1, -10)
Slider_BG.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider_BG.Size = UDim2.new(0, 214, 0, 6)
Slider_BG.BorderSizePixel = 0
Slider_BG.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Slider_BG.Parent = Slider_Componenet

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 50)
UICorner.Parent = Slider_BG

local Slider_Progress = Instance.new("Frame")
Slider_Progress.AnchorPoint = Vector2.new(0, 0.5)
Slider_Progress.Name = "Slider_Progress"
Slider_Progress.Position = UDim2.new(0, 0, 0.5, 0)
Slider_Progress.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider_Progress.Size = UDim2.new(0, 116, 0, 6)
Slider_Progress.BorderSizePixel = 0
Slider_Progress.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider_Progress.Parent = Slider_BG

    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 50)
    UICorner2.Parent = Slider_Progress

local Pointer = Instance.new("Frame")
Pointer.AnchorPoint = Vector2.new(1, 0.5)
Pointer.Name = "Pointer"
Pointer.Position = UDim2.new(1, 0, 0.5, 0)
Pointer.BorderColor3 = Color3.fromRGB(0, 0, 0)
Pointer.Size = UDim2.new(0, 12, 0, 12)
Pointer.BorderSizePixel = 0
Pointer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pointer.Parent = Slider_Progress

    local UICorner3 = Instance.new("UICorner")
    UICorner3.Parent = Pointer

local Slider_Value = Instance.new("TextLabel")
Slider_Value.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Slider_Value.TextColor3 = Color3.fromRGB(255, 255, 255)
Slider_Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Slider_Value.Text = tostring(slider.value)
Slider_Value.Name = "Slider_Value"
Slider_Value.AnchorPoint = Vector2.new(1, 0)
Slider_Value.Size = UDim2.new(0, 1, 0, 1)
Slider_Value.BackgroundTransparency = 1
Slider_Value.Position = UDim2.new(1, -9, 0, 0)
Slider_Value.BorderSizePixel = 0
Slider_Value.AutomaticSize = Enum.AutomaticSize.XY
Slider_Value.TextSize = 14
Slider_Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider_Value.Parent = Slider_Componenet

    local function updateSlider(value)
        slider.value = math.clamp(value, slider.min, slider.max)
        local percentage = (slider.value - slider.min) / (slider.max - slider.min)
        local progressWidth = 214 * percentage
        
        -- Smooth animation for progress bar
        local progressInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        TweenService:Create(Slider_Progress, progressInfo, {Size = UDim2.new(0, progressWidth, 0, 6)}):Play()
        
        -- Update value display
        Slider_Value.Text = tostring(slider.value)
        
        -- Call callback
        if slider.callback then
            slider.callback(slider.value)
        end
    end

    -- Set initial value
    updateSlider(slider.default)

    -- Mouse interaction
    local dragging = false
    local connection

    Slider_BG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            
            -- Calculate new value based on mouse position
            local mousePos = UserInputService:GetMouseLocation()
            local sliderPos = Slider_BG.AbsolutePosition
            local sliderSize = Slider_BG.AbsoluteSize
            local relativeX = mousePos.X - sliderPos.X
            local percentage = math.clamp(relativeX / sliderSize.X, 0, 1)
            local newValue = slider.min + (percentage * (slider.max - slider.min))
            
            -- Round to precision
            newValue = math.floor(newValue / slider.precision + 0.5) * slider.precision
            updateSlider(newValue)
        end
    end)

    connection = UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            local sliderPos = Slider_BG.AbsolutePosition
            local sliderSize = Slider_BG.AbsoluteSize
            local relativeX = mousePos.X - sliderPos.X
            local percentage = math.clamp(relativeX / sliderSize.X, 0, 1)
            local newValue = slider.min + (percentage * (slider.max - slider.min))
            
            -- Round to precision
            newValue = math.floor(newValue / slider.precision + 0.5) * slider.precision
            updateSlider(newValue)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    slider.component = Slider_Componenet
    slider.progress = Slider_Progress
    slider.pointer = Pointer
    slider.valueLabel = Slider_Value
    
    function slider:Set(value)
        updateSlider(value)
    end
    
    function slider:Get()
        return slider.value
    end

    table.insert(self.components, slider)
    return slider
end

function Section:CreateTextInput(config)
    print("TextInput created:", config.TextInputText)
    return {}
end

function Section:CreateDropdown(config)
    local dd = {}
    dd.config = config or {}
    dd.text = dd.config.DropdownText or "Dropdown"
    dd.options = dd.config.Options or {"Option 1","Option 2"}
    dd.selected = dd.config.Default or dd.options[1]
    dd.callback = dd.config.Callback
    dd.multiSelect = dd.config.MultiSelect or false
    dd.selectedItems = dd.multiSelect and (dd.config.SelectedItems or {}) or {}

local Dropdown_Componenet = Instance.new("Frame")
Dropdown_Componenet.BorderColor3 = Color3.fromRGB(0, 0, 0)
Dropdown_Componenet.AnchorPoint = Vector2.new(0.5, 0)
Dropdown_Componenet.BackgroundTransparency = 1
    Dropdown_Componenet.Position = UDim2.new(0.5, 0, 0, 0)
Dropdown_Componenet.Name = "Dropdown_Componenet"
Dropdown_Componenet.Size = UDim2.new(0, 228, 0, 55)
Dropdown_Componenet.BorderSizePixel = 0
Dropdown_Componenet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Dropdown_Componenet.Parent = self.holder

local Dropdown_Label = Instance.new("TextLabel")
Dropdown_Label.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Dropdown_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Dropdown_Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Dropdown_Label.Text = tostring(dd.text)
Dropdown_Label.Name = "Dropdown_Label"
Dropdown_Label.Size = UDim2.new(0, 1, 0, 1)
Dropdown_Label.BackgroundTransparency = 1
Dropdown_Label.Position = UDim2.new(0, 8, 0, 0)
Dropdown_Label.BorderSizePixel = 0
Dropdown_Label.AutomaticSize = Enum.AutomaticSize.XY
Dropdown_Label.TextSize = 14
Dropdown_Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Dropdown_Label.Parent = Dropdown_Componenet

local Dropdown = Instance.new("Frame")
Dropdown.AnchorPoint = Vector2.new(0.5, 0)
Dropdown.Name = "Dropdown"
Dropdown.Position = UDim2.new(0.5, 0, 0, 20)
Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
Dropdown.Size = UDim2.new(0, 212, 0, 30)
Dropdown.BorderSizePixel = 0
Dropdown.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Dropdown.Parent = Dropdown_Componenet

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Dropdown

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(26, 26, 26)
UIStroke.Parent = Dropdown

local Dropdown_Options = Instance.new("TextLabel")
Dropdown_Options.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Dropdown_Options.TextColor3 = Color3.fromRGB(255, 255, 255)
Dropdown_Options.BorderColor3 = Color3.fromRGB(0, 0, 0)
Dropdown_Options.Text = dd.multiSelect and (#dd.selectedItems > 0 and table.concat(dd.selectedItems, ", ") or "Select options...") or tostring(dd.selected or "")
Dropdown_Options.Name = "Dropdown_Options"
Dropdown_Options.AnchorPoint = Vector2.new(0, 0.5)
Dropdown_Options.Size = UDim2.new(0, 1, 0, 1)
Dropdown_Options.BackgroundTransparency = 1
Dropdown_Options.Position = UDim2.new(0, 10, 0.5, 0)
Dropdown_Options.BorderSizePixel = 0
Dropdown_Options.AutomaticSize = Enum.AutomaticSize.XY
Dropdown_Options.TextSize = 14
Dropdown_Options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Dropdown_Options.Parent = Dropdown

local Icon = Instance.new("ImageLabel")
Icon.ScaleType = Enum.ScaleType.Fit
Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Icon.Name = "Icon"
Icon.AnchorPoint = Vector2.new(1, 0.5)
    Icon.Image = dd.config.Icon or "rbxassetid://95652893039727"
Icon.BackgroundTransparency = 1
Icon.Position = UDim2.new(1, -8, 0.5, 0)
Icon.Size = UDim2.new(0, 15, 0, 15)
Icon.BorderSizePixel = 0
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.Parent = Dropdown

    -- Options container rendered in detached layer so it escapes section clipping
    local OptionsContainer = Instance.new("Frame")
    OptionsContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    OptionsContainer.Name = "Container"
    OptionsContainer.BorderSizePixel = 0
    OptionsContainer.ZIndex = 500
    OptionsContainer.AutomaticSize = Enum.AutomaticSize.Y
    OptionsContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    OptionsContainer.Visible = false
    OptionsContainer.Parent = MainFrame

    local ocStroke = Instance.new("UIStroke")
    ocStroke.Color = Color3.fromRGB(26, 26, 26)
    ocStroke.Parent = OptionsContainer

local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingBottom = UDim.new(0, 8)
    UIPadding.PaddingTop = UDim.new(0, 5)
    UIPadding.Parent = OptionsContainer

    local ocCorner = Instance.new("UICorner")
    ocCorner.CornerRadius = UDim.new(0, 4)
    ocCorner.Parent = OptionsContainer

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = OptionsContainer

    local function closeDropdown()
        open = false
        -- Smooth icon rotation back
        local rotateInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        TweenService:Create(Icon, rotateInfo, {Rotation = 0}):Play()
        
        -- Smooth dropdown close animation
        local closeInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        local closeTween = TweenService:Create(OptionsContainer, closeInfo, {Size = UDim2.new(0, 210, 0, 0)})
        closeTween:Play()
        closeTween.Completed:Connect(function()
            OptionsContainer.Visible = false
        end)
    end

    local function renderOptions()
        for _,child in ipairs(OptionsContainer:GetChildren()) do
            if child:IsA("Frame") and child.Name == "OptionRow" then
                child:Destroy()
            end
        end
        
        for i, opt in ipairs(dd.options) do
            local row = Instance.new("Frame")
            row.Name = "OptionRow"
            row.AnchorPoint = Vector2.new(0.5, 0)
            row.Size = UDim2.new(0, 210, 0, 20)
            row.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            row.BorderSizePixel = 0
            row.Parent = OptionsContainer
            
            -- Start with transparent for animation
            row.BackgroundTransparency = 1
            
            local isSelected = dd.multiSelect and table.find(dd.selectedItems, opt) or (opt == dd.selected)
            
            local tl = Instance.new("TextLabel")
            tl.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            tl.TextColor3 = isSelected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(76, 76, 76)
            tl.BorderColor3 = Color3.fromRGB(0, 0, 0)
            tl.Text = tostring(opt)
            tl.AnchorPoint = Vector2.new(0, 0.5)
            tl.Size = UDim2.new(0, 1, 0, 1)
            tl.BackgroundTransparency = 1
            tl.Position = UDim2.new(0.035, 0, 0.5, 0)
            tl.BorderSizePixel = 0
            tl.AutomaticSize = Enum.AutomaticSize.XY
            tl.TextSize = 16
            tl.Parent = row
            
            if dd.multiSelect then
                local checkmark = Instance.new("ImageLabel")
                checkmark.Name = "Checkmark"
                checkmark.Image = "rbxassetid://139958444428790"
                checkmark.ImageColor3 = Color3.fromRGB(255, 255, 255)
                checkmark.BackgroundTransparency = 1
                checkmark.AnchorPoint = Vector2.new(0.5, 0.5)
                checkmark.Size = UDim2.new(0, 15, 0, 16)
                checkmark.Parent = row
                
                -- Initially hide check icon and position it to the right (STARHUB style)
                checkmark.ImageTransparency = 1
                checkmark.Position = UDim2.new(1.2, 0, 0.5, 0)
                
                if isSelected then
                    -- Selected - show check icon with smooth slide-in animation
                    checkmark.Position = UDim2.new(0.9070789217948914, 0, 0.5, 0)
                    checkmark.ImageTransparency = 0
                end
            end
            
            -- Animate row appearance with stagger
            local delay = (i - 1) * 0.05
            local fadeIn = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local fadeInTween = TweenService:Create(row, fadeIn, {BackgroundTransparency = 0})
            
            if delay > 0 then
                wait(delay)
            end
            fadeInTween:Play()
            
            row.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    -- Smooth selection animation
                    local selectAnim = TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                    TweenService:Create(row, selectAnim, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                    
                    wait(0.1)
                    
                    if dd.multiSelect then
                        local index = table.find(dd.selectedItems, opt)
                        local checkIcon = row:FindFirstChild("Checkmark")
                        local textLabel = tl
                        
                        if index then
                            -- Remove from selection - STARHUB style slide out
                            table.remove(dd.selectedItems, index)
                            textLabel.TextColor3 = Color3.fromRGB(76, 76, 76)
                            
                            local slideOut = TweenService:Create(checkIcon, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                                Position = UDim2.new(1.2, 0, 0.5, 0),
                                ImageTransparency = 1
                            })
                            slideOut:Play()
                        else
                            -- Add to selection - STARHUB style slide in
                            table.insert(dd.selectedItems, opt)
                            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            
                            local slideIn = TweenService:Create(checkIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Position = UDim2.new(0.9070789217948914, 0, 0.5, 0),
                                ImageTransparency = 0
                            })
                            slideIn:Play()
                        end
                        
                        Dropdown_Options.Text = #dd.selectedItems > 0 and table.concat(dd.selectedItems, ", ") or "Select options..."
                        if dd.callback then dd.callback(dd.selectedItems) end
                    else
                        dd.selected = opt
                        Dropdown_Options.Text = tostring(opt)
                        closeDropdown()
                        if dd.callback then dd.callback(opt) end
                    end
                    
                    -- Reset row color
                    local resetAnim = TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                    TweenService:Create(row, resetAnim, {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}):Play()
                    
                    renderOptions()
                end
            end)
        end
    end

    renderOptions()

    local open = false
    local clickOutsideConnection = nil
    
    Dropdown.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            open = not open
            
            if open then
                -- Position and show dropdown
                local absPos = Dropdown.AbsolutePosition
                local absSize = Dropdown.AbsoluteSize
                local parentAbs = MainFrame.AbsolutePosition
                OptionsContainer.Position = UDim2.fromOffset(absPos.X - parentAbs.X, absPos.Y - parentAbs.Y + absSize.Y + 1)
                OptionsContainer.Size = UDim2.new(0, 210, 0, 0)
                OptionsContainer.Visible = true
                
                -- Smooth icon rotation
                local rotateInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                TweenService:Create(Icon, rotateInfo, {Rotation = 180}):Play()
                
                -- Smooth dropdown open animation with bounce
                local openInfo = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                TweenService:Create(OptionsContainer, openInfo, {Size = UDim2.new(0, 210, 0, math.min(#dd.options * 20 + 13, 120))}):Play()
                
                -- Set up click outside detection
                if clickOutsideConnection then
                    clickOutsideConnection:Disconnect()
                end
                clickOutsideConnection = UserInputService.InputBegan:Connect(function(input2)
                    if input2.UserInputType == Enum.UserInputType.MouseButton1 then
                        local mousePos = UserInputService:GetMouseLocation()
                        local dropdownPos = OptionsContainer.AbsolutePosition
                        local dropdownSize = OptionsContainer.AbsoluteSize
                        local dropdownFrame = Dropdown.AbsolutePosition
                        local dropdownFrameSize = Dropdown.AbsoluteSize
                        
                        -- Check if click is outside both dropdown and options
                        local outsideDropdown = not (mousePos.X >= dropdownFrame.X and mousePos.X <= dropdownFrame.X + dropdownFrameSize.X and
                                                   mousePos.Y >= dropdownFrame.Y and mousePos.Y <= dropdownFrame.Y + dropdownFrameSize.Y)
                        local outsideOptions = not (mousePos.X >= dropdownPos.X and mousePos.X <= dropdownPos.X + dropdownSize.X and
                                                  mousePos.Y >= dropdownPos.Y and mousePos.Y <= dropdownPos.Y + dropdownSize.Y)
                        
                        if outsideDropdown and outsideOptions then
                            closeDropdown()
                            clickOutsideConnection:Disconnect()
                            clickOutsideConnection = nil
                        end
                    end
                end)
            else
                closeDropdown()
                if clickOutsideConnection then
                    clickOutsideConnection:Disconnect()
                    clickOutsideConnection = nil
                end
            end
        end
    end)

    dd.component = Dropdown_Componenet
    dd.container = OptionsContainer
    dd.label = Dropdown_Options
    function dd:Set(value)
        if dd.multiSelect then
            dd.selectedItems = value or {}
            Dropdown_Options.Text = #dd.selectedItems > 0 and table.concat(dd.selectedItems, ", ") or "Select options..."
        else
            dd.selected = value
            Dropdown_Options.Text = tostring(value)
        end
        renderOptions()
    end
    function dd:Get()
        return dd.multiSelect and dd.selectedItems or dd.selected
    end
    function dd:AddOption(option)
        table.insert(dd.options, option)
        renderOptions()
    end
    function dd:RemoveOption(option)
        local index = table.find(dd.options, option)
        if index then
            table.remove(dd.options, index)
            if dd.multiSelect then
                local selectedIndex = table.find(dd.selectedItems, option)
                if selectedIndex then
                    table.remove(dd.selectedItems, selectedIndex)
                end
            end
            renderOptions()
        end
    end

    table.insert(self.components, dd)
    return dd
end

function Section:CreateKeybind(config)
	print("test")
end



function Section:CreateColorpicker(config)
    print("Colorpicker created:", config.ColorpickerText)
    return {}
end

function Section:CreateLabel(config)
    print("Label created:", config.LabelText)
    return {}
end

function Section:CreateButton(config)
    print("Button created:", config.ButtonText)
    return {}
end

function Section:AddColorToggle(config)
    local colorToggle = {}
    colorToggle.config = config or {}
    colorToggle.text = colorToggle.config.Text or "Color Toggle"
    colorToggle.defaultColor = colorToggle.config.DefaultColor or Color3.fromRGB(255, 255, 255)
    colorToggle.colorpickerIcon = colorToggle.config.Colorpicker_Icon or "rbxassetid://121639239565210"
    colorToggle.callback = colorToggle.config.Callback
    
    colorToggle.state = false
    colorToggle.color = colorToggle.defaultColor

local Toggle_Componenet = Instance.new("Frame")
Toggle_Componenet.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Componenet.AnchorPoint = Vector2.new(0.5, 0)
Toggle_Componenet.BackgroundTransparency = 1
Toggle_Componenet.Position = UDim2.new(0.5, 0, 0, 0)
Toggle_Componenet.Name = "Toggle_Componenet"
Toggle_Componenet.Size = UDim2.new(0, 228, 0, 30)
Toggle_Componenet.BorderSizePixel = 0
Toggle_Componenet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Toggle_Componenet.Parent = self.holder

local Toggle_Text = Instance.new("TextLabel")
Toggle_Text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Toggle_Text.TextColor3 = Color3.fromRGB(76, 76, 76)
Toggle_Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Toggle_Text.Text = colorToggle.text
Toggle_Text.Name = "Toggle_Text"
Toggle_Text.AnchorPoint = Vector2.new(0, 0.5)
Toggle_Text.Size = UDim2.new(0, 1, 0, 1)
Toggle_Text.BackgroundTransparency = 1
Toggle_Text.Position = UDim2.new(0.035087719559669495, 0, 0.5, 0)
Toggle_Text.BorderSizePixel = 0
Toggle_Text.AutomaticSize = Enum.AutomaticSize.XY
Toggle_Text.TextSize = 14
Toggle_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Text.Parent = Toggle_Componenet

local Toggle = Instance.new("Frame")
Toggle.AnchorPoint = Vector2.new(1, 0.5)
Toggle.Name = "Toggle"
Toggle.Position = UDim2.new(0.9649122953414917, 0, 0.5, 0)
Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle.Size = UDim2.new(0, 16, 0, 16)
Toggle.BorderSizePixel = 0
Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Toggle.Parent = Toggle_Componenet

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Toggle

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(26, 26, 26)
UIStroke.Parent = Toggle

local Check = Instance.new("ImageLabel")
Check.BorderColor3 = Color3.fromRGB(0, 0, 0)
Check.Name = "Check"
Check.AnchorPoint = Vector2.new(0.5, 0.5)
Check.Image = "rbxassetid://103083009202465"
Check.BackgroundTransparency = 1
Check.Position = UDim2.new(0.5, 0, 0.5, 0)
Check.Size = UDim2.new(0, 10, 0, 12)
Check.BorderSizePixel = 0
Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Check.Visible = false
Check.Parent = Toggle

local Color_Frame = Instance.new("ImageLabel")
Color_Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Color_Frame.Name = "Color_Frame"
Color_Frame.AnchorPoint = Vector2.new(1, 0.5)
    Color_Frame.Image = colorToggle.colorpickerIcon
Color_Frame.BackgroundTransparency = 1
Color_Frame.Position = UDim2.new(1, -30, 0.5, 0)
Color_Frame.Size = UDim2.new(0, 15, 0, 15)
Color_Frame.BorderSizePixel = 0
    Color_Frame.BackgroundColor3 = colorToggle.color
Color_Frame.Parent = Toggle_Componenet

    -- Color picker container (initially hidden)
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Position = UDim2.new(0.07462084293365479, 0, 0.7636815905570984, 0)
    Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Container.Size = UDim2.new(0, 197, 0, 143)
    Container.BorderSizePixel = 0
    Container.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
    Container.Visible = false
    Container.ZIndex = 1000
    Container.Parent = MainFrame

    local Colorframe = Instance.new("Frame")
    Colorframe.Name = "Colorframe"
    Colorframe.Position = UDim2.new(0.03479499742388725, 0, 0.03896091878414154, 0)
    Colorframe.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Colorframe.Size = UDim2.new(0, 183, 0, 107)
    Colorframe.BorderSizePixel = 0
    Colorframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Colorframe.Parent = Container

    local Value = Instance.new("ImageLabel")
    Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Value.Name = "Value"
    Value.AnchorPoint = Vector2.new(0.5, 0.5)
    Value.Image = "http://www.roblox.com/asset/?id=14684563800"
    Value.BackgroundTransparency = 1
    Value.Position = UDim2.new(0.49350759387016296, 0, 0.4711485207080841, 0)
    Value.Size = UDim2.new(0, 185, 0, 114)
    Value.BorderSizePixel = 0
    Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Value.Parent = Colorframe

    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 4)
    UICorner2.Parent = Value

    local Hue = Instance.new("ImageButton")
    Hue.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Hue.Size = UDim2.new(0.061389729380607605, -1, 1.7670859098434448, -8)
    Hue.Rotation = 90
    Hue.Image = "http://www.roblox.com/asset/?id=14684557999"
    Hue.Name = "Hue"
    Hue.Position = UDim2.new(0.46975407004356384, 0, 1.1288152933120728, 0)
    Hue.AnchorPoint = Vector2.new(0, 0.5)
    Hue.BorderSizePixel = 0
    Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Hue.Parent = Colorframe

    local UICorner3 = Instance.new("UICorner")
    UICorner3.CornerRadius = UDim.new(0, 30)
    UICorner3.Parent = Hue

    local HuePicker = Instance.new("Frame")
    HuePicker.AnchorPoint = Vector2.new(0.5, 0)
    HuePicker.Name = "Picker"
    HuePicker.Position = UDim2.new(0.5, 0, 0, 0)
    HuePicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
    HuePicker.Size = UDim2.new(0, 10, 0, 10)
    HuePicker.BorderSizePixel = 0
    HuePicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HuePicker.Parent = Hue

    local UICorner4 = Instance.new("UICorner")
    UICorner4.CornerRadius = UDim.new(0, 50)
    UICorner4.Parent = HuePicker

    local UIStroke2 = Instance.new("UIStroke")
    UIStroke2.Color = Color3.fromRGB(255, 255, 255)
    UIStroke2.Parent = HuePicker

    local ColorPicker = Instance.new("Frame")
    ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ColorPicker.AnchorPoint = Vector2.new(0.5, 0.5)
    ColorPicker.BackgroundTransparency = 1
    ColorPicker.Position = UDim2.new(0.5, 0, 0.5, 0)
    ColorPicker.Name = "Picker"
    ColorPicker.Size = UDim2.new(0, 10, 0, 10)
    ColorPicker.BorderSizePixel = 0
    ColorPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ColorPicker.Parent = Colorframe

    local UICorner5 = Instance.new("UICorner")
    UICorner5.CornerRadius = UDim.new(0, 50)
    UICorner5.Parent = ColorPicker

    local UIStroke3 = Instance.new("UIStroke")
    UIStroke3.Color = Color3.fromRGB(255, 255, 255)
    UIStroke3.Parent = ColorPicker

    local UICorner6 = Instance.new("UICorner")
    UICorner6.CornerRadius = UDim.new(0, 4)
    UICorner6.Parent = Colorframe

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4))
    }
    UIGradient.Parent = Colorframe

    local UICorner7 = Instance.new("UICorner")
    UICorner7.CornerRadius = UDim.new(0, 4)
    UICorner7.Parent = Container

    local ContainerStroke = Instance.new("UIStroke")
    ContainerStroke.Color = Color3.fromRGB(25, 25, 25)
    ContainerStroke.Parent = Container

    local function updateColor(newColor)
        colorToggle.color = newColor
        Color_Frame.BackgroundColor3 = newColor
        Color_Frame.ImageColor3 = newColor
        if colorToggle.callback then
            colorToggle.callback(colorToggle.state, newColor)
        end
    end

    local function closeColorPicker()
        Container.Visible = false
    end

    local function updateSVFrame()
        Colorframe.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
    end
    
    local function updateColor()
        local c = Color3.fromHSV(currentHue, currentSat, currentVal)
        colorToggle.color = c
        Color_Frame.BackgroundColor3 = c
        Color_Frame.ImageColor3 = c
        if colorToggle.callback then
            colorToggle.callback(colorToggle.state, c)
        end
    end

    -- Initialize with default color using Roblox's built-in HSV
    local h, s, v = colorToggle.defaultColor:ToHSV()
    local currentHue = h
    local currentSat = s
    local currentVal = v

    -- Color picker interaction
    local colorPickerDragging = false
    local huePickerDragging = false

    -- Initialize picker positions
    ColorPicker.Position = UDim2.new(currentSat, 0, 1 - currentVal, 0)
    HuePicker.Position = UDim2.new(0.5, 0, currentHue, 0)

    Colorframe.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            colorPickerDragging = true
            local absPos = Colorframe.AbsolutePosition
            local absSize = Colorframe.AbsoluteSize
            local rx = math.clamp((input.Position.X - absPos.X) / absSize.X, 0, 1)
            local ry = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
            currentSat = 1 - rx
            currentVal = 1 - ry
            ColorPicker.Position = UDim2.new(rx, 0, ry, 0)
            updateColor()
        end
    end)

    Hue.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            huePickerDragging = true
            local absPos = Hue.AbsolutePosition
            local absSize = Hue.AbsoluteSize
            local ry = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
            currentHue = ry
            HuePicker.Position = UDim2.new(0.5, 0, ry, 0)
            updateSVFrame()
            updateColor()
        end
    end)

    -- Global mouse tracking for dragging
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
        if colorPickerDragging then
            local absPos = Colorframe.AbsolutePosition
            local absSize = Colorframe.AbsoluteSize
            local rx = math.clamp((input.Position.X - absPos.X) / absSize.X, 0, 1)
            local ry = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
            currentSat = 1 - rx
            currentVal = 1 - ry
            ColorPicker.Position = UDim2.new(rx, 0, ry, 0)
            updateColor()
        end
        if huePickerDragging then
            local absPos = Hue.AbsolutePosition
            local absSize = Hue.AbsoluteSize
            local ry = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
            currentHue = ry
            HuePicker.Position = UDim2.new(0.5, 0, ry, 0)
            updateSVFrame()
            updateColor()
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            colorPickerDragging = false
            huePickerDragging = false
        end
    end)

    -- Toggle click functionality
    Toggle_Componenet.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            colorToggle.state = not colorToggle.state
            
            -- Animate toggle
            if colorToggle.state then
                Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                UIStroke.Color = Color3.fromRGB(26, 26, 26)
                Toggle_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
                Check.Visible = true
                
                -- Smooth scale animation
                local scaleInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local scaleTween = TweenService:Create(Check, scaleInfo, {Size = UDim2.new(0, 10, 0, 12)})
                scaleTween:Play()
            else
                Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                UIStroke.Color = Color3.fromRGB(26, 26, 26)
                Toggle_Text.TextColor3 = Color3.fromRGB(76, 76, 76)
                
                -- Smooth scale out animation
                local scaleInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local scaleTween = TweenService:Create(Check, scaleInfo, {Size = UDim2.new(0, 0, 0, 0)})
                scaleTween:Play()
                
                scaleTween.Completed:Connect(function()
                    Check.Visible = false
                end)
            end
            
            if colorToggle.callback then
                colorToggle.callback(colorToggle.state, colorToggle.color)
            end
        end
    end)

    -- Color frame click to open color picker
    Color_Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Container.Visible = not Container.Visible
            
            if Container.Visible then
                -- Position color picker near the color frame
                local colorFramePos = Color_Frame.AbsolutePosition
                local mainFramePos = MainFrame.AbsolutePosition
                Container.Position = UDim2.fromOffset(
                    colorFramePos.X - mainFramePos.X - 50,
                    colorFramePos.Y - mainFramePos.Y + 25
                )
            end
        end
    end)

    -- Click outside to close color picker
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and Container.Visible then
            -- Don't close if we're dragging the color picker or hue slider
            if not colorPickerDragging and not huePickerDragging then
                local mousePos = UserInputService:GetMouseLocation()
                local containerPos = Container.AbsolutePosition
                local containerSize = Container.AbsoluteSize
                
                if not (mousePos.X >= containerPos.X and mousePos.X <= containerPos.X + containerSize.X and
                       mousePos.Y >= containerPos.Y and mousePos.Y <= containerPos.Y + containerSize.Y) then
                    closeColorPicker()
                end
            end
        end
    end)

    colorToggle.component = Toggle_Componenet
    colorToggle.toggle = Toggle
    colorToggle.check = Check
    colorToggle.text = Toggle_Text
    colorToggle.colorFrame = Color_Frame
    colorToggle.colorPicker = Container
    
    function colorToggle:Set(state, color)
        colorToggle.state = state
        if color then
            colorToggle.color = color
            Color_Frame.BackgroundColor3 = color
        end
        
        -- Update visual state
        if state then
            Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            UIStroke.Color = Color3.fromRGB(26, 26, 26)
            Toggle_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
            Check.Visible = true
        else
            Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            UIStroke.Color = Color3.fromRGB(26, 26, 26)
            Toggle_Text.TextColor3 = Color3.fromRGB(76, 76, 76)
            Check.Visible = false
        end
    end
    
    function colorToggle:Get()
        return colorToggle.state, colorToggle.color
    end

    table.insert(self.components, colorToggle)
    return colorToggle
end

function Tab:CreateConfigSection(config)
    print("ConfigSection created:", config.Text)
    return {}
end

-- Library utility functions
function libary:KeybindList()
    print("KeybindList called")
end

function libary:CreateNotification(config)
    print("Notification created:", config.NotiTitle)
end

function libary:SetAccentColor(color)
    print("Accent color set:", color)
end

return libary
