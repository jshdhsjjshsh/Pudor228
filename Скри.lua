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
local SettingsBtn = Instance.new("TextButton")
local dd = Instance.new("UIDragDetector")

-- Переменные
local on = 0
local sellEnabled = false
local selectedCase = "Photon Core"
local totalOpened = 0
local speedDelay = 0.1

-- ВСЕ 28 КЕЙСОВ
local cases = {
    "Trash", "Daily", "Photon Core", "Divine", "Beggar", "Plodder", 
    "Office Clerk", "Manager", "Director", "Oligarch", "Frozen Heart", 
    "Bubble Gum", "Cats", "Glitch", "Dream", "Bloody Night", "Heavenfall", 
    "M5 F90", "G63", "Porsche 911", "URUS", "Gold", "Dark", "Palm", 
    "Burj", "Luxury", "Marina", "Cursed Demon"
}

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ============ ОСНОВНОЕ МЕНЮ (ФИОЛЕТОВЫЙ НЕОН) ============
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
Frame.BackgroundTransparency = 0.100
Frame.BorderColor3 = Color3.fromRGB(180, 0, 255)
Frame.BorderSizePixel = 3
Frame.Position = UDim2.new(0.35, 0, 0.25, 0)
Frame.Size = UDim2.new(0, 320, 0, 340)
Frame.Active = true
Frame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = Frame

dd.Parent = Frame

-- Фиолетовый неон-градиент
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 0, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 255))
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
Label.Text = "⚡ TON BATTLE ⚡"
Label.TextColor3 = Color3.fromRGB(180, 0, 255)
Label.TextSize = 26

-- Кнопка выбора кейса
SelectCaseBtn.Parent = Frame
SelectCaseBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
SelectCaseBtn.BorderColor3 = Color3.fromRGB(180, 0, 255)
SelectCaseBtn.BorderSizePixel = 2
SelectCaseBtn.Position = UDim2.new(0.05, 0, 0.11, 0)
SelectCaseBtn.Size = UDim2.new(0, 290, 0, 40)
SelectCaseBtn.Font = Enum.Font.GothamBold
SelectCaseBtn.Text = "🎲 ВЫБРАТЬ КЕЙС"
SelectCaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectCaseBtn.TextSize = 16

local selectCorner = Instance.new("UICorner")
selectCorner.CornerRadius = UDim.new(0, 12)
selectCorner.Parent = SelectCaseBtn

-- Метка выбранного кейса
SelectedCaseLabel.Parent = Frame
SelectedCaseLabel.BackgroundTransparency = 1
SelectedCaseLabel.Position = UDim2.new(0.05, 0, 0.20, 0)
SelectedCaseLabel.Size = UDim2.new(0, 290, 0, 22)
SelectedCaseLabel.Font = Enum.Font.Gotham
SelectedCaseLabel.Text = "✅ Выбран: " .. selectedCase
SelectedCaseLabel.TextColor3 = Color3.fromRGB(180, 0, 255)
SelectedCaseLabel.TextSize = 13

-- Кнопка настроек
SettingsBtn.Parent = Frame
SettingsBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
SettingsBtn.BorderColor3 = Color3.fromRGB(180, 0, 255)
SettingsBtn.BorderSizePixel = 2
SettingsBtn.Position = UDim2.new(0.05, 0, 0.28, 0)
SettingsBtn.Size = UDim2.new(0, 290, 0, 40)
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.Text = "⚙ НАСТРОЙКИ"
SettingsBtn.TextColor3 = Color3.fromRGB(180, 0, 255)
SettingsBtn.TextSize = 16

local setBtnCorner = Instance.new("UICorner")
setBtnCorner.CornerRadius = UDim.new(0, 12)
setBtnCorner.Parent = SettingsBtn

-- Кнопка старт/стоп
Auto.Parent = Frame
Auto.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
Auto.BorderColor3 = Color3.fromRGB(180, 0, 255)
Auto.BorderSizePixel = 3
Auto.Position = UDim2.new(0.05, 0, 0.45, 0)
Auto.Size = UDim2.new(0, 290, 0, 50)
Auto.Font = Enum.Font.GothamBold
Auto.Text = "▶ СТАРТ ФАРМ"
Auto.TextColor3 = Color3.fromRGB(255, 255, 255)
Auto.TextSize = 22

UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = Auto

-- Статус фарма
local FarmStatus = Instance.new("TextLabel")
FarmStatus.Parent = Frame
FarmStatus.BackgroundTransparency = 1
FarmStatus.Position = UDim2.new(0.05, 0, 0.63, 0)
FarmStatus.Size = UDim2.new(0, 290, 0, 22)
FarmStatus.Font = Enum.Font.Gotham
FarmStatus.Text = "⚡ Статус: Остановлен"
FarmStatus.TextColor3 = Color3.fromRGB(150, 150, 200)
FarmStatus.TextSize = 13

-- Счётчик открытых кейсов
local CounterLabel = Instance.new("TextLabel")
CounterLabel.Parent = Frame
CounterLabel.BackgroundTransparency = 1
CounterLabel.Position = UDim2.new(0.05, 0, 0.72, 0)
CounterLabel.Size = UDim2.new(0, 290, 0, 22)
CounterLabel.Font = Enum.Font.Gotham
CounterLabel.Text = "📊 Всего открыто: 0 кейсов"
CounterLabel.TextColor3 = Color3.fromRGB(180, 0, 255)
CounterLabel.TextSize = 13

-- Подвал с авторами
local Footer = Instance.new("TextLabel")
Footer.Parent = Frame
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(0.05, 0, 0.85, 0)
Footer.Size = UDim2.new(0, 290, 0, 35)
Footer.Font = Enum.Font.Gotham
Footer.Text = "👑 @NoMentalProblem & @Vezqx\n📢 t.me/TonBattleScript"
Footer.TextColor3 = Color3.fromRGB(100, 100, 180)
Footer.TextSize = 11
Footer.TextYAlignment = Enum.TextYAlignment.Top

-- ============ МЕНЮ НАСТРОЕК ============
local SettingsFrame = Instance.new("Frame")
local SettingsCorner = Instance.new("UICorner")
local SettingsGradient = Instance.new("UIGradient")
local SettingsTitle = Instance.new("TextLabel")
local SettingsClose = Instance.new("TextButton")
local SpeedTitle = Instance.new("TextLabel")
local SpeedBtn1 = Instance.new("TextButton")
local SpeedBtn05 = Instance.new("TextButton")
local SpeedBtn01 = Instance.new("TextButton")
local SellToggleSet = Instance.new("TextButton")
local SellStatusSet = Instance.new("TextLabel")
local TotalOpenedLabel = Instance.new("TextLabel")
local TelegramBtn = Instance.new("TextButton")
local CreditsLabel = Instance.new("TextLabel")
local SettingsDrag = Instance.new("UIDragDetector")

SettingsFrame.Parent = ScreenGui
SettingsFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
SettingsFrame.BackgroundTransparency = 0.100
SettingsFrame.BorderColor3 = Color3.fromRGB(180, 0, 255)
SettingsFrame.BorderSizePixel = 3
SettingsFrame.Position = UDim2.new(0.35, 0, 0.20, 0)
SettingsFrame.Size = UDim2.new(0, 340, 0, 420)
SettingsFrame.Visible = false
SettingsFrame.Active = true
SettingsFrame.Draggable = true

SettingsDrag.Parent = SettingsFrame

SettingsCorner.CornerRadius = UDim.new(0, 25)
SettingsCorner.Parent = SettingsFrame

SettingsGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 0, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 255))
})
SettingsGradient.Rotation = 45
SettingsGradient.Parent = SettingsFrame

SettingsTitle.Parent = SettingsFrame
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Position = UDim2.new(0.05, 0, 0.02, 0)
SettingsTitle.Size = UDim2.new(0, 250, 0, 40)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.Text = "⚙ НАСТРОЙКИ"
SettingsTitle.TextColor3 = Color3.fromRGB(180, 0, 255)
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

-- Настройка скорости
SpeedTitle.Parent = SettingsFrame
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Position = UDim2.new(0.05, 0, 0.11, 0)
SpeedTitle.Size = UDim2.new(0, 300, 0, 30)
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.Text = "⚡ СКОРОСТЬ ОТКРЫТИЯ:"
SpeedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedTitle.TextSize = 14

