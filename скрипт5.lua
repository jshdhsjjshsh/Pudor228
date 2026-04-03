local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local CloseBtn = Instance.new("TextButton")
local Auto = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local Label = Instance.new("TextLabel")
local SettingsBtn = Instance.new("TextButton")
local SelectedCaseLabel = Instance.new("TextLabel")
local dd = Instance.new("UIDragDetector")

-- Переменные
local on = 0
local sellEnabled = false
local selectedCase = "Photon Core"
local casesToOpen = 1000
local openedCount = 0
local speedMode = "medium" -- slow, medium, fast

-- Таблица задержек
local speedDelays = {
    slow = 3.5,
    medium = 2,
    fast = 0.8
}

-- ТОЛЬКО 4 КЕЙСА
local cases = {"Photon Core", "Marina", "Cursed Demon", "Heavenfall"}

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ============ ОСНОВНОЕ МЕНЮ ============
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
Frame.BackgroundTransparency = 0.100
Frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
Frame.BorderSizePixel = 3
Frame.Position = UDim2.new(0.35, 0, 0.20, 0)
Frame.Size = UDim2.new(0, 340, 0, 430)
Frame.ClipsDescendants = true
Frame.Active = true
Frame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = Frame

-- Drag детектор для движения
dd.Parent = Frame

-- Неон-градиент
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(100, 0, 255)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 0, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
})
UIGradient.Rotation = 60
UIGradient.Parent = Frame

-- Кнопка закрытия
CloseBtn.Parent = Frame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.BackgroundTransparency = 0.1
CloseBtn.BorderColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.BorderSizePixel = 1
CloseBtn.Position = UDim2.new(0.88, 0, 0.02, 0)
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 22

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 12)
closeCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false
end)

-- Название
Label.Parent = Frame
Label.BackgroundTransparency = 1
Label.Position = UDim2.new(0.05, 0, 0.02, 0)
Label.Size = UDim2.new(0, 250, 0, 40)
Label.Font = Enum.Font.GothamBold
Label.Text = "⚡ TON BATTLE V2 ⚡"
Label.TextColor3 = Color3.fromRGB(0, 255, 255)
Label.TextSize = 26

-- Кнопка выбора кейса
local SelectCaseBtn = Instance.new("TextButton")
SelectCaseBtn.Parent = Frame
SelectCaseBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
SelectCaseBtn.BorderColor3 = Color3.fromRGB(0, 255, 255)
SelectCaseBtn.BorderSizePixel = 2
SelectCaseBtn.Position = UDim2.new(0.05, 0, 0.11, 0)
SelectCaseBtn.Size = UDim2.new(0, 310, 0, 42)
SelectCaseBtn.Font = Enum.Font.GothamBold
SelectCaseBtn.Text = "🎲 ВЫБРАТЬ КЕЙС"
SelectCaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectCaseBtn.TextSize = 18

local selectCorner = Instance.new("UICorner")
selectCorner.CornerRadius = UDim.new(0, 12)
selectCorner.Parent = SelectCaseBtn

-- Метка выбранного кейса
SelectedCaseLabel.Parent = Frame
SelectedCaseLabel.BackgroundTransparency = 1
SelectedCaseLabel.Position = UDim2.new(0.05, 0, 0.20, 0)
SelectedCaseLabel.Size = UDim2.new(0, 310, 0, 25)
SelectedCaseLabel.Font = Enum.Font.Gotham
SelectedCaseLabel.Text = "✅ Выбран: " .. selectedCase
SelectedCaseLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
SelectedCaseLabel.TextSize = 13

-- Кнопка настроек
SettingsBtn.Parent = Frame
SettingsBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
SettingsBtn.BorderColor3 = Color3.fromRGB(255, 200, 0)
SettingsBtn.BorderSizePixel = 2
SettingsBtn.Position = UDim2.new(0.05, 0, 0.27, 0)
SettingsBtn.Size = UDim2.new(0, 310, 0, 42)
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.Text = "⚙ НАСТРОЙКИ"
SettingsBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
SettingsBtn.TextSize = 18

