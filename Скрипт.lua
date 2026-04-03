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
local casesToOpen = 1000 -- Количество кейсов для открытия
local openedCount = 0 -- Счётчик открытых кейсов

-- Список кейсов
local cases = {"Heavenfall", "URUS", "Bloody Night", "Photon Core", "Divine", "Marina", "Cursed Demon"}

-- ============ ОСНОВНОЕ МЕНЮ ============
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
Frame.BackgroundTransparency = 0.150
Frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
Frame.BorderSizePixel = 2
Frame.Position = UDim2.new(0.35, 0, 0.25, 0)
Frame.Size = UDim2.new(0, 320, 0, 360)

UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = Frame

UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
})
UIGradient.Rotation = 45
UIGradient.Parent = Frame

-- Кнопка закрытия
CloseBtn.Parent = Frame
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BackgroundTransparency = 0.2
CloseBtn.BorderColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.BorderSizePixel = 1
CloseBtn.Position = UDim2.new(0.88, 0, 0.02, 0)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false
end)

-- Название
Label.Parent = Frame
Label.BackgroundTransparency = 1.000
Label.Position = UDim2.new(0.05, 0, 0.02, 0)
Label.Size = UDim2.new(0, 250, 0, 35)
Label.Font = Enum.Font.GothamBold
Label.Text = "⚡ TON BATTLE ⚡"
Label.TextColor3 = Color3.fromRGB(0, 255, 255)
Label.TextSize = 24

-- Кнопка выбора кейса
local SelectCaseBtn = Instance.new("TextButton")
SelectCaseBtn.Parent = Frame
SelectCaseBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
SelectCaseBtn.BorderColor3 = Color3.fromRGB(0, 255, 255)
SelectCaseBtn.BorderSizePixel = 2
SelectCaseBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
SelectCaseBtn.Size = UDim2.new(0, 290, 0, 40)
SelectCaseBtn.Font = Enum.Font.Gotham
SelectCaseBtn.Text = "🎲 ВЫБРАТЬ КЕЙС"
SelectCaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectCaseBtn.TextSize = 18

local selectCorner = Instance.new("UICorner")
selectCorner.CornerRadius = UDim.new(0, 12)
selectCorner.Parent = SelectCaseBtn

-- Метка с выбранным кейсом
SelectedCaseLabel.Parent = Frame
SelectedCaseLabel.BackgroundTransparency = 1
SelectedCaseLabel.Position = UDim2.new(0.05, 0, 0.22, 0)
SelectedCaseLabel.Size = UDim2.new(0, 290, 0, 25)
SelectedCaseLabel.Font = Enum.Font.Gotham
SelectedCaseLabel.Text = "✅ Выбран: " .. selectedCase
SelectedCaseLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
SelectedCaseLabel.TextSize = 14

-- ============ НАСТРОЙКИ ============
local SettingsFrame = Instance.new("Frame")
local SettingsCorner = Instance.new("UICorner")
local SettingsTitle = Instance.new("TextLabel")
local SettingsClose = Instance.new("TextButton")
local AmountLabel = Instance.new("TextLabel")
local AmountBox = Instance.new("TextBox")
local AmountCorner = Instance.new("UICorner")
local SellToggle = Instance.new("TextButton")
local SellStatus = Instance.new("TextLabel")
local ProgressLabel = Instance.new("TextLabel")

-- Окно настроек
SettingsFrame.Parent = ScreenGui
SettingsFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
SettingsFrame.BackgroundTransparency = 0.150
SettingsFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
SettingsFrame.BorderSizePixel = 2
SettingsFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
SettingsFrame.Size = UDim2.new(0, 320, 0, 280)
SettingsFrame.Visible = false

SettingsCorner.CornerRadius = UDim.new(0, 20)
SettingsCorner.Parent = SettingsFrame

local SettingsGradient = Instance.new("UIGradient")
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
SettingsTitle.Size = UDim2.new(0, 250, 0, 35)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.Text = "⚙ НАСТРОЙКИ"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 200, 0)
SettingsTitle.TextSize = 22

