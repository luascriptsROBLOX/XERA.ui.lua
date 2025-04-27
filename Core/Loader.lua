-- XeraUI/Core/Loader.lua
local Loader = {}

function Loader:DisplayLoadingScreen(text)
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local Label = Instance.new("TextLabel")

    ScreenGui.Name = "XeraUILoader"
    ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Frame.Size = UDim2.new(0, 300, 0, 100)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -50)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    Frame.Parent = ScreenGui
    Frame.BorderSizePixel = 0

    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.Text = text or "Loading Xera UI..."
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 20
    Label.Parent = Frame

    task.wait(3)
    ScreenGui:Destroy()
end

return Loader
