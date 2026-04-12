-- ========== NEO CASE FARM BY ROBIN ==========
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- ВСЕ КЕЙСЫ
local AllCases = {
    "Trash", "Daily", "Photon Core", "Divine", "Beggar", "Plodder",
    "Office Clerk", "Manager", "Director", "Oligarch", "Frozen Heart",
    "Bubble Gum", "Cats", "Glitch", "Dream", "Bloody Night", "Heavenfall",
    "M5 F90", "G63", "Porsche 911", "URUS", "Gold", "Dark", "Palm",
    "Burj", "Luxury", "Marina", "Cursed Demon"
}

-- ТЕМЫ НЕОНА (8 вариантов)
local NeonThemes = {
    {Name = "Фиолетовый + Салатовый", Primary = Color3.fromRGB(180, 0, 255), Secondary = Color3.fromRGB(0, 255, 100)},
    {Name = "Синий + Розовый", Primary = Color3.fromRGB(0, 150, 255), Secondary = Color3.fromRGB(255, 0, 200)},
    {Name = "Красный + Желтый", Primary = Color3.fromRGB(255, 0, 0), Secondary = Color3.fromRGB(255, 255, 0)},
    {Name = "Голубой + Оранжевый", Primary = Color3.fromRGB(0, 255, 255), Secondary = Color3.fromRGB(255, 150, 0)},
    {Name = "Белый + Золотой", Primary = Color3.fromRGB(255, 255, 255), Secondary = Color3.fromRGB(255, 215, 0)},
    {Name = "Розовый + Фиолетовый", Primary = Color3.fromRGB(255, 0, 150), Secondary = Color3.fromRGB(150, 0, 255)},
    {Name = "Зеленый + Бирюзовый", Primary = Color3.fromRGB(0, 255, 0), Secondary = Color3.fromRGB(0, 255, 150)},
    {Name = "Оранжевый + Красный", Primary = Color3.fromRGB(255, 100, 0), Secondary = Color3.fromRGB(255, 0, 50)}
}

-- ЗАГРУЗКА НАСТРОЕК
local Settings = {
    Theme = 1,
    OpenAmount = 10,
    FarmDelay = 0.01,
    AutoBuySpeed = 1.0,
    LuckEnabled = false,
    LuckMultiplier = 2,
    SelectedCases = {}
}

local function SaveSettings()
    pcall(function()
        if writefile then
            writefile("NeoCaseFarm_Settings.json", HttpService:JSONEncode(Settings))
        end
    end)
end

local function LoadSettings()
    pcall(function()
        if readfile and isfile and isfile("NeoCaseFarm_Settings.json") then
            local data = HttpService:JSONDecode(readfile("NeoCaseFarm_Settings.json"))
            for k, v in pairs(data) do
                Settings[k] = v
            end
        end
    end)
end

LoadSettings()

-- ПЕРЕМЕННЫЕ СОСТОЯНИЯ
local Farming = false
local AutoSellEnabled = false
local AutoBuyEnabled = false
local LuckActive = false
local LuckEndTime = 0

-- ТЕКУЩИЕ ЦВЕТА
local function GetColors()
    return NeonThemes[Settings.Theme].Primary, NeonThemes[Settings.Theme].Secondary
end

-- ФУНКЦИЯ НЕОНОВОГО СВЕЧЕНИЯ
local function AddNeonGlow(guiObject, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 1.5
    stroke.Transparency = 0.2
    stroke.Parent = guiObject
    return stroke
end

-- ========== СОЗДАНИЕ GUI ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NeoCaseFarm"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- ========== МАЛЕНЬКОЕ СВЕРНУТОЕ МЕНЮ ==========
local MiniFrame = Instance.new("Frame")
MiniFrame.Parent = ScreenGui
MiniFrame.BackgroundColor3 = Color3.fromRGB(10, 5, 15)
MiniFrame.BackgroundTransparency = 0.15
MiniFrame.BorderSizePixel = 0
MiniFrame.Position = UDim2.new(0.85, 0, 0.85, 0)
MiniFrame.Size = UDim2.new(0, 50, 0, 50)
MiniFrame.Active = true
MiniFrame.Draggable = true
MiniFrame.Visible = true
AddNeonGlow(MiniFrame, GetColors(), 2)

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 25)
MiniCorner.Parent = MiniFrame

local MiniButton = Instance.new("TextButton")
MiniButton.Parent = MiniFrame
MiniButton.BackgroundTransparency = 1
MiniButton.Size = UDim2.new(1, 0, 1, 0)
MiniButton.Font = Enum.Font.GothamBold
MiniButton.Text = "📦"
MiniButton.TextColor3 = GetColors()
MiniButton.TextSize = 24
AddNeonGlow(MiniButton, GetColors(), 1.5)

local MiniText = Instance.new("TextLabel")
MiniText.Parent = MiniFrame
MiniText.BackgroundTransparency = 1
MiniText.Position = UDim2.new(0, 0, 0.7, 0)
MiniText.Size = UDim2.new(1, 0, 0, 15)
MiniText.Font = Enum.Font.GothamBold
MiniText.Text = "FARM"
MiniText.TextColor3 = GetColors()
MiniText.TextSize = 10

-- ========== ГЛАВНОЕ МЕНЮ ==========
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 5, 15)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 420)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
AddNeonGlow(MainFrame, GetColors(), 2)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- КНОПКА СВЕРНУТЬ
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Position = UDim2.new(0.85, 0, 0.01, 0)
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 18
AddNeonGlow(MinimizeBtn, Color3.fromRGB(255, 200, 0))
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeBtn

-- ЗАГОЛОВОК
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Size = UDim2.new(0.8, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ NEO CASE FARM ⚡"
Title.TextColor3 = GetColors()
Title.TextSize = 16
AddNeonGlow(Title, GetColors(), 1.5)

-- КНОПКА ВЫБОРА КЕЙСОВ
local SelectCasesBtn = Instance.new("TextButton")
SelectCasesBtn.Parent = MainFrame
SelectCasesBtn.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
SelectCasesBtn.BorderSizePixel = 0
SelectCasesBtn.Position = UDim2.new(0.05, 0, 0.11, 0)
SelectCasesBtn.Size = UDim2.new(0.9, 0, 0, 40)
SelectCasesBtn.Font = Enum.Font.GothamBold
SelectCasesBtn.Text = "📦 ВЫБРАТЬ КЕЙСЫ"
SelectCasesBtn.TextColor3 = GetColors()
SelectCasesBtn.TextSize = 14
AddNeonGlow(SelectCasesBtn, GetColors())
local SelectCorner = Instance.new("UICorner")
SelectCorner.CornerRadius = UDim.new(0, 8)
SelectCorner.Parent = SelectCasesBtn

-- СЧЕТЧИК КЕЙСОВ
local SelectedCountLabel = Instance.new("TextLabel")
SelectedCountLabel.Parent = MainFrame
SelectedCountLabel.BackgroundTransparency = 1
SelectedCountLabel.Position = UDim2.new(0.05, 0, 0.22, 0)
SelectedCountLabel.Size = UDim2.new(0.9, 0, 0, 20)
SelectedCountLabel.Font = Enum.Font.Gotham
SelectedCountLabel.Text = "📋 Выбрано: 0 кейсов"
SelectedCountLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SelectedCountLabel.TextSize = 11

-- СТАТУС АВТОПРОДАЖИ
local AutoSellStatus = Instance.new("TextLabel")
AutoSellStatus.Parent = MainFrame
AutoSellStatus.BackgroundTransparency = 1
AutoSellStatus.Position = UDim2.new(0.05, 0, 0.29, 0)
AutoSellStatus.Size = UDim2.new(0.9, 0, 0, 18)
AutoSellStatus.Font = Enum.Font.Gotham
AutoSellStatus.Text = "🛒 Автопродажа: ВЫКЛ"
AutoSellStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
AutoSellStatus.TextSize = 11

-- СТАТУС АВТОПОКУПКИ
local AutoBuyStatus = Instance.new("TextLabel")
AutoBuyStatus.Parent = MainFrame
AutoBuyStatus.BackgroundTransparency = 1
AutoBuyStatus.Position = UDim2.new(0.05, 0, 0.35, 0)
AutoBuyStatus.Size = UDim2.new(0.9, 0, 0, 18)
AutoBuyStatus.Font = Enum.Font.Gotham
AutoBuyStatus.Text = "🛍️ Автопокупка: ВЫКЛ"
AutoBuyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
AutoBuyStatus.TextSize = 11

-- КНОПКИ АВТО
local ToggleSellBtn = Instance.new("TextButton")
ToggleSellBtn.Parent = MainFrame
ToggleSellBtn.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
ToggleSellBtn.BorderSizePixel = 0
ToggleSellBtn.Position = UDim2.new(0.05, 0, 0.42, 0)
ToggleSellBtn.Size = UDim2.new(0.43, 0, 0, 35)
ToggleSellBtn.Font = Enum.Font.GothamBold
ToggleSellBtn.Text = "🛒 ПРОДАЖА"
ToggleSellBtn.TextColor3 = GetColors()
ToggleSellBtn.TextSize = 11
AddNeonGlow(ToggleSellBtn, GetColors())
local SellCorner = Instance.new("UICorner")
SellCorner.CornerRadius = UDim.new(0, 8)
SellCorner.Parent = ToggleSellBtn

local ToggleBuyBtn = Instance.new("TextButton")
ToggleBuyBtn.Parent = MainFrame
ToggleBuyBtn.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
ToggleBuyBtn.BorderSizePixel = 0
ToggleBuyBtn.Position = UDim2.new(0.52, 0, 0.42, 0)
ToggleBuyBtn.Size = UDim2.new(0.43, 0, 0, 35)
ToggleBuyBtn.Font = Enum.Font.GothamBold
ToggleBuyBtn.Text = "🛍️ ПОКУПКА"
ToggleBuyBtn.TextColor3 = GetColors()
ToggleBuyBtn.TextSize = 11
AddNeonGlow(ToggleBuyBtn, GetColors())
local BuyCorner = Instance.new("UICorner")
BuyCorner.CornerRadius = UDim.new(0, 8)
BuyCorner.Parent = ToggleBuyBtn

-- КНОПКА СТАРТ/СТОП
local StartBtn = Instance.new("TextButton")
StartBtn.Parent = MainFrame
StartBtn.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
StartBtn.BorderSizePixel = 0
StartBtn.Position = UDim2.new(0.05, 0, 0.53, 0)
StartBtn.Size = UDim2.new(0.9, 0, 0, 45)
StartBtn.Font = Enum.Font.GothamBold
StartBtn.Text = "▶ СТАРТ"
StartBtn.TextColor3 = GetColors()
StartBtn.TextSize = 16
AddNeonGlow(StartBtn, GetColors(), 2)
local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0, 8)
StartCorner.Parent = StartBtn