local setBtnCorner = Instance.new("UICorner")
setBtnCorner.CornerRadius = UDim.new(0, 12)
setBtnCorner.Parent = SettingsBtn

-- Кнопка старт/стоп
Auto.Parent = Frame
Auto.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
Auto.BorderColor3 = Color3.fromRGB(0, 255, 150)
Auto.BorderSizePixel = 3
Auto.Position = UDim2.new(0.05, 0, 0.42, 0)
Auto.Size = UDim2.new(0, 310, 0, 55)
Auto.Font = Enum.Font.GothamBold
Auto.Text = "▶ СТАРТ ФАРМ"
Auto.TextColor3 = Color3.fromRGB(255, 255, 255)
Auto.TextSize = 24

UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = Auto

-- Статистика
local StatsLabel = Instance.new("TextLabel")
StatsLabel.Parent = Frame
StatsLabel.BackgroundTransparency = 1
StatsLabel.Position = UDim2.new(0.05, 0, 0.60, 0)
StatsLabel.Size = UDim2.new(0, 310, 0, 22)
StatsLabel.Font = Enum.Font.Gotham
StatsLabel.Text = "📊 Открыто: 0 | Осталось: " .. casesToOpen
StatsLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
StatsLabel.TextSize = 13

-- Текущая скорость
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = Frame
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0.05, 0, 0.68, 0)
SpeedLabel.Size = UDim2.new(0, 310, 0, 22)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Text = "⚡ Скорость: СРЕДНЕ (2 сек)"
SpeedLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
SpeedLabel.TextSize = 13

-- Подвал с авторами
local Footer = Instance.new("TextLabel")
Footer.Parent = Frame
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(0.05, 0, 0.85, 0)
Footer.Size = UDim2.new(0, 310, 0, 35)
Footer.Font = Enum.Font.Gotham
Footer.Text = "👑 Создатели: @NoMentalProblem & @Vezqx"
Footer.TextColor3 = Color3.fromRGB(100, 100, 180)
Footer.TextSize = 12

-- ============ МЕНЮ НАСТРОЕК ============
local SettingsFrame = Instance.new("Frame")
local SettingsCorner = Instance.new("UICorner")
local SettingsGradient = Instance.new("UIGradient")
local SettingsTitle = Instance.new("TextLabel")
local SettingsClose = Instance.new("TextButton")
local AmountLabel = Instance.new("TextLabel")
local AmountBox = Instance.new("TextBox")
local AmountCorner = Instance.new("UICorner")
local SellToggle = Instance.new("TextButton")
local SpeedSlow = Instance.new("TextButton")
local SpeedMedium = Instance.new("TextButton")
local SpeedFast = Instance.new("TextButton")
local ProgressLabel = Instance.new("TextLabel")
local CreditsLabel = Instance.new("TextLabel")
local SettingsDrag = Instance.new("UIDragDetector")

SettingsFrame.Parent = ScreenGui
SettingsFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
SettingsFrame.BackgroundTransparency = 0.100
SettingsFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
SettingsFrame.BorderSizePixel = 3
SettingsFrame.Position = UDim2.new(0.35, 0, 0.15, 0)
SettingsFrame.Size = UDim2.new(0, 340, 0, 480)
SettingsFrame.Visible = false
SettingsFrame.Active = true
SettingsFrame.Draggable = true

SettingsDrag.Parent = SettingsFrame

SettingsCorner.CornerRadius = UDim.new(0, 25)
SettingsCorner.Parent = SettingsFrame

SettingsGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 0))
})
SettingsGradient.Rotation = 45
SettingsGradient.Parent = SettingsFrame

SettingsTitle.Parent = SettingsFrame
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Position = UDim2.new(0.05, 0, 0.02, 0)
SettingsTitle.Size = UDim2.new(0, 250, 0, 40)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.Text = "⚙ НАСТРОЙКИ"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 200, 0)
SettingsTitle.TextSize = 24

