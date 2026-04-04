local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local CloseBtn = Instance.new("TextButton")
local Auto = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local Label = Instance.new("TextLabel")
local SelectCaseBtn = Instance.new("TextButton")
local SelectedCaseLabel = Instance.new("TextLabel")
local SellToggle = Instance.new("TextButton")
local SellStatus = Instance.new("TextLabel")
local MinimizeBtn = Instance.new("TextButton")
local SmallMenu = Instance.new("TextButton")
local SettingsBtn = Instance.new("TextButton")
local dd = Instance.new("UIDragDetector")

local on = 0
local sellEnabled = false
local selectedCase = "Photon Core"
local totalOpened = 0
local customCases = {}

local cases = {"Photon Core", "Marina", "Cursed Demon", "Heavenfall"}
for i,v in ipairs(cases) do table.insert(customCases, v) end

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function updateCaseList()
    local newList = {}
    for i,v in ipairs(customCases) do table.insert(newList, v) end
    for i,v in ipairs(cases) do
        local found = false
        for j,w in ipairs(customCases) do if w == v then found = true break end end
        if not found then table.insert(newList, v) end
    end
    customCases = newList
end
updateCaseList()

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(8,5,20)
Frame.BackgroundTransparency = 0.1
Frame.BorderColor3 = Color3.fromRGB(180,0,255)
Frame.BorderSizePixel = 3
Frame.Position = UDim2.new(0.35,0,0.25,0)
Frame.Size = UDim2.new(0,320,0,380)
Frame.Active = true
Frame.Draggable = true
Frame.Visible = true

UICorner.CornerRadius = UDim.new(0,25)
UICorner.Parent = Frame
dd.Parent = Frame

UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180,0,255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100,0,200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180,0,255))
})
UIGradient.Rotation = 60
UIGradient.Parent = Frame

CloseBtn.Parent = Frame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
CloseBtn.BackgroundTransparency = 0.1
CloseBtn.BorderColor3 = Color3.fromRGB(255,100,100)
CloseBtn.BorderSizePixel = 1
CloseBtn.Position = UDim2.new(0.88,0,0.02,0)
CloseBtn.Size = UDim2.new(0,30,0,30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.TextSize = 20
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0,10)
closeCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() Frame.Visible = false SmallMenu.Visible = true end)

MinimizeBtn.Parent = Frame
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
MinimizeBtn.BackgroundTransparency = 0.1
MinimizeBtn.BorderColor3 = Color3.fromRGB(180,0,255)
MinimizeBtn.BorderSizePixel = 1
MinimizeBtn.Position = UDim2.new(0.78,0,0.02,0)
MinimizeBtn.Size = UDim2.new(0,30,0,30)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinimizeBtn.TextSize = 25
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0,10)
minCorner.Parent = MinimizeBtn
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false SmallMenu.Visible = true end)

SmallMenu.Parent = ScreenGui
SmallMenu.BackgroundColor3 = Color3.fromRGB(180,0,255)
SmallMenu.BackgroundTransparency = 0.15
SmallMenu.BorderColor3 = Color3.fromRGB(255,255,255)
SmallMenu.BorderSizePixel = 2
SmallMenu.Position = UDim2.new(0.02,0,0.85,0)
SmallMenu.Size = UDim2.new(0,50,0,50)
SmallMenu.Font = Enum.Font.GothamBold
SmallMenu.Text = "⚡"
SmallMenu.TextColor3 = Color3.fromRGB(255,255,255)
SmallMenu.TextSize = 30
SmallMenu.Visible = false
local smallCorner = Instance.new("UICorner")
smallCorner.CornerRadius = UDim.new(0,25)
smallCorner.Parent = SmallMenu
SmallMenu.MouseButton1Click:Connect(function() Frame.Visible = true SmallMenu.Visible = false end)

Label.Parent = Frame
Label.BackgroundTransparency = 1
Label.Position = UDim2.new(0.05,0,0.02,0)
Label.Size = UDim2.new(0,250,0,35)
Label.Font = Enum.Font.GothamBold
Label.Text = "⚡ TON BATTLE ⚡"
Label.TextColor3 = Color3.fromRGB(180,0,255)
Label.TextSize = 24

