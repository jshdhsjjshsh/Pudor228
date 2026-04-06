-- ========== TON BATTLE SCRIPT - NEON EDITION V5 ==========
-- Одно меню с прокруткой всех кейсов + возможность добавить свой

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ========== ВСЕ КЕЙСЫ (ПОЛНЫЙ СПИСОК) ==========
local AllCases = {
    "Trash", "Daily", "Photon Core", "Divine", "Beggar", "Plodder",
    "Office Clerk", "Manager", "Director", "Oligarch", "Frozen Heart",
    "Bubble Gum", "Cats", "Glitch", "Dream", "Bloody Night", "Heavenfall",
    "M5 F90", "G63", "Porsche 911", "URUS", "Gold", "Dark", "Palm",
    "Burj", "Luxury", "Marina", "Cursed Demon"
}

-- Пользовательские кейсы (копия всех + можно добавлять)
local CustomCases = {}
for i, v in ipairs(AllCases) do
    table.insert(CustomCases, v)
end

-- ========== НАСТРОЙКИ ==========
local Config = {
    SelectedCase = "Heavenfall",
    OpenAmount = 10,
    TimerSeconds = 0,
    DelayBetween = 0.05,
    AutoSell = false,
    IsFarming = false,
    FarmThread = nil,
    StartTime = 0
}

-- ========== СОЗДАНИЕ GUI ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NeonCaseSelector"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ========== ОСНОВНОЕ ОКНО ==========
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 5, 20)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderColor3 = Color3.fromRGB(180, 0, 255)
MainFrame.BorderSizePixel = 3
MainFrame.Position = UDim2.new(0.3, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 550)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 255))
})
MainGradient.Rotation = 60
MainGradient.Parent = MainFrame

-- Drag Detector
local DragDetector = Instance.new("UIDragDetector")
DragDetector.Parent = MainFrame

-- ========== КНОПКИ УПРАВЛЕНИЯ ОКНОМ ==========
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.BackgroundTransparency = 0.2
CloseBtn.BorderColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.BorderSizePixel = 1
CloseBtn.Position = UDim2.new(0.88, 0, 0.02, 0)
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 24
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeBtn.BackgroundTransparency = 0.2
MinimizeBtn.BorderColor3 = Color3.fromRGB(0, 255, 150)
MinimizeBtn.BorderSizePixel = 1
MinimizeBtn.Position = UDim2.new(0.78, 0, 0.02, 0)
MinimizeBtn.Size = UDim2.new(0, 35, 0, 35)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
MinimizeBtn.TextSize = 32
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 10)
MinCorner.Parent = MinimizeBtn
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    SmallMenu.Visible = true
end)

-- Маленькое меню для восстановления
local SmallMenu = Instance.new("TextButton")
SmallMenu.Parent = ScreenGui
SmallMenu.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
SmallMenu.BackgroundTransparency = 0.15
SmallMenu.BorderColor3 = Color3.fromRGB(0, 255, 150)
SmallMenu.BorderSizePixel = 2
SmallMenu.Position = UDim2.new(0.02, 0, 0.85, 0)
SmallMenu.Size = UDim2.new(0, 55, 0, 55)
SmallMenu.Font = Enum.Font.GothamBold
SmallMenu.Text = "⚡"
SmallMenu.TextColor3 = Color3.fromRGB(255, 255, 255)
SmallMenu.TextSize = 32
SmallMenu.Visible = false
local SmallCorner = Instance.new("UICorner")
SmallCorner.CornerRadius = UDim.new(0, 27)
SmallCorner.Parent = SmallMenu
SmallMenu.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    SmallMenu.Visible = false
end)

-- ========== ЗАГОЛОВОК ==========
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0.02, 0)
Title.Size = UDim2.new(0, 250, 0, 45)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ TON BATTLE V5 ⚡"
Title.TextColor3 = Color3.fromRGB(180, 0, 255)
Title.TextSize = 28

