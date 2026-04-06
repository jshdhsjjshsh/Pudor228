-- ========== TON BATTLE - MINI FARM ==========
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ВСЕ КЕЙСЫ
local Cases = {
    "Trash", "Daily", "Photon Core", "Divine", "Beggar", "Plodder",
    "Office Clerk", "Manager", "Director", "Oligarch", "Frozen Heart",
    "Bubble Gum", "Cats", "Glitch", "Dream", "Bloody Night", "Heavenfall",
    "M5 F90", "G63", "Porsche 911", "URUS", "Gold", "Dark", "Palm",
    "Burj", "Luxury", "Marina", "Cursed Demon"
}

local CustomCases = {}
for i, v in ipairs(Cases) do table.insert(CustomCases, v) end

local SelectedCase = "Heavenfall"
local AutoSell = false
local Farming = false
local FarmDelay = 0.01
local OpenAmount = 10

-- ========== ГЛАВНОЕ МЕНЮ (МАЛЕНЬКОЕ) ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MiniFarm"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 10)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderColor3 = Color3.fromRGB(150, 255, 100)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.4, 0, 0.35, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- ЗАГОЛОВОК
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ CASE FARM ⚡"
Title.TextColor3 = Color3.fromRGB(150, 255, 100)
Title.TextSize = 16

-- ВЫБРАННЫЙ КЕЙС
local SelectedLabel = Instance.new("TextLabel")
SelectedLabel.Parent = MainFrame
SelectedLabel.BackgroundColor3 = Color3.fromRGB(30, 35, 20)
SelectedLabel.BorderColor3 = Color3.fromRGB(150, 255, 100)
SelectedLabel.BorderSizePixel = 1
SelectedLabel.Position = UDim2.new(0.05, 0, 0.12, 0)
SelectedLabel.Size = UDim2.new(0.9, 0, 0, 25)
SelectedLabel.Font = Enum.Font.GothamBold
SelectedLabel.Text = "🎯 " .. SelectedCase
SelectedLabel.TextColor3 = Color3.fromRGB(150, 255, 100)
SelectedLabel.TextSize = 10
local SelCorner = Instance.new("UICorner")
SelCorner.CornerRadius = UDim.new(0, 5)
SelCorner.Parent = SelectedLabel

-- СПИСОК КЕЙСОВ
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = MainFrame
ScrollFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 15)
ScrollFrame.BorderColor3 = Color3.fromRGB(150, 255, 100)
ScrollFrame.BorderSizePixel = 1
ScrollFrame.Position = UDim2.new(0.05, 0, 0.22, 0)
ScrollFrame.Size = UDim2.new(0.9, 0, 0, 120)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 4
local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 6)
ScrollCorner.Parent = ScrollFrame

local ScrollLayout = Instance.new("UIListLayout")
ScrollLayout.Parent = ScrollFrame
ScrollLayout.Padding = UDim.new(0, 3)

-- ДОБАВЛЕНИЕ КЕЙСА
local AddBox = Instance.new("TextBox")
AddBox.Parent = MainFrame
AddBox.BackgroundColor3 = Color3.fromRGB(30, 35, 20)
AddBox.BorderColor3 = Color3.fromRGB(150, 255, 100)
AddBox.BorderSizePixel = 1
AddBox.Position = UDim2.new(0.05, 0, 0.5, 0)
AddBox.Size = UDim2.new(0.55, 0, 0, 25)
AddBox.Font = Enum.Font.Gotham
AddBox.PlaceholderText = "+ свой кейс"
AddBox.Text = ""
AddBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AddBox.TextSize = 10
local AddCorner = Instance.new("UICorner")
AddCorner.CornerRadius = UDim.new(0, 5)
AddCorner.Parent = AddBox