SelectCaseBtn.Parent = Frame
SelectCaseBtn.BackgroundColor3 = Color3.fromRGB(25,20,45)
SelectCaseBtn.BorderColor3 = Color3.fromRGB(180,0,255)
SelectCaseBtn.BorderSizePixel = 2
SelectCaseBtn.Position = UDim2.new(0.05,0,0.11,0)
SelectCaseBtn.Size = UDim2.new(0,290,0,35)
SelectCaseBtn.Font = Enum.Font.GothamBold
SelectCaseBtn.Text = "🎲 ВЫБРАТЬ КЕЙС"
SelectCaseBtn.TextColor3 = Color3.fromRGB(255,255,255)
SelectCaseBtn.TextSize = 15
local selCorner = Instance.new("UICorner")
selCorner.CornerRadius = UDim.new(0,12)
selCorner.Parent = SelectCaseBtn

SelectedCaseLabel.Parent = Frame
SelectedCaseLabel.BackgroundTransparency = 1
SelectedCaseLabel.Position = UDim2.new(0.05,0,0.19,0)
SelectedCaseLabel.Size = UDim2.new(0,290,0,20)
SelectedCaseLabel.Font = Enum.Font.Gotham
SelectedCaseLabel.Text = "✅ Выбран: " .. selectedCase
SelectedCaseLabel.TextColor3 = Color3.fromRGB(180,0,255)
SelectedCaseLabel.TextSize = 12

SellToggle.Parent = Frame
SellToggle.BackgroundColor3 = Color3.fromRGB(40,35,60)
SellToggle.BorderColor3 = Color3.fromRGB(255,100,100)
SellToggle.BorderSizePixel = 2
SellToggle.Position = UDim2.new(0.05,0,0.29,0)
SellToggle.Size = UDim2.new(0,140,0,35)
SellToggle.Font = Enum.Font.GothamBold
SellToggle.Text = "🔴 SELL: OFF"
SellToggle.TextColor3 = Color3.fromRGB(255,100,100)
SellToggle.TextSize = 13
local sellCorner = Instance.new("UICorner")
sellCorner.CornerRadius = UDim.new(0,10)
sellCorner.Parent = SellToggle

SellStatus.Parent = Frame
SellStatus.BackgroundTransparency = 1
SellStatus.Position = UDim2.new(0.55,0,0.29,0)
SellStatus.Size = UDim2.new(0,130,0,35)
SellStatus.Font = Enum.Font.Gotham
SellStatus.Text = "❌ Выкл"
SellStatus.TextColor3 = Color3.fromRGB(200,200,200)
SellStatus.TextSize = 12
SellStatus.TextXAlignment = Enum.TextXAlignment.Left

SettingsBtn.Parent = Frame
SettingsBtn.BackgroundColor3 = Color3.fromRGB(25,20,45)
SettingsBtn.BorderColor3 = Color3.fromRGB(180,0,255)
SettingsBtn.BorderSizePixel = 2
SettingsBtn.Position = UDim2.new(0.05,0,0.42,0)
SettingsBtn.Size = UDim2.new(0,290,0,35)
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.Text = "⚙ НАСТРОЙКИ"
SettingsBtn.TextColor3 = Color3.fromRGB(180,0,255)
SettingsBtn.TextSize = 15
local setCorner = Instance.new("UICorner")
setCorner.CornerRadius = UDim.new(0,12)
setCorner.Parent = SettingsBtn

Auto.Parent = Frame
Auto.BackgroundColor3 = Color3.fromRGB(0,200,100)
Auto.BorderColor3 = Color3.fromRGB(180,0,255)
Auto.BorderSizePixel = 3
Auto.Position = UDim2.new(0.05,0,0.55,0)
Auto.Size = UDim2.new(0,290,0,50)
Auto.Font = Enum.Font.GothamBold
Auto.Text = "▶ СТАРТ ФАРМ"
Auto.TextColor3 = Color3.fromRGB(255,255,255)
Auto.TextSize = 20
UICorner_2.CornerRadius = UDim.new(0,15)
UICorner_2.Parent = Auto

