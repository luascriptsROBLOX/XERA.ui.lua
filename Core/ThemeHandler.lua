-- XeraUI/Core/ThemeHandler.lua
local ThemeHandler = {}

ThemeHandler.CurrentTheme = {
    Background = Color3.fromRGB(24, 24, 24),
    Accent = Color3.fromRGB(0, 132, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    Secondary = Color3.fromRGB(34, 34, 34),
    Stroke = Color3.fromRGB(50, 50, 50)
}

function ThemeHandler:GetColor(name)
    return self.CurrentTheme[name]
end

function ThemeHandler:SetTheme(newTheme)
    self.CurrentTheme = newTheme
end

return ThemeHandler