local AddBtn = Instance.new("TextButton")
AddBtn.Parent = MainFrame
AddBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 50)
AddBtn.BorderColor3 = Color3.fromRGB(150, 255, 100)
AddBtn.BorderSizePixel = 1
AddBtn.Position = UDim2.new(0.63, 0, 0.5, 0)
AddBtn.Size = UDim2.new(0.32, 0, 0, 25)
AddBtn.Font = Enum.Font.GothamBold
AddBtn.Text = "+"
AddBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
AddBtn.TextSize = 14
local AddBtnCorner = Instance.new("UICorner")
AddBtnCorner.CornerRadius = UDim.new(0, 5)
AddBtnCorner.Parent = AddBtn

-- АВТОПРОДАЖА
local SellBtn = Instance.new("TextButton")
SellBtn.Parent = MainFrame
SellBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 40)
SellBtn.BorderColor3 = Color3.fromRGB(255, 80, 80)
SellBtn.BorderSizePixel = 1
SellBtn.Position = UDim2.new(0.05, 0, 0.62, 0)
SellBtn.Size = UDim2.new(0.43, 0, 0, 30)
SellBtn.Font = Enum.Font.GothamBold
SellBtn.Text = "🔴 ПРОД: ВЫКЛ"
SellBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
SellBtn.TextSize = 10
local SellCorner = Instance.new("UICorner")
SellCorner.CornerRadius = UDim.new(0, 5)
SellCorner.Parent = SellBtn

-- СТАРТ/СТОП
local StartBtn = Instance.new("TextButton")
StartBtn.Parent = MainFrame
StartBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 50)
StartBtn.BorderColor3 = Color3.fromRGB(150, 255, 100)
StartBtn.BorderSizePixel = 2
StartBtn.Position = UDim2.new(0.52, 0, 0.62, 0)
StartBtn.Size = UDim2.new(0.43, 0, 0, 30)
StartBtn.Font = Enum.Font.GothamBold
StartBtn.Text = "▶"
StartBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
StartBtn.TextSize = 16
local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0, 5)
StartCorner.Parent = StartBtn

-- КНОПКА НАСТРОЕК
local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Parent = MainFrame
SettingsBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 30)
SettingsBtn.BorderColor3 = Color3.fromRGB(150, 255, 100)
SettingsBtn.BorderSizePixel = 1
SettingsBtn.Position = UDim2.new(0.05, 0, 0.77, 0)
SettingsBtn.Size = UDim2.new(0.9, 0, 0, 25)
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.Text = "⚙ НАСТРОЙКИ"
SettingsBtn.TextColor3 = Color3.fromRGB(150, 255, 100)
SettingsBtn.TextSize = 10
local SetCorner = Instance.new("UICorner")
SetCorner.CornerRadius = UDim.new(0, 5)
SetCorner.Parent = SettingsBtn

-- СТАТУС
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.05, 0, 0.9, 0)
StatusLabel.Size = UDim2.new(0.9, 0, 0, 15)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "⚡ СТОП"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 9

-- ========== МЕНЮ НАСТРОЕК (ОТДЕЛЬНОЕ) ==========
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Parent = ScreenGui
SettingsFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 10)
SettingsFrame.BackgroundTransparency = 0.05
SettingsFrame.BorderColor3 = Color3.fromRGB(150, 255, 100)
SettingsFrame.BorderSizePixel = 2
SettingsFrame.Position = UDim2.new(0.4, 0, 0.35, 0)
SettingsFrame.Size = UDim2.new(0, 220, 0, 200)
SettingsFrame.Active = true
SettingsFrame.Draggable = true
SettingsFrame.Visible = false

local SetCorner2 = Instance.new("UICorner")
SetCorner2.CornerRadius = UDim.new(0, 10)
SetCorner2.Parent = SettingsFrame

local SetTitle = Instance.new("TextLabel")
SetTitle.Parent = SettingsFrame
SetTitle.BackgroundTransparency = 1
SetTitle.Position = UDim2.new(0, 0, 0, 0)
SetTitle.Size = UDim2.new(1, 0, 0, 30)
SetTitle.Font = Enum.Font.GothamBold
SetTitle.Text = "⚙ НАСТРОЙКИ"
SetTitle.TextColor3 = Color3.fromRGB(150, 255, 100)
SetTitle.TextSize = 14

