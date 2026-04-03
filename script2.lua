local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local CloseBtn = Instance.new("TextButton")
local Auto = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local Label = Instance.new("TextLabel")
local Dropdown = Instance.new("TextButton")
local DropdownList = Instance.new("Frame")
local SellToggle = Instance.new("TextButton")
local SellStatus = Instance.new("TextLabel")
local dd = Instance.new("UIDragDetector")
local on = 0
local sellEnabled = false
local selectedCase = "Photon Core"
local dropdownOpen = false

-- Список кейсов
local cases = {"Photon Core", "Marina", "Cursed Demon", "Heavenfall"}

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ОСНОВНОЕ ОКНО
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
Frame.BackgroundTransparency = 0.150
Frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
Frame.BorderSizePixel = 2
Frame.Position = UDim2.new(0.35, 0, 0.30, 0)
Frame.Size = UDim2.new(0, 300, 0, 310)

UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = Frame

-- Неон-градиент
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
})
UIGradient.Rotation = 45
UIGradient.Parent = Frame

-- КНОПКА ЗАКРЫТИЯ
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

-- НАЗВАНИЕ TON BATTLE
Label.Name = "Label"
Label.Parent = Frame
Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Label.BackgroundTransparency = 1.000
Label.Position = UDim2.new(0.05, 0, 0.02, 0)
Label.Size = UDim2.new(0, 230, 0, 35)
Label.Font = Enum.Font.GothamBold
Label.Text = "⚡ TON BATTLE ⚡"
Label.TextColor3 = Color3.fromRGB(0, 255, 255)
Label.TextSize = 24
Label.TextScaled = false

-- КНОПКА ВЫБОРА КЕЙСА
Dropdown.Name = "Dropdown"
Dropdown.Parent = Frame
Dropdown.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
Dropdown.BorderColor3 = Color3.fromRGB(0, 255, 255)
Dropdown.BorderSizePixel = 2
Dropdown.Position = UDim2.new(0.05, 0, 0.14, 0)
Dropdown.Size = UDim2.new(0, 270, 0, 40)
Dropdown.Font = Enum.Font.Gotham
Dropdown.Text = selectedCase .. " ▼"
Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
Dropdown.TextSize = 18

local dropdownCorner = Instance.new("UICorner")
dropdownCorner.CornerRadius = UDim.new(0, 12)
dropdownCorner.Parent = Dropdown

-- ВЫПАДАЮЩИЙ СПИСОК
DropdownList.Parent = Frame
DropdownList.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
DropdownList.BorderColor3 = Color3.fromRGB(0, 255, 255)
DropdownList.BorderSizePixel = 1
DropdownList.Position = UDim2.new(0.05, 0, 0.14, 40)
DropdownList.Size = UDim2.new(0, 270, 0, 160)
DropdownList.BackgroundTransparency = 0.1
DropdownList.Visible = false

local listCorner = Instance.new("UICorner")
listCorner.CornerRadius = UDim.new(0, 12)
listCorner.Parent = DropdownList

-- СОЗДАНИЕ КНОПОК ДЛЯ КЕЙСОВ
local function createCaseButton(caseName, yPos)
    local btn = Instance.new("TextButton")
    btn.Parent = DropdownList
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    btn.BorderColor3 = Color3.fromRGB(0, 255, 200)
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.Size = UDim2.new(0, 270, 0, 40)
    btn.Font = Enum.Font.Gotham
    btn.Text = caseName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        selectedCase = caseName
        Dropdown.Text = selectedCase .. " ▼"
        DropdownList.Visible = false
        dropdownOpen = false
    end)
end

for i, caseName in ipairs(cases) do
    createCaseButton(caseName, (i-1) * 40)
end

-- ОТКРЫТИЕ/ЗАКРЫТИЕ СПИСКА
Dropdown.MouseButton1Click:Connect(function()
    dropdownOpen = not dropdownOpen
    DropdownList.Visible = dropdownOpen
end)

