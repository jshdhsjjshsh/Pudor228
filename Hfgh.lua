-- TON BATTLE SCRIPT - ПОЛНАЯ ВЕРСИЯ
-- ПАРОЛЬ: mr.comcom

local function ShowPasswordMenu()
    local player = game.Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local blur = Instance.new("BlurEffect")
    blur.Parent = game:GetService("Lighting")
    blur.Size = 0
    
    spawn(function()
        for i = 0, 1, 0.05 do
            blur.Size = i * 12
            wait(0.02)
        end
    end)
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = screenGui
    mainFrame.Size = UDim2.new(0, 400, 0, 280)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -140)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 35)
    mainFrame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = mainFrame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 150)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 255))
    })
    gradient.Rotation = 45
    gradient.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Parent = mainFrame
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Position = UDim2.new(0, 0, 0.02, 0)
    title.BackgroundTransparency = 1
    title.Text = "🔐 АВТОРИЗАЦИЯ"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    
    local icon = Instance.new("ImageLabel")
    icon.Parent = mainFrame
    icon.Size = UDim2.new(0, 50, 0, 50)
    icon.Position = UDim2.new(0.5, -25, 0.14, 0)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://6023426912"
    
    local passwordBox = Instance.new("TextBox")
    passwordBox.Parent = mainFrame
    passwordBox.Size = UDim2.new(0.75, 0, 0, 45)
    passwordBox.Position = UDim2.new(0.125, 0, 0.4, 0)
    passwordBox.BackgroundColor3 = Color3.fromRGB(25, 20, 50)
    passwordBox.BorderSizePixel = 0
    passwordBox.Font = Enum.Font.Gotham
    passwordBox.PlaceholderText = "Введите пароль"
    passwordBox.Text = ""
    passwordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    passwordBox.TextSize = 16
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 10)
    boxCorner.Parent = passwordBox
    
    local loginBtn = Instance.new("TextButton")
    loginBtn.Parent = mainFrame
    loginBtn.Size = UDim2.new(0.5, 0, 0, 45)
    loginBtn.Position = UDim2.new(0.25, 0, 0.62, 0)
    loginBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    loginBtn.BorderSizePixel = 0
    loginBtn.Font = Enum.Font.GothamBold
    loginBtn.Text = "ВОЙТИ"
    loginBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    loginBtn.TextSize = 18
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = loginBtn
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Parent = mainFrame
    statusLabel.Size = UDim2.new(1, 0, 0, 25)
    statusLabel.Position = UDim2.new(0, 0, 0.85, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 12
    
    local function LoadMainScript()
        screenGui:Destroy()
        blur:Destroy()
        
        -- ВСЕ КЕЙСЫ
        local AllCases = {
            "Trash", "Daily", "Photon Core", "Divine", "Beggar", "Plodder",
            "Office Clerk", "Manager", "Director", "Oligarch", "Frozen Heart",
            "Bubble Gum", "Cats", "Glitch", "Dream", "Bloody Night", "Heavenfall",
            "M5 F90", "G63", "Porsche 911", "URUS", "Gold", "Dark", "Palm",
            "Burj", "Luxury", "Marina", "Cursed Demon"
        }
        
        local CustomCases = {}
        for i, v in ipairs(AllCases) do
            table.insert(CustomCases, v)
        end
        
        -- НАСТРОЙКИ
        local Config = {
            SelectedCase = "Heavenfall",
            OpenAmount = 10,
            TimerSeconds = 0,
            DelayBetween = 0.05,
            AutoSell = false,
            IsFarming = false,
            StartTime = 0
        }
        
        -- ГЛАВНОЕ ОКНО (МАЛЕНЬКОЕ)
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "NeonGUI"
        ScreenGui.Parent = player:WaitForChild("PlayerGui")
        
        local MainFrame = Instance.new("Frame")
        MainFrame.Parent = ScreenGui
        MainFrame.BackgroundColor3 = Color3.fromRGB(8, 5, 20)
        MainFrame.BackgroundTransparency = 0.05
        MainFrame.BorderColor3 = Color3.fromRGB(180, 0, 255)
        MainFrame.BorderSizePixel = 2
        MainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
        MainFrame.Size = UDim2.new(0, 380, 0, 420)
        MainFrame.Active = true
        MainFrame.Draggable = true
        
        local MainCorner = Instance.new("UICorner")
        MainCorner.CornerRadius = UDim.new(0, 12)
        MainCorner.Parent = MainFrame
        
        local MainGradient = Instance.new("UIGradient")
        MainGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 150)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 255))
        })
        MainGradient.Rotation = 60
        MainGradient.Parent = MainFrame
        
        -- КНОПКИ
        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Parent = MainFrame
        CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        CloseBtn.BackgroundTransparency = 0.2
        CloseBtn.BorderSizePixel = 0
        CloseBtn.Position = UDim2.new(0.88, 0, 0.02, 0)
        CloseBtn.Size = UDim2.new(0, 28, 0, 28)
        CloseBtn.Font = Enum.Font.GothamBold
        CloseBtn.Text = "✕"
        CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseBtn.TextSize = 18
        local CloseCorner = Instance.new("UICorner")
        CloseCorner.CornerRadius = UDim.new(0, 7)
        CloseCorner.Parent = CloseBtn
        
        local MinimizeBtn = Instance.new("TextButton")
        MinimizeBtn.Parent = MainFrame
        MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        MinimizeBtn.BackgroundTransparency = 0.2
        MinimizeBtn.BorderSizePixel = 0
        MinimizeBtn.Position = UDim2.new(0.78, 0, 0.02, 0)
        MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
        MinimizeBtn.Font = Enum.Font.GothamBold
        MinimizeBtn.Text = "−"
        MinimizeBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
        MinimizeBtn.TextSize = 22
        local MinCorner = Instance.new("UICorner")
        MinCorner.CornerRadius = UDim.new(0, 7)
        MinCorner.Parent = MinimizeBtn
        
        local SettingsBtn = Instance.new("TextButton")
        SettingsBtn.Parent = MainFrame
        SettingsBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
        SettingsBtn.BorderColor3 = Color3.fromRGB(180, 0, 255)
        SettingsBtn.BorderSizePixel = 1
        SettingsBtn.Position = UDim2.new(0.05, 0, 0.85, 0)
        SettingsBtn.Size = UDim2.new(0.9, 0, 0, 35)
        SettingsBtn.Font = Enum.Font.GothamBold
        SettingsBtn.Text = "⚙ НАСТРОЙКИ"
        SettingsBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
        SettingsBtn.TextSize = 13
        local SetCorner = Instance.new("UICorner")
        SetCorner.CornerRadius = UDim.new(0, 8)
        SetCorner.Parent = SettingsBtn
        
        local FloatingBtn = Instance.new("TextButton")
        FloatingBtn.Parent = ScreenGui
        FloatingBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
        FloatingBtn.BackgroundTransparency = 0.1
        FloatingBtn.BorderColor3 = Color3.fromRGB(0, 255, 150)
        FloatingBtn.BorderSizePixel = 2
        FloatingBtn.Position = UDim2.new(0.02, 0, 0.85, 0)
        FloatingBtn.Size = UDim2.new(0, 45, 0, 45)
        FloatingBtn.Font = Enum.Font.GothamBold
        FloatingBtn.Text = "⚡"
        FloatingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        FloatingBtn.TextSize = 24
        FloatingBtn.Visible = false
        local FloatCorner = Instance.new("UICorner")
        FloatCorner.CornerRadius = UDim.new(0, 22)
        FloatCorner.Parent = FloatingBtn
        local FloatDrag = Instance.new("UIDragDetector")
        FloatDrag.Parent = FloatingBtn
        
        CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false FloatingBtn.Visible = true end)
        MinimizeBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false FloatingBtn.Visible = true end)
        FloatingBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true FloatingBtn.Visible = false end)
        
        -- ЗАГОЛОВОК
        local Title = Instance.new("TextLabel")
        Title.Parent = MainFrame
        Title.BackgroundTransparency = 1
        Title.Position = UDim2.new(0.05, 0, 0.02, 0)
        Title.Size = UDim2.new(0, 200, 0, 30)
        Title.Font = Enum.Font.GothamBold
        Title.Text = "⚡ TON BATTLE ⚡"
        Title.TextColor3 = Color3.fromRGB(180, 0, 255)
        Title.TextSize = 18
        
        -- ВЫБРАННЫЙ КЕЙС
        local CurrentCaseLabel = Instance.new("TextLabel")
        CurrentCaseLabel.Parent = MainFrame
        CurrentCaseLabel.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
        CurrentCaseLabel.BorderColor3 = Color3.fromRGB(0, 255, 150)
        CurrentCaseLabel.BorderSizePixel = 1
        CurrentCaseLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
        CurrentCaseLabel.Size = UDim2.new(0.9, 0, 0, 30)
        CurrentCaseLabel.Font = Enum.Font.GothamBold
        CurrentCaseLabel.Text = "🎯 " .. Config.SelectedCase
        CurrentCaseLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        CurrentCaseLabel.TextSize = 12
        local CurCorner = Instance.new("UICorner")
        CurCorner.CornerRadius = UDim.new(0, 6)
        CurCorner.Parent = CurrentCaseLabel
        
        -- СПИСОК КЕЙСОВ
        local CaseScroll = Instance.new("ScrollingFrame")
        CaseScroll.Parent = MainFrame
        CaseScroll.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
        CaseScroll.BorderColor3 = Color3.fromRGB(180, 0, 255)
        CaseScroll.BorderSizePixel = 1
        CaseScroll.Position = UDim2.new(0.05, 0, 0.19, 0)
        CaseScroll.Size = UDim2.new(0.9, 0, 0, 160)
        CaseScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        CaseScroll.ScrollBarThickness = 5
        local ScrollCorner = Instance.new("UICorner")
        ScrollCorner.CornerRadius = UDim.new(0, 8)
        ScrollCorner.Parent = CaseScroll
        
        local CaseLayout = Instance.new("UIListLayout")
        CaseLayout.Parent = CaseScroll
        CaseLayout.Padding = UDim.new(0, 4)
        
        -- ДОБАВЛЕНИЕ КЕЙСА
        local AddBox = Instance.new("TextBox")
        AddBox.Parent = MainFrame
        AddBox.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
        AddBox.BorderColor3 = Color3.fromRGB(0, 255, 150)
        AddBox.BorderSizePixel = 1
        AddBox.Position = UDim2.new(0.05, 0, 0.48, 0)
        AddBox.Size = UDim2.new(0.6, 0, 0, 30)
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
        AddBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        AddBtn.BorderColor3 = Color3.fromRGB(0, 255, 150)
        AddBtn.BorderSizePixel = 1
        AddBtn.Position = UDim2.new(0.68, 0, 0.48, 0)
        AddBtn.Size = UDim2.new(0.27, 0, 0, 30)
        AddBtn.Font = Enum.Font.GothamBold
        AddBtn.Text = "+"
        AddBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        AddBtn.TextSize = 16
        local AddBtnCorner = Instance.new("UICorner")
        AddBtnCorner.CornerRadius = UDim.new(0, 6)
        AddBtnCorner.Parent = AddBtn
        
        -- КНОПКИ ФАРМА
        local SellBtn = Instance.new("TextButton")
        SellBtn.Parent = MainFrame
        SellBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
        SellBtn.BorderColor3 = Color3.fromRGB(255, 100, 100)
        SellBtn.BorderSizePixel = 1
        SellBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
        SellBtn.Size = UDim2.new(0.43, 0, 0, 35)
        SellBtn.Font = Enum.Font.GothamBold
        SellBtn.Text = "🔴 ПРОД:ВЫКЛ"
        SellBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        SellBtn.TextSize = 11
        local SellCorner = Instance.new("UICorner")
        SellCorner.CornerRadius = UDim.new(0, 6)
        SellCorner.Parent = SellBtn
        
        local StartBtn = Instance.new("TextButton")
        StartBtn.Parent = MainFrame
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        StartBtn.BorderColor3 = Color3.fromRGB(0, 255, 150)
        StartBtn.BorderSizePixel = 2
        StartBtn.Position = UDim2.new(0.52, 0, 0.6, 0)
        StartBtn.Size = UDim2.new(0.43, 0, 0, 35)
        StartBtn.Font = Enum.Font.GothamBold
        StartBtn.Text = "▶"
        StartBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        StartBtn.TextSize = 18
        local StartCorner = Instance.new("UICorner")
        StartCorner.CornerRadius = UDim.new(0, 6)
        StartCorner.Parent = StartBtn
        
        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Parent = MainFrame
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Position = UDim2.new(0.05, 0, 0.72, 0)
        StatusLabel.Size = UDim2.new(0.9, 0, 0, 20)
        StatusLabel.Font = Enum.Font.Gotham
        StatusLabel.Text = "⚡ СТОП"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
        StatusLabel.TextSize = 10
        
        -- ОТДЕЛЬНОЕ ОКНО НАСТРОЕК
        local SettingsFrame = Instance.new("Frame")
        SettingsFrame.Parent = ScreenGui
        SettingsFrame.BackgroundColor3 = Color3.fromRGB(10, 8, 25)
        SettingsFrame.BackgroundTransparency = 0.05
        SettingsFrame.BorderColor3 = Color3.fromRGB(0, 255, 150)
        SettingsFrame.BorderSizePixel = 2
        SettingsFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
        SettingsFrame.Size = UDim2.new(0, 350, 0, 320)
        SettingsFrame.Active = true
        SettingsFrame.Draggable = true
        SettingsFrame.Visible = false
        
        local SetCorner2 = Instance.new("UICorner")
        SetCorner2.CornerRadius = UDim.new(0, 12)
        SetCorner2.Parent = SettingsFrame
        
        local SetGradient = Instance.new("UIGradient")
        SetGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 150))
        })
        SetGradient.Rotation = 45
        SetGradient.Parent = SettingsFrame
        
        local SetTitle = Instance.new("TextLabel")
        SetTitle.Parent = SettingsFrame
        SetTitle.BackgroundTransparency = 1
        SetTitle.Position = UDim2.new(0, 0, 0, 0)
        SetTitle.Size = UDim2.new(1, 0, 0, 35)
        SetTitle.Font = Enum.Font.GothamBold
        SetTitle.Text = "⚙ НАСТРОЙКИ"
        SetTitle.TextColor3 = Color3.fromRGB(0, 255, 150)
        SetTitle.TextSize = 18
        
        local CloseSetBtn = Instance.new("TextButton")
        CloseSetBtn.Parent = SettingsFrame
        CloseSetBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        CloseSetBtn.BackgroundTransparency = 0.2
        CloseSetBtn.BorderSizePixel = 0
        CloseSetBtn.Position = UDim2.new(0.88, 0, 0.02, 0)
        CloseSetBtn.Size = UDim2.new(0, 28, 0, 28)
        CloseSetBtn.Font = Enum.Font.GothamBold
        CloseSetBtn.Text = "✕"
        CloseSetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseSetBtn.TextSize = 16
        local CloseSetCorner = Instance.new("UICorner")
        CloseSetCorner.CornerRadius = UDim.new(0, 7)
        CloseSetCorner.Parent = CloseSetBtn
        CloseSetBtn.MouseButton1Click:Connect(function() SettingsFrame.Visible = false end)
        
        -- КОЛИЧЕСТВО КЕЙСОВ
        local AmountLabel = Instance.new("TextLabel")
        AmountLabel.Parent = SettingsFrame
        AmountLabel.BackgroundTransparency = 1
        AmountLabel.Position = UDim2.new(0.05, 0, 0.12, 0)
        AmountLabel.Size = UDim2.new(0.6, 0, 0, 25)
        AmountLabel.Font = Enum.Font.Gotham
        AmountLabel.Text = "📦 Кейсов за раз (1-10):"
        AmountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        AmountLabel.TextSize = 12
        
        local AmountBoxSet = Instance.new("TextBox")
        AmountBoxSet.Parent = SettingsFrame
        AmountBoxSet.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
        AmountBoxSet.BorderColor3 = Color3.fromRGB(0, 255, 150)
        AmountBoxSet.BorderSizePixel = 1
        AmountBoxSet.Position = UDim2.new(0.65, 0, 0.12, 0)
        AmountBoxSet.Size = UDim2.new(0.3, 0, 0, 30)
        AmountBoxSet.Font = Enum.Font.GothamBold
        AmountBoxSet.Text = "10"
        AmountBoxSet.TextColor3 = Color3.fromRGB(255, 255, 255)
        AmountBoxSet.TextSize = 14
        local AmountSetCorner = Instance.new("UICorner")
        AmountSetCorner.CornerRadius = UDim.new(0, 6)
        AmountSetCorner.Parent = AmountBoxSet
        
        -- ТАЙМЕР
        local TimerLabel = Instance.new("TextLabel")
        TimerLabel.Parent = SettingsFrame
        TimerLabel.BackgroundTransparency = 1
        TimerLabel.Position = UDim2.new(0.05, 0, 0.3, 0)
        TimerLabel.Size = UDim2.new(0.6, 0, 0, 25)
        TimerLabel.Font = Enum.Font.Gotham
        TimerLabel.Text = "⏱ Таймер (сек) 0=∞:"
        TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TimerLabel.TextSize = 12
        
        local TimerBoxSet = Instance.new("TextBox")
        TimerBoxSet.Parent = SettingsFrame
        TimerBoxSet.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
        TimerBoxSet.BorderColor3 = Color3.fromRGB(0, 255, 150)
        TimerBoxSet.BorderSizePixel = 1
        TimerBoxSet.Position = UDim2.new(0.65, 0, 0.3, 0)
        TimerBoxSet.Size = UDim2.new(0.3, 0, 0, 30)
        TimerBoxSet.Font = Enum.Font.GothamBold
        TimerBoxSet.Text = "0"
        TimerBoxSet.TextColor3 = Color3.fromRGB(255, 255, 255)
        TimerBoxSet.TextSize = 14
        local TimerSetCorner = Instance.new("UICorner")
        TimerSetCorner.CornerRadius = UDim.new(0, 6)
        TimerSetCorner.Parent = TimerBoxSet
        
        -- СКОРОСТЬ
        local DelayLabel = Instance.new("TextLabel")
        DelayLabel.Parent = SettingsFrame
        DelayLabel.BackgroundTransparency = 1
        DelayLabel.Position = UDim2.new(0.05, 0, 0.48, 0)
        DelayLabel.Size = UDim2.new(0.6, 0, 0, 25)
        DelayLabel.Font = Enum.Font.Gotham
        DelayLabel.Text = "⚡ Задержка (сек):"
        DelayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        DelayLabel.TextSize = 12
        
        local DelayBoxSet = Instance.new("TextBox")
        DelayBoxSet.Parent = SettingsFrame
        DelayBoxSet.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
        DelayBoxSet.BorderColor3 = Color3.fromRGB(0, 255, 150)
        DelayBoxSet.BorderSizePixel = 1
        DelayBoxSet.Position = UDim2.new(0.65, 0, 0.48, 0)
        DelayBoxSet.Size = UDim2.new(0.3, 0, 0, 30)
        DelayBoxSet.Font = Enum.Font.GothamBold
        DelayBoxSet.Text = "0.05"
        DelayBoxSet.TextColor3 = Color3.fromRGB(255, 255, 255)
        DelayBoxSet.TextSize = 14
        local DelaySetCorner = Instance.new("UICorner")
        DelaySetCorner.CornerRadius = UDim.new(0, 6)
        DelaySetCorner.Parent = DelayBoxSet
        
        -- АВТОПРОДАЖА
        local AutoSellBtn = Instance.new("TextButton")
        AutoSellBtn.Parent = SettingsFrame
        AutoSellBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
        AutoSellBtn.BorderColor3 = Color3.fromRGB(255, 100, 100)
        AutoSellBtn.BorderSizePixel = 1
        AutoSellBtn.Position = UDim2.new(0.05, 0, 0.66, 0)
        AutoSellBtn.Size = UDim2.new(0.9, 0, 0, 40)
        AutoSellBtn.Font = Enum.Font.GothamBold
        AutoSellBtn.Text = "🔴 АВТОПРОДАЖА: ВЫКЛ"
        AutoSellBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        AutoSellBtn.TextSize = 12
        local AutoSellCorner = Instance.new("UICorner")
        AutoSellCorner.CornerRadius = UDim.new(0, 6)
        AutoSellCorner.Parent = AutoSellBtn
        
        -- СОЗДАТЕЛИ
        local CreatorLabel = Instance.new("TextLabel")
        CreatorLabel.Parent = SettingsFrame
        CreatorLabel.BackgroundTransparency = 1
        CreatorLabel.Position = UDim2.new(0.05, 0, 0.82, 0)
        CreatorLabel.Size = UDim2.new(0.9, 0, 0, 30)
        CreatorLabel.Font = Enum.Font.Gotham
        CreatorLabel.Text = "👑 @NoMentalProblem & @Vezqx"
        CreatorLabel.TextColor3 = Color3.fromRGB(180, 0, 255)
        CreatorLabel.TextSize = 10
        
        -- ФУНКЦИИ
        local function RefreshCaseList()
            for _, ch in pairs(CaseScroll:GetChildren()) do
                if ch:IsA("TextButton") then ch:Destroy() end
            end
            for i, cn in ipairs(CustomCases) do
                local btn = Instance.new("TextButton")
                btn.Parent = CaseScroll
                btn.BackgroundColor3 = Color3.fromRGB(30, 25, 55)
                btn.BorderColor3 = Color3.fromRGB(0, 255, 150)
                btn.BorderSizePixel = 1
                btn.Size = UDim2.new(1, 0, 0, 28)
                btn.Font = Enum.Font.Gotham
                btn.Text = cn
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.TextSize = 11
                local btnc = Instance.new("UICorner")
                btnc.CornerRadius = UDim.new(0, 5)
                btnc.Parent = btn
                if cn == Config.SelectedCase then
                    btn.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
                btn.MouseButton1Click:Connect(function()
                    Config.SelectedCase = cn
                    CurrentCaseLabel.Text = "🎯 " .. Config.SelectedCase
                    RefreshCaseList()
                end)
            end
            local cc = #CaseScroll:GetChildren() - 2
            CaseScroll.CanvasSize = UDim2.new(0, 0, 0, cc * 33 + 10)
        end
        
        AddBtn.MouseButton1Click:Connect(function()
            local nc = AddBox.Text
            if nc ~= "" then
                local ex = false
                for _, v in ipairs(CustomCases) do
                    if v == nc then ex = true break end
                end
                if not ex then
                    table.insert(CustomCases, nc)
                    RefreshCaseList()
                    AddBox.Text = ""
                    AddBtn.Text = "✅"
                    wait(0.8)
                    AddBtn.Text = "+"
                else
                    AddBtn.Text = "❌"
                    wait(0.8)
                    AddBtn.Text = "+"
                end
            end
        end)
        
        local function UpdateSellUI()
            if Config.AutoSell then
                SellBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
                SellBtn.Text = "🟢 ПРОД:ВКЛ"
                SellBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
                AutoSellBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
                AutoSellBtn.Text = "🟢 АВТОПРОДАЖА: ВКЛ"
                AutoSellBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
            else
                SellBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
                SellBtn.Text = "🔴 ПРОД:ВЫКЛ"
                SellBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
                AutoSellBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
                AutoSellBtn.Text = "🔴 АВТОПРОДАЖА: ВЫКЛ"
                AutoSellBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
        end
        
        SellBtn.MouseButton1Click:Connect(function()
            Config.AutoSell = not Config.AutoSell
            UpdateSellUI()
        end)
        
        AutoSellBtn.MouseButton1Click:Connect(function()
            Config.AutoSell = not Config.AutoSell
            UpdateSellUI()
        end)
        
        AmountBoxSet.FocusLost:Connect(function()
            local n = tonumber(AmountBoxSet.Text)
            if n and n >= 1 and n <= 10 then
                Config.OpenAmount = math.floor(n)
                AmountBoxSet.Text = tostring(Config.OpenAmount)
            else
                Config.OpenAmount = 10
                AmountBoxSet.Text = "10"
            end
        end)
        
        TimerBoxSet.FocusLost:Connect(function()
            local n = tonumber(TimerBoxSet.Text)
            if n and n >= 0 then
                Config.TimerSeconds = math.floor(n)
                TimerBoxSet.Text = tostring(Config.TimerSeconds)
            else
                Config.TimerSeconds = 0
                TimerBoxSet.Text = "0"
            end
        end)
        
        DelayBoxSet.FocusLost:Connect(function()
            local n = tonumber(DelayBoxSet.Text)
            if n and n >= 0.005 then
                Config.DelayBetween = n
                DelayBoxSet.Text = tostring(Config.DelayBetween)
            else
                Config.DelayBetween = 0.05
                DelayBoxSet.Text = "0.05"
            end
        end)
        
        SettingsBtn.MouseButton1Click:Connect(function()
            SettingsFrame.Visible = true
            SettingsFrame.Position = MainFrame.Position
            AmountBoxSet.Text = tostring(Config.OpenAmount)
            TimerBoxSet.Text = tostring(Config.TimerSeconds)
            DelayBoxSet.Text = tostring(Config.DelayBetween)
        end)
        
        local function FarmLoop()
            while Config.IsFarming do
                if Config.TimerSeconds > 0 and os.time() - Config.StartTime >= Config.TimerSeconds then
                    break
                end
                pcall(function()
                    local Events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
                    if Events then
                        local OC = Events:FindFirstChild("OpenCase")
                        if OC then OC:InvokeServer(Config.SelectedCase, Config.OpenAmount) end
                        if Config.AutoSell then
                            local Inv = Events:FindFirstChild("Inventory")
                            if Inv then Inv:FireServer("Sell", "ALL") end
                        end
                    end
                end)
                wait(Config.DelayBetween)
            end
            Config.IsFarming = false
            StartBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            StartBtn.Text = "▶"
            StatusLabel.Text = "⚡ СТОП"
            StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
        end
        
        StartBtn.MouseButton1Click:Connect(function()
            if not Config.IsFarming then
                Config.IsFarming = true
                Config.StartTime = os.time()
                StartBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
                StartBtn.Text = "⏹"
                StatusLabel.Text = "⚡ ФАРМ"
                StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
                spawn(FarmLoop)
            else
                Config.IsFarming = false
            end
        end)
        
        -- АНИМАЦИЯ
        spawn(function()
            local t = 0
            while true do
                t = t + 0.03
                local i = (math.sin(t) + 1) / 4 + 0.5
                MainFrame.BorderColor3 = Color3.new(i * 0.7, i * 0.5, i)
                SettingsFrame.BorderColor3 = Color3.new(i * 0.7, i * 0.5, i)
                wait(0.05)
            end
        end)
        
        RefreshCaseList()
        UpdateSellUI()
        print("✅ TON BATTLE ЗАГРУЖЕН | Кейс: " .. Config.SelectedCase)
    end
    
    loginBtn.MouseButton1Click:Connect(function()
        if passwordBox.Text == "mr.comcom" then
            LoadMainScript()
        else
            statusLabel.Text = "❌ НЕВЕРНЫЙ ПАРОЛЬ!"
            passwordBox.Text = ""
        end
    end)
end

ShowPasswordMenu()
