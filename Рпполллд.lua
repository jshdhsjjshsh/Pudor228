local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local CloseBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local SmallMenu = Instance.new("TextButton")
local dd = Instance.new("UIDragDetector")

local on = false
local sellEnabled = false
local selectedCase = "Photon Core"
local openAmount = 10
local timerSeconds = 0
local startTime = 0
local farmThread = nil

-- ВСЕ КЕЙСЫ (БОЛЬШОЙ СПИСОК)
local allCases = {
    "Trash", "Daily", "Photon Core", "Divine", "Beggar", "Plodder",
    "Office Clerk", "Manager", "Director", "Oligarch", "Frozen Heart",
    "Bubble Gum", "Cats", "Glitch", "Dream", "Bloody Night", "Heavenfall",
    "M5 F90", "G63", "Porsche 911", "URUS", "Gold", "Dark", "Palm",
    "Burj", "Luxury", "Marina", "Cursed Demon", "Cyberpunk", "Neon Strike",
    "Dragon Soul", "Phoenix", "Vampire", "Werewolf", "Wizard", "Elf",
    "Orc", "Dwarf", "Angel", "Demon", "Godlike", "Mythic", "Legendary",
    "Galaxy", "Nebula", "Supernova", "Black Hole", "Comet", "Asteroid",
    "Titan", "Atlas", "Prometheus", "Zeus", "Hades", "Poseidon", "Ares",
    "Hermes", "Apollo", "Artemis", "Athena", "Aphrodite", "Hephaestus"
}

local customCases = {}
for i,v in ipairs(allCases) do table.insert(customCases, v) end

local casesPerPage = 5
local currentPage = 1
local totalPages = math.ceil(#customCases / casesPerPage)

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ОСНОВНОЕ ОКНО
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(8,5,20)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderColor3 = Color3.fromRGB(180,0,255)
MainFrame.BorderSizePixel = 3
MainFrame.Position = UDim2.new(0.25,0,0.1,0)
MainFrame.Size = UDim2.new(0,550,0,580)
MainFrame.Active = true
MainFrame.Visible = true

UICorner.CornerRadius = UDim.new(0,20)
UICorner.Parent = MainFrame
dd.Parent = MainFrame

UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180,0,255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180,0,255))
})
UIGradient.Rotation = 60
UIGradient.Parent = MainFrame

-- КНОПКИ УПРАВЛЕНИЯ
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
CloseBtn.BackgroundTransparency = 0.1
CloseBtn.BorderColor3 = Color3.fromRGB(255,100,100)
CloseBtn.BorderSizePixel = 1
CloseBtn.Position = UDim2.new(0.94,0,0.01,0)
CloseBtn.Size = UDim2.new(0,28,0,28)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.TextSize = 18
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0,8)
closeCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false SmallMenu.Visible = true end)

MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
MinimizeBtn.BackgroundTransparency = 0.1
MinimizeBtn.BorderColor3 = Color3.fromRGB(0,255,150)
MinimizeBtn.BorderSizePixel = 1
MinimizeBtn.Position = UDim2.new(0.88,0,0.01,0)
MinimizeBtn.Size = UDim2.new(0,28,0,28)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(0,255,150)
MinimizeBtn.TextSize = 24
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0,8)
minCorner.Parent = MinimizeBtn
MinimizeBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false SmallMenu.Visible = true end)

SmallMenu.Parent = ScreenGui
SmallMenu.BackgroundColor3 = Color3.fromRGB(180,0,255)
SmallMenu.BackgroundTransparency = 0.15
SmallMenu.BorderColor3 = Color3.fromRGB(0,255,150)
SmallMenu.BorderSizePixel = 2
SmallMenu.Position = UDim2.new(0.02,0,0.85,0)
SmallMenu.Size = UDim2.new(0,55,0,55)
SmallMenu.Font = Enum.Font.GothamBold
SmallMenu.Text = "⚡"
SmallMenu.TextColor3 = Color3.fromRGB(255,255,255)
SmallMenu.TextSize = 32
SmallMenu.Visible = false
local smallCorner = Instance.new("UICorner")
smallCorner.CornerRadius = UDim.new(0,27)
smallCorner.Parent = SmallMenu
SmallMenu.MouseButton1Click:Connect(function() MainFrame.Visible = true SmallMenu.Visible = false end)