SettingsClose.Parent = SettingsFrame
SettingsClose.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
SettingsClose.BackgroundTransparency = 0.1
SettingsClose.BorderColor3 = Color3.fromRGB(255, 100, 100)
SettingsClose.BorderSizePixel = 1
SettingsClose.Position = UDim2.new(0.85, 0, 0.02, 0)
SettingsClose.Size = UDim2.new(0, 32, 0, 32)
SettingsClose.Font = Enum.Font.GothamBold
SettingsClose.Text = "✕"
SettingsClose.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsClose.TextSize = 22

local setCloseCorner = Instance.new("UICorner")
setCloseCorner.CornerRadius = UDim.new(0, 12)
setCloseCorner.Parent = SettingsClose

SettingsClose.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = false
end)

-- Количество кейсов
AmountLabel.Parent = SettingsFrame
AmountLabel.BackgroundTransparency = 1
AmountLabel.Position = UDim2.new(0.05, 0, 0.10, 0)
AmountLabel.Size = UDim2.new(0, 200, 0, 30)
AmountLabel.Font = Enum.Font.Gotham
AmountLabel.Text = "📦 Кейсов для открытия:"
AmountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountLabel.TextSize = 14

AmountBox.Parent = SettingsFrame
AmountBox.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
AmountBox.BorderColor3 = Color3.fromRGB(255, 200, 0)
AmountBox.BorderSizePixel = 2
AmountBox.Position = UDim2.new(0.05, 0, 0.17, 0)
AmountBox.Size = UDim2.new(0, 310, 0, 40)
AmountBox.Font = Enum.Font.Gotham
AmountBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
AmountBox.PlaceholderText = "Введите число (например 1000)"
AmountBox.Text = "1000"
AmountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountBox.TextSize = 16

AmountCorner.CornerRadius = UDim.new(0, 12)
AmountCorner.Parent = AmountBox

AmountBox.FocusLost:Connect(function()
    local num = tonumber(AmountBox.Text)
    if num and num > 0 then
        casesToOpen = math.floor(num)
        AmountBox.Text = tostring(casesToOpen)
        openedCount = 0
        ProgressLabel.Text = "📊 Прогресс: 0 / " .. casesToOpen
        StatsLabel.Text = "📊 Открыто: 0 | Осталось: " .. casesToOpen
    else
        casesToOpen = 1000
        AmountBox.Text = "1000"
    end
end)

-- Тумблер продажи
SellToggle.Parent = SettingsFrame
SellToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SellToggle.BorderColor3 = Color3.fromRGB(255, 100, 100)
SellToggle.BorderSizePixel = 2
SellToggle.Position = UDim2.new(0.05, 0, 0.30, 0)
SellToggle.Size = UDim2.new(0, 310, 0, 38)
SellToggle.Font = Enum.Font.GothamBold
SellToggle.Text = "🔴 ПРОДАЖА: ВЫКЛ"
SellToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
SellToggle.TextSize = 16

local sellCorner = Instance.new("UICorner")
sellCorner.CornerRadius = UDim.new(0, 10)
sellCorner.Parent = SellToggle

-- Заголовок скорости
local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Parent = SettingsFrame
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Position = UDim2.new(0.05, 0, 0.42, 0)
SpeedTitle.Size = UDim2.new(0, 200, 0, 25)
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.Text = "⚡ СКОРОСТЬ ОТКРЫТИЯ:"
SpeedTitle.TextColor3 = Color3.fromRGB(255, 200, 100)
SpeedTitle.TextSize = 14

-- Кнопки скорости
SpeedSlow.Parent = SettingsFrame
SpeedSlow.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SpeedSlow.BorderColor3 = Color3.fromRGB(100, 100, 255)
SpeedSlow.BorderSizePixel = 2
SpeedSlow.Position = UDim2.new(0.05, 0, 0.49, 0)
SpeedSlow.Size = UDim2.new(0, 95, 0, 35)
SpeedSlow.Font = Enum.Font.GothamBold
SpeedSlow.Text = "🐢 МЕДЛЕННО"
SpeedSlow.TextColor3 = Color3.fromRGB(150, 150, 255)
SpeedSlow.TextSize = 12

local slowCorner = Instance.new("UICorner")
slowCorner.CornerRadius = UDim.new(0, 10)
slowCorner.Parent = SpeedSlow