-- ЗАКРЫТИЕ СПИСКА ПРИ КЛИКЕ ВНЕ
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 and dropdownOpen then
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()
        local dropdownAbsPos = Dropdown.AbsolutePosition
        local dropdownSize = Dropdown.AbsoluteSize
        local listAbsPos = DropdownList.AbsolutePosition
        local listSize = DropdownList.AbsoluteSize
        
        local clickedOnDropdown = (mousePos.X >= dropdownAbsPos.X and mousePos.X <= dropdownAbsPos.X + dropdownSize.X and
                                   mousePos.Y >= dropdownAbsPos.Y and mousePos.Y <= dropdownAbsPos.Y + dropdownSize.Y)
        local clickedOnList = (mousePos.X >= listAbsPos.X and mousePos.X <= listAbsPos.X + listSize.X and
                               mousePos.Y >= listAbsPos.Y and mousePos.Y <= listAbsPos.Y + listSize.Y)
        
        if not clickedOnDropdown and not clickedOnList then
            DropdownList.Visible = false
            dropdownOpen = false
        end
    end
end)

-- ТУМБЛЕР ПРОДАЖИ
SellToggle.Parent = Frame
SellToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SellToggle.BorderColor3 = Color3.fromRGB(255, 100, 100)
SellToggle.BorderSizePixel = 2
SellToggle.Position = UDim2.new(0.05, 0, 0.42, 0)
SellToggle.Size = UDim2.new(0, 130, 0, 35)
SellToggle.Font = Enum.Font.GothamBold
SellToggle.Text = "🔴 SELL: OFF"
SellToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
SellToggle.TextSize = 15

local sellCorner = Instance.new("UICorner")
sellCorner.CornerRadius = UDim.new(0, 10)
sellCorner.Parent = SellToggle

-- СТАТУС ПРОДАЖИ
SellStatus.Parent = Frame
SellStatus.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SellStatus.BackgroundTransparency = 1
SellStatus.Position = UDim2.new(0.52, 0, 0.42, 0)
SellStatus.Size = UDim2.new(0, 130, 0, 35)
SellStatus.Font = Enum.Font.Gotham
SellStatus.Text = "❌ Выкл"
SellStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
SellStatus.TextSize = 14
SellStatus.TextXAlignment = Enum.TextXAlignment.Left

-- КНОПКА СТАРТ/СТОП
Auto.Parent = Frame
Auto.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
Auto.BorderColor3 = Color3.fromRGB(0, 255, 150)
Auto.BorderSizePixel = 2
Auto.Position = UDim2.new(0.05, 0, 0.58, 0)
Auto.Size = UDim2.new(0, 270, 0, 50)
Auto.Font = Enum.Font.GothamBold
Auto.Text = "▶ СТАРТ ФАРМ"
Auto.TextColor3 = Color3.fromRGB(255, 255, 255)
Auto.TextSize = 22

UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = Auto

-- ПОДВАЛ
local Footer = Instance.new("TextLabel")
Footer.Parent = Frame
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(0.05, 0, 0.85, 0)
Footer.Size = UDim2.new(0, 270, 0, 25)
Footer.Font = Enum.Font.Gotham
Footer.Text = "💀 TON BATTLE | NEON EDITION"
Footer.TextColor3 = Color3.fromRGB(100, 100, 150)
Footer.TextSize = 12

dd.Parent = Frame

-- ОБНОВЛЕНИЕ UI ПРОДАЖИ
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

-- ЛОГИКА ФАРМА
Auto.MouseButton1Click:Connect(function()
    if on == 0 then
        on = 1
        Auto.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        Auto.Text = "⏹ СТОП ФАРМ"
        
        task.spawn(function()
            while on == 1 do
                pcall(function()
                    -- Открытие выбранного кейса
                    local args = {selectedCase, 10}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("OpenCase"):InvokeServer(unpack(args))
                    
                    -- Продажа если включена
                    if sellEnabled then
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Inventory"):FireServer("Sell", "ALL")
                    end
                end)
                task.wait(2)
            end
        end)
    else
        on = 0
        Auto.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        Auto.Text = "▶ СТАРТ ФАРМ"
    end
end)

-- НЕОН-АНИМАЦИЯ
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

