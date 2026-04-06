-- ========== TON BATTLE - SIMPLE FARM ==========
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

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SimpleFarm"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 10)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderColor3 = Color3.fromRGB(150, 255, 100)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- ЗАГОЛОВОК
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ CASE FARM ⚡"
Title.TextColor3 = Color3.fromRGB(150, 255, 100)
Title.TextSize = 20

-- ВЫБРАННЫЙ КЕЙС
local SelectedLabel = Instance.new("TextLabel")
SelectedLabel.Parent = MainFrame
SelectedLabel.BackgroundColor3 = Color3.fromRGB(30, 35, 20)
SelectedLabel.BorderColor3 = Color3.fromRGB(150, 255, 100)
SelectedLabel.BorderSizePixel = 1
SelectedLabel.Position = UDim2.new(0.05, 0, 0.11, 0)
SelectedLabel.Size = UDim2.new(0.9, 0, 0, 30)
SelectedLabel.Font = Enum.Font.GothamBold
SelectedLabel.Text = "🎯 " .. SelectedCase
SelectedLabel.TextColor3 = Color3.fromRGB(150, 255, 100)
SelectedLabel.TextSize = 12
local SelCorner = Instance.new("UICorner")
SelCorner.CornerRadius = UDim.new(0, 6)
SelCorner.Parent = SelectedLabel

-- СПИСОК КЕЙСОВ
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = MainFrame
ScrollFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 15)
ScrollFrame.BorderColor3 = Color3.fromRGB(150, 255, 100)
ScrollFrame.BorderSizePixel = 1
ScrollFrame.Position = UDim2.new(0.05, 0, 0.21, 0)
ScrollFrame.Size = UDim2.new(0.9, 0, 0, 150)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 5
local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 8)
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
AddBox.Position = UDim2.new(0.05, 0, 0.51, 0)
AddBox.Size = UDim2.new(0.55, 0, 0, 30)
AddBox.Font = Enum.Font.Gotham
AddBox.PlaceholderText = "+ свой кейс"
AddBox.Text = ""
AddBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AddBox.TextSize = 11
local AddCorner = Instance.new("UICorner")
AddCorner.CornerRadius = UDim.new(0, 6)
AddCorner.Parent = AddBox

local AddBtn = Instance.new("TextButton")
AddBtn.Parent = MainFrame
AddBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 50)
AddBtn.BorderColor3 = Color3.fromRGB(150, 255, 100)
AddBtn.BorderSizePixel = 1
AddBtn.Position = UDim2.new(0.63, 0, 0.51, 0)
AddBtn.Size = UDim2.new(0.32, 0, 0, 30)
AddBtn.Font = Enum.Font.GothamBold
AddBtn.Text = "ДОБАВИТЬ"
AddBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
AddBtn.TextSize = 10
local AddBtnCorner = Instance.new("UICorner")
AddBtnCorner.CornerRadius = UDim.new(0, 6)
AddBtnCorner.Parent = AddBtn

-- АВТОПРОДАЖА
local SellBtn = Instance.new("TextButton")
SellBtn.Parent = MainFrame
SellBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 40)
SellBtn.BorderColor3 = Color3.fromRGB(255, 80, 80)
SellBtn.BorderSizePixel = 1
SellBtn.Position = UDim2.new(0.05, 0, 0.62, 0)
SellBtn.Size = UDim2.new(0.43, 0, 0, 35)
SellBtn.Font = Enum.Font.GothamBold
SellBtn.Text = "🔴 ПРОДАЖА: ВЫКЛ"
SellBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
SellBtn.TextSize = 11
local SellCorner = Instance.new("UICorner")
SellCorner.CornerRadius = UDim.new(0, 6)
SellCorner.Parent = SellBtn

-- СТАРТ/СТОП
local StartBtn = Instance.new("TextButton")
StartBtn.Parent = MainFrame
StartBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 50)
StartBtn.BorderColor3 = Color3.fromRGB(150, 255, 100)
StartBtn.BorderSizePixel = 2
StartBtn.Position = UDim2.new(0.52, 0, 0.62, 0)
StartBtn.Size = UDim2.new(0.43, 0, 0, 35)
StartBtn.Font = Enum.Font.GothamBold
StartBtn.Text = "▶ СТАРТ"
StartBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
StartBtn.TextSize = 14
local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0, 6)
StartCorner.Parent = StartBtn

