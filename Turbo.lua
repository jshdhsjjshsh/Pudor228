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

-- ТЕМЫ (ПО УМОЛЧАНИЮ ЧЕРНАЯ С БЕЛЫМИ БУКВАМИ)
local Themes = {
    {Name = "Черная + Белая", Primary = Color3.fromRGB(255, 255, 255), Secondary = Color3.fromRGB(200, 200, 200), BgColor = Color3.fromRGB(20, 20, 20), BtnColor = Color3.fromRGB(35, 35, 35)},
    {Name = "Фиолетовый + Салатовый", Primary = Color3.fromRGB(200, 0, 255), Secondary = Color3.fromRGB(0, 255, 100), BgColor = Color3.fromRGB(15, 5, 20), BtnColor = Color3.fromRGB(25, 10, 30)},
    {Name = "Синий + Розовый", Primary = Color3.fromRGB(0, 150, 255), Secondary = Color3.fromRGB(255, 0, 200), BgColor = Color3.fromRGB(5, 5, 20), BtnColor = Color3.fromRGB(10, 10, 30)},
    {Name = "Красный + Желтый", Primary = Color3.fromRGB(255, 0, 0), Secondary = Color3.fromRGB(255, 255, 0), BgColor = Color3.fromRGB(20, 5, 5), BtnColor = Color3.fromRGB(30, 10, 10)},
    {Name = "Голубой + Оранжевый", Primary = Color3.fromRGB(0, 255, 255), Secondary = Color3.fromRGB(255, 150, 0), BgColor = Color3.fromRGB(5, 15, 20), BtnColor = Color3.fromRGB(10, 20, 25)},
    {Name = "Белый + Золотой", Primary = Color3.fromRGB(255, 255, 255), Secondary = Color3.fromRGB(255, 215, 0), BgColor = Color3.fromRGB(20, 20, 20), BtnColor = Color3.fromRGB(30, 30, 30)},
    {Name = "Розовый + Фиолетовый", Primary = Color3.fromRGB(255, 0, 150), Secondary = Color3.fromRGB(150, 0, 255), BgColor = Color3.fromRGB(20, 5, 15), BtnColor = Color3.fromRGB(30, 10, 20)},
    {Name = "Зеленый + Бирюзовый", Primary = Color3.fromRGB(0, 255, 0), Secondary = Color3.fromRGB(0, 255, 150), BgColor = Color3.fromRGB(5, 20, 10), BtnColor = Color3.fromRGB(10, 25, 15)},
    {Name = "Оранжевый + Красный", Primary = Color3.fromRGB(255, 100, 0), Secondary = Color3.fromRGB(255, 0, 50), BgColor = Color3.fromRGB(20, 10, 5), BtnColor = Color3.fromRGB(30, 15, 10)}
}

-- ПАРОЛЬ
local PASSWORD = "mr.comcom"
local Authorized = false

-- ЗАГРУЗКА НАСТРОЕК
local Settings = {
    Theme = 1,
    OpenAmount = 10,
    FarmDelay = 0.01,
    AutoBuySpeed = 1.0,
    AutoBuyAmount = 1,
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
local SaveActive = false
local SaveEndTime = 0

-- ТЕКУЩИЕ ЦВЕТА
local function GetColors()
    return Themes[Settings.Theme].Primary, Themes[Settings.Theme].Secondary
end

local function GetBgColor()
    return Themes[Settings.Theme].BgColor
end

local function GetBtnColor()
    return Themes[Settings.Theme].BtnColor
end

-- ФУНКЦИЯ НЕОНОВОГО СВЕЧЕНИЯ
local function AddNeonGlow(guiObject, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 2
    stroke.Transparency = 0
    stroke.Parent = guiObject
    return stroke
end

-- ========== ОКНО ВВОДА ПАРОЛЯ ==========
local PasswordFrame = Instance.new("Frame")
PasswordFrame.Parent = LocalPlayer:WaitForChild("PlayerGui")
PasswordFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PasswordFrame.BorderSizePixel = 0
PasswordFrame.Position = UDim2.new(0.35, 0, 0.4, 0)
PasswordFrame.Size = UDim2.new(0, 250, 0, 120)
PasswordFrame.Active = true
PasswordFrame.Draggable = true
AddNeonGlow(PasswordFrame, Color3.fromRGB(255, 255, 255), 2)

local PassCorner = Instance.new("UICorner")
PassCorner.CornerRadius = UDim.new(0, 10)
PassCorner.Parent = PasswordFrame

local PassTitle = Instance.new("TextLabel")
PassTitle.Parent = PasswordFrame
PassTitle.BackgroundTransparency = 1
PassTitle.Position = UDim2.new(0, 0, 0, 10)
PassTitle.Size = UDim2.new(1, 0, 0, 25)
PassTitle.Font = Enum.Font.GothamBold
PassTitle.Text = "🔐 ВВЕДИТЕ ПАРОЛЬ"
PassTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PassTitle.TextSize = 14

local PassBox = Instance.new("TextBox")
PassBox.Parent = PasswordFrame
PassBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PassBox.BorderSizePixel = 0
PassBox.Position = UDim2.new(0.1, 0, 0.4, 0)
PassBox.Size = UDim2.new(0.8, 0, 0, 30)
PassBox.Font = Enum.Font.Gotham
PassBox.PlaceholderText = "Пароль..."
PassBox.Text = ""
PassBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PassBox.TextSize = 12
AddNeonGlow(PassBox, Color3.fromRGB(255, 255, 255))
local PassBoxCorner = Instance.new("UICorner")
PassBoxCorner.CornerRadius = UDim.new(0, 5)
PassBoxCorner.Parent = PassBox

local PassBtn = Instance.new("TextButton")
PassBtn.Parent = PasswordFrame
PassBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
PassBtn.BorderSizePixel = 0
PassBtn.Position = UDim2.new(0.3, 0, 0.75, 0)
PassBtn.Size = UDim2.new(0.4, 0, 0, 25)
PassBtn.Font = Enum.Font.GothamBold
PassBtn.Text = "ВОЙТИ"
PassBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PassBtn.TextSize = 12
AddNeonGlow(PassBtn, Color3.fromRGB(0, 255, 0))
local PassBtnCorner = Instance.new("UICorner")
PassBtnCorner.CornerRadius = UDim.new(0, 5)
PassBtnCorner.Parent = PassBtn

local PassError = Instance.new("TextLabel")
PassError.Parent = PasswordFrame
PassError.BackgroundTransparency = 1
PassError.Position = UDim2.new(0, 0, 0.85, 0)
PassError.Size = UDim2.new(1, 0, 0, 15)
PassError.Font = Enum.Font.Gotham
PassError.Text = ""
PassError.TextColor3 = Color3.fromRGB(255, 0, 0)
PassError.TextSize = 9
PassError.Visible = false

PassBtn.MouseButton1Click:Connect(function()
    if PassBox.Text == PASSWORD then
        Authorized = true
        PasswordFrame.Visible = false
        CreateGUI()
    else
        PassError.Text = "❌ Неверный пароль!"
        PassError.Visible = true
        task.wait(2)
        PassError.Visible = false
    end
end)

PassBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        if PassBox.Text == PASSWORD then
            Authorized = true
            PasswordFrame.Visible = false
            CreateGUI()
        else
            PassError.Text = "❌ Неверный пароль!"
            PassError.Visible = true
            task.wait(2)
            PassError.Visible = false
        end
    end
end)

-- ========== СОЗДАНИЕ GUI ПОСЛЕ АВТОРИЗАЦИИ ==========
function CreateGUI()
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NeoCaseFarm"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- ========== МАЛЕНЬКОЕ СВЕРНУТОЕ МЕНЮ ==========
local MiniFrame = Instance.new("Frame")
MiniFrame.Parent = ScreenGui
MiniFrame.BackgroundColor3 = GetBgColor()
MiniFrame.BackgroundTransparency = 0.1
MiniFrame.BorderSizePixel = 0
MiniFrame.Position = UDim2.new(0.88, 0, 0.88, 0)
MiniFrame.Size = UDim2.new(0, 35, 0, 35)
MiniFrame.Active = true
MiniFrame.Draggable = true
MiniFrame.Visible = false
AddNeonGlow(MiniFrame, GetColors(), 2)

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 18)
MiniCorner.Parent = MiniFrame

