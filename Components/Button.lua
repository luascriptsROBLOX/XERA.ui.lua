-- XeraUI/Components/Button.lua
-- Clean Button component

local Button = {}
local Theme = require(script.Parent.Parent.Theme)

function Button.CreateButton(text, callback, parent)
    local ButtonElement = Instance.new("TextButton")
    ButtonElement.Size = UDim2.new(1, -20, 0, 40)
    ButtonElement.BackgroundColor3 = Theme.Button
    ButtonElement.BorderSizePixel = 0
    ButtonElement.Text = text
    ButtonElement.Font = Enum.Font.GothamBold
    ButtonElement.TextSize = 14
    ButtonElement.TextColor3 = Theme.TextColor
    ButtonElement.AutoButtonColor = true
    ButtonElement.Parent = parent

    local Corner = Instance.new("UICorner", ButtonElement)
    Corner.CornerRadius = UDim.new(0, 6)

    ButtonElement.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return ButtonElement
end

return Button
