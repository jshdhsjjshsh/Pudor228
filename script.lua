local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Auto = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local Label = Instance.new("TextLabel")
local Dropdown = Instance.new("TextButton") -- Кнопка для выбора кейса
local DropdownList = Instance.new("Frame") -- Выпадающий список
local UICorner_3 = Instance.new("UICorner")
local dd = Instance.new("UIDragDetector")
local on = 0
local selectedCase = "Photon Core" -- Кейс по умолчанию

-- Список доступных кейсов
local cases = {"Photon Core", "Marina", "Cursed Demon", "Heavenfall"}

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Основное окно
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.200
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.366485506, 0, 0.363968015, 0)
Frame.Size = UDim2.new(0, 240, 0, 200)

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame

-- Кнопка выбора кейса
Dropdown.Name = "Dropdown"
Dropdown.Parent = Frame
Dropdown.BackgroundColor3 = Color3.fromRGB(255, 115, 0)
Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
Dropdown.BorderSizePixel = 0
Dropdown.Position = UDim2.new(0.0833333954, 0, 0.1, 0)
Dropdown.Size = UDim2.new(0, 200, 0, 40)
Dropdown.Font = Enum.Font.SourceSans
Dropdown.Text = selectedCase .. " ▼"
Dropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
Dropdown.TextSize = 18

UICorner_3.CornerRadius = UDim.new(0, 10)
UICorner_3.Parent = Dropdown

-- Выпадающий список (скрыт по умолчанию)
DropdownList.Parent = Frame
DropdownList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DropdownList.BorderColor3 = Color3.fromRGB(0, 0, 0)
DropdownList.BorderSizePixel = 0
DropdownList.Position = UDim2.new(0.0833333954, 0, 0.1, 40)
DropdownList.Size = UDim2.new(0, 200, 0, 160)
DropdownList.BackgroundTransparency = 0.1
DropdownList.Visible = false

local listUICorner = Instance.new("UICorner")
listUICorner.CornerRadius = UDim.new(0, 10)
listUICorner.Parent = DropdownList

-- Создание кнопок для каждого кейса
local function createCaseButton(caseName, yPos)
    local btn = Instance.new("TextButton")
    btn.Parent = DropdownList
    btn.BackgroundColor3 = Color3.fromRGB(255, 115, 0)
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Font = Enum.Font.SourceSans
    btn.Text = caseName
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextSize = 18
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        selectedCase = caseName
        Dropdown.Text = selectedCase .. " ▼"
        DropdownList.Visible = false
    end)
end

-- Создаём кнопки для всех кейсов
for i, caseName in ipairs(cases) do
    createCaseButton(caseName, (i-1) * 40)
end

-- Открытие/закрытие списка при клике
Dropdown.MouseButton1Click:Connect(function()
    DropdownList.Visible = not DropdownList.Visible
end)

-- Закрытие списка при клике вне его
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
        end
    end
end)

-- Кнопка автофарма
Auto.Name = "Auto"
Auto.Parent = Frame
Auto.BackgroundColor3 = Color3.fromRGB(255, 168, 29)
Auto.BorderColor3 = Color3.fromRGB(0, 0, 0)
Auto.BorderSizePixel = 0
Auto.Position = UDim2.new(0.0833333954, 0, 0.5, 0)
Auto.Size = UDim2.new(0, 200, 0, 50)
Auto.Font = Enum.Font.SourceSans
Auto.Text = "Start AutoFarm"
Auto.TextColor3 = Color3.fromRGB(0, 0, 0)
Auto.TextSize = 30

UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = Auto

-- Подпись
Label.Name = "Label"
Label.Parent = Frame
Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Label.BackgroundTransparency = 1.000
Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
Label.BorderSizePixel = 0
Label.Position = UDim2.new(0.0833333954, 0, 0.78, 0)
Label.Size = UDim2.new(0, 200, 0, 40)
Label.Font = Enum.Font.SourceSans
Label.Text = "NFT Battles V1"
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.TextSize = 30

dd.Parent = Frame

-- Логика автофарма
Auto.MouseButton1Click:Connect(function()
    if on == 0 then
        on = 1
        Auto.BackgroundColor3 = Color3.fromRGB(4, 132, 15)
        Auto.Text = "AutoFarm ON"
        
        task.spawn(function()
            while on == 1 do
                local args = {
                    selectedCase,
                    10
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("OpenCase"):InvokeServer(unpack(args))
                task.wait(2)
            end
        end)
    else
        on = 0
        Auto.BackgroundColor3 = Color3.fromRGB(255, 168, 29)
        Auto.Text = "Start AutoFarm"
    end
end)