local MiniButton = Instance.new("TextButton")
MiniButton.Parent = MiniFrame
MiniButton.BackgroundTransparency = 1
MiniButton.Size = UDim2.new(1, 0, 1, 0)
MiniButton.Font = Enum.Font.GothamBold
MiniButton.Text = "📦"
MiniButton.TextColor3 = GetColors()
MiniButton.TextSize = 18
AddNeonGlow(MiniButton, GetColors(), 1.5)

-- ========== ГЛАВНОЕ МЕНЮ ==========
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = GetBgColor()
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.38, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 340)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
AddNeonGlow(MainFrame, GetColors(), 2)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- КНОПКА СВЕРНУТЬ
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundColor3 = GetColors()
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Position = UDim2.new(0.82, 0, 0.02, 0)
MinimizeBtn.Size = UDim2.new(0, 22, 0, 22)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeBtn.TextSize = 14
AddNeonGlow(MinimizeBtn, GetColors(), 1.5)
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

-- ЗАГОЛОВОК
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Size = UDim2.new(0.8, 0, 0, 25)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ NEO FARM ⚡"
Title.TextColor3 = GetColors()
Title.TextSize = 13
AddNeonGlow(Title, GetColors(), 1.5)

-- КНОПКА ВЫБОРА КЕЙСОВ
local SelectCasesBtn = Instance.new("TextButton")
SelectCasesBtn.Parent = MainFrame
SelectCasesBtn.BackgroundColor3 = GetBtnColor()
SelectCasesBtn.BorderSizePixel = 0
SelectCasesBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
SelectCasesBtn.Size = UDim2.new(0.9, 0, 0, 30)
SelectCasesBtn.Font = Enum.Font.GothamBold
SelectCasesBtn.Text = "📦 КЕЙСЫ"
SelectCasesBtn.TextColor3 = GetColors()
SelectCasesBtn.TextSize = 11
AddNeonGlow(SelectCasesBtn, GetColors())
local SelectCorner = Instance.new("UICorner")
SelectCorner.CornerRadius = UDim.new(0, 6)
SelectCorner.Parent = SelectCasesBtn

-- СЧЕТЧИК КЕЙСОВ
local SelectedCountLabel = Instance.new("TextLabel")
SelectedCountLabel.Parent = MainFrame
SelectedCountLabel.BackgroundTransparency = 1
SelectedCountLabel.Position = UDim2.new(0.05, 0, 0.23, 0)
SelectedCountLabel.Size = UDim2.new(0.9, 0, 0, 15)
SelectedCountLabel.Font = Enum.Font.Gotham
SelectedCountLabel.Text = "📋 0 кейсов"
SelectedCountLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SelectedCountLabel.TextSize = 9

-- СТАТУС АВТОПРОДАЖИ
local AutoSellStatus = Instance.new("TextLabel")
AutoSellStatus.Parent = MainFrame
AutoSellStatus.BackgroundTransparency = 1
AutoSellStatus.Position = UDim2.new(0.05, 0, 0.29, 0)
AutoSellStatus.Size = UDim2.new(0.9, 0, 0, 14)
AutoSellStatus.Font = Enum.Font.Gotham
AutoSellStatus.Text = "🛒 Продажа: ВЫКЛ"
AutoSellStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
AutoSellStatus.TextSize = 9

-- СТАТУС АВТОПОКУПКИ
local AutoBuyStatus = Instance.new("TextLabel")
AutoBuyStatus.Parent = MainFrame
AutoBuyStatus.BackgroundTransparency = 1
AutoBuyStatus.Position = UDim2.new(0.05, 0, 0.35, 0)
AutoBuyStatus.Size = UDim2.new(0.9, 0, 0, 14)
AutoBuyStatus.Font = Enum.Font.Gotham
AutoBuyStatus.Text = "🛍️ Покупка: ВЫКЛ"
AutoBuyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
AutoBuyStatus.TextSize = 9

-- КНОПКИ АВТО
local ToggleSellBtn = Instance.new("TextButton")
ToggleSellBtn.Parent = MainFrame
ToggleSellBtn.BackgroundColor3 = GetBtnColor()
ToggleSellBtn.BorderSizePixel = 0
ToggleSellBtn.Position = UDim2.new(0.05, 0, 0.42, 0)
ToggleSellBtn.Size = UDim2.new(0.43, 0, 0, 28)
ToggleSellBtn.Font = Enum.Font.GothamBold
ToggleSellBtn.Text = "🛒 ПРОД"
ToggleSellBtn.TextColor3 = GetColors()
ToggleSellBtn.TextSize = 9
AddNeonGlow(ToggleSellBtn, GetColors())
local SellCorner = Instance.new("UICorner")
SellCorner.CornerRadius = UDim.new(0, 6)
SellCorner.Parent = ToggleSellBtn