-- ========== ВКЛАДКИ ==========
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundTransparency = 1
TabBar.Position = UDim2.new(0.03, 0, 0.11, 0)
TabBar.Size = UDim2.new(0.94, 0, 0, 40)

local tabs = {"🎲 КЕЙСЫ", "⚡ ФАРМ", "⚙ НАСТРОЙКИ", "ℹ ИНФО"}
local tabButtons = {}
local panels = {}

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Parent = TabBar
    btn.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
    btn.BorderColor3 = Color3.fromRGB(180, 0, 255)
    btn.BorderSizePixel = 2
    btn.Position = UDim2.new(0.02 + (i-1) * 0.245, 0, 0, 0)
    btn.Size = UDim2.new(0, 105, 0, 38)
    btn.Font = Enum.Font.GothamBold
    btn.Text = tabName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    tabButtons[i] = btn
    
    local panel = Instance.new("Frame")
    panel.Parent = MainFrame
    panel.BackgroundTransparency = 1
    panel.Position = UDim2.new(0.04, 0, 0.22, 0)
    panel.Size = UDim2.new(0.92, 0, 0.73, 0)
    panel.Visible = (i == 1)
    panels[i] = panel
end

-- ========== ПАНЕЛЬ КЕЙСЫ (С ПРОКРУТКОЙ) ==========
local CasesPanel = panels[1]

-- Поле для добавления своего кейса
local AddCaseBox = Instance.new("TextBox")
AddCaseBox.Parent = CasesPanel
AddCaseBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
AddCaseBox.BorderColor3 = Color3.fromRGB(0, 255, 150)
AddCaseBox.BorderSizePixel = 2
AddCaseBox.Position = UDim2.new(0, 0, 0, 0)
AddCaseBox.Size = UDim2.new(0.65, 0, 0, 40)
AddCaseBox.Font = Enum.Font.Gotham
AddCaseBox.PlaceholderText = "➕ Введите название нового кейса"
AddCaseBox.Text = ""
AddCaseBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AddCaseBox.TextSize = 13
local AddBoxCorner = Instance.new("UICorner")
AddBoxCorner.CornerRadius = UDim.new(0, 10)
AddBoxCorner.Parent = AddCaseBox

local AddCaseBtn = Instance.new("TextButton")
AddCaseBtn.Parent = CasesPanel
AddCaseBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
AddCaseBtn.BorderColor3 = Color3.fromRGB(0, 255, 150)
AddCaseBtn.BorderSizePixel = 2
AddCaseBtn.Position = UDim2.new(0.68, 0, 0, 0)
AddCaseBtn.Size = UDim2.new(0.3, 0, 0, 40)
AddCaseBtn.Font = Enum.Font.GothamBold
AddCaseBtn.Text = "➕ ДОБАВИТЬ"
AddCaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AddCaseBtn.TextSize = 12
local AddBtnCorner = Instance.new("UICorner")
AddBtnCorner.CornerRadius = UDim.new(0, 10)
AddBtnCorner.Parent = AddCaseBtn

-- Скроллинг фрейм для списка кейсов
local CaseScrollFrame = Instance.new("ScrollingFrame")
CaseScrollFrame.Parent = CasesPanel
CaseScrollFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
CaseScrollFrame.BorderColor3 = Color3.fromRGB(180, 0, 255)
CaseScrollFrame.BorderSizePixel = 2
CaseScrollFrame.Position = UDim2.new(0, 0, 0.12, 0)
CaseScrollFrame.Size = UDim2.new(1, 0, 0, 0.85)
CaseScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
CaseScrollFrame.ScrollBarThickness = 8
CaseScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)
local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 12)
ScrollCorner.Parent = CaseScrollFrame

local CaseListLayout = Instance.new("UIListLayout")
CaseListLayout.Parent = CaseScrollFrame
CaseListLayout.SortOrder = Enum.SortOrder.LayoutOrder
CaseListLayout.Padding = UDim.new(0, 8)

-- Функция обновления списка кейсов
local SelectedCaseLabel = nil