SpeedBtn1.Parent = SettingsFrame
SpeedBtn1.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SpeedBtn1.BorderColor3 = Color3.fromRGB(180, 0, 255)
SpeedBtn1.BorderSizePixel = 2
SpeedBtn1.Position = UDim2.new(0.05, 0, 0.19, 0)
SpeedBtn1.Size = UDim2.new(0, 95, 0, 45)
SpeedBtn1.Font = Enum.Font.GothamBold
SpeedBtn1.Text = "🐢 1 СЕК"
SpeedBtn1.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn1.TextSize = 14

local btn1Corner = Instance.new("UICorner")
btn1Corner.CornerRadius = UDim.new(0, 12)
btn1Corner.Parent = SpeedBtn1

SpeedBtn05.Parent = SettingsFrame
SpeedBtn05.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SpeedBtn05.BorderColor3 = Color3.fromRGB(180, 0, 255)
SpeedBtn05.BorderSizePixel = 2
SpeedBtn05.Position = UDim2.new(0.38, 0, 0.19, 0)
SpeedBtn05.Size = UDim2.new(0, 95, 0, 45)
SpeedBtn05.Font = Enum.Font.GothamBold
SpeedBtn05.Text = "⚡ 0.5 СЕК"
SpeedBtn05.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn05.TextSize = 14

local btn05Corner = Instance.new("UICorner")
btn05Corner.CornerRadius = UDim.new(0, 12)
btn05Corner.Parent = SpeedBtn05

SpeedBtn01.Parent = SettingsFrame
SpeedBtn01.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
SpeedBtn01.BorderColor3 = Color3.fromRGB(180, 0, 255)
SpeedBtn01.BorderSizePixel = 2
SpeedBtn01.Position = UDim2.new(0.71, 0, 0.19, 0)
SpeedBtn01.Size = UDim2.new(0, 95, 0, 45)
SpeedBtn01.Font = Enum.Font.GothamBold
SpeedBtn01.Text = "🔥 0.1 СЕК"
SpeedBtn01.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn01.TextSize = 14

local btn01Corner = Instance.new("UICorner")
btn01Corner.CornerRadius = UDim.new(0, 12)
btn01Corner.Parent = SpeedBtn01

-- Текущая скорость
local CurrentSpeed = Instance.new("TextLabel")
CurrentSpeed.Parent = SettingsFrame
CurrentSpeed.BackgroundTransparency = 1
CurrentSpeed.Position = UDim2.new(0.05, 0, 0.30, 0)
CurrentSpeed.Size = UDim2.new(0, 300, 0, 25)
CurrentSpeed.Font = Enum.Font.Gotham
CurrentSpeed.Text = "Текущая скорость: 0.1 сек"
CurrentSpeed.TextColor3 = Color3.fromRGB(180, 0, 255)
CurrentSpeed.TextSize = 13

-- Тумблер продажи
SellToggleSet.Parent = SettingsFrame
SellToggleSet.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SellToggleSet.BorderColor3 = Color3.fromRGB(255, 100, 100)
SellToggleSet.BorderSizePixel = 2
SellToggleSet.Position = UDim2.new(0.05, 0, 0.40, 0)
SellToggleSet.Size = UDim2.new(0, 150, 0, 40)
SellToggleSet.Font = Enum.Font.GothamBold
SellToggleSet.Text = "🔴 SELL: OFF"
SellToggleSet.TextColor3 = Color3.fromRGB(255, 100, 100)
SellToggleSet.TextSize = 14

local sellSetCorner = Instance.new("UICorner")
sellSetCorner.CornerRadius = UDim.new(0, 10)
sellSetCorner.Parent = SellToggleSet

SellStatusSet.Parent = SettingsFrame
SellStatusSet.BackgroundTransparency = 1
SellStatusSet.Position = UDim2.new(0.55, 0, 0.40, 0)
SellStatusSet.Size = UDim2.new(0, 140, 0, 40)
SellStatusSet.Font = Enum.Font.Gotham
SellStatusSet.Text = "❌ Выключена"
SellStatusSet.TextColor3 = Color3.fromRGB(200, 200, 200)
SellStatusSet.TextSize = 13
SellStatusSet.TextXAlignment = Enum.TextXAlignment.Left