local FarmStatus = Instance.new("TextLabel")
FarmStatus.Parent = Frame
FarmStatus.BackgroundTransparency = 1
FarmStatus.Position = UDim2.new(0.05,0,0.7,0)
FarmStatus.Size = UDim2.new(0,290,0,20)
FarmStatus.Font = Enum.Font.Gotham
FarmStatus.Text = "⚡ Статус: Остановлен"
FarmStatus.TextColor3 = Color3.fromRGB(150,150,200)
FarmStatus.TextSize = 12

local CounterLabel = Instance.new("TextLabel")
CounterLabel.Parent = Frame
CounterLabel.BackgroundTransparency = 1
CounterLabel.Position = UDim2.new(0.05,0,0.77,0)
CounterLabel.Size = UDim2.new(0,290,0,20)
CounterLabel.Font = Enum.Font.Gotham
CounterLabel.Text = "📊 Открыто: 0 кейсов"
CounterLabel.TextColor3 = Color3.fromRGB(180,0,255)
CounterLabel.TextSize = 12

local Footer = Instance.new("TextLabel")
Footer.Parent = Frame
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(0.05,0,0.88,0)
Footer.Size = UDim2.new(0,290,0,25)
Footer.Font = Enum.Font.Gotham
Footer.Text = "👑 @NoMentalProblem & @Vezqx"
Footer.TextColor3 = Color3.fromRGB(100,100,180)
Footer.TextSize = 11

local SettingsFrame = Instance.new("Frame")
local SettingsCorner = Instance.new("UICorner")
local SettingsGradient = Instance.new("UIGradient")
local SettingsTitle = Instance.new("TextLabel")
local SettingsClose = Instance.new("TextButton")
local AddCaseBox = Instance.new("TextBox")
local AddCaseBtn = Instance.new("TextButton")
local CaseListFrame = Instance.new("ScrollingFrame")
local CaseListLayout = Instance.new("UIListLayout")
local SettingsDrag = Instance.new("UIDragDetector")

SettingsFrame.Parent = ScreenGui
SettingsFrame.BackgroundColor3 = Color3.fromRGB(8,5,20)
SettingsFrame.BackgroundTransparency = 0.1
SettingsFrame.BorderColor3 = Color3.fromRGB(180,0,255)
SettingsFrame.BorderSizePixel = 3
SettingsFrame.Position = UDim2.new(0.35,0,0.15,0)
SettingsFrame.Size = UDim2.new(0,340,0,400)
SettingsFrame.Visible = false
SettingsFrame.Active = true
SettingsFrame.Draggable = true
SettingsDrag.Parent = SettingsFrame

SettingsCorner.CornerRadius = UDim.new(0,25)
SettingsCorner.Parent = SettingsFrame

SettingsGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180,0,255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100,0,200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180,0,255))
})
SettingsGradient.Rotation = 45
SettingsGradient.Parent = SettingsFrame

SettingsTitle.Parent = SettingsFrame
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Position = UDim2.new(0.05,0,0.02,0)
SettingsTitle.Size = UDim2.new(0,250,0,35)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.Text = "⚙ НАСТРОЙКИ"
SettingsTitle.TextColor3 = Color3.fromRGB(180,0,255)
SettingsTitle.TextSize = 22

SettingsClose.Parent = SettingsFrame
SettingsClose.BackgroundColor3 = Color3.fromRGB(255,50,50)
SettingsClose.BackgroundTransparency = 0.1
SettingsClose.BorderColor3 = Color3.fromRGB(255,100,100)
SettingsClose.BorderSizePixel = 1
SettingsClose.Position = UDim2.new(0.85,0,0.02,0)
SettingsClose.Size = UDim2.new(0,30,0,30)
SettingsClose.Font = Enum.Font.GothamBold
SettingsClose.Text = "✕"
SettingsClose.TextColor3 = Color3.fromRGB(255,255,255)
SettingsClose.TextSize = 20
local setCloseCorner = Instance.new("UICorner")
setCloseCorner.CornerRadius = UDim.new(0,10)
setCloseCorner.Parent = SettingsClose
SettingsClose.MouseButton1Click:Connect(function() SettingsFrame.Visible = false end)