local function RefreshCaseList()
    -- Очищаем старые кнопки
    for _, child in pairs(CaseScrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Создаем кнопки для всех кейсов
    for i, caseName in ipairs(CustomCases) do
        local caseBtn = Instance.new("TextButton")
        caseBtn.Parent = CaseScrollFrame
        caseBtn.BackgroundColor3 = Color3.fromRGB(30, 25, 55)
        caseBtn.BorderColor3 = Color3.fromRGB(0, 255, 150)
        caseBtn.BorderSizePixel = 2
        caseBtn.Size = UDim2.new(1, -10, 0, 50)
        caseBtn.Font = Enum.Font.GothamBold
        caseBtn.Text = caseName
        caseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        caseBtn.TextSize = 14
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 10)
        btnCorner.Parent = caseBtn
        
        -- Подсветка выбранного кейса
        if caseName == Config.SelectedCase then
            caseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
            caseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        
        caseBtn.MouseButton1Click:Connect(function()
            Config.SelectedCase = caseName
            RefreshCaseList()
            if SelectedCaseLabel then
                SelectedCaseLabel.Text = "✅ ВЫБРАН: " .. Config.SelectedCase
            end
        end)
    end
    
    -- Обновляем CanvasSize
    local childrenCount = #CaseScrollFrame:GetChildren() - 2
    CaseScrollFrame.CanvasSize = UDim2.new(0, 0, 0, childrenCount * 58 + 10)
end

-- Добавление своего кейса
AddCaseBtn.MouseButton1Click:Connect(function()
    local newCase = AddCaseBox.Text
    if newCase ~= "" and newCase ~= nil then
        -- Проверяем, нет ли уже такого кейса
        local exists = false
        for _, v in ipairs(CustomCases) do
            if v == newCase then
                exists = true
                break
            end
        end
        if not exists then
            table.insert(CustomCases, newCase)
            RefreshCaseList()
            AddCaseBox.Text = ""
            AddCaseBtn.Text = "✅ ДОБАВЛЕНО!"
            task.wait(1)
            AddCaseBtn.Text = "➕ ДОБАВИТЬ"
        else
            AddCaseBtn.Text = "❌ УЖЕ ЕСТЬ!"
            task.wait(1)
            AddCaseBtn.Text = "➕ ДОБАВИТЬ"
        end
    end
end)

-- ========== ПАНЕЛЬ ФАРМ ==========
local FarmPanel = panels[2]

local SelectedLabel = Instance.new("TextLabel")
SelectedLabel.Parent = FarmPanel
SelectedLabel.BackgroundTransparency = 1
SelectedLabel.Position = UDim2.new(0, 0, 0, 0)
SelectedLabel.Size = UDim2.new(1, 0, 0, 30)
SelectedLabel.Font = Enum.Font.GothamBold
SelectedLabel.Text = "✅ ВЫБРАН: " .. Config.SelectedCase
SelectedLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
SelectedLabel.TextSize = 14
SelectedCaseLabel = SelectedLabel

local AmountLabel = Instance.new("TextLabel")
AmountLabel.Parent = FarmPanel
AmountLabel.BackgroundTransparency = 1
AmountLabel.Position = UDim2.new(0, 0, 0.08, 0)
AmountLabel.Size = UDim2.new(1, 0, 0, 20)
AmountLabel.Font = Enum.Font.Gotham
AmountLabel.Text = "📦 КОЛИЧЕСТВО КЕЙСОВ ЗА РАЗ (1-10):"
AmountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountLabel.TextSize = 12

local AmountBox = Instance.new("TextBox")
AmountBox.Parent = FarmPanel
AmountBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
AmountBox.BorderColor3 = Color3.fromRGB(180, 0, 255)
AmountBox.BorderSizePixel = 2
AmountBox.Position = UDim2.new(0, 0, 0.14, 0)
AmountBox.Size = UDim2.new(1, 0, 0, 40)
AmountBox.Font = Enum.Font.GothamBold
AmountBox.Text = "10"
AmountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountBox.TextSize = 18
local AmountCorner = Instance.new("UICorner")
AmountCorner.CornerRadius = UDim.new(0, 10)
AmountCorner.Parent = AmountBox
AmountBox.FocusLost:Connect(function()
    local num = tonumber(AmountBox.Text)
    if num and num >= 1 and num <= 10 then
        Config.OpenAmount = math.floor(num)
        AmountBox.Text = tostring(Config.OpenAmount)
    else
        Config.OpenAmount = 10
        AmountBox.Text = "10"
    end
end)