SpeedMedium.Parent = SettingsFrame
SpeedMedium.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
SpeedMedium.BorderColor3 = Color3.fromRGB(0, 255, 150)
SpeedMedium.BorderSizePixel = 2
SpeedMedium.Position = UDim2.new(0.38, 0, 0.49, 0)
SpeedMedium.Size = UDim2.new(0, 95, 0, 35)
SpeedMedium.Font = Enum.Font.GothamBold
SpeedMedium.Text = "⚡ СРЕДНЕ"
SpeedMedium.TextColor3 = Color3.fromRGB(0, 255, 150)
SpeedMedium.TextSize = 12

local mediumCorner = Instance.new("UICorner")
mediumCorner.CornerRadius = UDim.new(0, 10)
mediumCorner.Parent = SpeedMedium

SpeedFast.Parent = SettingsFrame
SpeedFast.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SpeedFast.BorderColor3 = Color3.fromRGB(255, 100, 100)
SpeedFast.BorderSizePixel = 2
SpeedFast.Position = UDim2.new(0.71, 0, 0.49, 0)
SpeedFast.Size = UDim2.new(0, 95, 0, 35)
SpeedFast.Font = Enum.Font.GothamBold
SpeedFast.Text = "🔥 БЫСТРО"
SpeedFast.TextColor3 = Color3.fromRGB(255, 100, 100)
SpeedFast.TextSize = 12

local fastCorner = Instance.new("UICorner")
fastCorner.CornerRadius = UDim.new(0, 10)
fastCorner.Parent = SpeedFast

-- Информация о скорости
local SpeedInfo = Instance.new("TextLabel")
SpeedInfo.Parent = SettingsFrame
SpeedInfo.BackgroundTransparency = 1
SpeedInfo.Position = UDim2.new(0.05, 0, 0.57, 0)
SpeedInfo.Size = UDim2.new(0, 310, 0, 25)
SpeedInfo.Font = Enum.Font.Gotham
SpeedInfo.Text = "Текущая: СРЕДНЕ (задержка 2 сек)"
SpeedInfo.TextColor3 = Color3.fromRGB(0, 200, 255)
SpeedInfo.TextSize = 12

-- Прогресс
ProgressLabel.Parent = SettingsFrame
ProgressLabel.BackgroundTransparency = 1
ProgressLabel.Position = UDim2.new(0.05, 0, 0.65, 0)
ProgressLabel.Size = UDim2.new(0, 310, 0, 30)
ProgressLabel.Font = Enum.Font.Gotham
ProgressLabel.Text = "📊 Прогресс: 0 / " .. casesToOpen
ProgressLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
ProgressLabel.TextSize = 13

-- Авторы
CreditsLabel.Parent = SettingsFrame
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Position = UDim2.new(0.05, 0, 0.78, 0)
CreditsLabel.Size = UDim2.new(0, 310, 0, 50)
CreditsLabel.Font = Enum.Font.Gotham
CreditsLabel.Text = "👑 СОЗДАТЕЛИ:\n   @NoMentalProblem & @Vezqx"
CreditsLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
CreditsLabel.TextSize = 13
CreditsLabel.TextYAlignment = Enum.TextYAlignment.Top

-- Функция обновления UI скорости
local function updateSpeedUI()
    if speedMode == "slow" then
        SpeedSlow.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
        SpeedSlow.BorderColor3 = Color3.fromRGB(0, 200, 255)
        SpeedMedium.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SpeedMedium.BorderColor3 = Color3.fromRGB(100, 100, 255)
        SpeedFast.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SpeedFast.BorderColor3 = Color3.fromRGB(255, 100, 100)
        SpeedInfo.Text = "Текущая: МЕДЛЕННО (задержка 3.5 сек)"
        SpeedLabel.Text = "⚡ Скорость: МЕДЛЕННО (3.5 сек)"
    elseif speedMode == "medium" then
        SpeedSlow.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SpeedSlow.BorderColor3 = Color3.fromRGB(100, 100, 255)
        SpeedMedium.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        SpeedMedium.BorderColor3 = Color3.fromRGB(0, 255, 150)
        SpeedFast.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SpeedFast.BorderColor3 = Color3.fromRGB(255, 100, 100)
        SpeedInfo.Text = "Текущая: СРЕДНЕ (задержка 2 сек)"
        SpeedLabel.Text = "⚡ Скорость: СРЕДНЕ (2 сек)"
    elseif speedMode == "fast" then
        SpeedSlow.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SpeedSlow.BorderColor3 = Color3.fromRGB(100, 100, 255)
        SpeedMedium.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SpeedMedium.BorderColor3 = Color3.fromRGB(100, 100, 255)
        SpeedFast.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        SpeedFast.BorderColor3 = Color3.fromRGB(255, 100, 100)
        SpeedInfo.Text = "Текущая: БЫСТРО (задержка 0.8 сек)"
        SpeedLabel.Text = "⚡ Скорость: БЫСТРО (0.8 сек)"
    end