-- КНОПКА НАСТРОЕК
local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Parent = MainFrame
SettingsBtn.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
SettingsBtn.BorderSizePixel = 0
SettingsBtn.Position = UDim2.new(0.05, 0, 0.67, 0)
SettingsBtn.Size = UDim2.new(0.9, 0, 0, 35)
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.Text = "⚙ НАСТРОЙКИ"
SettingsBtn.TextColor3 = GetColors()
SettingsBtn.TextSize = 14
AddNeonGlow(SettingsBtn, GetColors())
local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 8)
SettingsCorner.Parent = SettingsBtn

-- СТАТУС
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.05, 0, 0.79, 0)
StatusLabel.Size = UDim2.new(0.9, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "⚡ СТОП"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 12

-- ИНФО О СОЗДАТЕЛЕ
local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Parent = MainFrame
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Position = UDim2.new(0.05, 0, 0.87, 0)
CreatorLabel.Size = UDim2.new(0.9, 0, 0, 50)
CreatorLabel.Font = Enum.Font.Gotham
CreatorLabel.Text = "👑 ROBIN\n━━━━━━━━━━━━━━"
CreatorLabel.TextColor3 = GetColors()
CreatorLabel.TextSize = 11

-- ========== МЕНЮ ВЫБОРА КЕЙСОВ ==========
local CasesFrame = Instance.new("Frame")
CasesFrame.Parent = ScreenGui
CasesFrame.BackgroundColor3 = Color3.fromRGB(10, 5, 15)
CasesFrame.BackgroundTransparency = 0.1
CasesFrame.BorderSizePixel = 0
CasesFrame.Position = UDim2.new(0.3, 0, 0.12, 0)
CasesFrame.Size = UDim2.new(0, 380, 0, 550)
CasesFrame.Visible = false
CasesFrame.Active = true
CasesFrame.Draggable = true
AddNeonGlow(CasesFrame, GetColors(), 2)

local CasesCorner = Instance.new("UICorner")
CasesCorner.CornerRadius = UDim.new(0, 12)
CasesCorner.Parent = CasesFrame

local CasesTitle = Instance.new("TextLabel")
CasesTitle.Parent = CasesFrame
CasesTitle.BackgroundTransparency = 1
CasesTitle.Position = UDim2.new(0, 0, 0, 5)
CasesTitle.Size = UDim2.new(0.8, 0, 0, 35)
CasesTitle.Font = Enum.Font.GothamBold
CasesTitle.Text = "📦 ВЫБОР КЕЙСОВ"
CasesTitle.TextColor3 = GetColors()
CasesTitle.TextSize = 18
AddNeonGlow(CasesTitle, GetColors(), 1.5)

local CloseCasesBtn = Instance.new("TextButton")
CloseCasesBtn.Parent = CasesFrame
CloseCasesBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseCasesBtn.BorderSizePixel = 0
CloseCasesBtn.Position = UDim2.new(0.88, 0, 0.01, 0)
CloseCasesBtn.Size = UDim2.new(0, 30, 0, 30)
CloseCasesBtn.Font = Enum.Font.GothamBold
CloseCasesBtn.Text = "✕"
CloseCasesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseCasesBtn.TextSize = 18
AddNeonGlow(CloseCasesBtn, Color3.fromRGB(255, 100, 100))
local CloseCasesCorner = Instance.new("UICorner")
CloseCasesCorner.CornerRadius = UDim.new(0, 8)
CloseCasesCorner.Parent = CloseCasesBtn

local SearchBox = Instance.new("TextBox")
SearchBox.Parent = CasesFrame
SearchBox.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
SearchBox.BorderSizePixel = 0
SearchBox.Position = UDim2.new(0.05, 0, 0.09, 0)
SearchBox.Size = UDim2.new(0.9, 0, 0, 30)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "🔍 Поиск кейса..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 12
AddNeonGlow(SearchBox, GetColors())
local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchBox

local CasesScroll = Instance.new("ScrollingFrame")
CasesScroll.Parent = CasesFrame
CasesScroll.BackgroundColor3 = Color3.fromRGB(15, 8, 20)
CasesScroll.BorderSizePixel = 0
CasesScroll.Position = UDim2.new(0.05, 0, 0.16, 0)
CasesScroll.Size = UDim2.new(0.9, 0, 0, 370)
CasesScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
CasesScroll.ScrollBarThickness = 5
CasesScroll.ScrollBarImageColor3 = GetColors()
AddNeonGlow(CasesScroll, GetColors())
local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 8)
ScrollCorner.Parent = CasesScroll

local CasesList = Instance.new("UIListLayout")
CasesList.Parent = CasesScroll
CasesList.Padding = UDim.new(0, 5)
CasesList.SortOrder = Enum.SortOrder.Name

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = CasesFrame
InfoLabel.BackgroundTransparency = 1
InfoLabel.Position = UDim2.new(0.05, 0, 0.86, 0)
InfoLabel.Size = UDim2.new(0.9, 0, 0, 20)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Text = "💡 1 клик - выбрать | 2 клик - отменить"
InfoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
InfoLabel.TextSize = 10