SettingsClose.Parent = SettingsFrame
SettingsClose.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
SettingsClose.BackgroundTransparency = 0.2
SettingsClose.BorderColor3 = Color3.fromRGB(255, 100, 100)
SettingsClose.BorderSizePixel = 1
SettingsClose.Position = UDim2.new(0.85, 0, 0.02, 0)
SettingsClose.Size = UDim2.new(0, 30, 0, 30)
SettingsClose.Font = Enum.Font.GothamBold
SettingsClose.Text = "✕"
SettingsClose.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsClose.TextSize = 20

local setCloseCorner = Instance.new("UICorner")
setCloseCorner.CornerRadius = UDim.new(0, 10)
setCloseCorner.Parent = SettingsClose

SettingsClose.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = false
end)

-- Количество кейсов
AmountLabel.Parent = SettingsFrame
AmountLabel.BackgroundTransparency = 1
AmountLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
AmountLabel.Size = UDim2.new(0, 200, 0, 30)
AmountLabel.Font = Enum.Font.Gotham
AmountLabel.Text = "📦 Кейсов для открытия:"
AmountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountLabel.TextSize = 14

AmountBox.Parent = SettingsFrame
AmountBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
AmountBox.BorderColor3 = Color3.fromRGB(255, 200, 0)
AmountBox.BorderSizePixel = 2
AmountBox.Position = UDim2.new(0.05, 0, 0.25, 0)
AmountBox.Size = UDim2.new(0, 290, 0, 40)
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
SellToggle.Position = UDim2.new(0.05, 0, 0.45, 0)
SellToggle.Size = UDim2.new(0, 140, 0, 35)
SellToggle.Font = Enum.Font.GothamBold
SellToggle.Text = "🔴 SELL: OFF"
SellToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
SellToggle.TextSize = 15

local sellCorner = Instance.new("UICorner")
sellCorner.CornerRadius = UDim.new(0, 10)
sellCorner.Parent = SellToggle

SellStatus.Parent = SettingsFrame
SellStatus.BackgroundTransparency = 1
SellStatus.Position = UDim2.new(0.52, 0, 0.45, 0)
SellStatus.Size = UDim2.new(0, 140, 0, 35)
SellStatus.Font = Enum.Font.Gotham
SellStatus.Text = "❌ Выкл"
SellStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
SellStatus.TextSize = 14
SellStatus.TextXAlignment = Enum.TextXAlignment.Left

-- Прогресс
ProgressLabel.Parent = SettingsFrame
ProgressLabel.BackgroundTransparency = 1
ProgressLabel.Position = UDim2.new(0.05, 0, 0.65, 0)
ProgressLabel.Size = UDim2.new(0, 290, 0, 30)
ProgressLabel.Font = Enum.Font.Gotham
ProgressLabel.Text = "📊 Прогресс: 0 / " .. casesToOpen
ProgressLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
ProgressLabel.TextSize = 14

-- Кнопка настроек в главном меню
SettingsBtn.Parent = Frame
SettingsBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
SettingsBtn.BorderColor3 = Color3.fromRGB(255, 200, 0)
SettingsBtn.BorderSizePixel = 2
SettingsBtn.Position = UDim2.new(0.05, 0, 0.32, 0)
SettingsBtn.Size = UDim2.new(0, 290, 0, 40)
SettingsBtn.Font = Enum.Font.Gotham
SettingsBtn.Text = "⚙ НАСТРОЙКИ"
SettingsBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
SettingsBtn.TextSize = 18

local setBtnCorner = Instance.new("UICorner")
setBtnCorner.CornerRadius = UDim.new(0, 12)
setBtnCorner.Parent = SettingsBtn

SettingsBtn.MouseButton1Click:Connect(function()
    ProgressLabel.Text = "📊 Прогресс: " .. openedCount .. " / " .. casesToOpen
    SettingsFrame.Visible = true
end)

-- Кнопка старт/стоп
Auto.Parent = Frame
Auto.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
Auto.BorderColor3 = Color3.fromRGB(0, 255, 150)
Auto.BorderSizePixel = 2
Auto.Position = UDim2.new(0.05, 0, 0.50, 0)
Auto.Size = UDim2.new(0, 290, 0, 50)
Auto.Font = Enum.Font.GothamBold
Auto.Text = "▶ СТАРТ ФАРМ"
Auto.TextColor3 = Color3.fromRGB(255, 255, 255)
Auto.TextSize = 22

UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = Auto