local ToggleBuyBtn = Instance.new("TextButton")
ToggleBuyBtn.Parent = MainFrame
ToggleBuyBtn.BackgroundColor3 = GetBtnColor()
ToggleBuyBtn.BorderSizePixel = 0
ToggleBuyBtn.Position = UDim2.new(0.52, 0, 0.42, 0)
ToggleBuyBtn.Size = UDim2.new(0.43, 0, 0, 28)
ToggleBuyBtn.Font = Enum.Font.GothamBold
ToggleBuyBtn.Text = "🛍️ ПОКУП"
ToggleBuyBtn.TextColor3 = GetColors()
ToggleBuyBtn.TextSize = 9
AddNeonGlow(ToggleBuyBtn, GetColors())
local BuyCorner = Instance.new("UICorner")
BuyCorner.CornerRadius = UDim.new(0, 6)
BuyCorner.Parent = ToggleBuyBtn

-- КНОПКА СТАРТ/СТОП
local StartBtn = Instance.new("TextButton")
StartBtn.Parent = MainFrame
StartBtn.BackgroundColor3 = GetBtnColor()
StartBtn.BorderSizePixel = 0
StartBtn.Position = UDim2.new(0.05, 0, 0.53, 0)
StartBtn.Size = UDim2.new(0.9, 0, 0, 35)
StartBtn.Font = Enum.Font.GothamBold
StartBtn.Text = "▶ СТАРТ"
StartBtn.TextColor3 = GetColors()
StartBtn.TextSize = 13
AddNeonGlow(StartBtn, GetColors(), 2)
local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0, 6)
StartCorner.Parent = StartBtn

-- КНОПКА НАСТРОЕК
local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Parent = MainFrame
SettingsBtn.BackgroundColor3 = GetBtnColor()
SettingsBtn.BorderSizePixel = 0
SettingsBtn.Position = UDim2.new(0.05, 0, 0.67, 0)
SettingsBtn.Size = UDim2.new(0.9, 0, 0, 28)
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.Text = "⚙ НАСТРОЙКИ"
SettingsBtn.TextColor3 = GetColors()
SettingsBtn.TextSize = 11
AddNeonGlow(SettingsBtn, GetColors())
local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 6)
SettingsCorner.Parent = SettingsBtn

-- КНОПКА ТЕМЫ
local ThemeBtn = Instance.new("TextButton")
ThemeBtn.Parent = MainFrame
ThemeBtn.BackgroundColor3 = GetBtnColor()
ThemeBtn.BorderSizePixel = 0
ThemeBtn.Position = UDim2.new(0.05, 0, 0.78, 0)
ThemeBtn.Size = UDim2.new(0.9, 0, 0, 25)
ThemeBtn.Font = Enum.Font.GothamBold
ThemeBtn.Text = "🎨 ТЕМЫ"
ThemeBtn.TextColor3 = GetColors()
ThemeBtn.TextSize = 10
AddNeonGlow(ThemeBtn, GetColors())
local ThemeBtnCorner = Instance.new("UICorner")
ThemeBtnCorner.CornerRadius = UDim.new(0, 6)
ThemeBtnCorner.Parent = ThemeBtn

-- СТАТУС
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.05, 0, 0.88, 0)
StatusLabel.Size = UDim2.new(0.9, 0, 0, 15)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "⚡ СТОП"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 10

-- ИНФО О СОЗДАТЕЛЕ
local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Parent = MainFrame
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Position = UDim2.new(0.05, 0, 0.94, 0)
CreatorLabel.Size = UDim2.new(0.9, 0, 0, 15)
CreatorLabel.Font = Enum.Font.Gotham
CreatorLabel.Text = "👑 ROBIN"
CreatorLabel.TextColor3 = GetColors()
CreatorLabel.TextSize = 9

-- ========== МЕНЮ ВЫБОРА КЕЙСОВ ==========
local CasesFrame = Instance.new("Frame")
CasesFrame.Parent = ScreenGui
CasesFrame.BackgroundColor3 = GetBgColor()
CasesFrame.BackgroundTransparency = 0.1
CasesFrame.BorderSizePixel = 0
CasesFrame.Position = UDim2.new(0.32, 0, 0.15, 0)
CasesFrame.Size = UDim2.new(0, 280, 0, 420)
CasesFrame.Visible = false
CasesFrame.Active = true
CasesFrame.Draggable = true
AddNeonGlow(CasesFrame, GetColors(), 2)

local CasesCorner = Instance.new("UICorner")
CasesCorner.CornerRadius = UDim.new(0, 10)
CasesCorner.Parent = CasesFrame

local CasesTitle = Instance.new("TextLabel")
CasesTitle.Parent = CasesFrame
CasesTitle.BackgroundTransparency = 1
CasesTitle.Position = UDim2.new(0, 0, 0, 5)
CasesTitle.Size = UDim2.new(0.8, 0, 0, 25)
CasesTitle.Font = Enum.Font.GothamBold
CasesTitle.Text = "📦 ВЫБОР КЕЙСОВ"
CasesTitle.TextColor3 = GetColors()
CasesTitle.TextSize = 14
AddNeonGlow(CasesTitle, GetColors(), 1.5)

local CloseCasesBtn = Instance.new("TextButton")
CloseCasesBtn.Parent = CasesFrame
CloseCasesBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseCasesBtn.BorderSizePixel = 0
CloseCasesBtn.Position = UDim2.new(0.87, 0, 0.02, 0)
CloseCasesBtn.Size = UDim2.new(0, 22, 0, 22)
CloseCasesBtn.Font = Enum.Font.GothamBold
CloseCasesBtn.Text = "✕"
CloseCasesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseCasesBtn.TextSize = 14
AddNeonGlow(CloseCasesBtn, Color3.fromRGB(255, 100, 100))
local CloseCasesCorner = Instance.new("UICorner")
CloseCasesCorner.CornerRadius = UDim.new(0, 6)
CloseCasesCorner.Parent = CloseCasesBtn

local SearchBox = Instance.new("TextBox")
SearchBox.Parent = CasesFrame
SearchBox.BackgroundColor3 = GetBtnColor()
SearchBox.BorderSizePixel = 0
SearchBox.Position = UDim2.new(0.05, 0, 0.1, 0)
SearchBox.Size = UDim2.new(0.9, 0, 0, 25)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "🔍 Поиск..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 10
AddNeonGlow(SearchBox, GetColors())
local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 5)
SearchCorner.Parent = SearchBox

local CasesScroll = Instance.new("ScrollingFrame")
CasesScroll.Parent = CasesFrame
CasesScroll.BackgroundColor3 = GetBgColor()
CasesScroll.BorderSizePixel = 0
CasesScroll.Position = UDim2.new(0.05, 0, 0.17, 0)
CasesScroll.Size = UDim2.new(0.9, 0, 0, 290)
CasesScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
CasesScroll.ScrollBarThickness = 4
CasesScroll.ScrollBarImageColor3 = GetColors()
AddNeonGlow(CasesScroll, GetColors())
local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 6)
ScrollCorner.Parent = CasesScroll