-- ЗАГОЛОВОК
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.12,0,0.01,0)
Title.Size = UDim2.new(0,300,0,35)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ TON BATTLE NEON ⚡"
Title.TextColor3 = Color3.fromRGB(180,0,255)
Title.TextSize = 24

-- ЛЕВОЕ ВЕРТИКАЛЬНОЕ МЕНЮ
local LeftMenu = Instance.new("Frame")
LeftMenu.Parent = MainFrame
LeftMenu.BackgroundColor3 = Color3.fromRGB(15,10,35)
LeftMenu.BackgroundTransparency = 0.3
LeftMenu.BorderColor3 = Color3.fromRGB(180,0,255)
LeftMenu.BorderSizePixel = 1
LeftMenu.Position = UDim2.new(0.01,0,0.09,0)
LeftMenu.Size = UDim2.new(0,100,0,0.88)
local leftCorner = Instance.new("UICorner")
leftCorner.CornerRadius = UDim.new(0,12)
leftCorner.Parent = LeftMenu

-- ПРАВАЯ ОБЛАСТЬ КОНТЕНТА
local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0.12,0,0.09,0)
ContentArea.Size = UDim2.new(0.86,0,0.88,0)

-- КНОПКИ МЕНЮ
local tabs = {"🎲 КЕЙСЫ", "⚡ ФАРМ", "⚙ НАСТРОЙКИ", "ℹ ИНФО"}
local tabButtons = {}
local panels = {}

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Parent = LeftMenu
    btn.BackgroundColor3 = Color3.fromRGB(25,20,55)
    btn.BorderColor3 = Color3.fromRGB(0,255,150)
    btn.BorderSizePixel = 1
    btn.Position = UDim2.new(0.05,0,0.05 + (i-1)*0.24,0)
    btn.Size = UDim2.new(0,90,0,45)
    btn.Font = Enum.Font.GothamBold
    btn.Text = tabName
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 11
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0,10)
    btnCorner.Parent = btn
    tabButtons[i] = btn
    
    local panel = Instance.new("Frame")
    panel.Parent = ContentArea
    panel.BackgroundTransparency = 1
    panel.Position = UDim2.new(0,0,0,0)
    panel.Size = UDim2.new(1,0,1,0)
    panel.Visible = (i == 1)
    panels[i] = panel
end

-- ============ ПАНЕЛЬ 1: КЕЙСЫ ============
local CasesPanel = panels[1]

-- Добавление своего кейса
local AddCaseBox = Instance.new("TextBox")
AddCaseBox.Parent = CasesPanel
AddCaseBox.BackgroundColor3 = Color3.fromRGB(25,20,45)
AddCaseBox.BorderColor3 = Color3.fromRGB(0,255,150)
AddCaseBox.BorderSizePixel = 2
AddCaseBox.Position = UDim2.new(0,0,0,0)
AddCaseBox.Size = UDim2.new(0.7,0,0,40)
AddCaseBox.Font = Enum.Font.Gotham
AddCaseBox.PlaceholderText = "➕ Впиши название кейса"
AddCaseBox.Text = ""
AddCaseBox.TextColor3 = Color3.fromRGB(255,255,255)
AddCaseBox.TextSize = 13
local addCorner = Instance.new("UICorner")
addCorner.CornerRadius = UDim.new(0,10)
addCorner.Parent = AddCaseBox

local AddCaseBtn = Instance.new("TextButton")
AddCaseBtn.Parent = CasesPanel
AddCaseBtn.BackgroundColor3 = Color3.fromRGB(0,150,100)
AddCaseBtn.BorderColor3 = Color3.fromRGB(0,255,150)
AddCaseBtn.BorderSizePixel = 2
AddCaseBtn.Position = UDim2.new(0.72,0,0,0)
AddCaseBtn.Size = UDim2.new(0.27,0,0,40)
AddCaseBtn.Font = Enum.Font.GothamBold
AddCaseBtn.Text = "ДОБАВИТЬ"
AddCaseBtn.TextColor3 = Color3.fromRGB(255,255,255)
AddCaseBtn.TextSize = 12
local addBtnCorner = Instance.new("UICorner")
addBtnCorner.CornerRadius = UDim.new(0,10)
addBtnCorner.Parent = AddCaseBtn

