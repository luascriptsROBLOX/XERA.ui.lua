-- XeraUI/Components/Toggle.lua
-- Custom toggle switch

local Toggle = {}
local Theme = require(script.Parent.Parent.Theme)

function Toggle.CreateToggle(text, default, callback, parent)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 40)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = parent

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TextLabel.Position = UDim2.new(0, 0, 0, 0)
    TextLabel.Text = text
    TextLabel.BackgroundTransparency = 1
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.TextSize = 14
    TextLabel.TextColor3 = Theme.TextColor
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = ToggleFrame

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 50, 0, 25)
    ToggleButton.Position = UDim2.new(1, -60, 0.5, -12)
    ToggleButton.BackgroundColor3 = Theme.ToggleOff
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = ""
    ToggleButton.AutoButtonColor = false
    ToggleButton.Parent = ToggleFrame

    local Corner = Instance.new("UICorner", ToggleButton)
    Corner.CornerRadius = UDim.new(0, 12)

    local Enabled = default or false

    local function Update()
        if Enabled then
            ToggleButton.BackgroundColor3 = Theme.ToggleOn
        else
            ToggleButton.BackgroundColor3 = Theme.ToggleOff
        end
        if callback then
            callback(Enabled)
        end
    end

    ToggleButton.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        Update()
    end)

    Update()

    return ToggleFrame
end

return Toggle