local SaveCasesBtn = Instance.new("TextButton")
SaveCasesBtn.Parent = CasesFrame
SaveCasesBtn.BackgroundColor3 = GetColors()
SaveCasesBtn.BorderSizePixel = 0
SaveCasesBtn.Position = UDim2.new(0.05, 0, 0.91, 0)
SaveCasesBtn.Size = UDim2.new(0.9, 0, 0, 35)
SaveCasesBtn.Font = Enum.Font.GothamBold
SaveCasesBtn.Text = "✅ СОХРАНИТЬ И ЗАКРЫТЬ"
SaveCasesBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
SaveCasesBtn.TextSize = 13
AddNeonGlow(SaveCasesBtn, GetColors(), 2)
local SaveCorner = Instance.new("UICorner")
SaveCorner.CornerRadius = UDim.new(0, 8)
SaveCorner.Parent = SaveCasesBtn

-- ========== МЕНЮ НАСТРОЕК ==========
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Parent = ScreenGui
SettingsFrame.BackgroundColor3 = Color3.fromRGB(10, 5, 15)
SettingsFrame.BackgroundTransparency = 0.1
SettingsFrame.BorderSizePixel = 0
SettingsFrame.Position = UDim2.new(0.32, 0, 0.15, 0)
SettingsFrame.Size = UDim2.new(0, 340, 0, 480)
SettingsFrame.Visible = false
SettingsFrame.Active = true
SettingsFrame.Draggable = true
AddNeonGlow(SettingsFrame, GetColors(), 2)

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 12)
SettingsCorner.Parent = SettingsFrame

local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Parent = SettingsFrame
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Position = UDim2.new(0, 0, 0, 5)
SettingsTitle.Size = UDim2.new(0.8, 0, 0, 35)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.Text = "⚙ НАСТРОЙКИ"
SettingsTitle.TextColor3 = GetColors()
SettingsTitle.TextSize = 18
AddNeonGlow(SettingsTitle, GetColors(), 1.5)

local CloseSettingsBtn = Instance.new("TextButton")
CloseSettingsBtn.Parent = SettingsFrame
CloseSettingsBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseSettingsBtn.BorderSizePixel = 0
CloseSettingsBtn.Position = UDim2.new(0.88, 0, 0.01, 0)
CloseSettingsBtn.Size = UDim2.new(0, 30, 0, 30)
CloseSettingsBtn.Font = Enum.Font.GothamBold
CloseSettingsBtn.Text = "✕"
CloseSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseSettingsBtn.TextSize = 18
AddNeonGlow(CloseSettingsBtn, Color3.fromRGB(255, 100, 100))
local CloseSetCorner = Instance.new("UICorner")
CloseSetCorner.CornerRadius = UDim.new(0, 8)
CloseSetCorner.Parent = CloseSettingsBtn

-- ТЕМА
local ThemeLabel = Instance.new("TextLabel")
ThemeLabel.Parent = SettingsFrame
ThemeLabel.BackgroundTransparency = 1
ThemeLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
ThemeLabel.Size = UDim2.new(0.5, 0, 0, 25)
ThemeLabel.Font = Enum.Font.Gotham
ThemeLabel.Text = "🎨 Тема:"
ThemeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ThemeLabel.TextSize = 12

local ThemeDropdown = Instance.new("TextButton")
ThemeDropdown.Parent = SettingsFrame
ThemeDropdown.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
ThemeDropdown.BorderSizePixel = 0
ThemeDropdown.Position = UDim2.new(0.55, 0, 0.1, 0)
ThemeDropdown.Size = UDim2.new(0.4, 0, 0, 25)
ThemeDropdown.Font = Enum.Font.Gotham
ThemeDropdown.Text = NeonThemes[Settings.Theme].Name
ThemeDropdown.TextColor3 = GetColors()
ThemeDropdown.TextSize = 10
AddNeonGlow(ThemeDropdown, GetColors())
local ThemeCorner = Instance.new("UICorner")
ThemeCorner.CornerRadius = UDim.new(0, 5)
ThemeCorner.Parent = ThemeDropdown

local ThemeList = Instance.new("ScrollingFrame")
ThemeList.Parent = SettingsFrame
ThemeList.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
ThemeList.BorderSizePixel = 0
ThemeList.Position = UDim2.new(0.55, 0, 0.16, 0)
ThemeList.Size = UDim2.new(0.4, 0, 0, 100)
ThemeList.CanvasSize = UDim2.new(0, 0, 0, 8 * 25)
ThemeList.ScrollBarThickness = 3
ThemeList.Visible = false
AddNeonGlow(ThemeList, GetColors())
local ThemeListCorner = Instance.new("UICorner")
ThemeListCorner.CornerRadius = UDim.new(0, 5)
ThemeListCorner.Parent = ThemeList

local ThemeListLayout = Instance.new("UIListLayout")
ThemeListLayout.Parent = ThemeList
ThemeListLayout.Padding = UDim.new(0, 2)

for i, theme in ipairs(NeonThemes) do
    local btn = Instance.new("TextButton")
    btn.Parent = ThemeList
    btn.BackgroundColor3 = Color3.fromRGB(30, 15, 35)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, 0, 0, 25)
    btn.Font = Enum.Font.Gotham
    btn.Text = theme.Name
    btn.TextColor3 = theme.Secondary
    btn.TextSize = 9
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        Settings.Theme = i
        ThemeDropdown.Text = theme.Name
        ThemeList.Visible = false
        SaveSettings()
        -- Обновляем цвета
        local primary, secondary = GetColors()
        AddNeonGlow(MainFrame, primary, 2)
        AddNeonGlow(MiniFrame, primary, 2)
        Title.TextColor3 = secondary
        SelectCasesBtn.TextColor3 = secondary
        ToggleSellBtn.TextColor3 = secondary
        ToggleBuyBtn.TextColor3 = secondary
        StartBtn.TextColor3 = secondary
        SettingsBtn.TextColor3 = secondary
        CreatorLabel.TextColor3 = secondary
    end)
