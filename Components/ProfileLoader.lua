-- XeraUI/Components/ProfileLoader.lua
-- Shows user profile pic and name

local ProfileLoader = {}

function ProfileLoader.LoadProfile(userId, parent)
    local ProfileFrame = Instance.new("Frame")
    ProfileFrame.Size = UDim2.new(1, -20, 0, 60)
    ProfileFrame.BackgroundTransparency = 1
    ProfileFrame.Parent = parent

    local Image = Instance.new("ImageLabel")
    Image.Size = UDim2.new(0, 40, 0, 40)
    Image.Position = UDim2.new(0, 0, 0.5, -20)
    Image.BackgroundTransparency = 1
    Image.Image = "rbxthumb://type=AvatarHeadShot&id="..tostring(userId).."&w=420&h=420"
    Image.Parent = ProfileFrame

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -50, 0, 20)
    NameLabel.Position = UDim2.new(0, 50, 0.5, -10)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 14
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.Text = "Loading..."
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = ProfileFrame

    -- Update Username
    spawn(function()
        local success, name = pcall(function()
            return game.Players:GetNameFromUserIdAsync(userId)
        end)
        if success then
            NameLabel.Text = name
        else
            NameLabel.Text = "Unknown"
        end
    end)

    return ProfileFrame
end

return ProfileLoader
