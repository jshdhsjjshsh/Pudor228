-- [[ TON BATTLE NEON SCRIPT ]] --
-- [[ ВСЕ ФУНКЦИИ РАБОТАЮТ ]] --

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Переменные
local isFarming = false
local autoSell = false
local selectedCase = "Photon Core"
local openAmount = 10
local farmDelay = 0.01
local farmTimer = 0
local startTime = 0
local farmCoroutine = nil

-- ВСЕ КЕЙСЫ (БОЛЬШОЙ СПИСОК)
local allCasesList = {
    "Trash", "Daily", "Photon Core", "Divine", "Beggar", "Plodder",
    "Office Clerk", "Manager", "Director", "Oligarch", "Frozen Heart",
    "Bubble Gum", "Cats", "Glitch", "Dream", "Bloody Night", "Heavenfall",
    "M5 F90", "G63", "Porsche 911", "URUS", "Gold", "Dark", "Palm",
    "Burj", "Luxury", "Marina", "Cursed Demon", "Cyberpunk", "Neon Strike",
    "Dragon Soul", "Phoenix", "Vampire", "Werewolf", "Wizard", "Elf",
    "Orc", "Dwarf", "Angel", "Demon", "Godlike", "Mythic", "Legendary"
}

local userCases = {}
for _, v in ipairs(allCasesList) do
    table.insert(userCases, v)
end

-- Пагинация
local itemsPerPage = 5
local currentPageNum = 1

-- GUI элементы
local screenGui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local leftMenu = Instance.new("Frame")
local contentArea = Instance.new("Frame")
local panels = {}
local menuButtons = {}

screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Name = "TonBattleNeon"

-- MAIN FRAME
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 8, 25)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderColor3 = Color3.fromRGB(180, 0, 255)
mainFrame.BorderSizePixel = 3
mainFrame.Position = UDim2.new(0.25, 0, 0.1, 0)
mainFrame.Size = UDim2.new(0, 520, 0, 550)
mainFrame.Active = true
mainFrame.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 255))
})
mainGradient.Rotation = 60
mainGradient.Parent = mainFrame

-- Drag Detector
local dragDetector = Instance.new("UIDragDetector")
dragDetector.Parent = mainFrame

-- ЗАГОЛОВОК
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = mainFrame
titleLabel.BackgroundTransparency = 1
titleLabel.Position = UDim2.new(0.12, 0, 0.01, 0)
titleLabel.Size = UDim2.new(0, 350, 0, 40)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "⚡ TON BATTLE NEON ⚡"
titleLabel.TextColor3 = Color3.fromRGB(180, 0, 255)
titleLabel.TextSize = 24

-- КНОПКА ЗАКРЫТИЯ
local closeButton = Instance.new("TextButton")
closeButton.Parent = mainFrame
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.BackgroundTransparency = 0.1
closeButton.BorderColor3 = Color3.fromRGB(255, 100, 100)
closeButton.BorderSizePixel = 1
closeButton.Position = UDim2.new(0.93, 0, 0.01, 0)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- КНОПКА СВЕРТЫВАНИЯ
local minimizeButton = Instance.new("TextButton")
minimizeButton.Parent = mainFrame
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.BackgroundTransparency = 0.1
minimizeButton.BorderColor3 = Color3.fromRGB(0, 255, 150)
minimizeButton.BorderSizePixel = 1
minimizeButton.Position = UDim2.new(0.86, 0, 0.01, 0)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Text = "−"
minimizeButton.TextColor3 = Color3.fromRGB(0, 255, 150)
minimizeButton.TextSize = 24
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeButton

-- МАЛЕНЬКАЯ КНОПКА ДЛЯ ВОССТАНОВЛЕНИЯ
local smallRestoreButton = Instance.new("TextButton")
smallRestoreButton.Parent = screenGui
smallRestoreButton.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
smallRestoreButton.BackgroundTransparency = 0.15
smallRestoreButton.BorderColor3 = Color3.fromRGB(0, 255, 150)
smallRestoreButton.BorderSizePixel = 2
smallRestoreButton.Position = UDim2.new(0.02, 0, 0.85, 0)
smallRestoreButton.Size = UDim2.new(0, 55, 0, 55)
smallRestoreButton.Font = Enum.Font.GothamBold
smallRestoreButton.Text = "⚡"
smallRestoreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
smallRestoreButton.TextSize = 32
smallRestoreButton.Visible = false
local smallCornerBtn = Instance.new("UICorner")
smallCornerBtn.CornerRadius = UDim.new(0, 27)
smallCornerBtn.Parent = smallRestoreButton

