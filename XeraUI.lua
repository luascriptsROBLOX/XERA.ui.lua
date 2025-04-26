--// XeraUI Library
local XeraUI = {}
XeraUI.Theme = {
    Background = Color3.fromRGB(25,25,25),
    Accent = Color3.fromRGB(0, 170, 255),
    TextColor = Color3.fromRGB(255,255,255),
    BorderColor = Color3.fromRGB(45,45,45)
}
XeraUI.Font = Enum.Font.GothamBold

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

--// Utilities
function XeraUI:Tween(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

function XeraUI:Create(class, props)
    local obj = Instance.new(class)
    for i,v in pairs(props) do
        obj[i] = v
    end
    return obj
end

--// Loading Screen
function XeraUI:CreateLoadingScreen(text)
    local loading = self:Create("ScreenGui", {Name = "XeraUILoading", Parent = game.CoreGui})
    local frame = self:Create("Frame", {
        Size = UDim2.new(0,300,0,100),
        Position = UDim2.new(0.5,-150,0.5,-50),
        BackgroundColor3 = self.Theme.Background,
        BorderColor3 = self.Theme.BorderColor,
        Parent = loading
    })
    self:Create("UICorner", {CornerRadius = UDim.new(0,8), Parent = frame})
    local title = self:Create("TextLabel", {
        Size = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        Text = text or "Loading Xera UI...",
        Font = self.Font,
        TextColor3 = self.Theme.TextColor,
        TextSize = 22,
        Parent = frame
    })
    wait(2)
    loading:Destroy()
end

--// Main Window
function XeraUI:CreateWindow(title)
    local gui = self:Create("ScreenGui", {Name = "XeraUI", Parent = game.CoreGui})
    local main = self:Create("Frame", {
        Size = UDim2.new(0, 550, 0, 400),
        Position = UDim2.new(0.5, -275, 0.5, -200),
        BackgroundColor3 = self.Theme.Background,
        BorderColor3 = self.Theme.BorderColor,
        Parent = gui
    })
    self:Create("UICorner", {CornerRadius = UDim.new(0,8), Parent = main})

    local topBar = self:Create("TextLabel", {
        Size = UDim2.new(1,0,0,40),
        BackgroundTransparency = 1,
        Text = title or "Xera UI",
        Font = self.Font,
        TextColor3 = self.Theme.TextColor,
        TextSize = 24,
        Parent = main
    })

    local tabHolder = self:Create("Frame", {
        Size = UDim2.new(0,140,1,-40),
        Position = UDim2.new(0,0,0,40),
        BackgroundColor3 = self.Theme.Background,
        BorderColor3 = self.Theme.BorderColor,
        Parent = main
    })

    local pageHolder = self:Create("Frame", {
        Size = UDim2.new(1,-140,1,-40),
        Position = UDim2.new(0,140,0,40),
        BackgroundTransparency = 1,
        Parent = main
    })

    local TabList = {}

    function TabList:CreateTab(tabName)
        local btn = XeraUI:Create("TextButton", {
            Size = UDim2.new(1,0,0,40),
            BackgroundTransparency = 1,
            Text = tabName,
            Font = XeraUI.Font,
            TextColor3 = XeraUI.Theme.TextColor,
            TextSize = 20,
            Parent = tabHolder
        })
        local page = XeraUI:Create("ScrollingFrame", {
            Size = UDim2.new(1,0,1,0),
            CanvasSize = UDim2.new(0,0,5,0),
            ScrollBarThickness = 3,
            BackgroundTransparency = 1,
            Visible = false,
            Parent = pageHolder
        })

        btn.MouseButton1Click:Connect(function()
            for _,v in pairs(pageHolder:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            page.Visible = true
        end)

        local Components = {}

        function Components:CreateButton(name, callback)
            local b = XeraUI:Create("TextButton", {
                Size = UDim2.new(1,-10,0,40),
                Position = UDim2.new(0,5,0,0),
                BackgroundColor3 = XeraUI.Theme.Background,
                BorderColor3 = XeraUI.Theme.BorderColor,
                Text = name,
                Font = XeraUI.Font,
                TextColor3 = XeraUI.Theme.TextColor,
                TextSize = 20,
                Parent = page
            })
            XeraUI:Create("UICorner", {CornerRadius = UDim.new(0,4), Parent = b})
            b.MouseButton1Click:Connect(callback)
        end

        function Components:CreateToggle(name, callback)
            local frame = XeraUI:Create("Frame", {
                Size = UDim2.new(1,-10,0,40),
                Position = UDim2.new(0,5,0,0),
                BackgroundColor3 = XeraUI.Theme.Background,
                BorderColor3 = XeraUI.Theme.BorderColor,
                Parent = page
            })
            XeraUI:Create("UICorner", {CornerRadius = UDim.new(0,4), Parent = frame})

            local label = XeraUI:Create("TextLabel", {
                Size = UDim2.new(0.8,0,1,0),
                BackgroundTransparency = 1,
                Text = name,
                Font = XeraUI.Font,
                TextColor3 = XeraUI.Theme.TextColor,
                TextSize = 18,
                Parent = frame
            })

            local toggle = XeraUI:Create("TextButton", {
                Size = UDim2.new(0.2,0,1,0),
                Position = UDim2.new(0.8,0,0,0),
                BackgroundColor3 = XeraUI.Theme.Accent,
                Text = "Off",
                Font = XeraUI.Font,
                TextColor3 = Color3.fromRGB(255,255,255),
                TextSize = 18,
                Parent = frame
            })

            local state = false
            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.Text = state and "On" or "Off"
                callback(state)
            end)
        end

        -- (Continued with Sliders, Dropdowns, Labels, Keybinds, etc...)

        return Components
    end

    return TabList
end

--// Destroy Function
function XeraUI:DestroyUI()
    for _,v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "XeraUI" or v.Name == "XeraUILoading" or v.Name == "XeraUILogger" then
            v:Destroy()
        end
    end
end

return XeraUI
