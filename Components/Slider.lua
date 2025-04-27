-- XeraUI/Components/Slider.lua
-- Smooth Slider component

local Slider = {}
local Theme = require(script.Parent.Parent.Theme)

function Slider.CreateSlider(text, min, max, default, callback, parent)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -20, 0, 50)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = parent

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 20)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.Text = text
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.Gotham
    Title.TextSize = 14
    Title.TextColor3 = Theme.TextColor
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = SliderFrame

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, 0, 0, 5)
    SliderBar.Position = UDim2.new(0, 0, 0, 30)
    SliderBar.BackgroundColor3 = Theme.SliderBackground
    SliderBar.BorderSizePixel = 0
    SliderBar.Parent = SliderFrame

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(0, 0, 1, 0)
    Fill.BackgroundColor3 = Theme.SliderFill
    Fill.BorderSizePixel = 0
    Fill.Parent = SliderBar

    local Dragging = false

    local function Update(input)
        local scale = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(scale, 0, 1, 0)
        local value = math.floor((min + (max - min) * scale) * 10) / 10
        if callback then
            callback(value)
        end
    end

    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            Update(input)
        end
    end)

    SliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            Update(input)
        end
    end)

    -- Initialize to default
    local defaultScale = (default - min) / (max - min)
    Fill.Size = UDim2.new(defaultScale, 0, 1, 0)
    if callback then
        callback(default)
    end

    return SliderFrame
end

return Slider
