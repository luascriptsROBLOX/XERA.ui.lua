--// XeraUI Library v1.0 | Custom UI Framework
local XeraUI = {}
XeraUI.__index = XeraUI

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Theme
XeraUI.Theme = {
    Background = Color3.fromRGB(25, 25, 25),
    Secondary = Color3.fromRGB(35, 35, 35),
    Accent = Color3.fromRGB(0, 170, 255),
    Text = Color3.fromRGB(230, 230, 230),
    ToggleOff = Color3.fromRGB(70, 70, 70),
    ToggleOn = Color3.fromRGB(0, 170, 255),
    Slider = Color3.fromRGB(0, 170, 255),
    Border = Color3.fromRGB(45, 45, 45)
}
XeraUI.Font = Enum.Font.Gotham

-- Utility Functions
local function Tween(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    return obj
end

local function MakeDraggable(frame)
    local dragging, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- Loading Screen
function XeraUI:CreateLoadingScreen(text)
    local loadingGui = Create("ScreenGui", {Name = "XeraUILoading", Parent = CoreGui, ResetOnSpawn = false})
    local frame = Create("Frame", {
        Size = UDim2.new(0, 400, 0, 150),
        Position = UDim2.new(0.5, -200, 0.5, -75),
        BackgroundColor3 = self.Theme.Background,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Parent = loadingGui
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = frame})

    local spinner = Create("ImageLabel", {
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(0.5, -25, 0.3, 0),
        BackgroundTransparency = 1,
        Image = "rbxassetid://1234567890", -- Replace with spinning circle asset
        Parent = frame
    })

    local title = Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0.6, 0),
        BackgroundTransparency = 1,
        Text = text or "Initializing UI... XeraAPI",
        Font = self.Font,
        TextColor3 = self.Theme.Text,
        TextSize = 20,
        TextWrapped = true,
        Parent = frame
    })

    -- Spinner Animation
    task.spawn(function()
        while spinner.Parent do
            spinner.Rotation = spinner.Rotation + 10
            task.wait()
        end
    end)

    -- Fade In
    frame.BackgroundTransparency = 1
    Tween(frame, {BackgroundTransparency = 0.1}, 0.5)

    task.wait(3) -- Simulate loading
    Tween(frame, {BackgroundTransparency = 1}, 0.5)
    task.wait(0.5)
    loadingGui:Destroy()
end

