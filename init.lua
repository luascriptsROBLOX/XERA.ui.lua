-- XeraUI/Init.lua
-- Initializes full UI framework

local WindowHandler = require(script.WindowHandler)
local SidebarHandler = require(script.SidebarHandler)
local PageHandler = require(script.PageHandler)
local Toggle = require(script.Components.Toggle)
local Button = require(script.Components.Button)
local Slider = require(script.Components.Slider)
local Label = require(script.Components.Label)
local ProfileLoader = require(script.Components.ProfileLoader)

local XeraUI = {}

function XeraUI:CreateWindow(title, userId)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "XeraUI_" .. title
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local Window = WindowHandler.CreateWindow(ScreenGui, title)

    local Sidebar = SidebarHandler.CreateSidebar(Window)
    local Pages, PageController = PageHandler.CreatePages(Window)

    local Tabs = {}

    function Tabs:AddTab(name)
        local Page = PageHandler.CreatePage(name, Pages)
        local Button = SidebarHandler.CreateTab(name, Sidebar)

        Button.MouseButton1Click:Connect(function()
            PageController:JumpTo(Page)
        end)

        local TabFunctions = {}

        function TabFunctions:AddToggle(text, default, callback)
            Toggle.CreateToggle(text, default, callback, Page)
        end

        function TabFunctions:AddButton(text, callback)
            Button.CreateButton(text, callback, Page)
        end

        function TabFunctions:AddSlider(text, min, max, default, callback)
            Slider.CreateSlider(text, min, max, default, callback, Page)
        end

        function TabFunctions:AddLabel(text)
            Label.CreateLabel(text, Page)
        end

        return TabFunctions
    end

    ProfileLoader.LoadProfile(userId or game.Players.LocalPlayer.UserId, Sidebar)

    return Tabs
end

return XeraUI