local AddLabel = Instance.new("TextLabel")
AddLabel.Parent = SettingsFrame
AddLabel.BackgroundTransparency = 1
AddLabel.Position = UDim2.new(0.05,0,0.11,0)
AddLabel.Size = UDim2.new(0,200,0,25)
AddLabel.Font = Enum.Font.GothamBold
AddLabel.Text = "➕ ДОБАВИТЬ СВОЙ КЕЙС:"
AddLabel.TextColor3 = Color3.fromRGB(255,255,255)
AddLabel.TextSize = 13

AddCaseBox.Parent = SettingsFrame
AddCaseBox.BackgroundColor3 = Color3.fromRGB(25,20,45)
AddCaseBox.BorderColor3 = Color3.fromRGB(180,0,255)
AddCaseBox.BorderSizePixel = 2
AddCaseBox.Position = UDim2.new(0.05,0,0.19,0)
AddCaseBox.Size = UDim2.new(0,200,0,35)
AddCaseBox.Font = Enum.Font.Gotham
AddCaseBox.PlaceholderText = "Название кейса"
AddCaseBox.Text = ""
AddCaseBox.TextColor3 = Color3.fromRGB(255,255,255)
AddCaseBox.TextSize = 14
local addBoxCorner = Instance.new("UICorner")
addBoxCorner.CornerRadius = UDim.new(0,10)
addBoxCorner.Parent = AddCaseBox

AddCaseBtn.Parent = SettingsFrame
AddCaseBtn.BackgroundColor3 = Color3.fromRGB(0,150,100)
AddCaseBtn.BorderColor3 = Color3.fromRGB(180,0,255)
AddCaseBtn.BorderSizePixel = 2
AddCaseBtn.Position = UDim2.new(0.72,0,0.19,0)
AddCaseBtn.Size = UDim2.new(0,90,0,35)
AddCaseBtn.Font = Enum.Font.GothamBold
AddCaseBtn.Text = "ДОБАВИТЬ"
AddCaseBtn.TextColor3 = Color3.fromRGB(255,255,255)
AddCaseBtn.TextSize = 12
local addBtnCorner = Instance.new("UICorner")
addBtnCorner.CornerRadius = UDim.new(0,10)
addBtnCorner.Parent = AddCaseBtn

local CasesLabel = Instance.new("TextLabel")
CasesLabel.Parent = SettingsFrame
CasesLabel.BackgroundTransparency = 1
CasesLabel.Position = UDim2.new(0.05,0,0.32,0)
CasesLabel.Size = UDim2.new(0,200,0,25)
CasesLabel.Font = Enum.Font.GothamBold
CasesLabel.Text = "📋 СПИСОК КЕЙСОВ:"
CasesLabel.TextColor3 = Color3.fromRGB(255,255,255)
CasesLabel.TextSize = 13

CaseListFrame.Parent = SettingsFrame
CaseListFrame.BackgroundTransparency = 1
CaseListFrame.Position = UDim2.new(0.05,0,0.39,0)
CaseListFrame.Size = UDim2.new(0,310,0,200)
CaseListFrame.CanvasSize = UDim2.new(0,0,0,0)
CaseListFrame.ScrollBarThickness = 5
CaseListFrame.ScrollBarImageColor3 = Color3.fromRGB(180,0,255)

CaseListLayout.Parent = CaseListFrame
CaseListLayout.SortOrder = Enum.SortOrder.LayoutOrder
CaseListLayout.Padding = UDim.new(0,4)

