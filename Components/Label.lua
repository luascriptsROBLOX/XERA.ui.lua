-- XeraUI/Components/Label.lua
-- Simple text label

local Label = {}
local Theme = require(script.Parent.Parent.Theme)

function Label.CreateLabel(text, parent)
    local LabelElement = Instance.new("TextLabel")
    LabelElement.Size = UDim2.new(1, -20, 0, 30)
    LabelElement.BackgroundTransparency = 1
    LabelElement.Font = Enum.Font.Gotham
    LabelElement.TextSize = 14
    LabelElement.TextColor3 = Theme.TextColor
    LabelElement.Text = text
    LabelElement.TextXAlignment = Enum.TextXAlignment.Left
    LabelElement.Parent = parent

    return LabelElement
end

return Label