local CasesList = Instance.new("UIListLayout")
CasesList.Parent = CasesScroll
CasesList.Padding = UDim.new(0, 3)
CasesList.SortOrder = Enum.SortOrder.Name

local DeselectAllBtn = Instance.new("TextButton")
DeselectAllBtn.Parent = CasesFrame
DeselectAllBtn.BackgroundColor3 = GetBtnColor()
DeselectAllBtn.BorderSizePixel = 0
DeselectAllBtn.Position = UDim2.new(0.05, 0, 0.88, 0)
DeselectAllBtn.Size = UDim2.new(0.43, 0, 0, 25)
DeselectAllBtn.Font = Enum.Font.GothamBold
DeselectAllBtn.Text = "❌ СНЯТЬ"
DeselectAllBtn.TextColor3 = GetColors()
DeselectAllBtn.TextSize = 10
AddNeonGlow(DeselectAllBtn, GetColors())
local DeselectAllCorner = Instance.new("UICorner")
DeselectAllCorner.CornerRadius = UDim.new(0, 5)
DeselectAllCorner.Parent = DeselectAllBtn

local SaveCasesBtn = Instance.new("TextButton")
SaveCasesBtn.Parent = CasesFrame
SaveCasesBtn.BackgroundColor3 = GetColors()
SaveCasesBtn.BorderSizePixel = 0
SaveCasesBtn.Position = UDim2.new(0.52, 0, 0.88, 0)
SaveCasesBtn.Size = UDim2.new(0.43, 0, 0, 25)
SaveCasesBtn.Font = Enum.Font.GothamBold
SaveCasesBtn.Text = "💾 СОХР"
SaveCasesBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
SaveCasesBtn.TextSize = 10
AddNeonGlow(SaveCasesBtn, GetColors(), 2)
local SaveCorner2 = Instance.new("UICorner")
SaveCorner2.CornerRadius = UDim.new(0, 5)
SaveCorner2.Parent = SaveCasesBtn

-- ========== МЕНЮ ТЕМ ==========
local ThemeFrame = Instance.new("Frame")
ThemeFrame.Parent = ScreenGui
ThemeFrame.BackgroundColor3 = GetBgColor()
ThemeFrame.BackgroundTransparency = 0.1
ThemeFrame.BorderSizePixel = 0
ThemeFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
ThemeFrame.Size = UDim2.new(0, 250, 0, 350)
ThemeFrame.Visible = false
ThemeFrame.Active = true
ThemeFrame.Draggable = true
AddNeonGlow(ThemeFrame, GetColors(), 2)

local ThemeCorner = Instance.new("UICorner")
ThemeCorner.CornerRadius = UDim.new(0, 10)
ThemeCorner.Parent = ThemeFrame

local ThemeTitle = Instance.new("TextLabel")
ThemeTitle.Parent = ThemeFrame
ThemeTitle.BackgroundTransparency = 1
ThemeTitle.Position = UDim2.new(0, 0, 0, 5)
ThemeTitle.Size = UDim2.new(0.8, 0, 0, 25)
ThemeTitle.Font = Enum.Font.GothamBold
ThemeTitle.Text = "🎨 ВЫБОР ТЕМЫ"
ThemeTitle.TextColor3 = GetColors()
ThemeTitle.TextSize = 14
AddNeonGlow(ThemeTitle, GetColors(), 1.5)

local CloseThemeBtn = Instance.new("TextButton")
CloseThemeBtn.Parent = ThemeFrame
CloseThemeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseThemeBtn.BorderSizePixel = 0
CloseThemeBtn.Position = UDim2.new(0.87, 0, 0.02, 0)
CloseThemeBtn.Size = UDim2.new(0, 22, 0, 22)
CloseThemeBtn.Font = Enum.Font.GothamBold
CloseThemeBtn.Text = "✕"
CloseThemeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseThemeBtn.TextSize = 14
AddNeonGlow(CloseThemeBtn, Color3.fromRGB(255, 100, 100))
local CloseThemeCorner = Instance.new("UICorner")
CloseThemeCorner.CornerRadius = UDim.new(0, 6)
CloseThemeCorner.Parent = CloseThemeBtn

local ThemeScroll = Instance.new("ScrollingFrame")
ThemeScroll.Parent = ThemeFrame
ThemeScroll.BackgroundColor3 = GetBgColor()
ThemeScroll.BorderSizePixel = 0
ThemeScroll.Position = UDim2.new(0.05, 0, 0.1, 0)
ThemeScroll.Size = UDim2.new(0.9, 0, 0, 300)
ThemeScroll.CanvasSize = UDim2.new(0, 0, 0, 9 * 35)
ThemeScroll.ScrollBarThickness = 4
ThemeScroll.ScrollBarImageColor3 = GetColors()
AddNeonGlow(ThemeScroll, GetColors())
local ThemeScrollCorner = Instance.new("UICorner")
ThemeScrollCorner.CornerRadius = UDim.new(0, 6)
ThemeScrollCorner.Parent = ThemeScroll

local ThemeList = Instance.new("UIListLayout")
ThemeList.Parent = ThemeScroll
ThemeList.Padding = UDim.new(0, 5)
ThemeList.SortOrder = Enum.SortOrder.Name

for i, theme in ipairs(Themes) do
    local btn = Instance.new("TextButton")
    btn.Parent = ThemeScroll
    btn.BackgroundColor3 = GetBtnColor()
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, -8, 0, 30)
    btn.Position = UDim2.new(0, 4, 0, 0)
    btn.Font = Enum.Font.Gotham
    btn.Text = theme.Name
    btn.TextColor3 = theme.Secondary
    btn.TextSize = 10
    AddNeonGlow(btn, theme.Primary, 1.5)
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        Settings.Theme = i
        SaveSettings()
        ScreenGui:Destroy()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/script.txt"))()
        end)
        if not success then
            -- Перезапуск скрипта локально
            local newScript = Instance.new("LocalScript")
            newScript.Source = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/neo-case-farm/main.lua"))()
            ]]
            newScript.Parent = LocalPlayer:WaitForChild("PlayerGui")
        end
    end)
end

-- ========== МЕНЮ НАСТРОЕК ==========
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Parent = ScreenGui
SettingsFrame.BackgroundColor3 = GetBgColor()
SettingsFrame.BackgroundTransparency = 0.1
SettingsFrame.BorderSizePixel = 0
SettingsFrame.Position = UDim2.new(0.34, 0, 0.2, 0)
SettingsFrame.Size = UDim2.new(0, 260, 0, 400)
SettingsFrame.Visible = false
SettingsFrame.Active = true
SettingsFrame.Draggable = true
AddNeonGlow(SettingsFrame, GetColors(), 2)

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 10)
SettingsCorner.Parent = SettingsFrame