-- Общий счётчик
TotalOpenedLabel.Parent = SettingsFrame
TotalOpenedLabel.BackgroundTransparency = 1
TotalOpenedLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
TotalOpenedLabel.Size = UDim2.new(0, 310, 0, 30)
TotalOpenedLabel.Font = Enum.Font.GothamBold
TotalOpenedLabel.Text = "📊 ВСЕГО ОТКРЫТО: 0 КЕЙСОВ"
TotalOpenedLabel.TextColor3 = Color3.fromRGB(180, 0, 255)
TotalOpenedLabel.TextSize = 14

-- Кнопка Telegram
TelegramBtn.Parent = SettingsFrame
TelegramBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
TelegramBtn.BorderColor3 = Color3.fromRGB(180, 0, 255)
TelegramBtn.BorderSizePixel = 2
TelegramBtn.Position = UDim2.new(0.05, 0, 0.67, 0)
TelegramBtn.Size = UDim2.new(0, 310, 0, 40)
TelegramBtn.Font = Enum.Font.GothamBold
TelegramBtn.Text = "📢 TELEGRAM КАНАЛ"
TelegramBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TelegramBtn.TextSize = 16

local tgCorner = Instance.new("UICorner")
tgCorner.CornerRadius = UDim.new(0, 12)
tgCorner.Parent = TelegramBtn

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

-- Авторы
CreditsLabel.Parent = SettingsFrame
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Position = UDim2.new(0.05, 0, 0.82, 0)
CreditsLabel.Size = UDim2.new(0, 310, 0, 45)
CreditsLabel.Font = Enum.Font.Gotham
CreditsLabel.Text = "👑 СОЗДАТЕЛИ:\n   @NoMentalProblem & @Vezqx"
CreditsLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
CreditsLabel.TextSize = 12
CreditsLabel.TextYAlignment = Enum.TextYAlignment.Top

-- Обработчики скорости
local function updateSpeedUI()
    if speedDelay == 1 then
        SpeedBtn1.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
        SpeedBtn05.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SpeedBtn01.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        CurrentSpeed.Text = "Текущая скорость: 1 секунда"
    elseif speedDelay == 0.5 then
        SpeedBtn1.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SpeedBtn05.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
        SpeedBtn01.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        CurrentSpeed.Text = "Текущая скорость: 0.5 секунд"
    else
        SpeedBtn1.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SpeedBtn05.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SpeedBtn01.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        CurrentSpeed.Text = "Текущая скорость: 0.1 секунд"
    end
    if on == 1 then
        FarmStatus.Text = "⚡ Статус: ФАРМ АКТИВЕН (" .. speedDelay .. " сек)"
    end
end

SpeedBtn1.MouseButton1Click:Connect(function()
    speedDelay = 1
    updateSpeedUI()
end)

SpeedBtn05.MouseButton1Click:Connect(function()
    speedDelay = 0.5
    updateSpeedUI()
end)

SpeedBtn01.MouseButton1Click:Connect(function()
    speedDelay = 0.1
    updateSpeedUI()
end)

-- Функции продажи
local function updateSellUI()
    if sellEnabled then
        SellToggleSet.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        SellToggleSet.BorderColor3 = Color3.fromRGB(0, 255, 100)
        SellToggleSet.Text = "🟢 SELL: ON"
        SellToggleSet.TextColor3 = Color3.fromRGB(0, 255, 100)
        SellStatusSet.Text = "✅ Включена"
        SellStatusSet.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        SellToggleSet.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SellToggleSet.BorderColor3 = Color3.fromRGB(255, 100, 100)
        SellToggleSet.Text = "🔴 SELL: OFF"
        SellToggleSet.TextColor3 = Color3.fromRGB(255, 100, 100)
        SellStatusSet.Text = "❌ Выключена"
        SellStatusSet.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end

SellToggleSet.MouseButton1Click:Connect(function()
    sellEnabled = not sellEnabled
    updateSellUI()
end)

SettingsBtn.MouseButton1Click:Connect(function()
    TotalOpenedLabel.Text = "📊 ВСЕГО ОТКРЫТО: " .. totalOpened .. " КЕЙСОВ"
    SettingsFrame.Visible = true
end)