local TimerLabel = Instance.new("TextLabel")
TimerLabel.Parent = FarmPanel
TimerLabel.BackgroundTransparency = 1
TimerLabel.Position = UDim2.new(0, 0, 0.27, 0)
TimerLabel.Size = UDim2.new(1, 0, 0, 20)
TimerLabel.Font = Enum.Font.Gotham
TimerLabel.Text = "⏱ ТАЙМЕР (СЕКУНД): 0 = БЕСКОНЕЧНО"
TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimerLabel.TextSize = 12

local TimerBox = Instance.new("TextBox")
TimerBox.Parent = FarmPanel
TimerBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
TimerBox.BorderColor3 = Color3.fromRGB(180, 0, 255)
TimerBox.BorderSizePixel = 2
TimerBox.Position = UDim2.new(0, 0, 0.33, 0)
TimerBox.Size = UDim2.new(1, 0, 0, 40)
TimerBox.Font = Enum.Font.GothamBold
TimerBox.Text = "0"
TimerBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TimerBox.TextSize = 18
local TimerCorner = Instance.new("UICorner")
TimerCorner.CornerRadius = UDim.new(0, 10)
TimerCorner.Parent = TimerBox
TimerBox.FocusLost:Connect(function()
    local num = tonumber(TimerBox.Text)
    if num and num >= 0 then
        Config.TimerSeconds = math.floor(num)
        TimerBox.Text = tostring(Config.TimerSeconds)
    else
        Config.TimerSeconds = 0
        TimerBox.Text = "0"
    end
end)

local SellBtn = Instance.new("TextButton")
SellBtn.Parent = FarmPanel
SellBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
SellBtn.BorderColor3 = Color3.fromRGB(255, 100, 100)
SellBtn.BorderSizePixel = 2
SellBtn.Position = UDim2.new(0, 0, 0.46, 0)
SellBtn.Size = UDim2.new(1, 0, 0, 45)
SellBtn.Font = Enum.Font.GothamBold
SellBtn.Text = "🔴 ПРОДАЖА: ВЫКЛ"
SellBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
SellBtn.TextSize = 14
local SellCorner = Instance.new("UICorner")
SellCorner.CornerRadius = UDim.new(0, 10)
SellCorner.Parent = SellBtn

local StartBtn = Instance.new("TextButton")
StartBtn.Parent = FarmPanel
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
StartBtn.BorderColor3 = Color3.fromRGB(0, 255, 150)
StartBtn.BorderSizePixel = 3
StartBtn.Position = UDim2.new(0, 0, 0.6, 0)
StartBtn.Size = UDim2.new(1, 0, 0, 55)
StartBtn.Font = Enum.Font.GothamBold
StartBtn.Text = "▶ СТАРТ ФАРМ"
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StartBtn.TextSize = 18
local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0, 12)
StartCorner.Parent = StartBtn

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = FarmPanel
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0.78, 0)
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.Text = "⚡ СТАТУС: ОСТАНОВЛЕН"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
StatusLabel.TextSize = 13

-- Обновление UI продажи
local function UpdateSellUI()
    if Config.AutoSell then
        SellBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        SellBtn.BorderColor3 = Color3.fromRGB(0, 255, 100)
        SellBtn.Text = "🟢 ПРОДАЖА: ВКЛ"
        SellBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        SellBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
        SellBtn.BorderColor3 = Color3.fromRGB(255, 100, 100)
        SellBtn.Text = "🔴 ПРОДАЖА: ВЫКЛ"
        SellBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end