local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Parent = SettingsFrame
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Position = UDim2.new(0, 0, 0, 5)
SettingsTitle.Size = UDim2.new(0.8, 0, 0, 25)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.Text = "⚙ НАСТРОЙКИ"
SettingsTitle.TextColor3 = GetColors()
SettingsTitle.TextSize = 14
AddNeonGlow(SettingsTitle, GetColors(), 1.5)

local CloseSettingsBtn = Instance.new("TextButton")
CloseSettingsBtn.Parent = SettingsFrame
CloseSettingsBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseSettingsBtn.BorderSizePixel = 0
CloseSettingsBtn.Position = UDim2.new(0.87, 0, 0.02, 0)
CloseSettingsBtn.Size = UDim2.new(0, 22, 0, 22)
CloseSettingsBtn.Font = Enum.Font.GothamBold
CloseSettingsBtn.Text = "✕"
CloseSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseSettingsBtn.TextSize = 14
AddNeonGlow(CloseSettingsBtn, Color3.fromRGB(255, 100, 100))
local CloseSetCorner = Instance.new("UICorner")
CloseSetCorner.CornerRadius = UDim.new(0, 6)
CloseSetCorner.Parent = CloseSettingsBtn

-- КОЛИЧЕСТВО КЕЙСОВ ЗА РАЗ
local AmountLabel = Instance.new("TextLabel")
AmountLabel.Parent = SettingsFrame
AmountLabel.BackgroundTransparency = 1
AmountLabel.Position = UDim2.new(0.05, 0, 0.12, 0)
AmountLabel.Size = UDim2.new(0.5, 0, 0, 20)
AmountLabel.Font = Enum.Font.Gotham
AmountLabel.Text = "📦 Кейсов:"
AmountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountLabel.TextSize = 10

local AmountBox = Instance.new("TextBox")
AmountBox.Parent = SettingsFrame
AmountBox.BackgroundColor3 = GetBtnColor()
AmountBox.BorderSizePixel = 0
AmountBox.Position = UDim2.new(0.55, 0, 0.12, 0)
AmountBox.Size = UDim2.new(0.4, 0, 0, 20)
AmountBox.Font = Enum.Font.GothamBold
AmountBox.Text = tostring(Settings.OpenAmount)
AmountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AmountBox.TextSize = 10
AddNeonGlow(AmountBox, GetColors())
local AmountCorner = Instance.new("UICorner")
AmountCorner.CornerRadius = UDim.new(0, 4)
AmountCorner.Parent = AmountBox

-- ЗАДЕРЖКА
local DelayLabel = Instance.new("TextLabel")
DelayLabel.Parent = SettingsFrame
DelayLabel.BackgroundTransparency = 1
DelayLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
DelayLabel.Size = UDim2.new(0.5, 0, 0, 20)
DelayLabel.Font = Enum.Font.Gotham
DelayLabel.Text = "⚡ Задержка:"
DelayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DelayLabel.TextSize = 10

local DelayBox = Instance.new("TextBox")
DelayBox.Parent = SettingsFrame
DelayBox.BackgroundColor3 = GetBtnColor()
DelayBox.BorderSizePixel = 0
DelayBox.Position = UDim2.new(0.55, 0, 0.2, 0)
DelayBox.Size = UDim2.new(0.4, 0, 0, 20)
DelayBox.Font = Enum.Font.GothamBold
DelayBox.Text = tostring(Settings.FarmDelay)
DelayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
DelayBox.TextSize = 10
AddNeonGlow(DelayBox, GetColors())
local DelayCorner = Instance.new("UICorner")
DelayCorner.CornerRadius = UDim.new(0, 4)
DelayCorner.Parent = DelayBox

-- КОЛИЧЕСТВО ПОКУПКИ
local BuyAmountLabel = Instance.new("TextLabel")
BuyAmountLabel.Parent = SettingsFrame
BuyAmountLabel.BackgroundTransparency = 1
BuyAmountLabel.Position = UDim2.new(0.05, 0, 0.28, 0)
BuyAmountLabel.Size = UDim2.new(0.5, 0, 0, 20)
BuyAmountLabel.Font = Enum.Font.Gotham
BuyAmountLabel.Text = "🛍️ Покупка:"
BuyAmountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BuyAmountLabel.TextSize = 10

local BuyAmountBox = Instance.new("TextBox")
BuyAmountBox.Parent = SettingsFrame
BuyAmountBox.BackgroundColor3 = GetBtnColor()
BuyAmountBox.BorderSizePixel = 0
BuyAmountBox.Position = UDim2.new(0.55, 0, 0.28, 0)
BuyAmountBox.Size = UDim2.new(0.4, 0, 0, 20)
BuyAmountBox.Font = Enum.Font.GothamBold
BuyAmountBox.Text = tostring(Settings.AutoBuyAmount)
BuyAmountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
BuyAmountBox.TextSize = 10
AddNeonGlow(BuyAmountBox, GetColors())
local BuyAmountCorner = Instance.new("UICorner")
BuyAmountCorner.CornerRadius = UDim.new(0, 4)
BuyAmountCorner.Parent = BuyAmountBox

-- СКОРОСТЬ ПОКУПКИ
local BuySpeedLabel = Instance.new("TextLabel")
BuySpeedLabel.Parent = SettingsFrame
BuySpeedLabel.BackgroundTransparency = 1
BuySpeedLabel.Position = UDim2.new(0.05, 0, 0.36, 0)
BuySpeedLabel.Size = UDim2.new(0.5, 0, 0, 20)
BuySpeedLabel.Font = Enum.Font.Gotham
BuySpeedLabel.Text = "⏱️ Скорость:"
BuySpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BuySpeedLabel.TextSize = 10

local BuySpeedBox = Instance.new("TextBox")
BuySpeedBox.Parent = SettingsFrame
BuySpeedBox.BackgroundColor3 = GetBtnColor()
BuySpeedBox.BorderSizePixel = 0
BuySpeedBox.Position = UDim2.new(0.55, 0, 0.36, 0)
BuySpeedBox.Size = UDim2.new(0.4, 0, 0, 20)
BuySpeedBox.Font = Enum.Font.GothamBold
BuySpeedBox.Text = tostring(Settings.AutoBuySpeed)
BuySpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
BuySpeedBox.TextSize = 10
AddNeonGlow(BuySpeedBox, GetColors())
local BuySpeedCorner = Instance.new("UICorner")
BuySpeedCorner.CornerRadius = UDim.new(0, 4)
BuySpeedCorner.Parent = BuySpeedBox