local CloseSetBtn = Instance.new("TextButton")
CloseSetBtn.Parent = SettingsFrame
CloseSetBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseSetBtn.BackgroundTransparency = 0.2
CloseSetBtn.BorderSizePixel = 0
CloseSetBtn.Position = UDim2.new(0.85, 0, 0.02, 0)
CloseSetBtn.Size = UDim2.new(0, 25, 0, 25)
CloseSetBtn.Font = Enum.Font.GothamBold
CloseSetBtn.Text = "✕"
CloseSetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseSetBtn.TextSize = 14
local CloseSetCorner = Instance.new("UICorner")
CloseSetCorner.CornerRadius = UDim.new(0, 5)
CloseSetCorner.Parent = CloseSetBtn
CloseSetBtn.MouseButton1Click:Connect(function() SettingsFrame.Visible = false end)

-- КОЛИЧЕСТВО КЕЙСОВ
local AmountLabel = Instance.new("TextLabel")
AmountLabel.Parent = SettingsFrame
AmountLabel.BackgroundTransparency = 1
AmountLabel.Position = UDim2.new(0.05, 0, 0.12, 0)
AmountLabel.Size = UDim2.new(0.6, 0, 0, 25)
AmountLabel.Font = Enum.Font.Gotham
AmountLabel.Text = "📦 Кейсов за раз:"
AmountLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
AmountLabel.TextSize = 10

local AmountBox = Instance.new("TextBox")
AmountBox.Parent = SettingsFrame
AmountBox.BackgroundColor3 = Color3.fromRGB(30, 35, 20)
AmountBox.BorderColor3 = Color3.fromRGB(150, 255, 100)
AmountBox.BorderSizePixel = 1
AmountBox.Position = UDim2.new(0.65, 0, 0.12, 0)
AmountBox.Size = UDim2.new(0.3, 0, 0, 25)
AmountBox.Font = Enum.Font.GothamBold
AmountBox.Text = "10"
AmountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountBox.TextSize = 12
local AmountCorner = Instance.new("UICorner")
AmountCorner.CornerRadius = UDim.new(0, 5)
AmountCorner.Parent = AmountBox

-- СКОРОСТЬ
local DelayLabel = Instance.new("TextLabel")
DelayLabel.Parent = SettingsFrame
DelayLabel.BackgroundTransparency = 1
DelayLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
DelayLabel.Size = UDim2.new(0.6, 0, 0, 25)
DelayLabel.Font = Enum.Font.Gotham
DelayLabel.Text = "⚡ Задержка (сек):"
DelayLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DelayLabel.TextSize = 10

local DelayBox = Instance.new("TextBox")
DelayBox.Parent = SettingsFrame
DelayBox.BackgroundColor3 = Color3.fromRGB(30, 35, 20)
DelayBox.BorderColor3 = Color3.fromRGB(150, 255, 100)
DelayBox.BorderSizePixel = 1
DelayBox.Position = UDim2.new(0.65, 0, 0.35, 0)
DelayBox.Size = UDim2.new(0.3, 0, 0, 25)
DelayBox.Font = Enum.Font.GothamBold
DelayBox.Text = "0.01"
DelayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
DelayBox.TextSize = 12
local DelayCorner = Instance.new("UICorner")
DelayCorner.CornerRadius = UDim.new(0, 5)
DelayCorner.Parent = DelayBox

-- СОЗДАТЕЛИ
local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Parent = SettingsFrame
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Position = UDim2.new(0.05, 0, 0.6, 0)
CreatorLabel.Size = UDim2.new(0.9, 0, 0, 30)
CreatorLabel.Font = Enum.Font.Gotham
CreatorLabel.Text = "👑 @NoMentalProblem & @Vezqx"
CreatorLabel.TextColor3 = Color3.fromRGB(150, 255, 100)
CreatorLabel.TextSize = 9