SellBtn.MouseButton1Click:Connect(function()
    Config.AutoSell = not Config.AutoSell
    UpdateSellUI()
end)

-- Функция фарма
local function FarmLoop()
    while Config.IsFarming do
        -- Проверка таймера
        if Config.TimerSeconds > 0 and os.time() - Config.StartTime >= Config.TimerSeconds then
            break
        end
        
        pcall(function()
            -- Открытие кейса
            local Events = ReplicatedStorage:FindFirstChild("Events")
            if Events then
                local OpenCase = Events:FindFirstChild("OpenCase")
                if OpenCase then
                    OpenCase:InvokeServer(Config.SelectedCase, Config.OpenAmount)
                end
            end
            
            -- Автопродажа
            if Config.AutoSell then
                local Events = ReplicatedStorage:FindFirstChild("Events")
                if Events then
                    local Inventory = Events:FindFirstChild("Inventory")
                    if Inventory then
                        Inventory:FireServer("Sell", "ALL")
                    end
                end
            end
        end)
        
        task.wait(Config.DelayBetween)
    end
    
    -- Остановка фарма
    Config.IsFarming = false
    StartBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    StartBtn.Text = "▶ СТАРТ ФАРМ"
    StatusLabel.Text = "⚡ СТАТУС: ОСТАНОВЛЕН"
    StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
end

StartBtn.MouseButton1Click:Connect(function()
    if not Config.IsFarming then
        Config.IsFarming = true
        Config.StartTime = os.time()
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        StartBtn.Text = "⏹ СТОП ФАРМ"
        StatusLabel.Text = "⚡ СТАТУС: ФАРМ АКТИВЕН"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        task.spawn(FarmLoop)
    else
        Config.IsFarming = false
    end
end)

-- ========== ПАНЕЛЬ НАСТРОЙКИ ==========
local SettingsPanel = panels[3]

local DelayLabel = Instance.new("TextLabel")
DelayLabel.Parent = SettingsPanel
DelayLabel.BackgroundTransparency = 1
DelayLabel.Position = UDim2.new(0, 0, 0, 0)
DelayLabel.Size = UDim2.new(1, 0, 0, 25)
DelayLabel.Font = Enum.Font.Gotham
DelayLabel.Text = "⚡ ЗАДЕРЖКА МЕЖДУ ОТКРЫТИЯМИ (СЕК):"
DelayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DelayLabel.TextSize = 12

local DelayBox = Instance.new("TextBox")
DelayBox.Parent = SettingsPanel
DelayBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
DelayBox.BorderColor3 = Color3.fromRGB(180, 0, 255)
DelayBox.BorderSizePixel = 2
DelayBox.Position = UDim2.new(0, 0, 0.08, 0)
DelayBox.Size = UDim2.new(1, 0, 0, 40)
DelayBox.Font = Enum.Font.GothamBold
DelayBox.Text = "0.05"
DelayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
DelayBox.TextSize = 18
local DelayCorner = Instance.new("UICorner")
DelayCorner.CornerRadius = UDim.new(0, 10)
DelayCorner.Parent = DelayBox
DelayBox.FocusLost:Connect(function()
    local num = tonumber(DelayBox.Text)
    if num and num >= 0.01 then
        Config.DelayBetween = num
        DelayBox.Text = tostring(Config.DelayBetween)
    else
        Config.DelayBetween = 0.05
        DelayBox.Text = "0.05"
    end
end)