-- Подвал
local Footer = Instance.new("TextLabel")
Footer.Parent = Frame
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(0.05, 0, 0.85, 0)
Footer.Size = UDim2.new(0, 290, 0, 25)
Footer.Font = Enum.Font.Gotham
Footer.Text = "💀 TON BATTLE | NEON EDITION"
Footer.TextColor3 = Color3.fromRGB(100, 100, 150)
Footer.TextSize = 12

dd.Parent = Frame

-- ============ ОТДЕЛЬНОЕ МЕНЮ ВЫБОРА КЕЙСОВ ============
local CaseMenu = Instance.new("Frame")
local CaseMenuCorner = Instance.new("UICorner")
local CaseMenuGradient = Instance.new("UIGradient")
local CaseMenuClose = Instance.new("TextButton")
local CaseMenuTitle = Instance.new("TextLabel")
local CaseListFrame = Instance.new("ScrollingFrame")
local CaseListLayout = Instance.new("UIListLayout")

CaseMenu.Parent = ScreenGui
CaseMenu.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
CaseMenu.BackgroundTransparency = 0.150
CaseMenu.BorderColor3 = Color3.fromRGB(255, 100, 255)
CaseMenu.BorderSizePixel = 2
CaseMenu.Position = UDim2.new(0.35, 0, 0.20, 0)
CaseMenu.Size = UDim2.new(0, 280, 0, 350)
CaseMenu.Visible = false

CaseMenuCorner.CornerRadius = UDim.new(0, 20)
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
CaseMenuClose.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CaseMenuClose.BackgroundTransparency = 0.2
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

-- Скролл фрейм для кейсов
CaseListFrame.Parent = CaseMenu
CaseListFrame.BackgroundTransparency = 1
CaseListFrame.Position = UDim2.new(0.05, 0, 0.12, 0)
CaseListFrame.Size = UDim2.new(0, 250, 0, 280)
CaseListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
CaseListFrame.ScrollBarThickness = 5

CaseListLayout.Parent = CaseListFrame
CaseListLayout.SortOrder = Enum.SortOrder.LayoutOrder
CaseListLayout.Padding = UDim.new(0, 8)

-- Функция создания кнопок для кейсов
local function createCaseButton(caseName)
    local btn = Instance.new("TextButton")
    btn.Parent = CaseListFrame
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    btn.BorderColor3 = Color3.fromRGB(255, 100, 255)
    btn.BorderSizePixel = 1
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.Font = Enum.Font.Gotham
    btn.Text = caseName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        selectedCase = caseName
        SelectedCaseLabel.Text = "✅ Выбран: " .. selectedCase
        CaseMenu.Visible = false
        openedCount = 0
        ProgressLabel.Text = "📊 Прогресс: 0 / " .. casesToOpen
    end)
end

for _, caseName in ipairs(cases) do
    createCaseButton(caseName)
end

-- Открытие меню выбора кейса
SelectCaseBtn.MouseButton1Click:Connect(function()
    CaseMenu.Visible = true
end)

-- ============ ФУНКЦИИ НАСТРОЕК ============
local function updateSellUI()
    if sellEnabled then
        SellToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        SellToggle.BorderColor3 = Color3.fromRGB(0, 255, 100)
        SellToggle.Text = "🟢 SELL: ON"
        SellToggle.TextColor3 = Color3.fromRGB(0, 255, 100)
        SellStatus.Text = "✅ Продажа активна"
        SellStatus.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        SellToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SellToggle.BorderColor3 = Color3.fromRGB(255, 100, 100)
        SellToggle.Text = "🔴 SELL: OFF"
        SellToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
        SellStatus.Text = "❌ Продажа выкл"
        SellStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end

SellToggle.MouseButton1Click:Connect(function()
    sellEnabled = not sellEnabled
    updateSellUI()
end)

-- Обновление прогресса
local function updateProgress()
    ProgressLabel.Text = "📊 Прогресс: " .. openedCount .. " / " .. casesToOpen
end

-- Логика фарма
Auto.MouseButton1Click:Connect(function()
    if on == 0 then
        if openedCount >= casesToOpen then
            openedCount = 0
            updateProgress()
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
                    updateProgress()
                    
                    if sellEnabled then
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Inventory"):FireServer("Sell", "ALL")
                    end
                end)
                task.wait(2)
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

