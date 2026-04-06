-- ========== TON BATTLE - COMPACT V6 ==========
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AllCases = {
    "Trash", "Daily", "Photon Core", "Divine", "Beggar", "Plodder",
    "Office Clerk", "Manager", "Director", "Oligarch", "Frozen Heart",
    "Bubble Gum", "Cats", "Glitch", "Dream", "Bloody Night", "Heavenfall",
    "M5 F90", "G63", "Porsche 911", "URUS", "Gold", "Dark", "Palm",
    "Burj", "Luxury", "Marina", "Cursed Demon"
}

local CustomCases = {}
for i, v in ipairs(AllCases) do table.insert(CustomCases, v) end

local Config = {
    SelectedCase = "Heavenfall",  -- кейс по умолчанию
    OpenAmount = 10,
    TimerSeconds = 0,
    DelayBetween = 0.05,
    AutoSell = false,
    IsFarming = false,
    FarmThread = nil,
    StartTime = 0
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NeonGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ========== ОСНОВНОЕ ОКНО ==========
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 5, 20)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderColor3 = Color3.fromRGB(180, 0, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.35, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 520)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 255))
})
MainGradient.Rotation = 60
MainGradient.Parent = MainFrame

local DragDetector = Instance.new("UIDragDetector")
DragDetector.Parent = MainFrame

-- ========== КНОПКИ ==========
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.BackgroundTransparency = 0.2
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(0.88, 0, 0.02, 0)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeBtn.BackgroundTransparency = 0.2
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Position = UDim2.new(0.78, 0, 0.02, 0)
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
MinimizeBtn.TextSize = 24
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeBtn

-- ПЛАВАЮЩАЯ КНОПКА
local FloatingBtn = Instance.new("TextButton")
FloatingBtn.Parent = ScreenGui
FloatingBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
FloatingBtn.BackgroundTransparency = 0.1
FloatingBtn.BorderColor3 = Color3.fromRGB(0, 255, 150)
FloatingBtn.BorderSizePixel = 2
FloatingBtn.Position = UDim2.new(0.02, 0, 0.85, 0)
FloatingBtn.Size = UDim2.new(0, 50, 0, 50)
FloatingBtn.Font = Enum.Font.GothamBold
FloatingBtn.Text = "⚡"
FloatingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingBtn.TextSize = 28
FloatingBtn.Visible = false
local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(0, 25)
FloatCorner.Parent = FloatingBtn
local FloatDrag = Instance.new("UIDragDetector")
FloatDrag.Parent = FloatingBtn

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false FloatingBtn.Visible = true end)
MinimizeBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false FloatingBtn.Visible = true end)
FloatingBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true FloatingBtn.Visible = false end)

-- ========== ЗАГОЛОВОК ==========
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0.02, 0)
Title.Size = UDim2.new(0, 200, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ TON BATTLE ⚡"
Title.TextColor3 = Color3.fromRGB(180, 0, 255)
Title.TextSize = 22

-- ========== ВЫБОР КЕЙСА (ТЕКУЩИЙ) ==========
local CurrentCaseLabel = Instance.new("TextLabel")
CurrentCaseLabel.Parent = MainFrame
CurrentCaseLabel.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
CurrentCaseLabel.BorderColor3 = Color3.fromRGB(0, 255, 150)
CurrentCaseLabel.BorderSizePixel = 1
CurrentCaseLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
CurrentCaseLabel.Size = UDim2.new(0.9, 0, 0, 35)
CurrentCaseLabel.Font = Enum.Font.GothamBold
CurrentCaseLabel.Text = "🎯 ВЫБРАН: " .. Config.SelectedCase
CurrentCaseLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
CurrentCaseLabel.TextSize = 14
local CurCorner = Instance.new("UICorner")
CurCorner.CornerRadius = UDim.new(0, 8)
CurCorner.Parent = CurrentCaseLabel

-- ========== СПИСОК КЕЙСОВ (СКРОЛЛ) ==========
local CaseScroll = Instance.new("ScrollingFrame")
CaseScroll.Parent = MainFrame
CaseScroll.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
CaseScroll.BorderColor3 = Color3.fromRGB(180, 0, 255)
CaseScroll.BorderSizePixel = 1
CaseScroll.Position = UDim2.new(0.05, 0, 0.19, 0)
CaseScroll.Size = UDim2.new(0.9, 0, 0, 200)
CaseScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
CaseScroll.ScrollBarThickness = 6
CaseScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)
local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 10)
ScrollCorner.Parent = CaseScroll

local CaseLayout = Instance.new("UIListLayout")
CaseLayout.Parent = CaseScroll
CaseLayout.SortOrder = Enum.SortOrder.LayoutOrder
CaseLayout.Padding = UDim.new(0, 5)

