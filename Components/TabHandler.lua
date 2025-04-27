-- XeraUI/Components/TabHandler.lua
-- Handles tab creation inside the main window

local TabHandler = {}
TabHandler.__index = TabHandler

function TabHandler.new(parent, options)
    local self = setmetatable({}, TabHandler)

    self.Title = options.Title or "Tab"
    self.Parent = parent
    self.Theme = require(game:GetService("ReplicatedStorage"):WaitForChild("XeraUI_Theme"))

    -- Create Tab Button
    self.TabButton = Instance.new("TextButton")
    self.TabButton.Name = "TabButton_" .. self.Title
    self.TabButton.Size = UDim2.new(1, 0, 0, 40)
    self.TabButton.BackgroundColor3 = self.Theme.Secondary
    self.TabButton.BorderColor3 = self.Theme.Stroke
    self.TabButton.Text = self.Title
    self.TabButton.Font = Enum.Font.GothamBold
    self.TabButton.TextColor3 = self.Theme.TextColor
    self.TabButton.TextSize = 18
    self.TabButton.Parent = self.Parent

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = self.TabButton

    -- Create Tab Frame (where controls will go)
    self.TabFrame = Instance.new("Frame")
    self.TabFrame.Name = "TabFrame_" .. self.Title
    self.TabFrame.Size = UDim2.new(1, 0, 1, 0)
    self.TabFrame.BackgroundTransparency = 1
    self.TabFrame.Visible = false
    self.TabFrame.Parent = self.Parent.Parent -- Parent to MainFrame

    -- Layout inside Tab
    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 6)
    Layout.Parent = self.TabFrame

    -- On Click Behavior
    self.TabButton.MouseButton1Click:Connect(function()
        for _, tab in ipairs(self.Parent.Parent:GetChildren()) do
            if tab:IsA("Frame") and tab.Name:find("TabFrame_") then
                tab.Visible = false
            end
        end
        self.TabFrame.Visible = true
    end)

    return self
end

function TabHandler:CreateButton(options)
    local Button = require(game:GetService("ReplicatedStorage"):WaitForChild("XeraUI_Button"))
    return Button.new(self.TabFrame, options)
end

function TabHandler:CreateToggle(options)
    local Toggle = require(game:GetService("ReplicatedStorage"):WaitForChild("XeraUI_Toggle"))
    return Toggle.new(self.TabFrame, options)
end

function TabHandler:CreateSlider(options)
    local Slider = require(game:GetService("ReplicatedStorage"):WaitForChild("XeraUI_Slider"))
    return Slider.new(self.TabFrame, options)
end

return TabHandler
