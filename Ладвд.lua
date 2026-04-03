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
local totalOpened = 0 -- Счётчик открытых кейсов
local speedDelay = 0.1 -- Скорость по умолчанию

-- ВСЕ 5 КЕЙСОВ
local cases = {"Photon Core", "Marina", "Cursed Demon", "Heavenfall", "Bloody Night"}

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ============ ОСНОВНОЕ МЕНЮ ============
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
Frame.BackgroundTransparency = 0.100
Frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
Frame.BorderSizePixel = 3
Frame.Position = UDim2.new(0.35, 0, 0.25, 0)
Frame.Size = UDim2.new(0, 320, 0, 320)
Frame.Active = true
Frame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = Frame

dd.Parent = Frame

-- Неон-градиент
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 255)),
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
Label.Text = "⚡ TON BATTLE ⚡"
Label.TextColor3 = Color3.fromRGB(0, 255, 255)
Label.TextSize = 26

-- Кнопка выбора кейса
SelectCaseBtn.Parent = Frame
SelectCaseBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
SelectCaseBtn.BorderColor3 = Color3.fromRGB(0, 255, 255)
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
SelectedCaseLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
SelectedCaseLabel.TextSize = 13

-- Кнопка настроек
SettingsBtn.Parent = Frame
SettingsBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
SettingsBtn.BorderColor3 = Color3.fromRGB(255, 200, 0)
SettingsBtn.BorderSizePixel = 2
SettingsBtn.Position = UDim2.new(0.05, 0, 0.28, 0)
SettingsBtn.Size = UDim2.new(0, 290, 0, 40)
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.Text = "⚙ НАСТРОЙКИ"
SettingsBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
SettingsBtn.TextSize = 16

local setBtnCorner = Instance.new("UICorner")
setBtnCorner.CornerRadius = UDim.new(0, 12)
setBtnCorner.Parent = SettingsBtn

-- Кнопка старт/стоп
Auto.Parent = Frame
Auto.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
Auto.BorderColor3 = Color3.fromRGB(0, 255, 150)
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
CounterLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
CounterLabel.TextSize = 13

-- Подвал с авторами и ссылкой
local Footer = Instance.new("TextLabel")
Footer.Parent = Frame
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(0.05, 0, 0.85, 0)
Footer.Size = UDim2.new(0, 290, 0, 40)
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
local SpeedLabel = Instance.new("TextLabel")
local SpeedSlider = Instance.new("TextBox")
local SpeedValue = Instance.new("TextLabel")
local SellToggleSet = Instance.new("TextButton")
local SellStatusSet = Instance.new("TextLabel")
local TotalOpenedLabel = Instance.new("TextLabel")
local CreditsLabel = Instance.new("TextLabel")
local TelegramBtn = Instance.new("TextButton")
local SettingsDrag = Instance.new("UIDragDetector")

SettingsFrame.Parent = ScreenGui
SettingsFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
SettingsFrame.BackgroundTransparency = 0.100
SettingsFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
SettingsFrame.BorderSizePixel = 3
SettingsFrame.Position = UDim2.new(0.35, 0, 0.20, 0)
SettingsFrame.Size = UDim2.new(0, 340, 0, 380)
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

-- Настройка скорости
SpeedLabel.Parent = SettingsFrame
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0.05, 0, 0.11, 0)
SpeedLabel.Size = UDim2.new(0, 200, 0, 30)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Text = "⚡ СКОРОСТЬ ОТКРЫТИЯ:"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 14

SpeedSlider.Parent = SettingsFrame
SpeedSlider.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
SpeedSlider.BorderColor3 = Color3.fromRGB(255, 200, 0)
SpeedSlider.BorderSizePixel = 2
SpeedSlider.Position = UDim2.new(0.05, 0, 0.18, 0)
SpeedSlider.Size = UDim2.new(0, 200, 0, 40)
SpeedSlider.Font = Enum.Font.Gotham
SpeedSlider.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
SpeedSlider.PlaceholderText = "0.1 - 5.0"
SpeedSlider.Text = "0.1"
SpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedSlider.TextSize = 16

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 12)
sliderCorner.Parent = SpeedSlider