-- ========== ДОБАВЛЕНИЕ СВОЕГО КЕЙСА ==========
local AddBox = Instance.new("TextBox")
AddBox.Parent = MainFrame
AddBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
AddBox.BorderColor3 = Color3.fromRGB(0, 255, 150)
AddBox.BorderSizePixel = 1
AddBox.Position = UDim2.new(0.05, 0, 0.48, 0)
AddBox.Size = UDim2.new(0.6, 0, 0, 35)
AddBox.Font = Enum.Font.Gotham
AddBox.PlaceholderText = "➕ Свой кейс"
AddBox.Text = ""
AddBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AddBox.TextSize = 13
local AddCorner = Instance.new("UICorner")
AddCorner.CornerRadius = UDim.new(0, 8)
AddCorner.Parent = AddBox

local AddBtn = Instance.new("TextButton")
AddBtn.Parent = MainFrame
AddBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
AddBtn.BorderColor3 = Color3.fromRGB(0, 255, 150)
AddBtn.BorderSizePixel = 1
AddBtn.Position = UDim2.new(0.68, 0, 0.48, 0)
AddBtn.Size = UDim2.new(0.27, 0, 0, 35)
AddBtn.Font = Enum.Font.GothamBold
AddBtn.Text = "ДОБАВИТЬ"
AddBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AddBtn.TextSize = 11
local AddBtnCorner = Instance.new("UICorner")
AddBtnCorner.CornerRadius = UDim.new(0, 8)
AddBtnCorner.Parent = AddBtn

-- ========== НАСТРОЙКИ ФАРМА ==========
local AmountBox = Instance.new("TextBox")
AmountBox.Parent = MainFrame
AmountBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
AmountBox.BorderColor3 = Color3.fromRGB(180, 0, 255)
AmountBox.BorderSizePixel = 1
AmountBox.Position = UDim2.new(0.05, 0, 0.58, 0)
AmountBox.Size = UDim2.new(0.27, 0, 0, 35)
AmountBox.Font = Enum.Font.GothamBold
AmountBox.Text = "10"
AmountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountBox.TextSize = 14
local AmCorner = Instance.new("UICorner")
AmCorner.CornerRadius = UDim.new(0, 8)
AmCorner.Parent = AmountBox

local AmountLabel = Instance.new("TextLabel")
AmountLabel.Parent = MainFrame
AmountLabel.BackgroundTransparency = 1
AmountLabel.Position = UDim2.new(0.35, 0, 0.58, 0)
AmountLabel.Size = UDim2.new(0.3, 0, 0, 35)
AmountLabel.Font = Enum.Font.Gotham
AmountLabel.Text = "📦 кейсов (1-10)"
AmountLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
AmountLabel.TextSize = 10

local TimerBox = Instance.new("TextBox")
TimerBox.Parent = MainFrame
TimerBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
TimerBox.BorderColor3 = Color3.fromRGB(180, 0, 255)
TimerBox.BorderSizePixel = 1
TimerBox.Position = UDim2.new(0.68, 0, 0.58, 0)
TimerBox.Size = UDim2.new(0.27, 0, 0, 35)
TimerBox.Font = Enum.Font.GothamBold
TimerBox.Text = "0"
TimerBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TimerBox.TextSize = 14
local TmCorner = Instance.new("UICorner")
TmCorner.CornerRadius = UDim.new(0, 8)
TmCorner.Parent = TimerBox

local TimerLabel = Instance.new("TextLabel")
TimerLabel.Parent = MainFrame
TimerLabel.BackgroundTransparency = 1
TimerLabel.Position = UDim2.new(0.05, 0, 0.66, 0)
TimerLabel.Size = UDim2.new(0.5, 0, 0, 20)
TimerLabel.Font = Enum.Font.Gotham
TimerLabel.Text = "⏱ таймер (сек) 0=∞"
TimerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TimerLabel.TextSize = 10

-- ========== КНОПКИ УПРАВЛЕНИЯ ==========
local SellBtn = Instance.new("TextButton")
SellBtn.Parent = MainFrame
SellBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
SellBtn.BorderColor3 = Color3.fromRGB(255, 100, 100)
SellBtn.BorderSizePixel = 1
SellBtn.Position = UDim2.new(0.05, 0, 0.71, 0)
SellBtn.Size = UDim2.new(0.43, 0, 0, 35)
SellBtn.Font = Enum.Font.GothamBold
SellBtn.Text = "🔴 ПРОДАЖА: ВЫКЛ"
SellBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
SellBtn.TextSize = 11
local SellCorner = Instance.new("UICorner")
SellCorner.CornerRadius = UDim.new(0, 8)
SellCorner.Parent = SellBtn