local ResetCasesBtn = Instance.new("TextButton")
ResetCasesBtn.Parent = SettingsPanel
ResetCasesBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
ResetCasesBtn.BorderColor3 = Color3.fromRGB(180, 0, 255)
ResetCasesBtn.BorderSizePixel = 2
ResetCasesBtn.Position = UDim2.new(0, 0, 0.22, 0)
ResetCasesBtn.Size = UDim2.new(1, 0, 0, 45)
ResetCasesBtn.Font = Enum.Font.GothamBold
ResetCasesBtn.Text = "🔄 СБРОСИТЬ ВСЕ ДОБАВЛЕННЫЕ КЕЙСЫ"
ResetCasesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetCasesBtn.TextSize = 13
local ResetCorner = Instance.new("UICorner")
ResetCorner.CornerRadius = UDim.new(0, 10)
ResetCorner.Parent = ResetCasesBtn
ResetCasesBtn.MouseButton1Click:Connect(function()
    CustomCases = {}
    for i, v in ipairs(AllCases) do
        table.insert(CustomCases, v)
    end
    RefreshCaseList()
    ResetCasesBtn.Text = "✅ СБРОШЕНО!"
    task.wait(1.5)
    ResetCasesBtn.Text = "🔄 СБРОСИТЬ ВСЕ ДОБАВЛЕННЫЕ КЕЙСЫ"
end)

-- ========== ПАНЕЛЬ ИНФО ==========
local InfoPanel = panels[4]

local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Parent = InfoPanel
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Position = UDim2.new(0, 0, 0, 0)
CreatorLabel.Size = UDim2.new(1, 0, 0, 50)
CreatorLabel.Font = Enum.Font.GothamBold
CreatorLabel.Text = "👑 СОЗДАТЕЛИ:\n@NoMentalProblem & @Vezqx"
CreatorLabel.TextColor3 = Color3.fromRGB(180, 0, 255)
CreatorLabel.TextSize = 15
CreatorLabel.TextYAlignment = Enum.TextYAlignment.Top

local TelegramBtn = Instance.new("TextButton")
TelegramBtn.Parent = InfoPanel
TelegramBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
TelegramBtn.BorderColor3 = Color3.fromRGB(0, 255, 150)
TelegramBtn.BorderSizePixel = 2
TelegramBtn.Position = UDim2.new(0, 0, 0.25, 0)
TelegramBtn.Size = UDim2.new(1, 0, 0, 50)
TelegramBtn.Font = Enum.Font.GothamBold
TelegramBtn.Text = "📢 TELEGRAM КАНАЛ"
TelegramBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TelegramBtn.TextSize = 16
local TelCorner = Instance.new("UICorner")
TelCorner.CornerRadius = UDim.new(0, 12)
TelCorner.Parent = TelegramBtn
TelegramBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://t.me/TonBattleScript")
    elseif toclipboard then
        toclipboard("https://t.me/TonBattleScript")
    end
    TelegramBtn.Text = "✅ ССЫЛКА СКОПИРОВАНА!"
    task.wait(1.5)
    TelegramBtn.Text = "📢 TELEGRAM КАНАЛ"
end)

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Parent = InfoPanel
VersionLabel.BackgroundTransparency = 1
VersionLabel.Position = UDim2.new(0, 0, 0.6, 0)
VersionLabel.Size = UDim2.new(1, 0, 0, 30)
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.Text = "⚡ TON BATTLE V5 | NEON EDITION"
VersionLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
VersionLabel.TextSize = 13

-- ========== ПЕРЕКЛЮЧЕНИЕ ВКЛАДОК ==========
for i, btn in ipairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        for j, panel in ipairs(panels) do
            panel.Visible = (j == i)
        end
        for j, bt in ipairs(tabButtons) do
            if j == i then
                bt.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
                bt.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                bt.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
                bt.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
    end)
end

-- ========== АНИМАЦИЯ НЕОНА ==========
task.spawn(function()
    local ticker = 0
    while true do
        ticker = ticker + 0.02
        local intensityR = (math.sin(ticker) + 1) / 4 + 0.5
        local intensityG = (math.cos(ticker) + 1) / 4 + 0.5
        MainFrame.BorderColor3 = Color3.new(intensityR * 0.7, intensityG, intensityR * 0.5)
        task.wait(0.05)
    end
end)

-- ========== ЗАПУСК ==========
RefreshCaseList()
UpdateSellUI()

print("✅ TON BATTLE V5 ЗАГРУЖЕН!")
print("📦 Всего кейсов: " .. #CustomCases)
print("🎯 Выбран кейс: " .. Config.SelectedCase)