end

ThemeDropdown.MouseButton1Click:Connect(function()
    ThemeList.Visible = not ThemeList.Visible
end)

-- КОЛИЧЕСТВО КЕЙСОВ ЗА РАЗ
local AmountLabel = Instance.new("TextLabel")
AmountLabel.Parent = SettingsFrame
AmountLabel.BackgroundTransparency = 1
AmountLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
AmountLabel.Size = UDim2.new(0.5, 0, 0, 25)
AmountLabel.Font = Enum.Font.Gotham
AmountLabel.Text = "📦 Кейсов за раз:"
AmountLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
AmountLabel.TextSize = 12

local AmountBox = Instance.new("TextBox")
AmountBox.Parent = SettingsFrame
AmountBox.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
AmountBox.BorderSizePixel = 0
AmountBox.Position = UDim2.new(0.55, 0, 0.2, 0)
AmountBox.Size = UDim2.new(0.4, 0, 0, 25)
AmountBox.Font = Enum.Font.GothamBold
AmountBox.Text = tostring(Settings.OpenAmount)
AmountBox.TextColor3 = GetColors()
AmountBox.TextSize = 12
AddNeonGlow(AmountBox, GetColors())
local AmountCorner = Instance.new("UICorner")
AmountCorner.CornerRadius = UDim.new(0, 5)
AmountCorner.Parent = AmountBox

-- ЗАДЕРЖКА
local DelayLabel = Instance.new("TextLabel")
DelayLabel.Parent = SettingsFrame
DelayLabel.BackgroundTransparency = 1
DelayLabel.Position = UDim2.new(0.05, 0, 0.28, 0)
DelayLabel.Size = UDim2.new(0.5, 0, 0, 25)
DelayLabel.Font = Enum.Font.Gotham
DelayLabel.Text = "⚡ Задержка (сек):"
DelayLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DelayLabel.TextSize = 12

local DelayBox = Instance.new("TextBox")
DelayBox.Parent = SettingsFrame
DelayBox.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
DelayBox.BorderSizePixel = 0
DelayBox.Position = UDim2.new(0.55, 0, 0.28, 0)
DelayBox.Size = UDim2.new(0.4, 0, 0, 25)
DelayBox.Font = Enum.Font.GothamBold
DelayBox.Text = tostring(Settings.FarmDelay)
DelayBox.TextColor3 = GetColors()
DelayBox.TextSize = 12
AddNeonGlow(DelayBox, GetColors())
local DelayCorner = Instance.new("UICorner")
DelayCorner.CornerRadius = UDim.new(0, 5)
DelayCorner.Parent = DelayBox

-- СКОРОСТЬ АВТОПОКУПКИ
local BuySpeedLabel = Instance.new("TextLabel")
BuySpeedLabel.Parent = SettingsFrame
BuySpeedLabel.BackgroundTransparency = 1
BuySpeedLabel.Position = UDim2.new(0.05, 0, 0.36, 0)
BuySpeedLabel.Size = UDim2.new(0.5, 0, 0, 25)
BuySpeedLabel.Font = Enum.Font.Gotham
BuySpeedLabel.Text = "🛍️ Скорость покупки:"
BuySpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
BuySpeedLabel.TextSize = 12

local BuySpeedBox = Instance.new("TextBox")
BuySpeedBox.Parent = SettingsFrame
BuySpeedBox.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
BuySpeedBox.BorderSizePixel = 0
BuySpeedBox.Position = UDim2.new(0.55, 0, 0.36, 0)
BuySpeedBox.Size = UDim2.new(0.4, 0, 0, 25)
BuySpeedBox.Font = Enum.Font.GothamBold
BuySpeedBox.Text = tostring(Settings.AutoBuySpeed)
BuySpeedBox.TextColor3 = GetColors()
BuySpeedBox.TextSize = 12
AddNeonGlow(BuySpeedBox, GetColors())
local BuySpeedCorner = Instance.new("UICorner")
BuySpeedCorner.CornerRadius = UDim.new(0, 5)
BuySpeedCorner.Parent = BuySpeedBox

-- УДАЧА ВКЛ/ВЫКЛ
local LuckToggleLabel = Instance.new("TextLabel")
LuckToggleLabel.Parent = SettingsFrame
LuckToggleLabel.BackgroundTransparency = 1
LuckToggleLabel.Position = UDim2.new(0.05, 0, 0.44, 0)
LuckToggleLabel.Size = UDim2.new(0.5, 0, 0, 25)
LuckToggleLabel.Font = Enum.Font.Gotham
LuckToggleLabel.Text = "🍀 Удача:"
LuckToggleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
LuckToggleLabel.TextSize = 12

local LuckToggleBtn = Instance.new("TextButton")
LuckToggleBtn.Parent = SettingsFrame
LuckToggleBtn.BackgroundColor3 = Settings.LuckEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
LuckToggleBtn.BorderSizePixel = 0
LuckToggleBtn.Position = UDim2.new(0.55, 0, 0.44, 0)
LuckToggleBtn.Size = UDim2.new(0.4, 0, 0, 25)
LuckToggleBtn.Font = Enum.Font.GothamBold
LuckToggleBtn.Text = Settings.LuckEnabled and "ВКЛ" or "ВЫКЛ"
LuckToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LuckToggleBtn.TextSize = 12
AddNeonGlow(LuckToggleBtn, Settings.LuckEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0))
local LuckToggleCorner = Instance.new("UICorner")
LuckToggleCorner.CornerRadius = UDim.new(0, 5)
LuckToggleCorner.Parent = LuckToggleBtn