-- Список кейсов с прокруткой
local CaseListFrame = Instance.new("ScrollingFrame")
CaseListFrame.Parent = CasesPanel
CaseListFrame.BackgroundColor3 = Color3.fromRGB(15,10,30)
CaseListFrame.BorderColor3 = Color3.fromRGB(180,0,255)
CaseListFrame.BorderSizePixel = 1
CaseListFrame.Position = UDim2.new(0,0,0.12,0)
CaseListFrame.Size = UDim2.new(1,0,0,0.65)
CaseListFrame.CanvasSize = UDim2.new(0,0,0,0)
CaseListFrame.ScrollBarThickness = 6
CaseListFrame.ScrollBarImageColor3 = Color3.fromRGB(180,0,255)
local cfCorner = Instance.new("UICorner")
cfCorner.CornerRadius = UDim.new(0,10)
cfCorner.Parent = CaseListFrame

local CaseListLayout = Instance.new("UIListLayout")
CaseListLayout.Parent = CaseListFrame
CaseListLayout.SortOrder = Enum.SortOrder.LayoutOrder
CaseListLayout.Padding = UDim.new(0,5)

-- Пагинация
local PageFrame = Instance.new("Frame")
PageFrame.Parent = CasesPanel
PageFrame.BackgroundTransparency = 1
PageFrame.Position = UDim2.new(0,0,0.8,0)
PageFrame.Size = UDim2.new(1,0,0,0.18)

