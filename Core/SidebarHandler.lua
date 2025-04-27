-- XeraUI/SidebarHandler.lua
-- Handles the Sidebar, Tab buttons, and switching

local SidebarHandler = {}
local Theme = require(script.Parent.Theme)

function SidebarHandler.CreateSidebar(parent)
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 180, 1, 0)
    Sidebar.Position = UDim2.new(0, 0, 0, 0)
    Sidebar.BackgroundColor3 = Theme.Sidebar
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = parent

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = Sidebar

    return Sidebar
end

function SidebarHandler.CreateTab(name, sidebar)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(1, -10, 0, 40)
    TabButton.Position = UDim2.new(0, 5, 0, 0)
    TabButton.BackgroundColor3 = Theme.SidebarButton
    TabButton.BorderSizePixel = 0
    TabButton.Text = name
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 14
    TabButton.TextColor3 = Theme.TextColor
    TabButton.AutoButtonColor = false
    TabButton.Parent = sidebar

    return TabButton
end

return SidebarHandler