-- МНОЖИТЕЛЬ УДАЧИ
local LuckMultLabel = Instance.new("TextLabel")
LuckMultLabel.Parent = SettingsFrame
LuckMultLabel.BackgroundTransparency = 1
LuckMultLabel.Position = UDim2.new(0.05, 0, 0.52, 0)
LuckMultLabel.Size = UDim2.new(0.5, 0, 0, 25)
LuckMultLabel.Font = Enum.Font.Gotham
LuckMultLabel.Text = "📊 Множитель:"
LuckMultLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
LuckMultLabel.TextSize = 12

local LuckMultDropdown = Instance.new("TextButton")
LuckMultDropdown.Parent = SettingsFrame
LuckMultDropdown.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
LuckMultDropdown.BorderSizePixel = 0
LuckMultDropdown.Position = UDim2.new(0.55, 0, 0.52, 0)
LuckMultDropdown.Size = UDim2.new(0.4, 0, 0, 25)
LuckMultDropdown.Font = Enum.Font.Gotham
LuckMultDropdown.Text = "x" .. Settings.LuckMultiplier
LuckMultDropdown.TextColor3 = GetColors()
LuckMultDropdown.TextSize = 12
AddNeonGlow(LuckMultDropdown, GetColors())
local LuckMultCorner = Instance.new("UICorner")
LuckMultCorner.CornerRadius = UDim.new(0, 5)
LuckMultCorner.Parent = LuckMultDropdown

local LuckMultList = Instance.new("ScrollingFrame")
LuckMultList.Parent = SettingsFrame
LuckMultList.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
LuckMultList.BorderSizePixel = 0
LuckMultList.Position = UDim2.new(0.55, 0, 0.58, 0)
LuckMultList.Size = UDim2.new(0.4, 0, 0, 75)
LuckMultList.CanvasSize = UDim2.new(0, 0, 0, 3 * 25)
LuckMultList.ScrollBarThickness = 3
LuckMultList.Visible = false
AddNeonGlow(LuckMultList, GetColors())
local LuckMultListCorner = Instance.new("UICorner")
LuckMultListCorner.CornerRadius = UDim.new(0, 5)
LuckMultListCorner.Parent = LuckMultList

local LuckMultLayout = Instance.new("UIListLayout")
LuckMultLayout.Parent = LuckMultList
LuckMultLayout.Padding = UDim.new(0, 2)

for _, mult in ipairs({2, 4, 6}) do
    local btn = Instance.new("TextButton")
    btn.Parent = LuckMultList
    btn.BackgroundColor3 = Color3.fromRGB(30, 15, 35)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, 0, 0, 25)
    btn.Font = Enum.Font.Gotham
    btn.Text = "x" .. mult
    btn.TextColor3 = GetColors()
    btn.TextSize = 10
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        Settings.LuckMultiplier = mult
        LuckMultDropdown.Text = "x" .. mult
        LuckMultList.Visible = false
        SaveSettings()
    end)
end

LuckMultDropdown.MouseButton1Click:Connect(function()
    LuckMultList.Visible = not LuckMultList.Visible
end)

-- ВРЕМЯ УДАЧИ
local LuckTimeLabel = Instance.new("TextLabel")
LuckTimeLabel.Parent = SettingsFrame
LuckTimeLabel.BackgroundTransparency = 1
LuckTimeLabel.Position = UDim2.new(0.05, 0, 0.6, 0)
LuckTimeLabel.Size = UDim2.new(0.5, 0, 0, 25)
LuckTimeLabel.Font = Enum.Font.Gotham
LuckTimeLabel.Text = "⏱️ Время удачи (мин):"
LuckTimeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
LuckTimeLabel.TextSize = 12

local LuckTimeBox = Instance.new("TextBox")
LuckTimeBox.Parent = SettingsFrame
LuckTimeBox.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
LuckTimeBox.BorderSizePixel = 0
LuckTimeBox.Position = UDim2.new(0.55, 0, 0.6, 0)
LuckTimeBox.Size = UDim2.new(0.4, 0, 0, 25)
LuckTimeBox.Font = Enum.Font.GothamBold
LuckTimeBox.Text = "5"
LuckTimeBox.TextColor3 = GetColors()
LuckTimeBox.TextSize = 12
AddNeonGlow(LuckTimeBox, GetColors())
local LuckTimeCorner = Instance.new("UICorner")
LuckTimeCorner.CornerRadius = UDim.new(0, 5)
LuckTimeCorner.Parent = LuckTimeBox

-- ИНФО О СОЗДАТЕЛЕ В НАСТРОЙКАХ
local SettingsCreatorLabel = Instance.new("TextLabel")
SettingsCreatorLabel.Parent = SettingsFrame
SettingsCreatorLabel.BackgroundTransparency = 1
SettingsCreatorLabel.Position = UDim2.new(0.05, 0, 0.75, 0)
SettingsCreatorLabel.Size = UDim2.new(0.9, 0, 0, 60)
SettingsCreatorLabel.Font = Enum.Font.Gotham
SettingsCreatorLabel.Text = "👑 СОЗДАТЕЛЬ: ROBIN\n━━━━━━━━━━━━━━\n⚡ Neo Case Farm v2.0"
SettingsCreatorLabel.TextColor3 = GetColors()
SettingsCreatorLabel.TextSize = 11
SettingsCreatorLabel.TextWrapped = true