-- Main Window
function XeraUI:CreateWindow(title)
    self:CreateLoadingScreen("Initializing UI... XeraAPI")

    local screenGui = Create("ScreenGui", {Name = "XeraUI", Parent = CoreGui, ResetOnSpawn = false})
    local main = Create("Frame", {
        Size = UDim2.new(0, 600, 0, 450),
        Position = UDim2.new(0.5, -300, 0.5, -225),
        BackgroundColor3 = self.Theme.Background,
        BorderSizePixel = 0,
        Parent = screenGui
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = main})
    MakeDraggable(main)

    local titleBar = Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Text = title or "XeraUI",
        Font = self.Font,
        TextColor3 = self.Theme.Text,
        TextSize = 20,
        Parent = main
    })

    local tabHolder = Create("Frame", {
        Size = UDim2.new(0, 150, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Parent = main
    })

    local pageHolder = Create("Frame", {
        Size = UDim2.new(1, -150, 1, -40),
        Position = UDim2.new(0, 150, 0, 40),
        BackgroundTransparency = 1,
        Parent = main
    })

    local tabs = {}
    local tabList = {}

    function tabList:CreateTab(tabName)
        local tabButton = Create("TextButton", {
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundColor3 = self.Theme.Secondary,
            BorderSizePixel = 0,
            Text = tabName,
            Font = self.Font,
            TextSize = 16,
            TextColor3 = self.Theme.Text,
            AutoButtonColor = false,
            Parent = tabHolder
        })

        local page = Create("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 2, 0),
            ScrollBarThickness = 4,
            BackgroundTransparency = 1,
            Visible = false,
            Parent = pageHolder
        })

        tabs[#tabs + 1] = {Button = tabButton, Page = page}

        tabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(tabs) do
                v.Page.Visible = false
                Tween(v.Button, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
            end
            page.Visible = true
            Tween(tabButton, {BackgroundColor3 = self.Theme.Accent}, 0.2)
        end)

        if #tabs == 1 then
            page.Visible = true
            tabButton.BackgroundColor3 = self.Theme.Accent
        end

        local components = {}
        local lastY = 10

        function components:CreateSection(title)
            local section = Create("TextLabel", {
                Size = UDim2.new(1, -10, 0, 30),
                Position = UDim2.new(0, 5, 0, lastY),
                BackgroundTransparency = 1,
                Text = title,
                Font = self.Font,
                TextSize = 18,
                TextColor3 = self.Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = page
            })
            lastY = lastY + 40
            return section
        end

        function components:CreateButton(name, callback)
            local button = Create("TextButton", {
                Size = UDim2.new(1, -10, 0, 40),
                Position = UDim2.new(0, 5, 0, lastY),
                BackgroundColor3 = self.Theme.Accent,
                BorderSizePixel = 0,
                Text = name,
                Font = self.Font,
                TextSize = 16,
                TextColor3 = self.Theme.Text,
                AutoButtonColor = false,
                Parent = page
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = button})

            button.MouseButton1Click:Connect(function()
                if callback then
                    callback()
                end
                Tween(button, {BackgroundColor3 = self.Theme.Secondary}, 0.1)
                task.wait(0.1)
                Tween(button, {BackgroundColor3 = self.Theme.Accent}, 0.1)
            end)

            lastY = lastY + 50
            page.CanvasSize = UDim2.new(0, 0, 0, lastY + 10)
        end

        function components:CreateToggle(name, default, callback)
            local toggleFrame = Create("Frame", {
                Size = UDim2.new(1, -10, 0, 40),
                Position = UDim2.new(0, 5, 0, lastY),
                BackgroundTransparency = 1,
                Parent = page
            })

            local label = Create("TextLabel", {
                Size = UDim2.new(0.7, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = name,
                Font = self.Font,
                TextSize = 16,
                TextColor3 = self.Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = toggleFrame
            })

            local toggleButton = Create("Frame", {
                Size = UDim2.new(0, 50, 0, 25),
                Position = UDim2.new(0.85, 0, 0.5, -12.5),
                BackgroundColor3 = default and self.Theme.ToggleOn or self.Theme.ToggleOff,
                Parent = toggleFrame
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = toggleButton})

            local knob = Create("Frame", {
                Size = UDim2.new(0, 20, 0, 20),
                Position = default and UDim2.new(0.6, 0, 0.5, -10) or UDim2.new(0, 0, 0.5, -10),
                BackgroundColor3 = self.Theme.Text,
                Parent = toggleButton
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = knob})

            local toggled = default

            toggleButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    toggled = not toggled
                    Tween(knob, {Position = toggled and UDim2.new(0.6, 0, 0.5, -10) or UDim2.new(0, 0, 0.5, -10)}, 0.2)
                    Tween(toggleButton, {BackgroundColor3 = toggled and self.Theme.ToggleOn or self.Theme.ToggleOff}, 0.2)
                    if callback then
                        callback(toggled)
                    end
                end
            end)

            lastY = lastY + 50
            page.CanvasSize = UDim2.new(0, 0, 0, lastY + 10)
        end

        function components:CreateSlider(name, min, max, default, callback)
            local sliderFrame = Create("Frame", {
                Size = UDim2.new(1, -10, 0, 60),
                Position = UDim2.new(0, 5, 0, lastY),
                BackgroundTransparency = 1,
                Parent = page
            })

            local label = Create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = name .. ": " .. default,
                Font = self.Font,
                TextSize = 16,
                TextColor3 = self.Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = sliderFrame
            })

            local bar = Create("Frame", {
                Size = UDim2.new(1, -20, 0, 8),
                Position = UDim2.new(0, 10, 0, 30),
                BackgroundColor3 = self.Theme.Secondary,
                Parent = sliderFrame
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = bar})

            local fill = Create("Frame", {
                Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = self.Theme.Slider,
                Parent = bar
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = fill})

            local dragging = false
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local percent = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    fill.Size = UDim2.new(percent, 0, 1, 0)
                    local value = math.floor(min + (max - min) * percent)
                    label.Text = name .. ": " .. value
                    if callback then
                        callback(value)
                    end
                end
            end)

            lastY = lastY + 70
            page.CanvasSize = UDim2.new(0, 0, 0, lastY + 10)
        end

        function components:CreateDropdown(name, options, default, callback)
            local dropdownFrame = Create("Frame", {
                Size = UDim2.new(1, -10, 0, 40),
                Position = UDim2.new(0, 5, 0, lastY),
                BackgroundColor3 = self.Theme.Secondary,
                Parent = page
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = dropdownFrame})

            local label = Create("TextLabel", {
                Size = UDim2.new(1, -50, 1, 0),
                BackgroundTransparency = 1,
                Text = name .. ": " .. (default or options[1]),
                Font = self.Font,
                TextSize = 16,
                TextColor3 = self.Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = dropdownFrame
            })

            local arrow = Create("TextLabel", {
                Size = UDim2.new(0, 40, 1, 0),
                Position = UDim2.new(1, -40, 0, 0),
                BackgroundTransparency = 1,
                Text = "▼",
                Font = self.Font,
                TextSize = 16,
                TextColor3 = self.Theme.Text,
                Parent = dropdownFrame
            })

            local optionsFrame = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = self.Theme.Secondary,
                BorderSizePixel = 0,
                Visible = false,
                Parent = dropdownFrame
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = optionsFrame})

            local selected = default or options[1]
            for i, option in ipairs(options) do
                local optButton = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 30),
                    Position = UDim2.new(0, 0, 0, (i-1)*30),
                    BackgroundTransparency = 1,
                    Text = option,
                    Font = self.Font,
                    TextSize = 14,
                    TextColor3 = self.Theme.Text,
                    AutoButtonColor = false,
                    Parent = optionsFrame
                })
                optButton.MouseButton1Click:Connect(function()
                    selected = option
                    label.Text = name .. ": " .. option
                    optionsFrame.Visible = false
                    Tween(optionsFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
                    if callback then
                        callback(option)
                    end
                end)
            end

            dropdownFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    optionsFrame.Visible = not optionsFrame.Visible
                    Tween(optionsFrame, {Size = optionsFrame.Visible and UDim2.new(1, 0, 0, #options * 30) or UDim2.new(1, 0, 0, 0)}, 0.2)
                end
            end)

            lastY = lastY + 50
            page.CanvasSize = UDim2.new(0, 0, 0, lastY + 10)
        end

        function components:CreateKeybind(name, default, callback)
            local keybindFrame = Create("Frame", {
                Size = UDim2.new(1, -10, 0, 40),
                Position = UDim2.new(0, 5, 0, lastY),
                BackgroundTransparency = 1,
                Parent = page
            })

            local label = Create("TextLabel", {
                Size = UDim2.new(0.7, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = name .. ": " .. (default and default.Name or "None"),
                Font = self.Font,
                TextSize = 16,
                TextColor3 = self.Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = keybindFrame
            })

            local keyButton = Create("TextButton", {
                Size = UDim2.new(0.3, 0, 1, 0),
                Position = UDim2.new(0.7, 0, 0, 0),
                BackgroundColor3 = self.Theme.Secondary,
                Text = "Set",
                Font = self.Font,
                TextSize = 14,
                TextColor3 = self.Theme.Text,
                AutoButtonColor = false,
                Parent = keybindFrame
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = keyButton})

            local currentKey = default
            local selecting = false

            keyButton.MouseButton1Click:Connect(function()
                selecting = true
                keyButton.Text = "..."
            end)

            UserInputService.InputBegan:Connect(function(input)
                if selecting and input.UserInputType == Enum.UserInputType.Keyboard then
                    currentKey = input.KeyCode
                    keyButton.Text = "Set"
                    label.Text = name .. ": " .. currentKey.Name
                    selecting = false
                    if callback then
                        callback(currentKey)
                    end
                end
            end)

            lastY = lastY + 50
            page.CanvasSize = UDim2.new(0, 0, 0, lastY + 10)
        end

        function components:CreateLabel(text)
            local label = Create("TextLabel", {
                Size = UDim2.new(1, -10, 0, 30),
                Position = UDim2.new(0, 5, 0, lastY),
                BackgroundTransparency = 1,
                Text = text,
                Font = self.Font,
                TextSize = 16,
                TextColor3 = self.Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = page
            })

            lastY = lastY + 40
            page.CanvasSize = UDim2.new(0, 0, 0, lastY + 10)
        end

        function components:CreateParagraph(title, content)
            local paraFrame = Create("Frame", {
                Size = UDim2.new(1, -10, 0, 80),
                Position = UDim2.new(0, 5, 0, lastY),
                BackgroundTransparency = 1,
                Parent = page
            })

            local titleLabel = Create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = title,
                Font = self.Font,
                TextSize = 16,
                TextColor3 = self.Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = paraFrame
            })

            local contentLabel = Create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 60),
                Position = UDim2.new(0, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = content,
                Font = self.Font,
                TextSize = 14,
                TextColor3 = self.Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Parent = paraFrame
            })

            lastY = lastY + 90
            page.CanvasSize = UDim2.new(0, 0, 0, lastY + 10)
        end

        function components:CreateNotification(title, content, duration)
            local notifGui = Create("ScreenGui", {Name = "XeraUINotification", Parent = CoreGui, ResetOnSpawn = false})
            local notifFrame = Create("Frame", {
                Size = UDim2.new(0, 300, 0, 100),
                Position = UDim2.new(1, -320, 1, -120),
                BackgroundColor3 = self.Theme.Background,
                BorderSizePixel = 0,
                Parent = notifGui
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = notifFrame})

            local titleLabel = Create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundTransparency = 1,
                Text = title,
                Font = self.Font,
                TextSize = 16,
                TextColor3 = self.Theme.Text,
                Parent = notifFrame
            })

            local contentLabel = Create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 70),
                Position = UDim2.new(0, 0, 0, 30),
                BackgroundTransparency = 1,
                Text = content,
                Font = self.Font,
                TextSize = 14,
                TextColor3 = self.Theme.Text,
                TextWrapped = true,
                Parent = notifFrame
            })

            notifFrame.BackgroundTransparency = 1
            Tween(notifFrame, {BackgroundTransparency = 0}, 0.5)
            task.wait(duration or 3)
            Tween(notifFrame, {BackgroundTransparency = 1}, 0.5)
            task.wait(0.5)
            notifGui:Destroy()
        end

        function components:CreateLogger()
            local loggerGui = Create("ScreenGui", {Name = "XeraUILogger", Parent = CoreGui, ResetOnSpawn = false})
            local loggerFrame = Create("Frame", {
                Size = UDim2.new(0, 400, 0, 200),
                Position = UDim2.new(0, 10, 0, 10),
                BackgroundColor3 = self.Theme.Background,
                BackgroundTransparency = 0.2,
                BorderSizePixel = 0,
                Parent = loggerGui
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = loggerFrame})
            MakeDraggable(loggerFrame)

            local logList = Create("ScrollingFrame", {
                Size = UDim2.new(1, -10, 1, -50),
                Position = UDim2.new(0, 5, 0, 5),
                BackgroundTransparency = 1,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarThickness = 4,
                Parent = loggerFrame
            })

            local clearButton = Create("TextButton", {
                Size = UDim2.new(0, 100, 0, 30),
                Position = UDim2.new(0.5, -50, 1, -40),
                BackgroundColor3 = self.Theme.Accent,
                Text = "Clear Logs",
                Font = self.Font,
                TextSize = 14,
                TextColor3 = self.Theme.Text,
                AutoButtonColor = false,
                Parent = loggerFrame
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = clearButton})

            local logs = {}
            local logY = 0

            local function AddLog(type, message)
                local logColor = self.Theme.Text
                if type == "INFO" then logColor = Color3.fromRGB(100, 149, 237)
                elseif type == "SUCCESS" then logColor = Color3.fromRGB(144, 238, 144)
                elseif type == "ERROR" then logColor = Color3.fromRGB(255, 99, 71)
                elseif type == "WARNING" then logColor = Color3.fromRGB(255, 215, 0) end

                local logLabel = Create("TextLabel", {
                    Size = UDim2.new(1, -10, 0, 20),
                    Position = UDim2.new(0, 5, 0, logY),
                    BackgroundTransparency = 1,
                    Text = "[" .. type .. "] " .. message,
                    Font = self.Font,
                    TextSize = 14,
                    TextColor3 = logColor,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = logList
                })

                table.insert(logs, logLabel)
                logY = logY + 25
                logList.CanvasSize = UDim2.new(0, 0, 0, logY)

                if #logs > 20 then
                    logs[1]:Destroy()
                    table.remove(logs, 1)
                    logY = logY - 25
                    for _, v in ipairs(logs) do
                        v.Position = UDim2.new(0, 5, 0, v.Position.Y.Offset - 25)
                    end
                end
            end

            clearButton.MouseButton1Click:Connect(function()
                for _, v in ipairs(logs) do
                    v:Destroy()
                end
                logs = {}
                logY = 0
                logList.CanvasSize = UDim2.new(0, 0, 0, 0)
            end)

            return {AddLog = AddLog}
        end

        return components
    end

    return tabList
end

-- Destroy UI
function XeraUI:DestroyUI()
    for _, v in ipairs(CoreGui:GetChildren()) do
        if v.Name == "XeraUI" or v.Name == "XeraUILoading" or v.Name == "XeraUINotification" or v.Name == "XeraUILogger" then
            v:Destroy()
        end
    end
end

return XeraUI
