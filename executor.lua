if not game:IsLoaded() then game.Loaded:Wait() end

local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

--------------------------------------------------
-- 🎨 THEME
--------------------------------------------------
local DARK = Color3.fromRGB(25,0,0)
local RED = Color3.fromRGB(255,0,0)
local NEON = Color3.fromRGB(255,0,0)

--------------------------------------------------
-- 🔑 KEY SYSTEM
--------------------------------------------------
local KEYS = {
    ["H4LL0_3X3CUT0R_B4S1C"] = {vip=false,created=os.time()},
    ["VIP_FULL_ACCESS"] = {vip=true,created=os.time()}
}

local function isValid(key)
    local d = KEYS[key]
    if not d then return false end
    if d.vip then return true end
    return (os.time()-d.created <= 86400)
end

--------------------------------------------------
-- 💾 SAVE SYSTEM
--------------------------------------------------
local FILE = "saved_scripts.json"
local saved = {}

if isfile and isfile(FILE) then
    saved = HttpService:JSONDecode(readfile(FILE))
end

local function saveData()
    writefile(FILE, HttpService:JSONEncode(saved))
end

local function runScript(code)
    pcall(function() loadstring(code)() end)
end

--------------------------------------------------
-- 📱 GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

--------------------------------------------------
-- 🔐 LOGIN
--------------------------------------------------
local login = Instance.new("Frame", gui)
login.Size = UDim2.new(0,300,0,180)
login.Position = UDim2.new(0.35,0,0.35,0)
login.BackgroundColor3 = DARK
Instance.new("UIStroke", login).Color = NEON

local titleLogin = Instance.new("TextLabel", login)
titleLogin.Size = UDim2.new(1,0,0,40)
titleLogin.Text = "EXECUTOR H3LL0💀"
titleLogin.TextColor3 = RED
titleLogin.BackgroundTransparency = 1
titleLogin.TextScaled = true

local box = Instance.new("TextBox", login)
box.Size = UDim2.new(0.8,0,0,40)
box.Position = UDim2.new(0.1,0,0.3,0)
box.PlaceholderText = "Enter Key..."
box.BackgroundColor3 = DARK
box.TextColor3 = RED

local btn = Instance.new("TextButton", login)
btn.Size = UDim2.new(0.8,0,0,40)
btn.Position = UDim2.new(0.1,0,0.6,0)
btn.Text = "VERIFY"
btn.BackgroundColor3 = DARK
btn.TextColor3 = RED

local status = Instance.new("TextLabel", login)
status.Size = UDim2.new(1,0,0,30)
status.Position = UDim2.new(0,0,0.8,0)
status.BackgroundTransparency = 1
status.TextColor3 = RED

--------------------------------------------------
-- 🧠 MAIN FRAME
--------------------------------------------------
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,380,0,260)
frame.Position = UDim2.new(0.35,0,0.35,0)
frame.BackgroundColor3 = DARK
frame.Visible = false
frame.Active = true
Instance.new("UIStroke", frame).Color = NEON

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "EXECUTOR H3LL0💀"
title.TextColor3 = RED
title.BackgroundTransparency = 1
title.TextScaled = true

--------------------------------------------------
-- ❌ MINIMIZE
--------------------------------------------------
local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.new(0,50,0,50)
mini.Position = UDim2.new(0.05,0,0.4,0)
mini.Text = "≡"
mini.Visible = false
mini.BackgroundColor3 = DARK
mini.TextColor3 = RED
Instance.new("UIStroke", mini).Color = NEON

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,0)
close.Text = "X"
close.BackgroundColor3 = DARK
close.TextColor3 = RED

--------------------------------------------------
-- 📄 PAGES
--------------------------------------------------
local mainPage = Instance.new("Frame", frame)
mainPage.Size = UDim2.new(1,0,1,-65)
mainPage.Position = UDim2.new(0,0,0,65)

local savedPage = Instance.new("ScrollingFrame", frame)
savedPage.Size = mainPage.Size
savedPage.Position = mainPage.Position
savedPage.Visible = false
savedPage.ScrollBarThickness = 5
savedPage.BackgroundTransparency = 1

local settingsPage = Instance.new("Frame", frame)
settingsPage.Size = mainPage.Size
settingsPage.Position = mainPage.Position
settingsPage.Visible = false
settingsPage.BackgroundColor3 = DARK

--------------------------------------------------
-- 🔘 TABS
--------------------------------------------------
local pages = {mainPage,savedPage,settingsPage}
local names = {"Main","Saved","Settings"}

for i,v in ipairs(names) do
    local tab = Instance.new("TextButton", frame)
    tab.Size = UDim2.new(1/3,0,0,30)
    tab.Position = UDim2.new((i-1)/3,0,0,35)
    tab.Text = v
    tab.BackgroundColor3 = DARK
    tab.TextColor3 = RED

    tab.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible=false end
        pages[i].Visible=true
    end)
end

--------------------------------------------------
-- 🏠 MAIN
--------------------------------------------------
local url = Instance.new("TextBox", mainPage)
url.Size = UDim2.new(0.9,0,0,40)
url.Position = UDim2.new(0.05,0,0.2,0)
url.PlaceholderText = "RAW URL..."
url.BackgroundColor3 = DARK
url.TextColor3 = RED

local run = Instance.new("TextButton", mainPage)
run.Size = UDim2.new(0.9,0,0,40)
run.Position = UDim2.new(0.05,0,0.55,0)
run.Text = "RUN"
run.BackgroundColor3 = DARK
run.TextColor3 = RED

run.MouseButton1Click:Connect(function()
    local ok,res = pcall(function() return game:HttpGet(url.Text) end)
    if ok then runScript(res) end
end)