local function refreshCaseList()
    for _,v in pairs(CaseListFrame:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for i,caseName in ipairs(customCases) do
        local btn = Instance.new("TextButton")
        btn.Parent = CaseListFrame
        btn.BackgroundColor3 = Color3.fromRGB(30,25,55)
        btn.BorderColor3 = Color3.fromRGB(180,0,255)
        btn.BorderSizePixel = 1
        btn.Size = UDim2.new(1,0,0,35)
        btn.Font = Enum.Font.Gotham
        btn.Text = caseName
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextSize = 13
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0,8)
        btnCorner.Parent = btn
        btn.MouseButton1Click:Connect(function()
            selectedCase = caseName
            SelectedCaseLabel.Text = "✅ Выбран: " .. selectedCase
            SettingsFrame.Visible = false
        end)
    end
end

AddCaseBtn.MouseButton1Click:Connect(function()
    if AddCaseBox.Text ~= "" then
        table.insert(customCases, AddCaseBox.Text)
        refreshCaseList()
        AddCaseBox.Text = ""
    end
end)

local function updateSellUI()
    if sellEnabled then
        SellToggle.BackgroundColor3 = Color3.fromRGB(0,150,50)
        SellToggle.BorderColor3 = Color3.fromRGB(0,255,100)
        SellToggle.Text = "🟢 SELL: ON"
        SellToggle.TextColor3 = Color3.fromRGB(0,255,100)
        SellStatus.Text = "✅ Включена"
        SellStatus.TextColor3 = Color3.fromRGB(0,255,100)
    else
        SellToggle.BackgroundColor3 = Color3.fromRGB(40,35,60)
        SellToggle.BorderColor3 = Color3.fromRGB(255,100,100)
        SellToggle.Text = "🔴 SELL: OFF"
        SellToggle.TextColor3 = Color3.fromRGB(255,100,100)
        SellStatus.Text = "❌ Выключена"
        SellStatus.TextColor3 = Color3.fromRGB(200,200,200)
    end
end

SellToggle.MouseButton1Click:Connect(function()
    sellEnabled = not sellEnabled
    updateSellUI()
end)

SettingsBtn.MouseButton1Click:Connect(function()
    refreshCaseList()
    SettingsFrame.Visible = true
end)

local function updateCounter()
    CounterLabel.Text = "📊 Открыто: " .. totalOpened .. " кейсов"
end

Auto.MouseButton1Click:Connect(function()
    if on == 0 then
        on = 1
        Auto.BackgroundColor3 = Color3.fromRGB(0,100,200)
        Auto.Text = "⏹ СТОП ФАРМ"
        FarmStatus.Text = "⚡ Статус: ФАРМ АКТИВЕН (0.01 сек)"
        FarmStatus.TextColor3 = Color3.fromRGB(180,0,255)
        task.spawn(function()
            while on == 1 do
                pcall(function()
                    local args = {selectedCase, 10}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("OpenCase"):InvokeServer(unpack(args))
                    totalOpened = totalOpened + 10
                    updateCounter()
                    if sellEnabled then
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Inventory"):FireServer("Sell", "ALL")
                    end
                end)
                task.wait(0.01)
            end
        end)
    else
        on = 0
        Auto.BackgroundColor3 = Color3.fromRGB(0,200,100)
        Auto.Text = "▶ СТАРТ ФАРМ"
        FarmStatus.Text = "⚡ Статус: Остановлен"
        FarmStatus.TextColor3 = Color3.fromRGB(150,150,200)
    end
end)

local CaseMenu = Instance.new("Frame")
local CaseMenuCorner = Instance.new("UICorner")
local CaseMenuGradient = Instance.new("UIGradient")
local CaseMenuClose = Instance.new("TextButton")
local CaseMenuTitle = Instance.new("TextLabel")
local CaseListFrame2 = Instance.new("ScrollingFrame")
local CaseListLayout2 = Instance.new("UIListLayout")
local CaseDrag = Instance.new("UIDragDetector")

CaseMenu.Parent = ScreenGui
CaseMenu.BackgroundColor3 = Color3.fromRGB(8,5,20)
CaseMenu.BackgroundTransparency = 0.1
CaseMenu.BorderColor3 = Color3.fromRGB(180,0,255)
CaseMenu.BorderSizePixel = 3
CaseMenu.Position = UDim2.new(0.35,0,0.25,0)
CaseMenu.Size = UDim2.new(0,280,0,350)
CaseMenu.Visible = false
CaseMenu.Active = true
CaseMenu.Draggable = true
CaseDrag.Parent = CaseMenu