local StartBtn = Instance.new("TextButton")
StartBtn.Parent = MainFrame
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
StartBtn.BorderColor3 = Color3.fromRGB(0, 255, 150)
StartBtn.BorderSizePixel = 2
StartBtn.Position = UDim2.new(0.52, 0, 0.71, 0)
StartBtn.Size = UDim2.new(0.43, 0, 0, 35)
StartBtn.Font = Enum.Font.GothamBold
StartBtn.Text = "▶ СТАРТ"
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StartBtn.TextSize = 14
local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0, 8)
StartCorner.Parent = StartBtn

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.05, 0, 0.82, 0)
StatusLabel.Size = UDim2.new(0.9, 0, 0, 25)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "⚡ СТАТУС: ОСТАНОВЛЕН"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
StatusLabel.TextSize = 11

-- ========== ИНФО ==========
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = MainFrame
InfoLabel.BackgroundTransparency = 1
InfoLabel.Position = UDim2.new(0.05, 0, 0.9, 0)
InfoLabel.Size = UDim2.new(0.9, 0, 0, 20)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Text = "👑 @NoMentalProblem & @Vezqx | 📢 TG: TonBattleScript"
InfoLabel.TextColor3 = Color3.fromRGB(180, 0, 255)
InfoLabel.TextSize = 9

-- ========== ФУНКЦИИ ==========
local function RefreshCaseList()
    for _, child in pairs(CaseScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for i, caseName in ipairs(CustomCases) do
        local btn = Instance.new("TextButton")
        btn.Parent = CaseScroll
        btn.BackgroundColor3 = Color3.fromRGB(30, 25, 55)
        btn.BorderColor3 = Color3.fromRGB(0, 255, 150)
        btn.BorderSizePixel = 1
        btn.Size = UDim2.new(1, 0, 0, 35)
        btn.Font = Enum.Font.Gotham
        btn.Text = caseName
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        if caseName == Config.SelectedCase then
            btn.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        
        btn.MouseButton1Click:Connect(function()
            Config.SelectedCase = caseName
            CurrentCaseLabel.Text = "🎯 ВЫБРАН: " .. Config.SelectedCase
            RefreshCaseList()
        end)
    end
    
    local childrenCount = #CaseScroll:GetChildren() - 2
    CaseScroll.CanvasSize = UDim2.new(0, 0, 0, childrenCount * 42 + 10)
end

AddBtn.MouseButton1Click:Connect(function()
    local newCase = AddBox.Text
    if newCase ~= "" then
        local exists = false
        for _, v in ipairs(CustomCases) do
            if v == newCase then exists = true break end
        end
        if not exists then
            table.insert(CustomCases, newCase)
            RefreshCaseList()
            AddBox.Text = ""
            AddBtn.Text = "✅"
            task.wait(0.8)
            AddBtn.Text = "ДОБАВИТЬ"
        else
            AddBtn.Text = "❌"
            task.wait(0.8)
            AddBtn.Text = "ДОБАВИТЬ"
        end
    end
end)

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

local function FarmLoop()
    while Config.IsFarming do
        if Config.TimerSeconds > 0 and os.time() - Config.StartTime >= Config.TimerSeconds then
            break
        end
        pcall(function()
            local Events = ReplicatedStorage:FindFirstChild("Events")
            if Events then
                local OpenCase = Events:FindFirstChild("OpenCase")
                if OpenCase then
                    OpenCase:InvokeServer(Config.SelectedCase, Config.OpenAmount)
                end
                if Config.AutoSell then
                    local Inventory = Events:FindFirstChild("Inventory")
                    if Inventory then
                        Inventory:FireServer("Sell", "ALL")
                    end
                end
            end
        end)
        task.wait(Config.DelayBetween)
    end
    Config.IsFarming = false
    StartBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    StartBtn.Text = "▶ СТАРТ"
    StatusLabel.Text = "⚡ СТАТУС: ОСТАНОВЛЕН"
    StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
end

StartBtn.MouseButton1Click:Connect(function()
    if not Config.IsFarming then
        Config.IsFarming = true
        Config.StartTime = os.time()
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        StartBtn.Text = "⏹ СТОП"
        StatusLabel.Text = "⚡ СТАТУС: ФАРМ АКТИВЕН"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        task.spawn(FarmLoop)
    else
        Config.IsFarming = false
    end
end)

-- ========== АНИМАЦИЯ ==========
task.spawn(function()
    local ticker = 0
    while true do
        ticker = ticker + 0.03
        local intensity = (math.sin(ticker) + 1) / 4 + 0.5
        MainFrame.BorderColor3 = Color3.new(intensity * 0.7, intensity * 0.5, intensity)
        task.wait(0.05)
    end
end)

-- ========== ЗАПУСК ==========
RefreshCaseList()
UpdateSellUI()

print("✅ TON BATTLE LOADED | Case: " .. Config.SelectedCase)