-- ЛЕВОЕ МЕНЮ
leftMenu.Parent = mainFrame
leftMenu.BackgroundColor3 = Color3.fromRGB(15, 10, 35)
leftMenu.BackgroundTransparency = 0.2
leftMenu.BorderColor3 = Color3.fromRGB(180, 0, 255)
leftMenu.BorderSizePixel = 1
leftMenu.Position = UDim2.new(0.01, 0, 0.1, 0)
leftMenu.Size = UDim2.new(0, 95, 0, 0.87)
local leftMenuCorner = Instance.new("UICorner")
leftMenuCorner.CornerRadius = UDim.new(0, 12)
leftMenuCorner.Parent = leftMenu

-- ОБЛАСТЬ КОНТЕНТА
contentArea.Parent = mainFrame
contentArea.BackgroundTransparency = 1
contentArea.Position = UDim2.new(0.13, 0, 0.1, 0)
contentArea.Size = UDim2.new(0.85, 0, 0.87, 0)

-- СОЗДАНИЕ ПАНЕЛЕЙ
local tabNames = {"🎲 КЕЙСЫ", "⚡ ФАРМ", "⚙ НАСТРОЙКИ", "ℹ ИНФО"}

for i = 1, 4 do
    local btn = Instance.new("TextButton")
    btn.Parent = leftMenu
    btn.BackgroundColor3 = Color3.fromRGB(25, 20, 55)
    btn.BorderColor3 = Color3.fromRGB(0, 255, 150)
    btn.BorderSizePixel = 1
    btn.Position = UDim2.new(0.05, 0, 0.05 + (i-1) * 0.23, 0)
    btn.Size = UDim2.new(0, 85, 0, 42)
    btn.Font = Enum.Font.GothamBold
    btn.Text = tabNames[i]
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    menuButtons[i] = btn
    
    local panel = Instance.new("Frame")
    panel.Parent = contentArea
    panel.BackgroundTransparency = 1
    panel.Size = UDim2.new(1, 0, 1, 0)
    panel.Visible = (i == 1)
    panels[i] = panel
end

-- ==================== ПАНЕЛЬ 1: КЕЙСЫ ====================
local casesPanel = panels[1]

-- Добавление кейса
local addCaseBox = Instance.new("TextBox")
addCaseBox.Parent = casesPanel
addCaseBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
addCaseBox.BorderColor3 = Color3.fromRGB(0, 255, 150)
addCaseBox.BorderSizePixel = 2
addCaseBox.Position = UDim2.new(0, 0, 0, 0)
addCaseBox.Size = UDim2.new(0.68, 0, 0, 38)
addCaseBox.Font = Enum.Font.Gotham
addCaseBox.PlaceholderText = "➕ Введи название кейса"
addCaseBox.Text = ""
addCaseBox.TextColor3 = Color3.fromRGB(255, 255, 255)
addCaseBox.TextSize = 13
local addBoxCorner = Instance.new("UICorner")
addBoxCorner.CornerRadius = UDim.new(0, 10)
addBoxCorner.Parent = addCaseBox

local addCaseButton = Instance.new("TextButton")
addCaseButton.Parent = casesPanel
addCaseButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
addCaseButton.BorderColor3 = Color3.fromRGB(0, 255, 150)
addCaseButton.BorderSizePixel = 2
addCaseButton.Position = UDim2.new(0.7, 0, 0, 0)
addCaseButton.Size = UDim2.new(0.28, 0, 0, 38)
addCaseButton.Font = Enum.Font.GothamBold
addCaseButton.Text = "ДОБАВИТЬ"
addCaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
addCaseButton.TextSize = 11
local addBtnCorner = Instance.new("UICorner")
addBtnCorner.CornerRadius = UDim.new(0, 10)
addBtnCorner.Parent = addCaseButton