end

-- Обработчики скорости
SpeedSlow.MouseButton1Click:Connect(function()
    speedMode = "slow"
    updateSpeedUI()
end)

SpeedMedium.MouseButton1Click:Connect(function()
    speedMode = "medium"
    updateSpeedUI()
end)

SpeedFast.MouseButton1Click:Connect(function()
    speedMode = "fast"
    updateSpeedUI()
end)

-- Функция обновления UI продажи
local function updateSellUI()
    if sellEnabled then
        SellToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        SellToggle.BorderColor3 = Color3.fromRGB(0, 255, 100)
        SellToggle.Text = "🟢 ПРОДАЖА: ВКЛ"
        SellToggle.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        SellToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SellToggle.BorderColor3 = Color3.fromRGB(255, 100, 100)
        SellToggle.Text = "🔴 ПРОДАЖА: ВЫКЛ"
        SellToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end

SellToggle.MouseButton1Click:Connect(function()
    sellEnabled = not sellEnabled
    updateSellUI()
end)

-- Кнопка открытия настроек
SettingsBtn.MouseButton1Click:Connect(function()
    updateSpeedUI()
    ProgressLabel.Text = "📊 Прогресс: " .. openedCount .. " / " .. casesToOpen
    SettingsFrame.Visible = true
end)

-- ============ МЕНЮ ВЫБОРА КЕЙСОВ (4 штуки) ============
local CaseMenu = Instance.new("Frame")
local CaseMenuCorner = Instance.new("UICorner")
local CaseMenuGradient = Instance.new("UIGradient")
local CaseMenuClose = Instance.new("TextButton")
local CaseMenuTitle = Instance.new("TextLabel")
local CaseListFrame = Instance.new("ScrollingFrame")
local CaseListLayout = Instance.new("UIListLayout")
local CaseDrag = Instance.new("UIDragDetector")

CaseMenu.Parent = ScreenGui
CaseMenu.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
CaseMenu.BackgroundTransparency = 0.100
CaseMenu.BorderColor3 = Color3.fromRGB(255, 100, 255)
CaseMenu.BorderSizePixel = 3
CaseMenu.Position = UDim2.new(0.35, 0, 0.18, 0)
CaseMenu.Size = UDim2.new(0, 300, 0, 320)
CaseMenu.Visible = false
CaseMenu.Active = true
CaseMenu.Draggable = true

CaseDrag.Parent = CaseMenu

CaseMenuCorner.CornerRadius = UDim.new(0, 25)
CaseMenuCorner.Parent = CaseMenu

CaseMenuGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 0, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
})
CaseMenuGradient.Rotation = 45
CaseMenuGradient.Parent = CaseMenu

CaseMenuTitle.Parent = CaseMenu
CaseMenuTitle.BackgroundTransparency = 1
CaseMenuTitle.Position = UDim2.new(0.05, 0, 0.02, 0)
CaseMenuTitle.Size = UDim2.new(0, 200, 0, 40)
CaseMenuTitle.Font = Enum.Font.GothamBold
CaseMenuTitle.Text = "🎲 ВЫБЕРИ КЕЙС"
CaseMenuTitle.TextColor3 = Color3.fromRGB(255, 100, 255)
CaseMenuTitle.TextSize = 22