local function updatePageButtons()
    for _,v in pairs(PageFrame:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    totalPages = math.ceil(#customCases / casesPerPage)
    if totalPages == 0 then totalPages = 1 end
    local startX = 0.5 - (totalPages * 0.06)
    for i = 1, totalPages do
        local btn = Instance.new("TextButton")
        btn.Parent = PageFrame
        btn.BackgroundColor3 = Color3.fromRGB(30,25,55)
        btn.BorderColor3 = Color3.fromRGB(180,0,255)
        btn.BorderSizePixel = 1
        btn.Size = UDim2.new(0,35,0,30)
        btn.Position = UDim2.new(startX + (i-1)*0.11, 0, 0.1, 0)
        btn.Font = Enum.Font.GothamBold
        btn.Text = tostring(i)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextSize = 13
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0,8)
        btnCorner.Parent = btn
        btn.MouseButton1Click:Connect(function()
            currentPage = i
            refreshCaseList()
        end)
    end
end

local function refreshCaseList()
    for _,v in pairs(CaseListFrame:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    local startIdx = (currentPage-1) * casesPerPage + 1
    local endIdx = math.min(startIdx + casesPerPage - 1, #customCases)
    local yOffset = 0
    for i = startIdx, endIdx do
        local caseName = customCases[i]
        local btn = Instance.new("TextButton")
        btn.Parent = CaseListFrame
        btn.BackgroundColor3 = Color3.fromRGB(30,25,55)
        btn.BorderColor3 = Color3.fromRGB(0,255,150)
        btn.BorderSizePixel = 1
        btn.Size = UDim2.new(1,0,0,45)
        btn.Position = UDim2.new(0,0,0,yOffset)
        btn.Font = Enum.Font.GothamBold
        btn.Text = caseName
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextSize = 13
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0,10)
        btnCorner.Parent = btn
        btn.MouseButton1Click:Connect(function()
            selectedCase = caseName
            SelectedLabel.Text = "✅ " .. selectedCase
        end)
        yOffset = yOffset + 50
    end
    CaseListFrame.CanvasSize = UDim2.new(0,0,0,yOffset)
    updatePageButtons()
end

AddCaseBtn.MouseButton1Click:Connect(function()
    if AddCaseBox.Text ~= "" then
        table.insert(customCases, AddCaseBox.Text)
        refreshCaseList()
        AddCaseBox.Text = ""
    end
end)

-- ============ ПАНЕЛЬ 2: ФАРМ ============
local FarmPanel = panels[2]

local SelectedLabel = Instance.new("TextLabel")
SelectedLabel.Parent = FarmPanel
SelectedLabel.BackgroundTransparency = 1
SelectedLabel.Position = UDim2.new(0,0,0,0)
SelectedLabel.Size = UDim2.new(1,0,0,30)
SelectedLabel.Font = Enum.Font.GothamBold
SelectedLabel.Text = "✅ " .. selectedCase
SelectedLabel.TextColor3 = Color3.fromRGB(0,255,150)
SelectedLabel.TextSize = 14

local AmountLabel = Instance.new("TextLabel")
AmountLabel.Parent = FarmPanel
AmountLabel.BackgroundTransparency = 1
AmountLabel.Position = UDim2.new(0,0,0.08,0)
AmountLabel.Size = UDim2.new(1,0,0,20)
AmountLabel.Font = Enum.Font.Gotham
AmountLabel.Text = "📦 Кейсов за раз (1-10):"
AmountLabel.TextColor3 = Color3.fromRGB(255,255,255)
AmountLabel.TextSize = 12

local AmountBox = Instance.new("TextBox")
AmountBox.Parent = FarmPanel
AmountBox.BackgroundColor3 = Color3.fromRGB(25,20,45)
AmountBox.BorderColor3 = Color3.fromRGB(180,0,255)
AmountBox.BorderSizePixel = 2
AmountBox.Position = UDim2.new(0,0,0.14,0)
AmountBox.Size = UDim2.new(1,0,0,40)
AmountBox.Font = Enum.Font.GothamBold
AmountBox.Text = "10"
AmountBox.TextColor3 = Color3.fromRGB(255,255,255)
AmountBox.TextSize = 18
local amCorner = Instance.new("UICorner")
amCorner.CornerRadius = UDim.new(0,10)
amCorner.Parent = AmountBox
AmountBox.FocusLost:Connect(function()
    local num = tonumber(AmountBox.Text)
    if num and num >= 1 and num <= 10 then openAmount = math.floor(num) AmountBox.Text = tostring(openAmount)
    else openAmount = 10 AmountBox.Text = "10" end
end)

local TimerLabel = Instance.new("TextLabel")
TimerLabel.Parent = FarmPanel
TimerLabel.BackgroundTransparency = 1
TimerLabel.Position = UDim2.new(0,0,0.28,0)
TimerLabel.Size = UDim2.new(1,0,0,20)
TimerLabel.Font = Enum.Font.Gotham
TimerLabel.Text = "⏱ Таймер (сек) | 0 = бесконечно:"
TimerLabel.TextColor3 = Color3.fromRGB(255,255,255)
TimerLabel.TextSize = 12

local TimerBox = Instance.new("TextBox")
TimerBox.Parent = FarmPanel
TimerBox.BackgroundColor3 = Color3.fromRGB(25,20,45)
TimerBox.BorderColor3 = Color3.fromRGB(180,0,255)
TimerBox.BorderSizePixel = 2
TimerBox.Position = UDim2.new(0,0,0.34,0)
TimerBox.Size = UDim2.new(1,0,0,40)
TimerBox.Font = Enum.Font.GothamBold
TimerBox.Text = "0"
TimerBox.TextColor3 = Color3.fromRGB(255,255,255)
TimerBox.TextSize = 18
local tmCorner = Instance.new("UICorner")
tmCorner.CornerRadius = UDim.new(0,10)
tmCorner.Parent = TimerBox
TimerBox.FocusLost:Connect(function()
    local num = tonumber(TimerBox.Text)
    if num and num >= 0 then timerSeconds = math.floor(num) TimerBox.Text = tostring(timerSeconds)
    else timerSeconds = 0 TimerBox.Text = "0" end
end)

local SellBtn = Instance.new("TextButton")
SellBtn.Parent = FarmPanel
SellBtn.BackgroundColor3 = Color3.fromRGB(40,35,60)
SellBtn.BorderColor3 = Color3.fromRGB(255,100,100)
SellBtn.BorderSizePixel = 2
SellBtn.Position = UDim2.new(0,0,0.48,0)
SellBtn.Size = UDim2.new(1,0,0,40)
SellBtn.Font = Enum.Font.GothamBold
SellBtn.Text = "🔴 ПРОДАЖА: ВЫКЛ"
SellBtn.TextColor3 = Color3.fromRGB(255,100,100)
SellBtn.TextSize = 14
local sellCorner = Instance.new("UICorner")
sellCorner.CornerRadius = UDim.new(0,10)
sellCorner.Parent = SellBtn

local StartStopBtn = Instance.new("TextButton")
StartStopBtn.Parent = FarmPanel
StartStopBtn.BackgroundColor3 = Color3.fromRGB(0,200,100)
StartStopBtn.BorderColor3 = Color3.fromRGB(0,255,150)
StartStopBtn.BorderSizePixel = 3
StartStopBtn.Position = UDim2.new(0,0,0.62,0)
StartStopBtn.Size = UDim2.new(1,0,0,50)
StartStopBtn.Font = Enum.Font.GothamBold
StartStopBtn.Text = "▶ СТАРТ ФАРМ"
StartStopBtn.TextColor3 = Color3.fromRGB(255,255,255)
StartStopBtn.TextSize = 18
local startCorner = Instance.new("UICorner")
startCorner.CornerRadius = UDim.new(0,12)
startCorner.Parent = StartStopBtn

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = FarmPanel
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0,0,0.82,0)
StatusLabel.Size = UDim2.new(1,0,0,25)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "⚡ Статус: Остановлен"
StatusLabel.TextColor3 = Color3.fromRGB(150,150,200)
StatusLabel.TextSize = 12

-- ФУНКЦИЯ ОБНОВЛЕНИЯ КНОПКИ ПРОДАЖИ
local function updateSellUI()
    if sellEnabled then
        SellBtn.BackgroundColor3 = Color3.fromRGB(0,150,50)
        SellBtn.BorderColor3 = Color3.fromRGB(0,255,100)
        SellBtn.Text = "🟢 ПРОДАЖА: ВКЛ"
        SellBtn.TextColor3 = Color3.fromRGB(0,255,100)
    else
        SellBtn.BackgroundColor3 = Color3.fromRGB(40,35,60)
        SellBtn.BorderColor3 = Color3.fromRGB(255,100,100)
        SellBtn.Text = "🔴 ПРОДАЖА: ВЫКЛ"
        SellBtn.TextColor3 = Color3.fromRGB(255,100,100)
    end
end

SellBtn.MouseButton1Click:Connect(function()
    sellEnabled = not sellEnabled
    updateSellUI()
end)

-- ГЛАВНАЯ ФУНКЦИЯ ФАРМА (СТАРТ/СТОП ОДНОЙ КНОПКОЙ)
local function startFarm()
    if on then return end
    on = true
    startTime = os.time()
    StartStopBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    StartStopBtn.Text = "⏹ СТОП ФАРМ"
    StatusLabel.Text = "⚡ Статус: ФАРМ АКТИВЕН"
    StatusLabel.TextColor3 = Color3.fromRGB(0,255,150)
    
    local delay = tonumber(SpeedBox.Text) or 0.01
    if delay < 0.01 then delay = 0.01 end
    
    farmThread = task.spawn(function()
        while on do
            if timerSeconds > 0 and os.time() - startTime >= timerSeconds then
                break
            end
            pcall(function()
                local args = {selectedCase, openAmount}
                local rs = game:GetService("ReplicatedStorage")
                rs:WaitForChild("Events"):WaitForChild("OpenCase"):InvokeServer(unpack(args))
                if sellEnabled then
                    rs:WaitForChild("Events"):WaitForChild("Inventory"):FireServer("Sell", "ALL")
                end
            end)
            task.wait(delay)
        end
        stopFarm()
    end)
end

local function stopFarm()
    on = false
    if farmThread then task.cancel(farmThread) end
    StartStopBtn.BackgroundColor3 = Color3.fromRGB(0,200,100)
    StartStopBtn.Text = "▶ СТАРТ ФАРМ"
    StatusLabel.Text = "⚡ Статус: Остановлен"
    StatusLabel.TextColor3 = Color3.fromRGB(150,150,200)
end

StartStopBtn.MouseButton1Click:Connect(function()
    if on then
        stopFarm()
    else
        startFarm()
    end
end)

-- ============ ПАНЕЛЬ 3: НАСТРОЙКИ ============
local SettingsPanel = panels[3]

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SettingsPanel
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0,0,0,0)
SpeedLabel.Size = UDim2.new(1,0,0,25)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Text = "⚡ Задержка между открытиями (сек):"
SpeedLabel.TextColor3 = Color3.fromRGB(255,255,255)
SpeedLabel.TextSize = 12