CaseMenuCorner.CornerRadius = UDim.new(0,25)
CaseMenuCorner.Parent = CaseMenu

CaseMenuGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180,0,255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100,0,200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180,0,255))
})
CaseMenuGradient.Rotation = 45
CaseMenuGradient.Parent = CaseMenu

CaseMenuTitle.Parent = CaseMenu
CaseMenuTitle.BackgroundTransparency = 1
CaseMenuTitle.Position = UDim2.new(0.05,0,0.02,0)
CaseMenuTitle.Size = UDim2.new(0,200,0,35)
CaseMenuTitle.Font = Enum.Font.GothamBold
CaseMenuTitle.Text = "🎲 ВЫБЕРИ КЕЙС"
CaseMenuTitle.TextColor3 = Color3.fromRGB(180,0,255)
CaseMenuTitle.TextSize = 18

CaseMenuClose.Parent = CaseMenu
CaseMenuClose.BackgroundColor3 = Color3.fromRGB(255,50,50)
CaseMenuClose.BackgroundTransparency = 0.1
CaseMenuClose.BorderColor3 = Color3.fromRGB(255,100,100)
CaseMenuClose.BorderSizePixel = 1
CaseMenuClose.Position = UDim2.new(0.85,0,0.02,0)
CaseMenuClose.Size = UDim2.new(0,30,0,30)
CaseMenuClose.Font = Enum.Font.GothamBold
CaseMenuClose.Text = "✕"
CaseMenuClose.TextColor3 = Color3.fromRGB(255,255,255)
CaseMenuClose.TextSize = 18
local caseCloseCorner = Instance.new("UICorner")
caseCloseCorner.CornerRadius = UDim.new(0,10)
caseCloseCorner.Parent = CaseMenuClose
CaseMenuClose.MouseButton1Click:Connect(function() CaseMenu.Visible = false end)

CaseListFrame2.Parent = CaseMenu
CaseListFrame2.BackgroundTransparency = 1
CaseListFrame2.Position = UDim2.new(0.05,0,0.12,0)
CaseListFrame2.Size = UDim2.new(0,250,0,270)
CaseListFrame2.CanvasSize = UDim2.new(0,0,0,0)
CaseListFrame2.ScrollBarThickness = 5
CaseListFrame2.ScrollBarImageColor3 = Color3.fromRGB(180,0,255)

CaseListLayout2.Parent = CaseListFrame2
CaseListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
CaseListLayout2.Padding = UDim.new(0,6)

local function refreshMainCaseList()
    for _,v in pairs(CaseListFrame2:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for i,caseName in ipairs(customCases) do
        local btn = Instance.new("TextButton")
        btn.Parent = CaseListFrame2
        btn.BackgroundColor3 = Color3.fromRGB(30,25,55)
        btn.BorderColor3 = Color3.fromRGB(180,0,255)
        btn.BorderSizePixel = 1
        btn.Size = UDim2.new(1,0,0,45)
        btn.Font = Enum.Font.GothamBold
        btn.Text = caseName
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextSize = 14
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0,10)
        btnCorner.Parent = btn
        btn.MouseButton1Click:Connect(function()
            selectedCase = caseName
            SelectedCaseLabel.Text = "✅ Выбран: " .. selectedCase
            CaseMenu.Visible = false
        end)
    end
end

SelectCaseBtn.MouseButton1Click:Connect(function()
    refreshMainCaseList()
    CaseMenu.Visible = true
end)

task.spawn(function()
    local ticker = 0
    while true do
        ticker = ticker + 0.02
        local intensity = (math.sin(ticker) + 1) / 4 + 0.5
        Frame.BorderColor3 = Color3.new(intensity * 0.7, 0, intensity)
        task.wait(0.05)
    end
end)

updateSellUI()
updateCounter()
refreshCaseList()