-- ============ МЕНЮ ВЫБОРА КЕЙСОВ (С ПРОКРУТКОЙ) ============
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
CaseMenu.BorderColor3 = Color3.fromRGB(180, 0, 255)
CaseMenu.BorderSizePixel = 3
CaseMenu.Position = UDim2.new(0.35, 0, 0.15, 0)
CaseMenu.Size = UDim2.new(0, 300, 0, 420)
CaseMenu.Visible = false
CaseMenu.Active = true
CaseMenu.Draggable = true

CaseDrag.Parent = CaseMenu

CaseMenuCorner.CornerRadius = UDim.new(0, 25)
CaseMenuCorner.Parent = CaseMenu

CaseMenuGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 0, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 255))
})
CaseMenuGradient.Rotation = 45
CaseMenuGradient.Parent = CaseMenu

CaseMenuTitle.Parent = CaseMenu
CaseMenuTitle.BackgroundTransparency = 1
CaseMenuTitle.Position = UDim2.new(0.05, 0, 0.02, 0)
CaseMenuTitle.Size = UDim2.new(0, 200, 0, 35)
CaseMenuTitle.Font = Enum.Font.GothamBold
CaseMenuTitle.Text = "🎲 ВЫБЕРИ КЕЙС"
CaseMenuTitle.TextColor3 = Color3.fromRGB(180, 0, 255)
CaseMenuTitle.TextSize = 20

CaseMenuClose.Parent = CaseMenu
CaseMenuClose.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CaseMenuClose.BackgroundTransparency = 0.1
CaseMenuClose.BorderColor3 = Color3.fromRGB(255, 100, 100)
CaseMenuClose.BorderSizePixel = 1
CaseMenuClose.Position = UDim2.new(0.85, 0, 0.02, 0)
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

-- Скролл фрейм для прокрутки
CaseListFrame.Parent = CaseMenu
CaseListFrame.BackgroundTransparency = 1
CaseListFrame.Position = UDim2.new(0.05, 0, 0.12, 0)
CaseListFrame.Size = UDim2.new(0, 270, 0, 340)
CaseListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
CaseListFrame.ScrollBarThickness = 6
CaseListFrame.ScrollBarImageColor3 = Color3.fromRGB(180, 0, 255)

CaseListLayout.Parent = CaseListFrame
CaseListLayout.SortOrder = Enum.SortOrder.LayoutOrder
CaseListLayout.Padding = UDim.new(0, 6)

-- Создание кнопок для всех 28 кейсов
local function createCaseButton(caseName)
    local btn = Instance.new("TextButton")
    btn.Parent = CaseListFrame
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
    btn.BorderColor3 = Color3.fromRGB(180, 0, 255)
    btn.BorderSizePixel = 1
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.Font = Enum.Font.GothamBold
    btn.Text = caseName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        selectedCase = caseName
        SelectedCaseLabel.Text = "✅ Выбран: " .. selectedCase
        CaseMenu.Visible = false
    end)
end

for _, caseName in ipairs(cases) do
    createCaseButton(caseName)
end

SelectCaseBtn.MouseButton1Click:Connect(function()
    CaseMenu.Visible = true
end)

-- ============ ОСНОВНАЯ ЛОГИКА ФАРМА ============
local function updateCounter()
    CounterLabel.Text = "📊 Всего открыто: " .. totalOpened .. " кейсов"
    TotalOpenedLabel.Text = "📊 ВСЕГО ОТКРЫТО: " .. totalOpened .. " КЕЙСОВ"
end

Auto.MouseButton1Click:Connect(function()
    if on == 0 then
        on = 1
        Auto.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        Auto.Text = "⏹ СТОП ФАРМ"
        FarmStatus.Text = "⚡ Статус: ФАРМ АКТИВЕН (" .. speedDelay .. " сек)"
        FarmStatus.TextColor3 = Color3.fromRGB(180, 0, 255)
        
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
                task.wait(speedDelay)
            end
        end)
    else
        on = 0
        Auto.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        Auto.Text = "▶ СТАРТ ФАРМ"
        FarmStatus.Text = "⚡ Статус: Остановлен"
        FarmStatus.TextColor3 = Color3.fromRGB(150, 150, 200)
    end
end)

-- Неон-анимация
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
updateSpeedUI()
updateCounter()
