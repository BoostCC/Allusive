local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/BoostCC/Allusive/refs/heads/main/libarysrc.lua"))()

local Window = library:CreateWindow({
    library_config = {
        Cheat_Name = "LibaryTest",
        Cheat_Icon = "rbxassetid://130833403023050",
        interface_keybind = "Insert",
        Scalable = true,
        Player_Membership = "<font color='#6583FB'>Paid</font>",
    }
})

local Home = Window:CreateTab({icon = "rbxassetid://133833791023200", TabText = "Home"})
local Misc = Window:CreateTab({icon = "rbxassetid://133833791023200", TabText = "Combat"})
local Save = Window:CreateTab({icon = "rbxassetid://133833791023200", TabText = "Basic"})
local AimLeftSection = Home:CreateSection({position = "left", SectionText = "Aim Settings" , SectionIcon = "rbxassetid://133833791023200", MasterSwitchState = true})
local AimRightSection = Home:CreateSection({position = "right", SectionText = "Aim Options" , SectionIcon = "rbxassetid://133833791023200", MasterSwitchState = true})
local OtherOptionsLeftSection = Home:CreateSection({position = "left", SectionText = "Other Options" , SectionIcon = "rbxassetid://133833791023200", MasterSwitchState = true})
local OtherOptionsRightSection = Home:CreateSection({position = "right", SectionText = "Other Options" , SectionIcon = "rbxassetid://133833791023200", MasterSwitchState = true})

local Toggle1 = AimLeftSection:CreateToggle({ToggleText = "Enable Aim", Callback = function(Value)
    print("Aim Toggle:", Value)
end})

local Toggle2 = AimRightSection:CreateToggle({ToggleText = "Show Active Keybinds", Callback = function(Value)
    library:KeybindList()
end})


local Slider1 = AimLeftSection:CreateSlider({SliderText = "FOV", Min = 0, Max = 500, Value = 100, Callback = function(Value)
    print("FOV:", Value)
end})

local Label = AimRightSection:CreateLabel({LabelText = "This is a label lol"})

local Slider2 = AimRightSection:CreateSlider({SliderText = "FOV", Min = 0, Max = 500, Value = 100, Callback = function(Value)
    print("FOV:", Value)
end})

local TextInput1 = AimRightSection:CreateTextInput({TextInputText = "Target Player", Callback = function(Text)
    print("Target:", Text)
end})

local Dropdown1 = AimLeftSection:CreateDropdown({DropdownText = "Aim Type", Options = {"Mouse", "Keyboard", "Controller"}, Callback = function(Option)
    print("Aim Type:", Option)
end})

local MultiDropdown1 = AimRightSection:CreateDropdown({
    DropdownText = "Weapon Types", 
    Options = {"Rifle", "Pistol", "Shotgun", "Sniper", "SMG"}, 
    MultiSelect = true,
    Default = {"Rifle", "Pistol"},
    Callback = function(SelectedOptions)
        print("Selected Weapons:", table.concat(SelectedOptions, ", "))
    end
})

local toggle = OtherOptionsLeftSection:CreateToggle({ToggleText = "Enable Other Options", Callback = function(Value)
    print("Other Options:", Value)
end})

local ColorToggle = OtherOptionsLeftSection:AddColorToggle("ColorPicker w/Toggle", false, function(Value) 
    print("ColorToggle:", Value)
end)

local Keybind1 = AimRightSection:CreateKeybind({KeybindText = "Aim Key", Callback = function(Key)
    print("Aim Key:", Key)
end})

local AccentPicker = AimRightSection:CreateColorpicker({
    ColorpickerText = "Accent Color",
    Colorpicker_Icon = "Default", -- default icon is "rbxassetid://121639239565210"
    defaultColor = Color3.fromRGB(155, 77, 255),
    Callback = function(color)
        if library.SetAccentColor then
            library:SetAccentColor(color)
        end
        print("Accent updated", color)
    end
})


local ExampleButton = OtherOptionsLeftSection:CreateButton({ButtonText = "Example Button", Callback = function()
    library:CreateNotification({Icon = "default", NotiTitle = "Notification", NotiDescription = "This is an example notification.", Time = 3}) --default icon is rbxassetid://126734532279048
end}) 





library:KeybindList()



-- local ConfigSection = Save:CreateConfigSection({
--     Text = "Config Manager"
-- })

