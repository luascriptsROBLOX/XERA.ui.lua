-- XeraUI/PageHandler.lua
-- Manages pages (different tabs)

local PageHandler = {}
local Theme = require(script.Parent.Theme)

function PageHandler.CreatePages(parent)
    local Pages = Instance.new("Frame")
    Pages.Name = "Pages"
    Pages.Size = UDim2.new(1, -180, 1, -35)
    Pages.Position = UDim2.new(0, 180, 0, 35)
    Pages.BackgroundColor3 = Theme.Background
    Pages.BorderSizePixel = 0
    Pages.Parent = parent

    local UIPageLayout = Instance.new("UIPageLayout")
    UIPageLayout.FillDirection = Enum.FillDirection.Horizontal
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
    UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
    UIPageLayout.TweenTime = 0.4
    UIPageLayout.Padding = UDim.new(0, 10)
    UIPageLayout.Parent = Pages

    return Pages, UIPageLayout
end

function PageHandler.CreatePage(name, parent)
    local Page = Instance.new("Frame")
    Page.Name = name .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundColor3 = Theme.Background
    Page.BorderSizePixel = 0
    Page.Parent = parent

    return Page
end

return PageHandler