-- ========== КЛЕВЕР УДАЧИ (ПРАВЫЙ НИЖНИЙ УГОЛ) ==========
local CloverFrame = Instance.new("Frame")
CloverFrame.Parent = ScreenGui
CloverFrame.BackgroundColor3 = Color3.fromRGB(10, 5, 15)
CloverFrame.BackgroundTransparency = 0.2
CloverFrame.BorderSizePixel = 0
CloverFrame.Position = UDim2.new(0.92, 0, 0.88, 0)
CloverFrame.Size = UDim2.new(0, 60, 0, 60)
CloverFrame.Visible = false
AddNeonGlow(CloverFrame, Color3.fromRGB(0, 255, 0), 2)

local CloverCorner = Instance.new("UICorner")
CloverCorner.CornerRadius = UDim.new(0, 30)
CloverCorner.Parent = CloverFrame

local CloverIcon = Instance.new("TextLabel")
CloverIcon.Parent = CloverFrame
CloverIcon.BackgroundTransparency = 1
CloverIcon.Size = UDim2.new(1, 0, 0.7, 0)
CloverIcon.Font = Enum.Font.GothamBold
CloverIcon.Text = "🍀"
CloverIcon.TextColor3 = Color3.fromRGB(0, 255, 100)
CloverIcon.TextSize = 30
AddNeonGlow(CloverIcon, Color3.fromRGB(0, 255, 0), 1.5)

local CloverTimer = Instance.new("TextLabel")
CloverTimer.Parent = CloverFrame
CloverTimer.BackgroundTransparency = 1
CloverTimer.Position = UDim2.new(0, 0, 0.65, 0)
CloverTimer.Size = UDim2.new(1, 0, 0, 20)
CloverTimer.Font = Enum.Font.GothamBold
CloverTimer.Text = "5:00"
CloverTimer.TextColor3 = Color3.fromRGB(0, 255, 100)
CloverTimer.TextSize = 12

local CloverMult = Instance.new("TextLabel")
CloverMult.Parent = CloverFrame
CloverMult.BackgroundTransparency = 1
CloverMult.Position = UDim2.new(0, 0, 0.5, 0)
CloverMult.Size = UDim2.new(1, 0, 0, 15)
CloverMult.Font = Enum.Font.GothamBold
CloverMult.Text = "x2"
CloverMult.TextColor3 = Color3.fromRGB(255, 255, 0)
CloverMult.TextSize = 10

-- ========== ФУНКЦИИ ==========
local function UpdateSelectedCount()
    local count = 0
    for _ in pairs(Settings.SelectedCases) do count = count + 1 end
    SelectedCountLabel.Text = "📋 Выбрано: " .. count .. " кейсов"
end

local function IsCaseSelected(caseName)
    return Settings.SelectedCases[caseName] == true
end

local function RefreshCasesList(searchText)
    for _, child in pairs(CasesScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local yPos = 0
    for _, caseName in ipairs(AllCases) do
        if searchText == "" or string.find(string.lower(caseName), string.lower(searchText)) then
            local btn = Instance.new("TextButton")
            btn.Parent = CasesScroll
            btn.BackgroundColor3 = IsCaseSelected(caseName) and GetColors() or Color3.fromRGB(30, 15, 35)
            btn.BorderSizePixel = 0
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Position = UDim2.new(0, 5, 0, yPos)
            btn.Font = Enum.Font.Gotham
            btn.Text = (IsCaseSelected(caseName) and "✅ " or "☐ ") .. caseName
            btn.TextColor3 = IsCaseSelected(caseName) and Color3.fromRGB(0, 0, 0) or GetColors()
            btn.TextSize = 11
            AddNeonGlow(btn, GetColors(), 1)
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = btn
            
            btn.MouseButton1Click:Connect(function()
                if IsCaseSelected(caseName) then
                    Settings.SelectedCases[caseName] = nil
                else
                    Settings.SelectedCases[caseName] = true
                end
                RefreshCasesList(SearchBox.Text)
                UpdateSelectedCount()
            end)
            
            yPos = yPos + 35
        end
    end
    
    CasesScroll.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

local function UpdateStatusLabels()
    AutoSellStatus.Text = AutoSellEnabled and "🛒 Автопродажа: ВКЛ" or "🛒 Автопродажа: ВЫКЛ"
    AutoSellStatus.TextColor3 = AutoSellEnabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    AutoBuyStatus.Text = AutoBuyEnabled and "🛍️ Автопокупка: ВКЛ" or "🛍️ Автопокупка: ВЫКЛ"
    AutoBuyStatus.TextColor3 = AutoBuyEnabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 100, 100)
end

local function UpdateLuckTimer()
    if LuckActive then
        local remaining = LuckEndTime - os.time()
        if remaining <= 0 then
            LuckActive = false
            CloverFrame.Visible = false
            Settings.LuckEnabled = false
            LuckToggleBtn.Text = "ВЫКЛ"
            LuckToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        else
            local minutes = math.floor(remaining / 60)
            local seconds = remaining % 60
            CloverTimer.Text = string.format("%d:%02d", minutes, seconds)
        end
    end
end

