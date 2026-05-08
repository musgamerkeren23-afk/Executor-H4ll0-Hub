if not game:IsLoaded() then game.Loaded:Wait() end

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- 🎨 COLOR THEME
local DARK = Color3.fromRGB(25, 0, 0)        -- background
local RED = Color3.fromRGB(120, 0, 0)        -- button
local NEON = Color3.fromRGB(255, 0, 0)       -- outline neon
local WHITE = Color3.fromRGB(255, 255, 255)  -- text

--------------------------------------------------
-- 🔑 KEY SYSTEM
--------------------------------------------------
local VALID_KEY = "H4LL0_3X3CUT0R_B4S1C"

--------------------------------------------------
-- 📱 GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

--------------------------------------------------
-- 🔐 LOGIN FRAME
--------------------------------------------------
local login = Instance.new("Frame", gui)
login.Size = UDim2.new(0,300,0,180)
login.Position = UDim2.new(0.35,0,0.35,0)
login.BackgroundColor3 = Color3.fromRGB(20,20,20)

local title = Instance.new("TextLabel", login)
title.Size = UDim2.new(1,0,0,40)
title.Text = "🔑ENTER KEY🔒"
title.TextScaled = true
title.TextColor3 = RED
title.BackgroundTransparency = 1

local box = Instance.new("TextBox", login)
box.Size = UDim2.new(0.8,0,0,40)
box.Position = UDim2.new(0.1,0,0.35,0)
box.PlaceholderText = "Input Key..."

local btn = Instance.new("TextButton", login)
btn.Size = UDim2.new(0.8,0,0,40)
btn.Position = UDim2.new(0.1,0,0.65,0)
btn.Text = "VERIFY"

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0,200,0,40)
button.BackgroundColor3 = RED
button.TextColor3 = WHITE

-- 🔴 OUTLINE BUTTON
local stroke2 = Instance.new("UIStroke")
stroke2.Parent = button
stroke2.Color = NEON
stroke2.Thickness = 2

local status = Instance.new("TextLabel", login)
status.Size = UDim2.new(1,0,0,25)
status.Position = UDim2.new(0,0,0.85,0)
status.BackgroundTransparency = 1

--------------------------------------------------
-- 🧠 MAIN LOADER (HIDDEN AWAL)
--------------------------------------------------
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,350,0,230)
frame.Position = UDim2.new(0.35,0,0.35,0)
frame.BackgroundColor3 = DARK
frame.Visible = false
frame.Active = true

-- 🔴 INI OUTLINE NYA
local stroke = Instance.new("UIStroke")
stroke.Parent = frame
stroke.Color = NEON
stroke.Thickness = 2

-- MINI BUTTON
local miniBtn = Instance.new("TextButton", gui)
miniBtn.Size = UDim2.new(0,50,0,50)
miniBtn.Position = UDim2.new(0.05,0,0.4,0)
miniBtn.Text = "💀"
miniBtn.Visible = false

--------------------------------------------------
-- 🔹 TOP
--------------------------------------------------
local top = Instance.new("TextLabel", frame)
top.Size = UDim2.new(1,0,0,35)
top.Text = "3X3CUT0R H4LL0💀"
top.TextScaled = true
top.BackgroundTransparency = 1

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.Text = "❌"

--------------------------------------------------
-- 📄 PAGES
--------------------------------------------------
local mainPage = Instance.new("Frame", frame)
mainPage.Size = UDim2.new(1,0,1,-65)
mainPage.Position = UDim2.new(0,0,0,65)

local settingsPage = mainPage:Clone()
settingsPage.Parent = frame
settingsPage.Visible = false

--------------------------------------------------
-- 🔘 TAB
--------------------------------------------------
local mainTab = Instance.new("TextButton", frame)
mainTab.Size = UDim2.new(0.5,0,0,30)
mainTab.Position = UDim2.new(0,0,0,35)
mainTab.Text = "Main"

local setTab = Instance.new("TextButton", frame)
setTab.Size = UDim2.new(0.5,0,0,30)
setTab.Position = UDim2.new(0.5,0,0,35)
setTab.Text = "Settings"

--------------------------------------------------
-- 🏠 MAIN PAGE
--------------------------------------------------
local urlBox = Instance.new("TextBox", mainPage)
urlBox.Size = UDim2.new(0.9,0,0,40)
urlBox.Position = UDim2.new(0.05,0,0.2,0)
urlBox.PlaceholderText = "🔗RAW URL..."

local runBtn = Instance.new("TextButton", mainPage)
runBtn.Size = UDim2.new(0.9,0,0,40)
runBtn.Position = UDim2.new(0.05,0,0.55,0)
runBtn.Text = "📥Execute"

local runStatus = Instance.new("TextLabel", mainPage)
runStatus.Size = UDim2.new(1,0,0,25)
runStatus.Position = UDim2.new(0,0,0.8,0)
runStatus.BackgroundTransparency = 1

--------------------------------------------------
-- ⚙️ SETTINGS
--------------------------------------------------
local info = Instance.new("TextLabel", settingsPage)
info.Size = UDim2.new(1,0,1,0)
info.Text = "Settings Page"
info.TextScaled = true
info.BackgroundTransparency = 1

--------------------------------------------------
-- 🔄 TAB SWITCH
--------------------------------------------------
mainTab.MouseButton1Click:Connect(function()
    mainPage.Visible = true
    settingsPage.Visible = false
end)

setTab.MouseButton1Click:Connect(function()
    mainPage.Visible = false
    settingsPage.Visible = true
end)

--------------------------------------------------
-- ▶️ RUN SCRIPT
--------------------------------------------------
runBtn.MouseButton1Click:Connect(function()
    local url = urlBox.Text

    local ok, result = pcall(function()
        return game:HttpGet(url)
    end)

    if not ok then
        runStatus.Text = "Fetch Error"
        return
    end

    local ok2 = pcall(function()
        loadstring(result)()
    end)

    runStatus.Text = ok2 and "Success ✔" or "Error"
end)

--------------------------------------------------
-- 🔐 VERIFY
--------------------------------------------------
btn.MouseButton1Click:Connect(function()
    if box.Text == VALID_KEY then
        status.Text = "Access Granted✅"
        task.wait(1)

        login.Visible = false
        frame.Visible = true
    else
        status.Text = "Invalid Key❌"
    end
end)

--------------------------------------------------
-- ❌ MINIMIZE
--------------------------------------------------
closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    miniBtn.Visible = true
end)

miniBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    miniBtn.Visible = false
end)

--------------------------------------------------
-- 🖱️ DRAG
--------------------------------------------------
local function drag(obj)
    local dragging = false
    local dragStart, startPos

    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch 
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
        end
    end)

    obj.InputChanged:Connect(function(input)
        if dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    obj.InputEnded:Connect(function()
        dragging = false
    end)
end

drag(login)
drag(frame)
drag(miniBtn)