-- УДАЧА ВКЛ/ВЫКЛ
local LuckToggleLabel = Instance.new("TextLabel")
LuckToggleLabel.Parent = SettingsFrame
LuckToggleLabel.BackgroundTransparency = 1
LuckToggleLabel.Position = UDim2.new(0.05, 0, 0.46, 0)
LuckToggleLabel.Size = UDim2.new(0.5, 0, 0, 20)
LuckToggleLabel.Font = Enum.Font.Gotham
LuckToggleLabel.Text = "🍀 Удача:"
LuckToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LuckToggleLabel.TextSize = 10

local LuckToggleBtn = Instance.new("TextButton")
LuckToggleBtn.Parent = SettingsFrame
LuckToggleBtn.BackgroundColor3 = Settings.LuckEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
LuckToggleBtn.BorderSizePixel = 0
LuckToggleBtn.Position = UDim2.new(0.55, 0, 0.46, 0)
LuckToggleBtn.Size = UDim2.new(0.4, 0, 0, 20)
LuckToggleBtn.Font = Enum.Font.GothamBold
LuckToggleBtn.Text = Settings.LuckEnabled and "ВКЛ" or "ВЫКЛ"
LuckToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LuckToggleBtn.TextSize = 10
AddNeonGlow(LuckToggleBtn, Settings.LuckEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0))
local LuckToggleCorner = Instance.new("UICorner")
LuckToggleCorner.CornerRadius = UDim.new(0, 4)
LuckToggleCorner.Parent = LuckToggleBtn

-- МНОЖИТЕЛЬ УДАЧИ
local LuckMultLabel = Instance.new("TextLabel")
LuckMultLabel.Parent = SettingsFrame
LuckMultLabel.BackgroundTransparency = 1
LuckMultLabel.Position = UDim2.new(0.05, 0, 0.54, 0)
LuckMultLabel.Size = UDim2.new(0.5, 0, 0, 20)
LuckMultLabel.Font = Enum.Font.Gotham
LuckMultLabel.Text = "📊 Множ:"
LuckMultLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LuckMultLabel.TextSize = 10

local LuckMultDropdown = Instance.new("TextButton")
LuckMultDropdown.Parent = SettingsFrame
LuckMultDropdown.BackgroundColor3 = GetBtnColor()
LuckMultDropdown.BorderSizePixel = 0
LuckMultDropdown.Position = UDim2.new(0.55, 0, 0.54, 0)
LuckMultDropdown.Size = UDim2.new(0.4, 0, 0, 20)
LuckMultDropdown.Font = Enum.Font.Gotham
LuckMultDropdown.Text = "x" .. Settings.LuckMultiplier
LuckMultDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
LuckMultDropdown.TextSize = 10
AddNeonGlow(LuckMultDropdown, GetColors())
local LuckMultCorner = Instance.new("UICorner")
LuckMultCorner.CornerRadius = UDim.new(0, 4)
LuckMultCorner.Parent = LuckMultDropdown

local LuckMultList = Instance.new("ScrollingFrame")
LuckMultList.Parent = SettingsFrame
LuckMultList.BackgroundColor3 = GetBtnColor()
LuckMultList.BorderSizePixel = 0
LuckMultList.Position = UDim2.new(0.55, 0, 0.6, 0)
LuckMultList.Size = UDim2.new(0.4, 0, 0, 60)
LuckMultList.CanvasSize = UDim2.new(0, 0, 0, 3 * 20)
LuckMultList.ScrollBarThickness = 3
LuckMultList.Visible = false
AddNeonGlow(LuckMultList, GetColors())
local LuckMultListCorner = Instance.new("UICorner")
LuckMultListCorner.CornerRadius = UDim.new(0, 4)
LuckMultListCorner.Parent = LuckMultList

local LuckMultLayout = Instance.new("UIListLayout")
LuckMultLayout.Parent = LuckMultList
LuckMultLayout.Padding = UDim.new(0, 2)

for _, mult in ipairs({2, 4, 6}) do
    local btn = Instance.new("TextButton")
    btn.Parent = LuckMultList
    btn.BackgroundColor3 = GetBtnColor()
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, 0, 0, 20)
    btn.Font = Enum.Font.Gotham
    btn.Text = "x" .. mult
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 9
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 3)
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
LuckTimeLabel.Position = UDim2.new(0.05, 0, 0.62, 0)
LuckTimeLabel.Size = UDim2.new(0.5, 0, 0, 20)
LuckTimeLabel.Font = Enum.Font.Gotham
LuckTimeLabel.Text = "⏱️ Время(мин):"
LuckTimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LuckTimeLabel.TextSize = 10

local LuckTimeBox = Instance.new("TextBox")
LuckTimeBox.Parent = SettingsFrame
LuckTimeBox.BackgroundColor3 = GetBtnColor()
LuckTimeBox.BorderSizePixel = 0
LuckTimeBox.Position = UDim2.new(0.55, 0, 0.62, 0)
LuckTimeBox.Size = UDim2.new(0.4, 0, 0, 20)
LuckTimeBox.Font = Enum.Font.GothamBold
LuckTimeBox.Text = "5"
LuckTimeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
LuckTimeBox.TextSize = 10
AddNeonGlow(LuckTimeBox, GetColors())
local LuckTimeCorner = Instance.new("UICorner")
LuckTimeCorner.CornerRadius = UDim.new(0, 4)
LuckTimeCorner.Parent = LuckTimeBox

-- СЕЙВ ВКЛ/ВЫКЛ
local SaveToggleLabel = Instance.new("TextLabel")
SaveToggleLabel.Parent = SettingsFrame
SaveToggleLabel.BackgroundTransparency = 1
SaveToggleLabel.Position = UDim2.new(0.05, 0, 0.72, 0)
SaveToggleLabel.Size = UDim2.new(0.5, 0, 0, 20)
SaveToggleLabel.Font = Enum.Font.Gotham
SaveToggleLabel.Text = "✕ Сейв:"
SaveToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveToggleLabel.TextSize = 10

local SaveToggleBtn = Instance.new("TextButton")
SaveToggleBtn.Parent = SettingsFrame
SaveToggleBtn.BackgroundColor3 = SaveActive and Color3.fromRGB(0, 200, 200) or Color3.fromRGB(200, 0, 0)
SaveToggleBtn.BorderSizePixel = 0
SaveToggleBtn.Position = UDim2.new(0.55, 0, 0.72, 0)
SaveToggleBtn.Size = UDim2.new(0.4, 0, 0, 20)
SaveToggleBtn.Font = Enum.Font.GothamBold
SaveToggleBtn.Text = SaveActive and "ВКЛ" or "ВЫКЛ"
SaveToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveToggleBtn.TextSize = 10
AddNeonGlow(SaveToggleBtn, SaveActive and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(255, 0, 0))
local SaveToggleCorner = Instance.new("UICorner")
SaveToggleCorner.CornerRadius = UDim.new(0, 4)
SaveToggleCorner.Parent = SaveToggleBtn

