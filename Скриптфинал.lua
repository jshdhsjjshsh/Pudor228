local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
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
local currentPage = 1
local casesPerPage = 5
local speedDelay = 0.01

local allCases = {
    "Trash", "Daily", "Photon Core", "Divine", "Beggar", "Plodder",
    "Office Clerk", "Manager", "Director", "Oligarch", "Frozen Heart",
    "Bubble Gum", "Cats", "Glitch", "Dream", "Bloody Night", "Heavenfall",
    "M5 F90", "G63", "Porsche 911", "URUS", "Gold", "Dark", "Palm",
    "Burj", "Luxury", "Marina", "Cursed Demon"
}

local customCases = {}
for i,v in ipairs(allCases) do table.insert(customCases, v) end
local totalPages = math.ceil(#customCases / casesPerPage)

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ГЛАВНОЕ ОКНО
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(15,10,25)
Frame.BackgroundTransparency = 0.05
Frame.BorderColor3 = Color3.fromRGB(180,0,255)
Frame.BorderSizePixel = 2
Frame.Position = UDim2.new(0.3,0,0.15,0)
Frame.Size = UDim2.new(0,550,0,450)
Frame.Active = true
Frame.Draggable = true

UICorner.CornerRadius = UDim.new(0,15)
UICorner.Parent = Frame
dd.Parent = Frame

-- ЗАГОЛОВОК
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.02,0,0.01,0)
Title.Size = UDim2.new(0,200,0,35)
Title.Font = Enum.Font.GothamBold
Title.Text = "NFT BATTLE"
Title.TextColor3 = Color3.fromRGB(180,0,255)
Title.TextSize = 22

-- КНОПКИ УПРАВЛЕНИЯ ОКНОМ
CloseBtn.Parent = Frame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
CloseBtn.BackgroundTransparency = 0.2
CloseBtn.Position = UDim2.new(0.94,0,0.01,0)
CloseBtn.Size = UDim2.new(0,28,0,28)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.TextSize = 18
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0,8)
closeCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() Frame.Visible = false SmallMenu.Visible = true end)

MinimizeBtn.Parent = Frame
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50,50,80)
MinimizeBtn.BackgroundTransparency = 0.2
MinimizeBtn.Position = UDim2.new(0.88,0,0.01,0)
MinimizeBtn.Size = UDim2.new(0,28,0,28)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(200,200,255)
MinimizeBtn.TextSize = 22
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0,8)
minCorner.Parent = MinimizeBtn
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false SmallMenu.Visible = true end)

SmallMenu.Parent = ScreenGui
SmallMenu.BackgroundColor3 = Color3.fromRGB(180,0,255)
SmallMenu.BackgroundTransparency = 0.1
SmallMenu.BorderColor3 = Color3.fromRGB(255,255,255)
SmallMenu.BorderSizePixel = 1
SmallMenu.Position = UDim2.new(0.02,0,0.85,0)
SmallMenu.Size = UDim2.new(0,45,0,45)
SmallMenu.Font = Enum.Font.GothamBold
SmallMenu.Text = "⚡"
SmallMenu.TextColor3 = Color3.fromRGB(255,255,255)
SmallMenu.TextSize = 24
SmallMenu.Visible = false
local smallCorner = Instance.new("UICorner")
smallCorner.CornerRadius = UDim.new(0,22)
smallCorner.Parent = SmallMenu
SmallMenu.MouseButton1Click:Connect(function() Frame.Visible = true SmallMenu.Visible = false end)

-- ============ ЛЕВОЕ МЕНЮ (ВЕРТИКАЛЬНЫЕ КНОПКИ) ============
local LeftMenu = Instance.new("Frame")
LeftMenu.Parent = Frame
LeftMenu.BackgroundColor3 = Color3.fromRGB(10,8,20)
LeftMenu.BackgroundTransparency = 0.3
LeftMenu.Position = UDim2.new(0,0,0.1,0)
LeftMenu.Size = UDim2.new(0,120,0,0.88)
LeftMenu.BorderSizePixel = 0

local menuBtns = {"🎲 КЕЙСЫ", "⚡ ФАРМ", "⚙ НАСТРОЙКИ", "ℹ ИНФО"}
local menuButtons = {}
local panels = {}

