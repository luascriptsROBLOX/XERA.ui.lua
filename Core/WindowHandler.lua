-- XeraUI/Core/WindowHandler.lua
local WindowHandler = {}
WindowHandler.__index = WindowHandler

local ThemeHandler = loadstring(game:HttpGet("https://raw.githubusercontent.com/luascriptsROBLOX/XERA.ui.lua/refs/heads/main/Components/Theme.lua"))()

function WindowHandler.new(options)
    local self = setmetatable({}, WindowHandler)

    self.Title = options.Title or "Xera UI"
    self.Theme = ThemeHandler.CurrentTheme

    self.ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Size = UDim2.new(0, 600, 0, 400)
    self.MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    self.MainFrame.BackgroundColor3 = self.Theme.Background
    self.MainFrame.BorderColor3 = self.Theme.Stroke
    self.MainFrame.Parent = self.ScreenGui

    local Title = Instance.new("TextLabel", self.MainFrame)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.Text = self.Title
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = self.Theme.TextColor
    Title.TextSize = 24

    return self
end

function WindowHandler:CreateTab(opts)
    -- Forward to TabHandler
    local TabHandler = loadstring(game:HttpGet("https://raw.githubusercontent.com/luascriptsROBLOX/XERA.ui.lua/refs/heads/main/Components/TabHandler.lua"))()
    return TabHandler.new(self.MainFrame, opts)
end

return WindowHandler