local function FarmLoop()
    while Farming do
        pcall(function()
            local Events = ReplicatedStorage:FindFirstChild("Events")
            if Events then
                local OpenCase = Events:FindFirstChild("OpenCase")
                
                for caseName, _ in pairs(Settings.SelectedCases) do
                    if OpenCase then
                        for i = 1, Settings.OpenAmount do
                            OpenCase:InvokeServer(caseName, 1)
                            task.wait(0.05)
                        end
                    end
                    task.wait(Settings.FarmDelay)
                end
                
                if AutoSellEnabled then
                    local Inventory = Events:FindFirstChild("Inventory")
                    if Inventory then
                        Inventory:FireServer("Sell", "ALL")
                    end
                end
                
                if AutoBuyEnabled then
                    local BuyCase = Events:FindFirstChild("BuyCase")
                    if BuyCase then
                        for caseName, _ in pairs(Settings.SelectedCases) do
                            BuyCase:InvokeServer(caseName, 1)
                            task.wait(Settings.AutoBuySpeed)
                        end
                    end
                end
            end
        end)
        task.wait(Settings.FarmDelay)
    end
end

-- ========== ПОДКЛЮЧЕНИЕ СОБЫТИЙ ==========
MiniButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MiniFrame.Visible = false
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniFrame.Visible = true
end)

SelectCasesBtn.MouseButton1Click:Connect(function()
    CasesFrame.Visible = true
    RefreshCasesList("")
    UpdateSelectedCount()
end)

CloseCasesBtn.MouseButton1Click:Connect(function()
    CasesFrame.Visible = false
end)

SaveCasesBtn.MouseButton1Click:Connect(function()
    SaveSettings()
    CasesFrame.Visible = false
    UpdateSelectedCount()
end)

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    RefreshCasesList(SearchBox.Text)
end)

ToggleSellBtn.MouseButton1Click:Connect(function()
    AutoSellEnabled = not AutoSellEnabled
    UpdateStatusLabels()
end)

ToggleBuyBtn.MouseButton1Click:Connect(function()
    AutoBuyEnabled = not AutoBuyEnabled
    UpdateStatusLabels()
end)

StartBtn.MouseButton1Click:Connect(function()
    if next(Settings.SelectedCases) == nil then
        StatusLabel.Text = "⚠️ ВЫБЕРИТЕ КЕЙСЫ!"
        task.wait(2)
        StatusLabel.Text = "⚡ СТОП"
        return
    end
    
    Farming = not Farming
    if Farming then
        StartBtn.Text = "⏹ СТОП"
        StatusLabel.Text = "⚡ ФАРМ АКТИВЕН"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
        task.spawn(FarmLoop)
    else
        StartBtn.Text = "▶ СТАРТ"
        StatusLabel.Text = "⚡ СТОП"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

SettingsBtn.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = true
end)

CloseSettingsBtn.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = false
end)

AmountBox.FocusLost:Connect(function()
    local num = tonumber(AmountBox.Text)
    if num and num >= 1 and num <= 100 then
        Settings.OpenAmount = math.floor(num)
        AmountBox.Text = tostring(Settings.OpenAmount)
        SaveSettings()
    else
        AmountBox.Text = tostring(Settings.OpenAmount)
    end
end)

DelayBox.FocusLost:Connect(function()
    local num = tonumber(DelayBox.Text)
    if num and num >= 0.001 then
        Settings.FarmDelay = num
        DelayBox.Text = tostring(Settings.FarmDelay)
        SaveSettings()
    else
        DelayBox.Text = tostring(Settings.FarmDelay)
    end
end)

BuySpeedBox.FocusLost:Connect(function()
    local num = tonumber(BuySpeedBox.Text)
    if num and num >= 0.1 then
        Settings.AutoBuySpeed = num
        BuySpeedBox.Text = tostring(Settings.AutoBuySpeed)
        SaveSettings()
    else
        BuySpeedBox.Text = tostring(Settings.AutoBuySpeed)
    end
end)

LuckToggleBtn.MouseButton1Click:Connect(function()
    if not LuckActive then
        local timeMinutes = tonumber(LuckTimeBox.Text) or 5
        LuckActive = true
        LuckEndTime = os.time() + (timeMinutes * 60)
        Settings.LuckEnabled = true
        LuckToggleBtn.Text = "ВКЛ"
        LuckToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        
        CloverFrame.Visible = true
        CloverMult.Text = "x" .. Settings.LuckMultiplier
        
        if Settings.LuckMultiplier == 4 then
            CloverIcon.Text = "🍀🍀"
            CloverIcon.TextSize = 25
        elseif Settings.LuckMultiplier == 6 then
            CloverIcon.Text = "🌟🍀🌟"
            CloverIcon.TextSize = 20
        else
            CloverIcon.Text = "🍀"
            CloverIcon.TextSize = 30
        end
        
        UpdateLuckTimer()
    else
        LuckActive = false
        Settings.LuckEnabled = false
        LuckToggleBtn.Text = "ВЫКЛ"
        LuckToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        CloverFrame.Visible = false
    end
    SaveSettings()
end)

RunService.Heartbeat:Connect(function()
    if LuckActive then
        UpdateLuckTimer()
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        ThemeList.Visible = false
        LuckMultList.Visible = false
    end
end)

-- ========== ИНИЦИАЛИЗАЦИЯ ==========
UpdateSelectedCount()
UpdateStatusLabels()

AmountBox.Text = tostring(Settings.OpenAmount)
DelayBox.Text = tostring(Settings.FarmDelay)
BuySpeedBox.Text = tostring(Settings.AutoBuySpeed)

print("✅ NEO CASE FARM BY ROBIN LOADED!")
