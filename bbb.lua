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
local dd = Instance.new("UIDragDetector")

-- Переменные
local on = 0
local sellEnabled = false
local selectedCase = "Photon Core"

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
Frame.Position = UDim2.new(0.35, 0, 0.30, 0)
Frame.Size = UDim2.new(0, 300, 0, 280)
Frame.Active = true
Frame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = Frame

-- Drag детектор
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
Label.BackgroundTransparency = 1
Label.Position = UDim2.new(0.05, 0, 0.02, 0)
Label.Size = UDim2.new(0, 250, 0, 35)
Label.Font = Enum.Font.GothamBold
Label.Text = "⚡ TON BATTLE ⚡"
Label.TextColor3 = Color3.fromRGB(0, 255, 255)
Label.TextSize = 24

-- Кнопка выбора кейса
SelectCaseBtn.Parent = Frame
SelectCaseBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
SelectCaseBtn.BorderColor3 = Color3.fromRGB(0, 255, 255)
SelectCaseBtn.BorderSizePixel = 2
SelectCaseBtn.Position = UDim2.new(0.05, 0, 0.13, 0)
SelectCaseBtn.Size = UDim2.new(0, 270, 0, 40)
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
SelectedCaseLabel.Position = UDim2.new(0.05, 0, 0.23, 0)
SelectedCaseLabel.Size = UDim2.new(0, 270, 0, 22)
SelectedCaseLabel.Font = Enum.Font.Gotham
SelectedCaseLabel.Text = "✅ Выбран: " .. selectedCase
SelectedCaseLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
SelectedCaseLabel.TextSize = 12

-- Тумблер продажи
SellToggle.Parent = Frame
SellToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SellToggle.BorderColor3 = Color3.fromRGB(255, 100, 100)
SellToggle.BorderSizePixel = 2
SellToggle.Position = UDim2.new(0.05, 0, 0.35, 0)
SellToggle.Size = UDim2.new(0, 130, 0, 35)
SellToggle.Font = Enum.Font.GothamBold
SellToggle.Text = "🔴 SELL: OFF"
SellToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
SellToggle.TextSize = 14

local sellCorner = Instance.new("UICorner")
sellCorner.CornerRadius = UDim.new(0, 10)
sellCorner.Parent = SellToggle

SellStatus.Parent = Frame
SellStatus.BackgroundTransparency = 1
SellStatus.Position = UDim2.new(0.52, 0, 0.35, 0)
SellStatus.Size = UDim2.new(0, 130, 0, 35)
SellStatus.Font = Enum.Font.Gotham
SellStatus.Text = "❌ Выкл"
SellStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
SellStatus.TextSize = 13
SellStatus.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка старт/стоп
Auto.Parent = Frame
Auto.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
Auto.BorderColor3 = Color3.fromRGB(0, 255, 150)
Auto.BorderSizePixel = 3
Auto.Position = UDim2.new(0.05, 0, 0.50, 0)
Auto.Size = UDim2.new(0, 270, 0, 50)
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
FarmStatus.Position = UDim2.new(0.05, 0, 0.72, 0)
FarmStatus.Size = UDim2.new(0, 270, 0, 22)
FarmStatus.Font = Enum.Font.Gotham
FarmStatus.Text = "⚡ Статус: Остановлен"
FarmStatus.TextColor3 = Color3.fromRGB(150, 150, 200)
FarmStatus.TextSize = 12

-- Подвал с авторами
local Footer = Instance.new("TextLabel")
Footer.Parent = Frame
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(0.05, 0, 0.85, 0)
Footer.Size = UDim2.new(0, 270, 0, 30)
Footer.Font = Enum.Font.Gotham
Footer.Text = "👑 @NoMentalProblem & @Vezqx"
Footer.TextColor3 = Color3.fromRGB(100, 100, 180)
Footer.TextSize = 11

-- ============ МЕНЮ ВЫБОРА КЕЙСОВ ============
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
CaseMenu.Position = UDim2.new(0.35, 0, 0.30, 0)
CaseMenu.Size = UDim2.new(0, 280, 0, 300)
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
CaseListFrame.Size = UDim2.new(0, 250, 0, 220)
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
        SellToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        SellToggle.BorderColor3 = Color3.fromRGB(0, 255, 100)
        SellToggle.Text = "🟢 SELL: ON"
        SellToggle.TextColor3 = Color3.fromRGB(0, 255, 100)
        SellStatus.Text = "✅ Включена"
        SellStatus.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        SellToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SellToggle.BorderColor3 = Color3.fromRGB(255, 100, 100)
        SellToggle.Text = "🔴 SELL: OFF"
        SellToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
        SellStatus.Text = "❌ Выключена"
        SellStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end

SellToggle.MouseButton1Click:Connect(function()
    sellEnabled = not sellEnabled
    updateSellUI()
end)

-- ОСНОВНАЯ ЛОГИКА ФАРМА (скорость 0.1 сек, бесконечно)
Auto.MouseButton1Click:Connect(function()
    if on == 0 then
        on = 1
        Auto.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        Auto.Text = "⏹ СТОП ФАРМ"
        FarmStatus.Text = "⚡ Статус: ФАРМ АКТИВЕН (0.1 сек)"
        FarmStatus.TextColor3 = Color3.fromRGB(0, 255, 100)
        
        task.spawn(function()
            while on == 1 do
                pcall(function()
                    -- Открытие кейса (10 шт за раз)
                    local args = {selectedCase, 10}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("OpenCase"):InvokeServer(unpack(args))
                    
                    -- Автопродажа если включена
                    if sellEnabled then
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Inventory"):FireServer("Sell", "ALL")
                    end
                end)
                task.wait(0.1) -- Скорость 0.1 секунды
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