-- ВРЕМЯ СЕЙВА
local SaveTimeLabel = Instance.new("TextLabel")
SaveTimeLabel.Parent = SettingsFrame
SaveTimeLabel.BackgroundTransparency = 1
SaveTimeLabel.Position = UDim2.new(0.05, 0, 0.8, 0)
SaveTimeLabel.Size = UDim2.new(0.5, 0, 0, 20)
SaveTimeLabel.Font = Enum.Font.Gotham
SaveTimeLabel.Text = "⏱️ Время(мин):"
SaveTimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveTimeLabel.TextSize = 10

local SaveTimeBox = Instance.new("TextBox")
SaveTimeBox.Parent = SettingsFrame
SaveTimeBox.BackgroundColor3 = GetBtnColor()
SaveTimeBox.BorderSizePixel = 0
SaveTimeBox.Position = UDim2.new(0.55, 0, 0.8, 0)
SaveTimeBox.Size = UDim2.new(0.4, 0, 0, 20)
SaveTimeBox.Font = Enum.Font.GothamBold
SaveTimeBox.Text = "5"
SaveTimeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveTimeBox.TextSize = 10
AddNeonGlow(SaveTimeBox, GetColors())
local SaveTimeCorner = Instance.new("UICorner")
SaveTimeCorner.CornerRadius = UDim.new(0, 4)
SaveTimeCorner.Parent = SaveTimeBox

-- СОЗДАТЕЛЬ
local SettingsCreatorLabel = Instance.new("TextLabel")
SettingsCreatorLabel.Parent = SettingsFrame
SettingsCreatorLabel.BackgroundTransparency = 1
SettingsCreatorLabel.Position = UDim2.new(0.05, 0, 0.9, 0)
SettingsCreatorLabel.Size = UDim2.new(0.9, 0, 0, 30)
SettingsCreatorLabel.Font = Enum.Font.Gotham
SettingsCreatorLabel.Text = "👑 ROBIN"
SettingsCreatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsCreatorLabel.TextSize = 9

-- ========== ЗНАЧОК УДАЧИ ==========
local LuckIconFrame = Instance.new("Frame")
LuckIconFrame.Parent = ScreenGui
LuckIconFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LuckIconFrame.BackgroundTransparency = 0.1
LuckIconFrame.BorderSizePixel = 0
LuckIconFrame.Size = UDim2.new(0, 45, 0, 55)
LuckIconFrame.Visible = false
AddNeonGlow(LuckIconFrame, Color3.fromRGB(0, 255, 0), 2)

local LuckIconCorner = Instance.new("UICorner")
LuckIconCorner.CornerRadius = UDim.new(0, 8)
LuckIconCorner.Parent = LuckIconFrame

local LuckIconIcon = Instance.new("TextLabel")
LuckIconIcon.Parent = LuckIconFrame
LuckIconIcon.BackgroundTransparency = 1
LuckIconIcon.Position = UDim2.new(0, 0, 0.05, 0)
LuckIconIcon.Size = UDim2.new(1, 0, 0.5, 0)
LuckIconIcon.Font = Enum.Font.GothamBold
LuckIconIcon.Text = "🍀"
LuckIconIcon.TextColor3 = Color3.fromRGB(0, 255, 100)
LuckIconIcon.TextSize = 22
AddNeonGlow(LuckIconIcon, Color3.fromRGB(0, 255, 0), 1.5)

local LuckIconTimer = Instance.new("TextLabel")
LuckIconTimer.Parent = LuckIconFrame
LuckIconTimer.BackgroundTransparency = 1
LuckIconTimer.Position = UDim2.new(0, 0, 0.55, 0)
LuckIconTimer.Size = UDim2.new(1, 0, 0, 18)
LuckIconTimer.Font = Enum.Font.GothamBold
LuckIconTimer.Text = "5:00"
LuckIconTimer.TextColor3 = Color3.fromRGB(255, 255, 255)
LuckIconTimer.TextSize = 10

local LuckIconMult = Instance.new("TextLabel")
LuckIconMult.Parent = LuckIconFrame
LuckIconMult.BackgroundTransparency = 1
LuckIconMult.Position = UDim2.new(0, 0, 0.8, 0)
LuckIconMult.Size = UDim2.new(1, 0, 0, 12)
LuckIconMult.Font = Enum.Font.GothamBold
LuckIconMult.Text = "x2"
LuckIconMult.TextColor3 = Color3.fromRGB(255, 255, 0)
LuckIconMult.TextSize = 8

-- ========== ЗНАЧОК СЕЙВА ==========
local SaveIconFrame = Instance.new("Frame")
SaveIconFrame.Parent = ScreenGui
SaveIconFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SaveIconFrame.BackgroundTransparency = 0.1
SaveIconFrame.BorderSizePixel = 0
SaveIconFrame.Size = UDim2.new(0, 45, 0, 55)
SaveIconFrame.Visible = false
AddNeonGlow(SaveIconFrame, Color3.fromRGB(0, 255, 255), 2)

local SaveIconCorner = Instance.new("UICorner")
SaveIconCorner.CornerRadius = UDim.new(0, 8)
SaveIconCorner.Parent = SaveIconFrame

local SaveIconIcon = Instance.new("TextLabel")
SaveIconIcon.Parent = SaveIconFrame
SaveIconIcon.BackgroundTransparency = 1
SaveIconIcon.Position = UDim2.new(0, 0, 0.05, 0)
SaveIconIcon.Size = UDim2.new(1, 0, 0.5, 0)
SaveIconIcon.Font = Enum.Font.GothamBold
SaveIconIcon.Text = "✕"
SaveIconIcon.TextColor3 = Color3.fromRGB(0, 255, 255)
SaveIconIcon.TextSize = 22
AddNeonGlow(SaveIconIcon, Color3.fromRGB(0, 255, 255), 1.5)

local SaveIconTimer = Instance.new("TextLabel")
SaveIconTimer.Parent = SaveIconFrame
SaveIconTimer.BackgroundTransparency = 1
SaveIconTimer.Position = UDim2.new(0, 0, 0.55, 0)
SaveIconTimer.Size = UDim2.new(1, 0, 0, 18)
SaveIconTimer.Font = Enum.Font.GothamBold
SaveIconTimer.Text = "5:00"
SaveIconTimer.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveIconTimer.TextSize = 10