-- НАСТРОЙКИ (СКОРОСТЬ)
local DelayLabel = Instance.new("TextLabel")
DelayLabel.Parent = MainFrame
DelayLabel.BackgroundTransparency = 1
DelayLabel.Position = UDim2.new(0.05, 0, 0.73, 0)
DelayLabel.Size = UDim2.new(0.5, 0, 0, 20)
DelayLabel.Font = Enum.Font.Gotham
DelayLabel.Text = "⚡ СКОРОСТЬ (сек):"
DelayLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DelayLabel.TextSize = 10

local DelayBox = Instance.new("TextBox")
DelayBox.Parent = MainFrame
DelayBox.BackgroundColor3 = Color3.fromRGB(30, 35, 20)
DelayBox.BorderColor3 = Color3.fromRGB(150, 255, 100)
DelayBox.BorderSizePixel = 1
DelayBox.Position = UDim2.new(0.55, 0, 0.73, 0)
DelayBox.Size = UDim2.new(0.4, 0, 0, 25)
DelayBox.Font = Enum.Font.GothamBold
DelayBox.Text = "0.01"
DelayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
DelayBox.TextSize = 12
local DelayCorner = Instance.new("UICorner")
DelayCorner.CornerRadius = UDim.new(0, 6)
DelayCorner.Parent = DelayBox

-- ИНФО
local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Parent = MainFrame
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Position = UDim2.new(0.05, 0, 0.85, 0)
CreatorLabel.Size = UDim2.new(0.9, 0, 0, 20)
CreatorLabel.Font = Enum.Font.Gotham
CreatorLabel.Text = "👑 @NoMentalProblem & @Vezqx"
CreatorLabel.TextColor3 = Color3.fromRGB(150, 255, 100)
CreatorLabel.TextSize = 9

local TGLabels = Instance.new("TextLabel")
TGLabels.Parent = MainFrame
TGLabels.BackgroundTransparency = 1
TGLabels.Position = UDim2.new(0.05, 0, 0.9, 0)
TGLabels.Size = UDim2.new(0.9, 0, 0, 15)
TGLabels.Font = Enum.Font.Gotham
TGLabels.Text = "📢 TG: TonBattleScript"
TGLabels.TextColor3 = Color3.fromRGB(150, 200, 100)
TGLabels.TextSize = 8

-- СТАТУС
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.05, 0, 0.95, 0)
StatusLabel.Size = UDim2.new(0.9, 0, 0, 15)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "⚡ СТАТУС: ОСТАНОВЛЕН"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 9

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
        btn.Size = UDim2.new(1, 0, 0, 28)
        btn.Font = Enum.Font.Gotham
        btn.Text = caseName
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 11
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 5)
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
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, count * 33 + 10)
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
    if AutoSell then
        SellBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 50)
        SellBtn.BorderColor3 = Color3.fromRGB(150, 255, 100)
        SellBtn.Text = "🟢 ПРОДАЖА: ВКЛ"
        SellBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        SellBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 40)
        SellBtn.BorderColor3 = Color3.fromRGB(255, 80, 80)
        SellBtn.Text = "🔴 ПРОДАЖА: ВЫКЛ"
        SellBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end

SellBtn.MouseButton1Click:Connect(function()
    AutoSell = not AutoSell
    UpdateSellUI()
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
                    OpenCase:InvokeServer(SelectedCase, 1)
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
        StartBtn.Text = "⏹ СТОП"
        StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        StatusLabel.Text = "⚡ СТАТУС: ФАРМ АКТИВЕН"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 100)
        task.spawn(FarmLoop)
    else
        Farming = false
        StartBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 50)
        StartBtn.Text = "▶ СТАРТ"
        StartBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        StatusLabel.Text = "⚡ СТАТУС: ОСТАНОВЛЕН"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

-- ЗАПУСК
RefreshCaseList()
UpdateSellUI()

print("✅ SIMPLE FARM LOADED")