CaseMenuClose.Parent = CaseMenu
CaseMenuClose.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CaseMenuClose.BackgroundTransparency = 0.1
CaseMenuClose.BorderColor3 = Color3.fromRGB(255, 100, 100)
CaseMenuClose.BorderSizePixel = 1
CaseMenuClose.Position = UDim2.new(0.83, 0, 0.02, 0)
CaseMenuClose.Size = UDim2.new(0, 32, 0, 32)
CaseMenuClose.Font = Enum.Font.GothamBold
CaseMenuClose.Text = "✕"
CaseMenuClose.TextColor3 = Color3.fromRGB(255, 255, 255)
CaseMenuClose.TextSize = 22

local caseCloseCorner = Instance.new("UICorner")
caseCloseCorner.CornerRadius = UDim.new(0, 12)
caseCloseCorner.Parent = CaseMenuClose

CaseMenuClose.MouseButton1Click:Connect(function()
    CaseMenu.Visible = false
end)

-- Скролл фрейм для кейсов
CaseListFrame.Parent = CaseMenu
CaseListFrame.BackgroundTransparency = 1
CaseListFrame.Position = UDim2.new(0.05, 0, 0.12, 0)
CaseListFrame.Size = UDim2.new(0, 270, 0, 240)
CaseListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
CaseListFrame.ScrollBarThickness = 5

CaseListLayout.Parent = CaseListFrame
CaseListLayout.SortOrder = Enum.SortOrder.LayoutOrder
CaseListLayout.Padding = UDim.new(0, 8)

-- Функция создания кнопок для кейсов
local function createCaseButton(caseName)
    local btn = Instance.new("TextButton")
    btn.Parent = CaseListFrame
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
    btn.BorderColor3 = Color3.fromRGB(255, 100, 255)
    btn.BorderSizePixel = 1
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Font = Enum.Font.GothamBold
    btn.Text = caseName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        selectedCase = caseName
        SelectedCaseLabel.Text = "✅ Выбран: " .. selectedCase
        openedCount = 0
        ProgressLabel.Text = "📊 Прогресс: 0 / " .. casesToOpen
        StatsLabel.Text = "📊 Открыто: 0 | Осталось: " .. casesToOpen
        CaseMenu.Visible = false
    end)
end

for _, caseName in ipairs(cases) do
    createCaseButton(caseName)
end

SelectCaseBtn.MouseButton1Click:Connect(function()
    CaseMenu.Visible = true
end)

-- ============ ЛОГИКА ФАРМА ============
local function updateStats()
    local remaining = casesToOpen - openedCount
    if remaining < 0 then remaining = 0 end
    StatsLabel.Text = "📊 Открыто: " .. openedCount .. " | Осталось: " .. remaining
    ProgressLabel.Text = "📊 Прогресс: " .. openedCount .. " / " .. casesToOpen
end

Auto.MouseButton1Click:Connect(function()
    if on == 0 then
        if openedCount >= casesToOpen then
            openedCount = 0
            updateStats()
        end
        
        on = 1
        Auto.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        Auto.Text = "⏹ СТОП ФАРМ"
        
        task.spawn(function()
            while on == 1 and openedCount < casesToOpen do
                pcall(function()
                    local args = {selectedCase, 10}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("OpenCase"):InvokeServer(unpack(args))
                    openedCount = openedCount + 10
                    updateStats()
                    
                    if sellEnabled then
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Inventory"):FireServer("Sell", "ALL")
                    end
                end)
                task.wait(speedDelays[speedMode])
            end
            
            if openedCount >= casesToOpen then
                on = 0
                Auto.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
                Auto.Text = "▶ СТАРТ ФАРМ"
            end
        end)
    else
        on = 0
        Auto.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        Auto.Text = "▶ СТАРТ ФАРМ"
    end
end)

-- Неон-анимация
task.spawn(function()
    local ticker = 0
    while true do
        ticker = ticker + 0.02
        local intensity = (math.sin(ticker) + 1) / 4 + 0.5
        Frame.BorderColor3 = Color3.new(intensity, intensity * 0.5, 1)
        task.wait(0.05)
    end
end)

updateSellUI()
updateSpeedUI()
updateStats()