SpeedValue.Parent = SettingsFrame
SpeedValue.BackgroundTransparency = 1
SpeedValue.Position = UDim2.new(0.72, 0, 0.18, 0)
SpeedValue.Size = UDim2.new(0, 80, 0, 40)
SpeedValue.Font = Enum.Font.Gotham
SpeedValue.Text = "сек"
SpeedValue.TextColor3 = Color3.fromRGB(0, 255, 200)
SpeedValue.TextSize = 14
SpeedValue.TextXAlignment = Enum.TextXAlignment.Left

SpeedSlider.FocusLost:Connect(function()
    local num = tonumber(SpeedSlider.Text)
    if num and num >= 0.05 and num <= 10 then
        speedDelay = num
        SpeedSlider.Text = tostring(speedDelay)
        if on == 1 then
            FarmStatus.Text = "⚡ Статус: ФАРМ АКТИВЕН (" .. speedDelay .. " сек)"
        end
    else
        speedDelay = 0.1
        SpeedSlider.Text = "0.1"
    end
end)

-- Тумблер продажи в настройках
SellToggleSet.Parent = SettingsFrame
SellToggleSet.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SellToggleSet.BorderColor3 = Color3.fromRGB(255, 100, 100)
SellToggleSet.BorderSizePixel = 2
SellToggleSet.Position = UDim2.new(0.05, 0, 0.32, 0)
SellToggleSet.Size = UDim2.new(0, 150, 0, 38)
SellToggleSet.Font = Enum.Font.GothamBold
SellToggleSet.Text = "🔴 SELL: OFF"
SellToggleSet.TextColor3 = Color3.fromRGB(255, 100, 100)
SellToggleSet.TextSize = 14

local sellSetCorner = Instance.new("UICorner")
sellSetCorner.CornerRadius = UDim.new(0, 10)
sellSetCorner.Parent = SellToggleSet

SellStatusSet.Parent = SettingsFrame
SellStatusSet.BackgroundTransparency = 1
SellStatusSet.Position = UDim2.new(0.55, 0, 0.32, 0)
SellStatusSet.Size = UDim2.new(0, 140, 0, 38)
SellStatusSet.Font = Enum.Font.Gotham
SellStatusSet.Text = "❌ Выключена"
SellStatusSet.TextColor3 = Color3.fromRGB(200, 200, 200)
SellStatusSet.TextSize = 13
SellStatusSet.TextXAlignment = Enum.TextXAlignment.Left

-- Общий счётчик открытых кейсов
TotalOpenedLabel.Parent = SettingsFrame
TotalOpenedLabel.BackgroundTransparency = 1
TotalOpenedLabel.Position = UDim2.new(0.05, 0, 0.48, 0)
TotalOpenedLabel.Size = UDim2.new(0, 310, 0, 30)
TotalOpenedLabel.Font = Enum.Font.GothamBold
TotalOpenedLabel.Text = "📊 ВСЕГО ОТКРЫТО: 0 КЕЙСОВ"
TotalOpenedLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
TotalOpenedLabel.TextSize = 14

-- Кнопка Telegram
TelegramBtn.Parent = SettingsFrame
TelegramBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
TelegramBtn.BorderColor3 = Color3.fromRGB(0, 200, 255)
TelegramBtn.BorderSizePixel = 2
TelegramBtn.Position = UDim2.new(0.05, 0, 0.62, 0)
TelegramBtn.Size = UDim2.new(0, 310, 0, 40)
TelegramBtn.Font = Enum.Font.GothamBold
TelegramBtn.Text = "📢 TELEGRAM КАНАЛ"
TelegramBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TelegramBtn.TextSize = 16

local tgCorner = Instance.new("UICorner")
tgCorner.CornerRadius = UDim.new(0, 12)
tgCorner.Parent = TelegramBtn