-- Список кейсов с прокруткой
local casesScrollFrame = Instance.new("ScrollingFrame")
casesScrollFrame.Parent = casesPanel
casesScrollFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
casesScrollFrame.BorderColor3 = Color3.fromRGB(180, 0, 255)
casesScrollFrame.BorderSizePixel = 1
casesScrollFrame.Position = UDim2.new(0, 0, 0.12, 0)
casesScrollFrame.Size = UDim2.new(1, 0, 0, 0.65)
casesScrollFrame.ScrollBarThickness = 6
casesScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(180, 0, 255)
local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 10)
scrollCorner.Parent = casesScrollFrame

local casesLayout = Instance.new("UIListLayout")
casesLayout.Parent = casesScrollFrame
casesLayout.Padding = UDim.new(0, 5)
casesLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Пагинация
local paginationFrame = Instance.new("Frame")
paginationFrame.Parent = casesPanel
paginationFrame.BackgroundTransparency = 1
paginationFrame.Position = UDim2.new(0, 0, 0.8, 0)
paginationFrame.Size = UDim2.new(1, 0, 0, 0.18)

local function updatePagination()
    for _, child in pairs(paginationFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local totalPages = math.ceil(#userCases / itemsPerPage)
    if totalPages == 0 then totalPages = 1 end
    
    local startX = 0.5 - (math.min(totalPages, 7) * 0.07)
    
    for i = 1, totalPages do
        local pageBtn = Instance.new("TextButton")
        pageBtn.Parent = paginationFrame
        pageBtn.BackgroundColor3 = Color3.fromRGB(30, 25, 55)
        pageBtn.BorderColor3 = Color3.fromRGB(180, 0, 255)
        pageBtn.BorderSizePixel = 1
        pageBtn.Size = UDim2.new(0, 35, 0, 30)
        pageBtn.Position = UDim2.new(startX + (i-1) * 0.12, 0, 0.1, 0)
        pageBtn.Font = Enum.Font.GothamBold
        pageBtn.Text = tostring(i)
        pageBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        pageBtn.TextSize = 13
        local pageCorner = Instance.new("UICorner")
        pageCorner.CornerRadius = UDim.new(0, 8)
        pageCorner.Parent = pageBtn
        
        pageBtn.MouseButton1Click:Connect(function()
            currentPageNum = i
            refreshCasesList()
        end)
    end
end

local selectedCaseLabel = nil

local function refreshCasesList()
    for _, child in pairs(casesScrollFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local startIdx = (currentPageNum - 1) * itemsPerPage + 1
    local endIdx = math.min(startIdx + itemsPerPage - 1, #userCases)
    
    for i = startIdx, endIdx do
        local caseName = userCases[i]
        local caseBtn = Instance.new("TextButton")
        caseBtn.Parent = casesScrollFrame
        caseBtn.BackgroundColor3 = Color3.fromRGB(30, 25, 55)
        caseBtn.BorderColor3 = Color3.fromRGB(0, 255, 150)
        caseBtn.BorderSizePixel = 1
        caseBtn.Size = UDim2.new(1, 0, 0, 42)
        caseBtn.Font = Enum.Font.GothamBold
        caseBtn.Text = caseName
        caseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        caseBtn.TextSize = 13
        local caseCorner = Instance.new("UICorner")
        caseCorner.CornerRadius = UDim.new(0, 10)
        caseCorner.Parent = caseBtn
        
        caseBtn.MouseButton1Click:Connect(function()
            selectedCase = caseName
            if selectedCaseLabel then
                selectedCaseLabel.Text = "✅ " .. selectedCase
            end
        end)
    end
    
    updatePagination()
end

addCaseButton.MouseButton1Click:Connect(function()
    if addCaseBox.Text ~= "" then
        table.insert(userCases, addCaseBox.Text)
        refreshCasesList()
        addCaseBox.Text = ""
    end
end)

-- ==================== ПАНЕЛЬ 2: ФАРМ ====================
local farmPanel = panels[2]

-- Выбранный кейс
selectedCaseLabel = Instance.new("TextLabel")
selectedCaseLabel.Parent = farmPanel
selectedCaseLabel.BackgroundTransparency = 1
selectedCaseLabel.Position = UDim2.new(0, 0, 0, 0)
selectedCaseLabel.Size = UDim2.new(1, 0, 0, 30)
selectedCaseLabel.Font = Enum.Font.GothamBold
selectedCaseLabel.Text = "✅ " .. selectedCase
selectedCaseLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
selectedCaseLabel.TextSize = 14

-- Количество кейсов
local amountLabel = Instance.new("TextLabel")
amountLabel.Parent = farmPanel
amountLabel.BackgroundTransparency = 1
amountLabel.Position = UDim2.new(0, 0, 0.08, 0)
amountLabel.Size = UDim2.new(1, 0, 0, 20)
amountLabel.Font = Enum.Font.Gotham
amountLabel.Text = "📦 Кейсов за раз (1-10):"
amountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
amountLabel.TextSize = 12

local amountBox = Instance.new("TextBox")
amountBox.Parent = farmPanel
amountBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
amountBox.BorderColor3 = Color3.fromRGB(180, 0, 255)
amountBox.BorderSizePixel = 2
amountBox.Position = UDim2.new(0, 0, 0.13, 0)
amountBox.Size = UDim2.new(1, 0, 0, 38)
amountBox.Font = Enum.Font.GothamBold
amountBox.Text = "10"
amountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
amountBox.TextSize = 18
local amountCorner = Instance.new("UICorner")
amountCorner.CornerRadius = UDim.new(0, 10)
amountCorner.Parent = amountBox
amountBox.FocusLost:Connect(function()
    local num = tonumber(amountBox.Text)
    if num and num >= 1 and num <= 10 then
        openAmount = math.floor(num)
        amountBox.Text = tostring(openAmount)
    else
        openAmount = 10
        amountBox.Text = "10"
    end
end)

-- Таймер
local timerLabel = Instance.new("TextLabel")
timerLabel.Parent = farmPanel
timerLabel.BackgroundTransparency = 1
timerLabel.Position = UDim2.new(0, 0, 0.26, 0)
timerLabel.Size = UDim2.new(1, 0, 0, 20)
timerLabel.Font = Enum.Font.Gotham
timerLabel.Text = "⏱ Таймер (сек) | 0 = бесконечно:"
timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timerLabel.TextSize = 12

local timerBox = Instance.new("TextBox")
timerBox.Parent = farmPanel
timerBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
timerBox.BorderColor3 = Color3.fromRGB(180, 0, 255)
timerBox.BorderSizePixel = 2
timerBox.Position = UDim2.new(0, 0, 0.31, 0)
timerBox.Size = UDim2.new(1, 0, 0, 38)
timerBox.Font = Enum.Font.GothamBold
timerBox.Text = "0"
timerBox.TextColor3 = Color3.fromRGB(255, 255, 255)
timerBox.TextSize = 18
local timerCorner = Instance.new("UICorner")
timerCorner.CornerRadius = UDim.new(0, 10)
timerCorner.Parent = timerBox
timerBox.FocusLost:Connect(function()
    local num = tonumber(timerBox.Text)
    if num and num >= 0 then
        farmTimer = math.floor(num)
        timerBox.Text = tostring(farmTimer)
    else
        farmTimer = 0
        timerBox.Text = "0"
    end
end)

-- Кнопка продажи
local sellButton = Instance.new("TextButton")
sellButton.Parent = farmPanel
sellButton.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
sellButton.BorderColor3 = Color3.fromRGB(255, 100, 100)
sellButton.BorderSizePixel = 2
sellButton.Position = UDim2.new(0, 0, 0.45, 0)
sellButton.Size = UDim2.new(1, 0, 0, 38)
sellButton.Font = Enum.Font.GothamBold
sellButton.Text = "🔴 ПРОДАЖА: ВЫКЛ"
sellButton.TextColor3 = Color3.fromRGB(255, 100, 100)
sellButton.TextSize = 13
local sellCorner = Instance.new("UICorner")
sellCorner.CornerRadius = UDim.new(0, 10)
sellCorner.Parent = sellButton

-- Кнопка СТАРТ/СТОП
local farmButton = Instance.new("TextButton")
farmButton.Parent = farmPanel
farmButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
farmButton.BorderColor3 = Color3.fromRGB(0, 255, 150)
farmButton.BorderSizePixel = 3
farmButton.Position = UDim2.new(0, 0, 0.58, 0)
farmButton.Size = UDim2.new(1, 0, 0, 48)
farmButton.Font = Enum.Font.GothamBold
farmButton.Text = "▶ СТАРТ ФАРМ"
farmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmButton.TextSize = 18
local farmCorner = Instance.new("UICorner")
farmCorner.CornerRadius = UDim.new(0, 12)
farmCorner.Parent = farmButton

-- Статус
local statusLabel = Instance.new("TextLabel")
statusLabel.Parent = farmPanel
statusLabel.BackgroundTransparency = 1
statusLabel.Position = UDim2.new(0, 0, 0.78, 0)
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = "⚡ Статус: Остановлен"
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
statusLabel.TextSize = 12

-- Функции фарма
local function updateSellButton()
    if autoSell then
        sellButton.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        sellButton.BorderColor3 = Color3.fromRGB(0, 255, 100)
        sellButton.Text = "🟢 ПРОДАЖА: ВКЛ"
        sellButton.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        sellButton.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
        sellButton.BorderColor3 = Color3.fromRGB(255, 100, 100)
        sellButton.Text = "🔴 ПРОДАЖА: ВЫКЛ"
        sellButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end

local function stopFarm()
    isFarming = false
    if farmCoroutine then
        task.cancel(farmCoroutine)
        farmCoroutine = nil
    end
    farmButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    farmButton.Text = "▶ СТАРТ ФАРМ"
    statusLabel.Text = "⚡ Статус: Остановлен"
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
end

local function startFarm()
    if isFarming then return end
    isFarming = true
    startTime = os.time()
    farmButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    farmButton.Text = "⏹ СТОП ФАРМ"
    statusLabel.Text = "⚡ Статус: ФАРМ АКТИВЕН"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    
    farmCoroutine = task.spawn(function()
        while isFarming do
            if farmTimer > 0 and os.time() - startTime >= farmTimer then
                break
            end
            local success, err = pcall(function()
                local events = ReplicatedStorage:WaitForChild("Events")
                events:WaitForChild("OpenCase"):InvokeServer(selectedCase, openAmount)
                if autoSell then
                    events:WaitForChild("Inventory"):FireServer("Sell", "ALL")
                end
            end)
            if not success then
                warn("Ошибка: ", err)
            end
            task.wait(farmDelay)
        end
        stopFarm()
    end)
end

-- Обработчики кнопок
sellButton.MouseButton1Click:Connect(function()
    autoSell = not autoSell
    updateSellButton()
end)

farmButton.MouseButton1Click:Connect(function()
    if isFarming then
        stopFarm()
    else
        startFarm()
    end
end)

-- ==================== ПАНЕЛЬ 3: НАСТРОЙКИ ====================
local settingsPanel = panels[3]

local delayLabel = Instance.new("TextLabel")
delayLabel.Parent = settingsPanel
delayLabel.BackgroundTransparency = 1
delayLabel.Position = UDim2.new(0, 0, 0, 0)
delayLabel.Size = UDim2.new(1, 0, 0, 25)
delayLabel.Font = Enum.Font.Gotham
delayLabel.Text = "⚡ Задержка между открытиями (сек):"
delayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
delayLabel.TextSize = 12

local delayBox = Instance.new("TextBox")
delayBox.Parent = settingsPanel
delayBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
delayBox.BorderColor3 = Color3.fromRGB(180, 0, 255)
delayBox.BorderSizePixel = 2
delayBox.Position = UDim2.new(0, 0, 0.08, 0)
delayBox.Size = UDim2.new(1, 0, 0, 38)
delayBox.Font = Enum.Font.GothamBold
delayBox.Text = "0.01"
delayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
delayBox.TextSize = 18
local delayCorner = Instance.new("UICorner")
delayCorner.CornerRadius = UDim.new(0, 10)
delayCorner.Parent = delayBox
delayBox.FocusLost:Connect(function()
    local num = tonumber(delayBox.Text)
    if num and num > 0 then
        farmDelay = num
        if farmDelay < 0.01 then farmDelay = 0.01 end
        delayBox.Text = tostring(farmDelay)
    else
        farmDelay = 0.01
        delayBox.Text = "0.01"
    end
end)

local resetButton = Instance.new("TextButton")
resetButton.Parent = settingsPanel
resetButton.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
resetButton.BorderColor3 = Color3.fromRGB(180, 0, 255)
resetButton.BorderSizePixel = 2
resetButton.Position = UDim2.new(0, 0, 0.22, 0)
resetButton.Size = UDim2.new(1, 0, 0, 45)
resetButton.Font = Enum.Font.GothamBold
resetButton.Text = "🔄 СБРОСИТЬ ВСЕ КЕЙСЫ"
resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resetButton.TextSize = 14
local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 10)
resetCorner.Parent = resetButton
resetButton.MouseButton1Click:Connect(function()
    userCases = {}
    for _, v in ipairs(allCasesList) do
        table.insert(userCases, v)
    end
    refreshCasesList()
end)

-- ==================== ПАНЕЛЬ 4: ИНФО ====================
local infoPanel = panels[4]

local creatorsLabel = Instance.new("TextLabel")
creatorsLabel.Parent = infoPanel
creatorsLabel.BackgroundTransparency = 1
creatorsLabel.Position = UDim2.new(0, 0, 0, 0)
creatorsLabel.Size = UDim2.new(1, 0, 0, 50)
creatorsLabel.Font = Enum.Font.GothamBold
creatorsLabel.Text = "👑 СОЗДАТЕЛИ:\n@NoMentalProblem  &  @Vezqx"
creatorsLabel.TextColor3 = Color3.fromRGB(180, 0, 255)
creatorsLabel.TextSize = 14
creatorsLabel.TextYAlignment = Enum.TextYAlignment.Top

local tgButton = Instance.new("TextButton")
tgButton.Parent = infoPanel
tgButton.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
tgButton.BorderColor3 = Color3.fromRGB(0, 255, 150)
tgButton.BorderSizePixel = 2
tgButton.Position = UDim2.new(0, 0, 0.3, 0)
tgButton.Size = UDim2.new(1, 0, 0, 50)
tgButton.Font = Enum.Font.GothamBold
tgButton.Text = "📢 TELEGRAM КАНАЛ"
tgButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tgButton.TextSize = 16
local tgCorner = Instance.new("UICorner")
tgCorner.CornerRadius = UDim.new(0, 12)
tgCorner.Parent = tgButton
tgButton.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        if setclipboard then
            setclipboard("https://t.me/TonBattleScript")
        elseif toclipboard then
            toclipboard("https://t.me/TonBattleScript")
        end
    end)
    tgButton.Text = "✅ ССЫЛКА СКОПИРОВАНА!"
    task.wait(1.5)
    tgButton.Text = "📢 TELEGRAM КАНАЛ"
end)

local versionLabel = Instance.new("TextLabel")
versionLabel.Parent = infoPanel
versionLabel.BackgroundTransparency = 1
versionLabel.Position = UDim2.new(0, 0, 0.68, 0)
versionLabel.Size = UDim2.new(1, 0, 0, 30)
versionLabel.Font = Enum.Font.Gotham
versionLabel.Text = "⚡ TON BATTLE V3 | NEON EDITION"
versionLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
versionLabel.TextSize = 12

-- ПЕРЕКЛЮЧЕНИЕ ВКЛАДОК
for i, btn in ipairs(menuButtons) do
    btn.MouseButton1Click:Connect(function()
        for j, panel in ipairs(panels) do
            panel.Visible = (j == i)
        end
        for j, bt in ipairs(menuButtons) do
            bt.BackgroundColor3 = (j == i) and Color3.fromRGB(180, 0, 255) or Color3.fromRGB(25, 20, 55)
        end
    end)
end

-- КНОПКИ УПРАВЛЕНИЯ ОКНОМ
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    smallRestoreButton.Visible = true
end)

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    smallRestoreButton.Visible = true
end)

smallRestoreButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    smallRestoreButton.Visible = false
end)

-- НЕОН АНИМАЦИЯ
task.spawn(function()
    local tick = 0
    while true do
        tick = tick + 0.02
        local intensity = (math.sin(tick) + 1) / 4 + 0.5
        mainFrame.BorderColor3 = Color3.new(intensity * 0.7, intensity * 0.3, intensity)
        task.wait(0.05)
    end
end)

-- ЗАПУСК
refreshCasesList()
updateSellButton()