local SpeedBox = Instance.new("TextBox")
SpeedBox.Parent = SettingsPanel
SpeedBox.BackgroundColor3 = Color3.fromRGB(25,20,45)
SpeedBox.BorderColor3 = Color3.fromRGB(180,0,255)
SpeedBox.BorderSizePixel = 2
SpeedBox.Position = UDim2.new(0,0,0.08,0)
SpeedBox.Size = UDim2.new(1,0,0,40)
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.Text = "0.01"
SpeedBox.TextColor3 = Color3.fromRGB(255,255,255)
SpeedBox.TextSize = 18
local spCorner = Instance.new("UICorner")
spCorner.CornerRadius = UDim.new(0,10)
spCorner.Parent = SpeedBox

local ResetBtn = Instance.new("TextButton")
ResetBtn.Parent = SettingsPanel
ResetBtn.BackgroundColor3 = Color3.fromRGB(150,50,200)
ResetBtn.BorderColor3 = Color3.fromRGB(180,0,255)
ResetBtn.BorderSizePixel = 2
ResetBtn.Position = UDim2.new(0,0,0.22,0)
ResetBtn.Size = UDim2.new(1,0,0,45)
ResetBtn.Font = Enum.Font.GothamBold
ResetBtn.Text = "🔄 СБРОСИТЬ ВСЕ КЕЙСЫ"
ResetBtn.TextColor3 = Color3.fromRGB(255,255,255)
ResetBtn.TextSize = 14
local resCorner = Instance.new("UICorner")
resCorner.CornerRadius = UDim.new(0,10)
resCorner.Parent = ResetBtn
ResetBtn.MouseButton1Click:Connect(function()
    customCases = {}
    for i,v in ipairs(allCases) do table.insert(customCases, v) end
    refreshCaseList()
end)