--------------------------------------------------
-- 📜 SAVED
--------------------------------------------------
local function refresh()
    for _,v in pairs(savedPage:GetChildren()) do
        if v.Name == "Item" then v:Destroy() end
    end

    for i,v in ipairs(saved) do
        local y = 50 + (i-1)*50 -- FIX posisi

        local name = Instance.new("TextButton", savedPage)
        name.Name = "Item"
        name.Size = UDim2.new(0.4,0,0,40)
        name.Position = UDim2.new(0.02,0,0,y)
        name.Text = v.name
        name.TextColor3 = RED
        name.BackgroundColor3 = DARK

        local exec = Instance.new("TextButton", savedPage)
        exec.Name = "Item"
        exec.Size = UDim2.new(0.18,0,0,40)
        exec.Position = UDim2.new(0.45,0,0,y)
        exec.Text = "▶"
        exec.TextColor3 = RED
        exec.BackgroundColor3 = DARK

        local edit = Instance.new("TextButton", savedPage)
        edit.Name = "Item"
        edit.Size = UDim2.new(0.18,0,0,40)
        edit.Position = UDim2.new(0.64,0,0,y)
        edit.Text = "✏️"
        edit.TextColor3 = RED
        edit.BackgroundColor3 = DARK

        local del = Instance.new("TextButton", savedPage)
        del.Name = "Item"
        del.Size = UDim2.new(0.18,0,0,40)
        del.Position = UDim2.new(0.83,0,0,y)
        del.Text = "X"
        del.TextColor3 = RED
        del.BackgroundColor3 = DARK

        exec.MouseButton1Click:Connect(function()
            runScript(v.code)
        end)

        edit.MouseButton1Click:Connect(function()
            popup.Visible = true
            nameBox.Text = v.name
            scriptBox.Text = v.code
            editing = i
        end)

        del.MouseButton1Click:Connect(function()
            table.remove(saved,i)
            saveData()
            refresh()
        end)
    end

    savedPage.CanvasSize = UDim2.new(0,0,0,#saved*50 + 60)
end

--------------------------------------------------
-- ➕ ADD BUTTON (FIX)
--------------------------------------------------
local add = Instance.new("TextButton", savedPage)
add.Size = UDim2.new(0,40,0,40)
add.Position = UDim2.new(0,5,0,5) -- FIX posisi
add.Text = "+"
add.ZIndex = 10
add.TextColor3 = RED
add.BackgroundColor3 = DARK

--------------------------------------------------
-- 📥 POPUP
--------------------------------------------------
local popup = Instance.new("Frame", gui)
popup.Size = UDim2.new(0,300,0,220)
popup.Position = UDim2.new(0.35,0,0.35,0)
popup.Visible = false
popup.BackgroundColor3 = DARK

local nameBox = Instance.new("TextBox", popup)
nameBox.Size = UDim2.new(0.9,0,0,40)
nameBox.Position = UDim2.new(0.05,0,0.15,0)
nameBox.PlaceholderText = "Name"
nameBox.TextColor3 = RED
nameBox.BackgroundColor3 = DARK

local scriptBox = Instance.new("TextBox", popup)
scriptBox.Size = UDim2.new(0.9,0,0,60)
scriptBox.Position = UDim2.new(0.05,0,0.4,0)
scriptBox.PlaceholderText = "Script"
scriptBox.MultiLine = true
scriptBox.TextColor3 = RED
scriptBox.BackgroundColor3 = DARK

local saveBtn = Instance.new("TextButton", popup)
saveBtn.Size = UDim2.new(0.9,0,0,40)
saveBtn.Position = UDim2.new(0.05,0,0.75,0)
saveBtn.Text = "SAVE"
saveBtn.TextColor3 = RED
saveBtn.BackgroundColor3 = DARK

local editing = nil

add.MouseButton1Click:Connect(function()
    popup.Visible = true
    editing = nil
end)

saveBtn.MouseButton1Click:Connect(function()
    if editing then
        saved[editing] = {name=nameBox.Text,code=scriptBox.Text}
    else
        table.insert(saved,{name=nameBox.Text,code=scriptBox.Text})
    end
    saveData()
    popup.Visible = false
    refresh()
end)

--------------------------------------------------
-- ⚙️ SETTINGS
--------------------------------------------------
local info = Instance.new("TextLabel", settingsPage)
info.Size = UDim2.new(1,0,1,0)
info.Text = "EXECUTOR H3LL0💀\nSettings Page"
info.TextColor3 = RED
info.BackgroundTransparency = 1

--------------------------------------------------
-- 🔐 VERIFY
--------------------------------------------------
btn.MouseButton1Click:Connect(function()
    if isValid(box.Text) then
        login.Visible = false
        frame.Visible = true
        refresh()
    else
        status.Text = "Invalid / Expired"
    end
end)

--------------------------------------------------
-- ❌ MINIMIZE
--------------------------------------------------
close.MouseButton1Click:Connect(function()
    frame.Visible = false
    mini.Visible = true
end)

mini.MouseButton1Click:Connect(function()
    frame.Visible = true
    mini.Visible = false
end)

--------------------------------------------------
-- 🖱️ DRAG FIX (HP + PC)
--------------------------------------------------
local function drag(obj)
    local dragging=false
    local dragStart,startPos

    obj.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=true
            dragStart=input.Position
            startPos=obj.Position
        end
    end)

    obj.InputChanged:Connect(function(input)
        if dragging then
            local delta=input.Position-dragStart
            obj.Position=UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset+delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset+delta.Y
            )
        end
    end)

    obj.InputEnded:Connect(function()
        dragging=false
    end)
end

drag(frame)
drag(login)
drag(mini)
