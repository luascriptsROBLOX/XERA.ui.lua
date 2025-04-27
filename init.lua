-- XeraUI/init.lua
local XeraUI = {}

XeraUI.Core = {
    WindowHandler = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourgithubrepo/XeraUI/main/Core/WindowHandler.lua"))(),
    ThemeHandler = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourgithubrepo/XeraUI/main/Core/ThemeHandler.lua"))(),
    Loader = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourgithubrepo/XeraUI/main/Core/Loader.lua"))(),
}

XeraUI.Components = {
    Button = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourgithubrepo/XeraUI/main/Components/Button.lua"))(),
    Toggle = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourgithubrepo/XeraUI/main/Components/Toggle.lua"))(),
    Slider = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourgithubrepo/XeraUI/main/Components/Slider.lua"))(),
    Dropdown = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourgithubrepo/XeraUI/main/Components/Dropdown.lua"))(),
    Label = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourgithubrepo/XeraUI/main/Components/Label.lua"))(),
    Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourgithubrepo/XeraUI/main/Components/Notification.lua"))(),
    Keybind = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourgithubrepo/XeraUI/main/Components/Keybind.lua"))(),
    TabHandler = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourgithubrepo/XeraUI/main/Components/TabHandler.lua"))(),
}

function XeraUI:CreateWindow(opts)
    return XeraUI.Core.WindowHandler.new(opts)
end

return XeraUI