-- ============ ПАНЕЛЬ 4: ИНФО ============
local InfoPanel = panels[4]

local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Parent = InfoPanel
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Position = UDim2.new(0,0,0,0)
CreatorLabel.Size = UDim2.new(1,0,0,50)
CreatorLabel.Font = Enum.Font.GothamBold
CreatorLabel.Text = "👑 СОЗДАТЕЛИ:\n@NoMentalProblem  &  @Vezqx"
CreatorLabel.TextColor3 = Color3.fromRGB(180,0,255)
CreatorLabel.TextSize = 14
CreatorLabel.TextYAlignment = Enum.TextYAlignment.Top

local ChannelBtn = Instance.new("TextButton")
ChannelBtn.Parent = InfoPanel
ChannelBtn.BackgroundColor3 = Color3.fromRGB(0,100,150)
ChannelBtn.BorderColor3 = Color3.fromRGB(0,255,150)
ChannelBtn.BorderSizePixel = 2
ChannelBtn.Position = UDim2.new(0,0,0.28,0)
ChannelBtn.Size = UDim2.new(1,0,0,50)
ChannelBtn.Font = Enum.Font.GothamBold
ChannelBtn.Text = "📢 TELEGRAM КАНАЛ"
ChannelBtn.TextColor3 = Color3.fromRGB(255,255,255)
ChannelBtn.TextSize = 16
local chCorner = Instance.new("UICorner")
chCorner.CornerRadius = UDim.new(0,12)
chCorner.Parent = ChannelBtn
ChannelBtn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard("https://t.me/TonBattleScript")
    elseif toclipboard then toclipboard("https://t.me/TonBattleScript") end
    ChannelBtn.Text = "✅ ССЫЛКА СКОПИРОВАНА!"
    task.wait(1.5)
    ChannelBtn.Text = "📢 TELEGRAM КАНАЛ"
end)

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Parent = InfoPanel
VersionLabel.BackgroundTransparency = 1
VersionLabel.Position = UDim2.new(0,0,0.65,0)
VersionLabel.Size = UDim2.new(1,0,0,30)
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.Text = "⚡ TON BATTLE V3 | NEON EDITION"
VersionLabel.TextColor3 = Color3.fromRGB(0,255,150)
VersionLabel.TextSize = 12

-- ПЕРЕКЛЮЧЕНИЕ ВКЛАДОК
for i, btn in ipairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        for j, panel in ipairs(panels) do panel.Visible = (j == i) end
        for j, bt in ipairs(tabButtons) do
            bt.BackgroundColor3 = (j == i) and Color3.fromRGB(180,0,255) or Color3.fromRGB(25,20,55)
        end
    end)
end

-- АНИМАЦИЯ НЕОНА
task.spawn(function()
    local ticker = 0
    while true do
        ticker = ticker + 0.02
        local intensity = (math.sin(ticker) + 1) / 4 + 0.5
        MainFrame.BorderColor3 = Color3.new(intensity * 0.7, intensity * 0.3, intensity)
        task.wait(0.05)
    end
end)

-- ЗАПУСК
refreshCaseList()
updateSellUI()
