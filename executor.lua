if not game:IsLoaded() then game.Loaded:Wait() end

local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

--------------------------------------------------
-- 🎨 THEME
--------------------------------------------------
local DARK = Color3.fromRGB(25,0,0)
local RED = Color3.fromRGB(120,0,0)
local NEON = Color3.fromRGB(255,0,0)
local WHITE = Color3.fromRGB(255,255,255)

--------------------------------------------------
-- 🔑 KEY SYSTEM
--------------------------------------------------
local KEYS = {
    ["H4LL0_3X3CUT0R_B4S1C"] = {vip = false, created = os.time()},
    ["VIP_FULL_ACCESS"] = {vip = true, created = os.time()}
}

local function isValid(key)
    local data = KEYS[key]
    if not data then return false end
    if data.vip then return true end
    return (os.time() - data.created <= 86400)
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

--------------------------------------------------
-- ⚙️ SCRIPT FUNCTIONS
--------------------------------------------------
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

local box = Instance.new("TextBox", login)
box.Size = UDim2.new(0.8,0,0,40)
box.Position = UDim2.new(0.1,0,0.3,0)
box.PlaceholderText = "🔑Enter Key..."
box.BackgroundColor3 = RED
box.TextColor3 = WHITE

local btn = Instance.new("TextButton", login)
btn.Size = UDim2.new(0.8,0,0,40)
btn.Position = UDim2.new(0.1,0,0.6,0)
btn.Text = "🔓VERIFY"
btn.BackgroundColor3 = RED
btn.TextColor3 = WHITE

local status = Instance.new("TextLabel", login)
status.Size = UDim2.new(1,0,0,30)
status.Position = UDim2.new(0,0,0.8,0)
status.BackgroundTransparency = 1
status.TextColor3 = WHITE

--------------------------------------------------
-- 🧠 MAIN
--------------------------------------------------
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,380,0,260)
frame.Position = UDim2.new(0.35,0,0.35,0)
frame.BackgroundColor3 = DARK
frame.Visible = false
frame.Active = true

Instance.new("UIStroke", frame).Color = NEON

--------------------------------------------------
-- ❌ MINIMIZE
--------------------------------------------------
local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.new(0,50,0,50)
mini.Position = UDim2.new(0.05,0,0.4,0)
mini.Text = "💀"
mini.Visible = false
mini.BackgroundColor3 = DARK
mini.TextColor3 = WHITE
Instance.new("UIStroke", mini).Color = NEON

--------------------------------------------------
-- 🔹 TOP
--------------------------------------------------
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "❌"
close.BackgroundColor3 = RED
close.TextColor3 = WHITE

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
savedPage.CanvasSize = UDim2.new(0,0,0,0)

local settingsPage = mainPage:Clone()
settingsPage.Parent = frame
settingsPage.Visible = false

--------------------------------------------------
-- 🔘 TABS
--------------------------------------------------
local tabs = {"Main","Saved","Settings"}
local pages = {mainPage,savedPage,settingsPage}

for i,name in ipairs(tabs) do
    local tab = Instance.new("TextButton", frame)
    tab.Size = UDim2.new(1/3,0,0,30)
    tab.Position = UDim2.new((i-1)/3,0,0,35)
    tab.Text = name
    tab.BackgroundColor3 = RED
    tab.TextColor3 = WHITE

    tab.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible = false end
        pages[i].Visible = true
    end)
end

--------------------------------------------------
-- 🏠 MAIN
--------------------------------------------------
local url = Instance.new("TextBox", mainPage)
url.Size = UDim2.new(0.9,0,0,40)
url.Position = UDim2.new(0.05,0,0.2,0)
url.PlaceholderText = "RAW URL..."
url.BackgroundColor3 = RED
url.TextColor3 = WHITE

local run = Instance.new("TextButton", mainPage)
run.Size = UDim2.new(0.9,0,0,40)
run.Position = UDim2.new(0.05,0,0.55,0)
run.Text = "EXECUTE"
run.BackgroundColor3 = RED
run.TextColor3 = WHITE

run.MouseButton1Click:Connect(function()
    local ok,res = pcall(function() return game:HttpGet(url.Text) end)
    if ok then runScript(res) end
end)

--------------------------------------------------
-- 📜 SAVED SYSTEM
--------------------------------------------------
local function refresh()
    savedPage:ClearAllChildren()

    for i,v in ipairs(saved) do
        local y = (i-1)*50

        local name = Instance.new("TextButton", savedPage)
        name.Size = UDim2.new(0.45,0,0,40)
        name.Position = UDim2.new(0.02,0,0,y)
        name.Text = v.name

        local exec = Instance.new("TextButton", savedPage)
        exec.Size = UDim2.new(0.15,0,0,40)
        exec.Position = UDim2.new(0.5,0,0,y)
        exec.Text = "▶"

        local edit = Instance.new("TextButton", savedPage)
        edit.Size = UDim2.new(0.15,0,0,40)
        edit.Position = UDim2.new(0.67,0,0,y)
        edit.Text = "✏️"

        local del = Instance.new("TextButton", savedPage)
        del.Size = UDim2.new(0.15,0,0,40)
        del.Position = UDim2.new(0.84,0,0,y)
        del.Text = "X"

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

    savedPage.CanvasSize = UDim2.new(0,0,0,#saved*50)
end

--------------------------------------------------
-- ➕ ADD
--------------------------------------------------
local add = Instance.new("TextButton", savedPage)
add.Size = UDim2.new(0,40,0,40)
add.Position = UDim2.new(1,-45,0,5)
add.Text = "+"

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

local scriptBox = Instance.new("TextBox", popup)
scriptBox.Size = UDim2.new(0.9,0,0,60)
scriptBox.Position = UDim2.new(0.05,0,0.4,0)
scriptBox.PlaceholderText = "Script"
scriptBox.MultiLine = true

local saveBtn = Instance.new("TextButton", popup)
saveBtn.Size = UDim2.new(0.9,0,0,40)
saveBtn.Position = UDim2.new(0.05,0,0.75,0)
saveBtn.Text = "SAVE"

local editing = nil

add.MouseButton1Click:Connect(function()
    popup.Visible = true
    editing = nil
end)

saveBtn.MouseButton1Click:Connect(function()
    if editing then
        saved[editing] = {name=nameBox.Text, code=scriptBox.Text}
    else
        table.insert(saved,{name=nameBox.Text, code=scriptBox.Text})
    end
    saveData()
    popup.Visible = false
    refresh()
end)

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
-- 🖱️ DRAG
--------------------------------------------------
local function drag(obj)
    local d=false; local s; local p
    obj.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then
            d=true; s=i.Position; p=obj.Position
        end
    end)
    obj.InputChanged:Connect(function(i)
        if d then
            local delta=i.Position-s
            obj.Position=UDim2.new(p.X.Scale,p.X.Offset+delta.X,p.Y.Scale,p.Y.Offset+delta.Y)
        end
    end)
    obj.InputEnded:Connect(function() d=false end)
end

drag(frame)
drag(login)
drag(mini)