-- ========== ФУНКЦИИ ==========
local function UpdateIconPositions()
    if LuckActive and SaveActive then
        LuckIconFrame.Position = UDim2.new(0.88, 0, 0.78, 0)
        SaveIconFrame.Position = UDim2.new(0.88, 0, 0.68, 0)
    elseif LuckActive then
        LuckIconFrame.Position = UDim2.new(0.9, 0, 0.8, 0)
        SaveIconFrame.Position = UDim2.new(0.9, 0, 0.7, 0)
    elseif SaveActive then
        SaveIconFrame.Position = UDim2.new(0.9, 0, 0.8, 0)
        LuckIconFrame.Position = UDim2.new(0.9, 0, 0.8, 0)
    end
end

local function UpdateSelectedCount()
    local count = 0
    for _ in pairs(Settings.SelectedCases) do count = count + 1 end
    SelectedCountLabel.Text = "📋 " .. count .. " кейсов"
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
            btn.BackgroundColor3 = IsCaseSelected(caseName) and GetColors() or GetBtnColor()
            btn.BorderSizePixel = 0
            btn.Size = UDim2.new(1, -8, 0, 24)
            btn.Position = UDim2.new(0, 4, 0, yPos)
            btn.Font = Enum.Font.Gotham
            btn.Text = (IsCaseSelected(caseName) and "✅ " or "☐ ") .. caseName
            btn.TextColor3 = IsCaseSelected(caseName) and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
            btn.TextSize = 9
            AddNeonGlow(btn, GetColors(), 1)
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 4)
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
            
            yPos = yPos + 27
        end
    end
    
    CasesScroll.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

local function UpdateStatusLabels()
    AutoSellStatus.Text = AutoSellEnabled and "🛒 Продажа: ВКЛ" or "🛒 Продажа: ВЫКЛ"
    AutoSellStatus.TextColor3 = AutoSellEnabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    AutoBuyStatus.Text = AutoBuyEnabled and "🛍️ Покупка: ВКЛ" or "🛍️ Покупка: ВЫКЛ"
    AutoBuyStatus.TextColor3 = AutoBuyEnabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 100, 100)
end

local function UpdateLuckTimer()
    if LuckActive then
        local remaining = LuckEndTime - os.time()
        if remaining <= 0 then
            LuckActive = false
            LuckIconFrame.Visible = false
            Settings.LuckEnabled = false
            LuckToggleBtn.Text = "ВЫКЛ"
            LuckToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            UpdateIconPositions()
        else
            local minutes = math.floor(remaining / 60)
            local seconds = remaining % 60
            LuckIconTimer.Text = string.format("%d:%02d", minutes, seconds)
        end
    end
end

local function UpdateSaveTimer()
    if SaveActive then
        local remaining = SaveEndTime - os.time()
        if remaining <= 0 then
            SaveActive = false
            SaveIconFrame.Visible = false
            SaveToggleBtn.Text = "ВЫКЛ"
            SaveToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            UpdateIconPositions()
        else
            local minutes = math.floor(remaining / 60)
            local seconds = remaining % 60
            SaveIconTimer.Text = string.format("%d:%02d", minutes, seconds)
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
                            task.wait(0.03)
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
                            for i = 1, Settings.AutoBuyAmount do
                                BuyCase:InvokeServer(caseName, 1)
                                task.wait(0.05)
                            end
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

DeselectAllBtn.MouseButton1Click:Connect(function()
    Settings.SelectedCases = {}
    RefreshCasesList(SearchBox.Text)
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
        StatusLabel.Text = "⚠️ ВЫБЕРИ КЕЙСЫ!"
        task.wait(2)
        StatusLabel.Text = "⚡ СТОП"
        return
    end
    
    Farming = not Farming
    if Farming then
        StartBtn.Text = "⏹ СТОП"
        StatusLabel.Text = "⚡ ФАРМ"
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

ThemeBtn.MouseButton1Click:Connect(function()
    ThemeFrame.Visible = true
end)

CloseSettingsBtn.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = false
end)

CloseThemeBtn.MouseButton1Click:Connect(function()
    ThemeFrame.Visible = false
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

BuyAmountBox.FocusLost:Connect(function()
    local num = tonumber(BuyAmountBox.Text)
    if num and num >= 1 and num <= 10 then
        Settings.AutoBuyAmount = math.floor(num)
        BuyAmountBox.Text = tostring(Settings.AutoBuyAmount)
        SaveSettings()
    else
        BuyAmountBox.Text = tostring(Settings.AutoBuyAmount)
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
        
        LuckIconFrame.Visible = true
        LuckIconMult.Text = "x" .. Settings.LuckMultiplier
        LuckIconIcon.Text = "🍀"
        
        UpdateIconPositions()
        UpdateLuckTimer()
    else
        LuckActive = false
        Settings.LuckEnabled = false
        LuckToggleBtn.Text = "ВЫКЛ"
        LuckToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        LuckIconFrame.Visible = false
        UpdateIconPositions()
    end
    SaveSettings()
end)

SaveToggleBtn.MouseButton1Click:Connect(function()
    if not SaveActive then
        local timeMinutes = tonumber(SaveTimeBox.Text) or 5
        SaveActive = true
        SaveEndTime = os.time() + (timeMinutes * 60)
        SaveToggleBtn.Text = "ВКЛ"
        SaveToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 200)
        
        SaveIconFrame.Visible = true
        SaveIconIcon.Text = "✕"
        
        UpdateIconPositions()
        UpdateSaveTimer()
    else
        SaveActive = false
        SaveToggleBtn.Text = "ВЫКЛ"
        SaveToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        SaveIconFrame.Visible = false
        UpdateIconPositions()
    end
end)

RunService.Heartbeat:Connect(function()
    if LuckActive then
        UpdateLuckTimer()
    end
    if SaveActive then
        UpdateSaveTimer()
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        LuckMultList.Visible = false
    end
end)

-- ========== ИНИЦИАЛИЗАЦИЯ ==========
UpdateSelectedCount()
UpdateStatusLabels()

AmountBox.Text = tostring(Settings.OpenAmount)
DelayBox.Text = tostring(Settings.FarmDelay)
BuyAmountBox.Text = tostring(Settings.AutoBuyAmount)
BuySpeedBox.Text = tostring(Settings.AutoBuySpeed)

-- Если есть сохраненные кейсы, обновляем список
for caseName in pairs(Settings.SelectedCases) do
    -- просто итерация для подсчета
end

print("✅ NEO CASE FARM BY ROBIN LOADED!")
end