local TGLabels = Instance.new("TextLabel")
TGLabels.Parent = SettingsFrame
TGLabels.BackgroundTransparency = 1
TGLabels.Position = UDim2.new(0.05, 0, 0.75, 0)
TGLabels.Size = UDim2.new(0.9, 0, 0, 20)
TGLabels.Font = Enum.Font.Gotham
TGLabels.Text = "📢 TG: TonBattleScript"
TGLabels.TextColor3 = Color3.fromRGB(150, 200, 100)
TGLabels.TextSize = 8

-- ========== ФУНКЦИИ ==========
local function RefreshCaseList()
    for _, child in pairs(ScrollFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for i, caseName in ipairs(CustomCases) do
        local btn = Instance.new("TextButton")
        btn.Parent = ScrollFrame
        btn.BackgroundColor3 = Color3.fromRGB(35, 40, 25)
        btn.BorderColor3 = Color3.fromRGB(150, 255, 100)
        btn.BorderSizePixel = 1
        btn.Size = UDim2.new(1, 0, 0, 24)
        btn.Font = Enum.Font.Gotham
        btn.Text = caseName
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 9
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = btn
        
        if caseName == SelectedCase then
            btn.BackgroundColor3 = Color3.fromRGB(100, 200, 50)
            btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        end
        
        btn.MouseButton1Click:Connect(function()
            SelectedCase = caseName
            SelectedLabel.Text = "🎯 " .. SelectedCase
            RefreshCaseList()
        end)
    end
    
    local count = #ScrollFrame:GetChildren() - 2
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, count * 28 + 10)
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
            task.wait(0.5)
            AddBtn.Text = "+"
        else
            AddBtn.Text = "❌"
            task.wait(0.5)
            AddBtn.Text = "+"
        end
    end
end)

local function UpdateSellUI()
    if AutoSell then
        SellBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 50)
        SellBtn.BorderColor3 = Color3.fromRGB(150, 255, 100)
        SellBtn.Text = "🟢 ПРОД: ВКЛ"
        SellBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        SellBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 40)
        SellBtn.BorderColor3 = Color3.fromRGB(255, 80, 80)
        SellBtn.Text = "🔴 ПРОД: ВЫКЛ"
        SellBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end

SellBtn.MouseButton1Click:Connect(function()
    AutoSell = not AutoSell
    UpdateSellUI()
end)

SettingsBtn.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = true
    SettingsFrame.Position = MainFrame.Position
end)

AmountBox.FocusLost:Connect(function()
    local num = tonumber(AmountBox.Text)
    if num and num >= 1 and num <= 10 then
        OpenAmount = math.floor(num)
        AmountBox.Text = tostring(OpenAmount)
    else
        OpenAmount = 10
        AmountBox.Text = "10"
    end
end)

DelayBox.FocusLost:Connect(function()
    local num = tonumber(DelayBox.Text)
    if num and num >= 0.005 then
        FarmDelay = num
        DelayBox.Text = tostring(FarmDelay)
    else
        FarmDelay = 0.01
        DelayBox.Text = "0.01"
    end
end)

local function FarmLoop()
    while Farming do
        pcall(function()
            local Events = ReplicatedStorage:FindFirstChild("Events")
            if Events then
                local OpenCase = Events:FindFirstChild("OpenCase")
                if OpenCase then
                    OpenCase:InvokeServer(SelectedCase, OpenAmount)
                end
                if AutoSell then
                    local Inventory = Events:FindFirstChild("Inventory")
                    if Inventory then
                        Inventory:FireServer("Sell", "ALL")
                    end
                end
            end
        end)
        task.wait(FarmDelay)
    end
end

StartBtn.MouseButton1Click:Connect(function()
    if not Farming then
        Farming = true
        StartBtn.BackgroundColor3 = Color3.fromRGB(200, 80, 50)
        StartBtn.Text = "⏹"
        StatusLabel.Text = "⚡ ФАРМ"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 100)
        task.spawn(FarmLoop)
    else
        Farming = false
        StartBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 50)
        StartBtn.Text = "▶"
        StatusLabel.Text = "⚡ СТОП"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

-- ЗАПУСК
RefreshCaseList()
UpdateSellUI()

print("✅ MINI FARM LOADED")