for i, name in ipairs(menuBtns) do
    local btn = Instance.new("TextButton")
    btn.Parent = LeftMenu
    btn.BackgroundColor3 = Color3.fromRGB(25,20,45)
    btn.BorderColor3 = Color3.fromRGB(180,0,255)
    btn.BorderSizePixel = 1
    btn.Position = UDim2.new(0.05,0,0.05 + (i-1)*0.22,0)
    btn.Size = UDim2.new(0.9,0,0,40)
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 13
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0,8)
    btnCorner.Parent = btn
    menuButtons[i] = btn
    
    local panel = Instance.new("Frame")
    panel.Parent = Frame
    panel.BackgroundTransparency = 1
    panel.Position = UDim2.new(0.25,0,0.1,0)
    panel.Size = UDim2.new(0.72,0,0.85,0)
    panel.Visible = (i == 1)
    panels[i] = panel
end

-- ============ ПАНЕЛЬ КЕЙСЫ ============
local CasesPanel = panels[1]

local AddBox = Instance.new("TextBox")
AddBox.Parent = CasesPanel
AddBox.BackgroundColor3 = Color3.fromRGB(25,20,45)
AddBox.BorderColor3 = Color3.fromRGB(180,0,255)
AddBox.BorderSizePixel = 1
AddBox.Position = UDim2.new(0,0,0,0)
AddBox.Size = UDim2.new(0.65,0,0,35)
AddBox.Font = Enum.Font.Gotham
AddBox.PlaceholderText = "➕ Введите название кейса"
AddBox.Text = ""
AddBox.TextColor3 = Color3.fromRGB(255,255,255)
AddBox.TextSize = 13
local addCorner = Instance.new("UICorner")
addCorner.CornerRadius = UDim.new(0,8)
addCorner.Parent = AddBox

local AddBtn = Instance.new("TextButton")
AddBtn.Parent = CasesPanel
AddBtn.BackgroundColor3 = Color3.fromRGB(0,150,100)
AddBtn.BorderColor3 = Color3.fromRGB(0,255,150)
AddBtn.BorderSizePixel = 1
AddBtn.Position = UDim2.new(0.68,0,0,0)
AddBtn.Size = UDim2.new(0.3,0,0,35)
AddBtn.Font = Enum.Font.GothamBold
AddBtn.Text = "ДОБАВИТЬ"
AddBtn.TextColor3 = Color3.fromRGB(255,255,255)
AddBtn.TextSize = 12
local addBtnCorner = Instance.new("UICorner")
addBtnCorner.CornerRadius = UDim.new(0,8)
addBtnCorner.Parent = AddBtn

local CaseList = Instance.new("ScrollingFrame")
CaseList.Parent = CasesPanel
CaseList.BackgroundColor3 = Color3.fromRGB(15,10,30)
CaseList.BorderColor3 = Color3.fromRGB(180,0,255)
CaseList.BorderSizePixel = 1
CaseList.Position = UDim2.new(0,0,0.12,0)
CaseList.Size = UDim2.new(1,0,0,0.7)
CaseList.CanvasSize = UDim2.new(0,0,0,0)
CaseList.ScrollBarThickness = 5
CaseList.ScrollBarImageColor3 = Color3.fromRGB(180,0,255)
local listCorner = Instance.new("UICorner")
listCorner.CornerRadius = UDim.new(0,8)
listCorner.Parent = CaseList

local CaseLayout = Instance.new("UIListLayout")
CaseLayout.Parent = CaseList
CaseLayout.SortOrder = Enum.SortOrder.LayoutOrder
CaseLayout.Padding = UDim.new(0,5)

local PageFrame = Instance.new("Frame")
PageFrame.Parent = CasesPanel
PageFrame.BackgroundTransparency = 1
PageFrame.Position = UDim2.new(0,0,0.85,0)
PageFrame.Size = UDim2.new(1,0,0,0.12)