TelegramBtn.MouseButton1Click:Connect(function()
    setclipboard or toclipboard or function() end
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
CreditsLabel.Position = UDim2.new(0.05, 0, 0.78, 0)
CreditsLabel.Size = UDim2.new(0, 310, 0, 45)
CreditsLabel.Font = Enum.Font.Gotham
CreditsLabel.Text = "👑 СОЗДАТЕЛИ:\n   @NoMentalProblem & @Vezqx"
CreditsLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
CreditsLabel.TextSize = 12
CreditsLabel.TextYAlignment = Enum.TextYAlignment.Top

-- ============ МЕНЮ ВЫБОРА КЕЙСОВ (5 штук) ============
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
CaseMenu.Position = UDim2.new(0.35, 0, 0.25, 0)
CaseMenu.Size = UDim2.new(0, 280, 0, 320)
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
CaseMenuTitle.Size = UDim2.new(0, 200, 0, 35)
CaseMenuTitle.Font = Enum.Font.GothamBold
CaseMenuTitle.Text = "🎲 ВЫБЕРИ КЕЙС"
CaseMenuTitle.TextColor3 = Color3.fromRGB(255, 100, 255)
CaseMenuTitle.TextSize = 20

CaseMenuClose.Parent = CaseMenu
CaseMenuClose.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CaseMenuClose.BackgroundTransparency = 0.1
CaseMenuClose.BorderColor3 = Color3.fromRGB(255, 100, 100)
CaseMenuClose.BorderSizePixel = 1
CaseMenuClose.Position = UDim2.new(0.85, 0, 0.02, 0)
CaseMenuClose.Size = UDim2.new(0, 30, 0, 30)
CaseMenuClose.Font = Enum.Font.GothamBold
CaseMenuClose.Text = "✕"
CaseMenuClose.TextColor3 = Color3.fromRGB(255, 255, 255)
CaseMenuClose.TextSize = 20

local caseCloseCorner = Instance.new("UICorner")
caseCloseCorner.CornerRadius = UDim.new(0, 10)
caseCloseCorner.Parent = CaseMenuClose

CaseMenuClose.MouseButton1Click:Connect(function()
    CaseMenu.Visible = false
end)

-- Скролл фрейм
CaseListFrame.Parent = CaseMenu
CaseListFrame.BackgroundTransparency = 1
CaseListFrame.Position = UDim2.new(0.05, 0, 0.12, 0)
CaseListFrame.Size = UDim2.new(0, 250, 0, 240)
CaseListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
CaseListFrame.ScrollBarThickness = 5

CaseListLayout.Parent = CaseListFrame
CaseListLayout.SortOrder = Enum.SortOrder.LayoutOrder
CaseListLayout.Padding = UDim.new(0, 8)

-- Создание кнопок для кейсов
local function createCaseButton(caseName)
    local btn = Instance.new("TextButton")
    btn.Parent = CaseListFrame
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
    btn.BorderColor3 = Color3.fromRGB(255, 100, 255)
    btn.BorderSizePixel = 1
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.Font = Enum.Font.GothamBold
    btn.Text = caseName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 15
    
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

-- ============ ФУНКЦИИ ============
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

-- Кнопка открытия настроек
SettingsBtn.MouseButton1Click:Connect(function()
    TotalOpenedLabel.Text = "📊 ВСЕГО ОТКРЫТО: " .. totalOpened .. " КЕЙСОВ"
    SettingsFrame.Visible = true
end)

-- Обновление счётчика
local function updateCounter()
    CounterLabel.Text = "📊 Всего открыто: " .. totalOpened .. " кейсов"
    TotalOpenedLabel.Text = "📊 ВСЕГО ОТКРЫТО: " .. totalOpened .. " КЕЙСОВ"
end

-- ОСНОВНАЯ ЛОГИКА ФАРМА
Auto.MouseButton1Click:Connect(function()
    if on == 0 then
        on = 1
        Auto.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        Auto.Text = "⏹ СТОП ФАРМ"
        FarmStatus.Text = "⚡ Статус: ФАРМ АКТИВЕН (" .. speedDelay .. " сек)"
        FarmStatus.TextColor3 = Color3.fromRGB(0, 255, 100)
        
        task.spawn(function()
            while on == 1 do
                pcall(function()
                    -- Открытие кейса (10 шт за раз)
                    local args = {selectedCase, 10}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("OpenCase"):InvokeServer(unpack(args))
                    totalOpened = totalOpened + 10
                    updateCounter()
                    
                    -- Автопродажа если включена
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
        Frame.BorderColor3 = Color3.new(intensity, intensity * 0.5, 1)
        task.wait(0.05)
    end
end)

updateSellUI()
updateCounter()