local function updatePages()
    for _,v in pairs(PageFrame:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    totalPages = math.ceil(#customCases / casesPerPage)
    if totalPages == 0 then totalPages = 1 end
    local startX = 0.5 - (totalPages * 0.04)
    for i = 1, totalPages do
        local btn = Instance.new("TextButton")
        btn.Parent = PageFrame
        btn.BackgroundColor3 = Color3.fromRGB(30,25,55)
        btn.BorderColor3 = Color3.fromRGB(180,0,255)
        btn.BorderSizePixel = 1
        btn.Size = UDim2.new(0,30,0,28)
        btn.Position = UDim2.new(startX + (i-1)*0.09, 0, 0, 0)
        btn.Font = Enum.Font.GothamBold
        btn.Text = tostring(i)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextSize = 12
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0,6)
        btnCorner.Parent = btn
        btn.MouseButton1Click:Connect(function()
            currentPage = i
            refreshCaseList()
        end)
    end
end

local function refreshCaseList()
    for _,v in pairs(CaseList:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    local startIdx = (currentPage-1) * casesPerPage + 1
    local endIdx = math.min(startIdx + casesPerPage - 1, #customCases)
    for i = startIdx, endIdx do
        local caseName = customCases[i]
        local btn = Instance.new("TextButton")
        btn.Parent = CaseList
        btn.BackgroundColor3 = Color3.fromRGB(30,25,55)
        btn.BorderColor3 = Color3.fromRGB(0,255,150)
        btn.BorderSizePixel = 1
        btn.Size = UDim2.new(1,0,0,40)
        btn.Font = Enum.Font.GothamBold
        btn.Text = caseName
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextSize = 13
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0,8)
        btnCorner.Parent = btn
        btn.MouseButton1Click:Connect(function()
            selectedCase = caseName
            SelectedLabel.Text = "✅ " .. selectedCase
        end)
    end
    updatePages()
end

AddBtn.MouseButton1Click:Connect(function()
    if AddBox.Text ~= "" then
        table.insert(customCases, AddBox.Text)
        refreshCaseList()
        AddBox.Text = ""
    end
end)

-- ============ ПАНЕЛЬ ФАРМ ============
local FarmPanel = panels[2]

local SelectedLabel = Instance.new("TextLabel")
SelectedLabel.Parent = FarmPanel
SelectedLabel.BackgroundTransparency = 1
SelectedLabel.Position = UDim2.new(0,0,0,0)
SelectedLabel.Size = UDim2.new(1,0,0,25)
SelectedLabel.Font = Enum.Font.Gotham
SelectedLabel.Text = "✅ " .. selectedCase
SelectedLabel.TextColor3 = Color3.fromRGB(0,255,150)
SelectedLabel.TextSize = 13

local AmountLbl = Instance.new("TextLabel")
AmountLbl.Parent = FarmPanel
AmountLbl.BackgroundTransparency = 1
AmountLbl.Position = UDim2.new(0,0,0.1,0)
AmountLbl.Size = UDim2.new(1,0,0,20)
AmountLbl.Font = Enum.Font.Gotham
AmountLbl.Text = "📦 Кейсов за раз (1-10):"
AmountLbl.TextColor3 = Color3.fromRGB(200,200,255)
AmountLbl.TextSize = 12

local AmountBox = Instance.new("TextBox")
AmountBox.Parent = FarmPanel
AmountBox.BackgroundColor3 = Color3.fromRGB(25,20,45)
AmountBox.BorderColor3 = Color3.fromRGB(180,0,255)
AmountBox.BorderSizePixel = 1
AmountBox.Position = UDim2.new(0,0,0.18,0)
AmountBox.Size = UDim2.new(1,0,0,35)
AmountBox.Font = Enum.Font.GothamBold
AmountBox.Text = "10"
AmountBox.TextColor3 = Color3.fromRGB(255,255,255)
AmountBox.TextSize = 16
local amCorner = Instance.new("UICorner")
amCorner.CornerRadius = UDim.new(0,8)
amCorner.Parent = AmountBox
AmountBox.FocusLost:Connect(function()
    local num = tonumber(AmountBox.Text)
    if num and num >= 1 and num <= 10 then openAmount = math.floor(num) AmountBox.Text = tostring(openAmount)
    else openAmount = 10 AmountBox.Text = "10" end
end)

local TimerLbl = Instance.new("TextLabel")
TimerLbl.Parent = FarmPanel
TimerLbl.BackgroundTransparency = 1
TimerLbl.Position = UDim2.new(0,0,0.32,0)
TimerLbl.Size = UDim2.new(1,0,0,20)
TimerLbl.Font = Enum.Font.Gotham
TimerLbl.Text = "⏱ Таймер (сек): 0 = бесконечно"
TimerLbl.TextColor3 = Color3.fromRGB(200,200,255)
TimerLbl.TextSize = 12

local TimerBox = Instance.new("TextBox")
TimerBox.Parent = FarmPanel
TimerBox.BackgroundColor3 = Color3.fromRGB(25,20,45)
TimerBox.BorderColor3 = Color3.fromRGB(180,0,255)
TimerBox.BorderSizePixel = 1
TimerBox.Position = UDim2.new(0,0,0.4,0)
TimerBox.Size = UDim2.new(1,0,0,35)
TimerBox.Font = Enum.Font.GothamBold
TimerBox.Text = "0"
TimerBox.TextColor3 = Color3.fromRGB(255,255,255)
TimerBox.TextSize = 16
local tmCorner = Instance.new("UICorner")
tmCorner.CornerRadius = UDim.new(0,8)
tmCorner.Parent = TimerBox
TimerBox.FocusLost:Connect(function()
    local num = tonumber(TimerBox.Text)
    if num and num >= 0 then timerSeconds = math.floor(num) TimerBox.Text = tostring(timerSeconds)
    else timerSeconds = 0 TimerBox.Text = "0" end
end)

local SpeedLbl = Instance.new("TextLabel")
SpeedLbl.Parent = FarmPanel
SpeedLbl.BackgroundTransparency = 1
SpeedLbl.Position = UDim2.new(0,0,0.54,0)
SpeedLbl.Size = UDim2.new(1,0,0,20)
SpeedLbl.Font = Enum.Font.Gotham
SpeedLbl.Text = "⚡ Задержка (сек):"
SpeedLbl.TextColor3 = Color3.fromRGB(200,200,255)
SpeedLbl.TextSize = 12

local SpeedBox = Instance.new("TextBox")
SpeedBox.Parent = FarmPanel
SpeedBox.BackgroundColor3 = Color3.fromRGB(25,20,45)
SpeedBox.BorderColor3 = Color3.fromRGB(180,0,255)
SpeedBox.BorderSizePixel = 1
SpeedBox.Position = UDim2.new(0,0,0.62,0)
SpeedBox.Size = UDim2.new(1,0,0,35)
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.Text = "0.01"
SpeedBox.TextColor3 = Color3.fromRGB(255,255,255)
SpeedBox.TextSize = 16
local spCorner = Instance.new("UICorner")
spCorner.CornerRadius = UDim.new(0,8)
spCorner.Parent = SpeedBox
SpeedBox.FocusLost:Connect(function()
    local num = tonumber(SpeedBox.Text)
    if num and num > 0 then speedDelay = num SpeedBox.Text = tostring(speedDelay)
    else speedDelay = 0.01 SpeedBox.Text = "0.01" end
end)

local SellBtn = Instance.new("TextButton")
SellBtn.Parent = FarmPanel
SellBtn.BackgroundColor3 = Color3.fromRGB(40,35,60)
SellBtn.BorderColor3 = Color3.fromRGB(255,100,100)
SellBtn.BorderSizePixel = 1
SellBtn.Position = UDim2.new(0,0,0.76,0)
SellBtn.Size = UDim2.new(1,0,0,35)
SellBtn.Font = Enum.Font.GothamBold
SellBtn.Text = "🔴 ПРОДАЖА: ВЫКЛ"
SellBtn.TextColor3 = Color3.fromRGB(255,100,100)
SellBtn.TextSize = 13
local sellCorner = Instance.new("UICorner")
sellCorner.CornerRadius = UDim.new(0,8)
sellCorner.Parent = SellBtn

local StartBtn = Instance.new("TextButton")
StartBtn.Parent = FarmPanel
StartBtn.BackgroundColor3 = Color3.fromRGB(0,200,100)
StartBtn.BorderColor3 = Color3.fromRGB(0,255,150)
StartBtn.BorderSizePixel = 2
StartBtn.Position = UDim2.new(0,0,0.88,0)
StartBtn.Size = UDim2.new(1,0,0,45)
StartBtn.Font = Enum.Font.GothamBold
StartBtn.Text = "▶ СТАРТ ФАРМ"
StartBtn.TextColor3 = Color3.fromRGB(255,255,255)
StartBtn.TextSize = 16
local startCorner = Instance.new("UICorner")
startCorner.CornerRadius = UDim.new(0,10)
startCorner.Parent = StartBtn

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = FarmPanel
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0,0,0.96,0)
StatusLabel.Size = UDim2.new(1,0,0,20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "⚡ Статус: Остановлен"
StatusLabel.TextColor3 = Color3.fromRGB(150,150,200)
StatusLabel.TextSize = 11

-- ============ ПАНЕЛЬ НАСТРОЙКИ ============
local SettingsPanel = panels[3]

local ResetCasesBtn = Instance.new("TextButton")
ResetCasesBtn.Parent = SettingsPanel
ResetCasesBtn.BackgroundColor3 = Color3.fromRGB(150,50,200)
ResetCasesBtn.BorderColor3 = Color3.fromRGB(180,0,255)
ResetCasesBtn.BorderSizePixel = 1
ResetCasesBtn.Position = UDim2.new(0,0,0,0)
ResetCasesBtn.Size = UDim2.new(1,0,0,40)
ResetCasesBtn.Font = Enum.Font.GothamBold
ResetCasesBtn.Text = "🔄 СБРОСИТЬ ВСЕ КЕЙСЫ"
ResetCasesBtn.TextColor3 = Color3.fromRGB(255,255,255)
ResetCasesBtn.TextSize = 14
local resCorner = Instance.new("UICorner")
resCorner.CornerRadius = UDim.new(0,8)
resCorner.Parent = ResetCasesBtn
ResetCasesBtn.MouseButton1Click:Connect(function()
    customCases = {}
    for i,v in ipairs(allCases) do table.insert(customCases, v) end
    refreshCaseList()
end)

-- ============ ПАНЕЛЬ ИНФО ============
local InfoPanel = panels[4]

local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Parent = InfoPanel
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Position = UDim2.new(0,0,0,0)
CreatorLabel.Size = UDim2.new(1,0,0,50)
CreatorLabel.Font = Enum.Font.GothamBold
CreatorLabel.Text = "👑 СОЗДАТЕЛИ:\n@NoMentalProblem & @Vezqx"
CreatorLabel.TextColor3 = Color3.fromRGB(180,0,255)
CreatorLabel.TextSize = 14
CreatorLabel.TextYAlignment = Enum.TextYAlignment.Top

local ChannelBtn = Instance.new("TextButton")
ChannelBtn.Parent = InfoPanel
ChannelBtn.BackgroundColor3 = Color3.fromRGB(0,100,150)
ChannelBtn.BorderColor3 = Color3.fromRGB(0,255,150)
ChannelBtn.BorderSizePixel = 1
ChannelBtn.Position = UDim2.new(0,0,0.35,0)
ChannelBtn.Size = UDim2.new(1,0,0,40)
ChannelBtn.Font = Enum.Font.GothamBold
ChannelBtn.Text = "📢 TELEGRAM КАНАЛ"
ChannelBtn.TextColor3 = Color3.fromRGB(255,255,255)
ChannelBtn.TextSize = 14
local chCorner = Instance.new("UICorner")
chCorner.CornerRadius = UDim.new(0,8)
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
VersionLabel.Size = UDim2.new(1,0,0,25)
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.Text = "⚡ TON BATTLE V3 | NEON EDITION"
VersionLabel.TextColor3 = Color3.fromRGB(0,255,150)
VersionLabel.TextSize = 12

-- ============ ПЕРЕКЛЮЧЕНИЕ МЕНЮ ============
for i, btn in ipairs(menuButtons) do
    btn.MouseButton1Click:Connect(function()
        for j, panel in ipairs(panels) do panel.Visible = (j == i) end
        for j, bt in ipairs(menuButtons) do
            bt.BackgroundColor3 = (j == i) and Color3.fromRGB(180,0,255) or Color3.fromRGB(25,20,45)
        end
    end)
end

-- ============ ФУНКЦИИ ============
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

local farmThread = nil
StartBtn.MouseButton1Click:Connect(function()
    if not on then
        on = true
        startTime = os.time()
        StartBtn.BackgroundColor3 = Color3.fromRGB(0,100,200)
        StartBtn.Text = "⏹ СТОП ФАРМ"
        StatusLabel.Text = "⚡ Статус: ФАРМ АКТИВЕН"
        StatusLabel.TextColor3 = Color3.fromRGB(0,255,150)
        
        farmThread = task.spawn(function()
            while on do
                if timerSeconds > 0 and os.time() - startTime >= timerSeconds then
                    break
                end
                pcall(function()
                    local args = {selectedCase, openAmount}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("OpenCase"):InvokeServer(unpack(args))
                    if sellEnabled then
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Inventory"):FireServer("Sell", "ALL")
                    end
                end)
                task.wait(speedDelay)
            end
            on = false
            StartBtn.BackgroundColor3 = Color3.fromRGB(0,200,100)
            StartBtn.Text = "▶ СТАРТ ФАРМ"
            StatusLabel.Text = "⚡ Статус: Остановлен"
            StatusLabel.TextColor3 = Color3.fromRGB(150,150,200)
        end)
    else
        on = false
        if farmThread then task.cancel(farmThread) end
        StartBtn.BackgroundColor3 = Color3.fromRGB(0,200,100)
        StartBtn.Text = "▶ СТАРТ ФАРМ"
        StatusLabel.Text = "⚡ Статус: Остановлен"
        StatusLabel.TextColor3 = Color3.fromRGB(150,150,200)
    end
end)

-- АНИМАЦИЯ
task.spawn(function()
    local ticker = 0
    while true do
        ticker = ticker + 0.02
        local intensity = (math.sin(ticker) + 1) / 4 + 0.5
        Frame.BorderColor3 = Color3.new(intensity * 0.7, intensity * 0.2, intensity)
        task.wait(0.05)
    end
end)

refreshCaseList()
updateSellUI()
