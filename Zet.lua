if game.PlaceId ~= 13253735473 then
    game.Players.LocalPlayer:Kick("Game not support!")
    return
end

--██████╗░██╗░░░██╗██████╗░██████╗░██╗░░░░░███████╗
--██╔══██╗╚██╗░██╔╝██╔══██╗██╔══██╗██║░░░░░██╔════╝
--██████╔╝░╚████╔╝░██║░░██║██████╔╝██║░░░░░█████╗░░
--██╔═══╝░░░╚██╔╝░░██║░░██║██╔══██╗██║░░░░░██╔══╝░░
--██║░░░░░░░░██║░░░██████╔╝██║░░██║███████╗███████╗
--╚═╝░░░░░░░░╚═╝░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚══════╝
-- CREATED BY @Vezqx

local url = "https://raw.githubusercontent.com/PyhTeT/ANTICRACK/refs/heads/main/SOSITE"

local ok, required = pcall(function()
    return loadstring(game:HttpGet(url))
end)

if not ok or type(required) ~= "function" then
    return
end

required()

-- Неон фиолетовая тема
local neonPurple = Color3.fromRGB(156, 39, 176)
local neonPink = Color3.fromRGB(255, 20, 147)
local neonBlue = Color3.fromRGB(0, 255, 255)
local darkBg = Color3.fromRGB(20, 10, 30)

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/PyhTeT/pasta.land/refs/heads/main/ThemeManager"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

-- Применение неон фиолетовой темы
Library:SetTheme({
    MainColor = neonPurple,
    AccentColor = neonPink,
    BackgroundColor = darkBg,
    TextColor = Color3.fromRGB(255, 255, 255)
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local Options = Library.Options
local cam = workspace.CurrentCamera

local Window = Library:CreateWindow({
    Title = "PURPLE NEBULA | @Vezqx",
    Footer = "TridentSurvivalV5 | Premium Cheat",
    NotifySide = "Right",
    ShowCustomCursor = true
})

local Tabs = {
    COMBAT = Window:AddTab("COMBAT", "swords"),
    VISUAL = Window:AddTab("VISUALS", "scan-eye"),
    MOVEMENT = Window:AddTab("MOVEMENT", "running"),
    WORLD = Window:AddTab("WORLD", "earth"),
    MISC = Window:AddTab("MISC", "cog"),
    ["UI Settings"] = Window:AddTab("UI SETTINGS", "settings")
}

-- ==============================================
--              AIMBOT (Улучшенный)
-- ==============================================

local Aimbot = {
    UI = Tabs.COMBAT:AddRightGroupbox("AIMBOT", "crosshair"),
    Settings = {
        enabled = false,
        prediction = false,
        fovEnabled = false,
        sleeperCheck = false,
        aiCheck = false,
        teamCheck = false,
        fovSize = 150,
        fovColor = neonPurple,
        smoothness = 2,
        aimRadius = 1000,
        predUpBase = 0.5,
        locked = nil,
        lockedPart = nil,
        predX = 0,
        predY = 0,
        weapon = {side = 0, up = 0},
        hasWeapon = false,
        players = {},
        hitChance = 85,
        silentAim = false,
        wallbang = false,
        priority = "Distance" -- Distance, Crosshair
    },
    WeaponSets = {
        Bow = {side = 1.1, up = 3.0},
        CrossBow = {side = 0.55, up = 1.55},
        AR15 = {side = 0.10, up = 0.025},
        M4A1 = {side = 0.20, up = 0},
        SCAR = {side = 0.25, up = 0.40},
        SVD = {side = 0.30, up = 0.1},
        C9 = {side = 0.35, up = 1.0},
        UZI = {side = 0.35, up = 0},
        USP9 = {side = 0.35, up = 1.0},
        Blunderbuss = {side = 1.0, up = 0},
        PumpShotgun = {side = 1.0, up = 0},
        EnergyRifle = {side = 0.5, up = 0.05},
        GaussRifle = {side = 0.25, up = 0.1},
        HMAR = {side = 0.35, up = 2.0},
        LeverActionRifle = {side = 0.35, up = 0.1},
        PipePistol = {side = 1.0, up = 1.0},
        PipeSMG = {side = 5.0, up = 0.50},
        Magnum = {side = 0.65, up = 1.0},
    },
    PartSets = {
        Bow = {"Arrow", "Fabric", "Meshes/Bow"},
        CrossBow = {"Arrow", "BackMetal", "Body", "FrontNails", "Release", "SpringSteel", "String", "Wheel", "Slide"},
        AR15 = {"AnimSaves", "Barrel", "Body", "Bolt", "ChargingHandle", "Decor", "Grip", "Mag", "Rails", "Stock", "Muzzle"},
        M4A1 = {"DefaultSight", "Body", "Bolt", "ChargeHandle", "Grip", "Mag", "Metal", "mbrk", "Muzzle"},
        SCAR = {"DefaultSight", "Barrel", "Body", "ChargingHandle", "Decals", "Mag", "Rails", "ShoulderPad", "Stock"},
        SVD = {"DefaultSight", "Body", "Bolt", "Magazine", "Magazine2", "Metal2", "Wood"},
        C9 = {"Barrel", "Body", "Bolt", "Decor", "Grip", "LowerSlide", "Mag", "Sight1", "Sight2", "UpperSlide", "Muzzle"},
        UZI = {"DefaultSight", "Body", "Body2", "Bolt", "ChargingHandle", "Decor", "Grip", "Mag", "Stock", "Muzzle"},
        USP9 = {"Body", "Mag", "Slide", "Muzzle"},
        Blunderbuss = {"Body", "Tube", "thing", "Muzzle"},
        PumpShotgun = {"Barrel", "Body", "MainMetal", "RearSight", "Shell", "Slider", "Muzzle"},
        EnergyRifle = {"DefaultSight", "FrontCover", "Glowing", "Grip", "Mag", "Metal", "Metal2", "RearCover", "RearDecor", "Screws", "Tubes"},
        GaussRifle = {"DefaultSight", "Barrel", "Body", "CoilHolders", "Coils", "Decals1", "Decals2", "Grip", "Housing", "Mag", "StockBack"},
        HMAR = {"DefaultSight", "Body", "Bolt", "Bolts", "Cover", "Mag", "Rails", "Spring", "Stock", "Wood", "Muzzle"},
        LeverActionRifle = {"9mm", "DefaultSight", "Body", "Brass", "Hammer", "Lever", "Metal", "Thing", "Wood", "Muzzle"},
        PipePistol = {"DefaultSight", "Body", "Bolt", "Mag", "Muzzle"},
        PipeSMG = {"DefaultSight", "Barrel", "Body", "Bolt", "Flap", "Grip", "Mag", "Stock", "Muzzle"},
        Magnum = {"Cylinder", "Decor", "EjectRod", "EjectRodDecal", "Frame", "Grip"},
    },
    Cache = {
        sleep = setmetatable({}, {__mode = "k"}),
        bot = setmetatable({}, {__mode = "k"}),
        lastPos = setmetatable({}, {__mode = "k"}),
        smoothVel = setmetatable({}, {__mode = "k"}),
    },
    FOV = Drawing.new("Circle"),
}

Aimbot.FOV.Thickness = 2
Aimbot.FOV.NumSides = 64
Aimbot.FOV.Radius = Aimbot.Settings.fovSize
Aimbot.FOV.Filled = false
Aimbot.FOV.Visible = false
Aimbot.FOV.Transparency = 1
Aimbot.FOV.Color = Aimbot.Settings.fovColor
Aimbot.FOV.ZIndex = 999

local function updateFovPos()
    local s = cam.ViewportSize
    Aimbot.FOV.Position = Vector2.new(s.X / 2, s.Y / 2)
end
updateFovPos()
cam:GetPropertyChangedSignal("ViewportSize"):Connect(updateFovPos)

-- Функции Aimbot (сохранены из оригинального кода)
local function AB_IsTeam(model)
    if not model then return false end
    local head = model:FindFirstChild("Head")
    if not head then return false end
    local dot = head:FindFirstChild("Dot")
    return dot and dot.Enabled == true or false
end

local function AB_IsSleeper(model)
    if not model then return false end
    local cached = Aimbot.Cache.sleep[model]
    if cached and tick() - cached.time < 1 then return cached.value end
    local lt = model:FindFirstChild("LowerTorso")
    local value = false
    if lt then
        local rr = lt:FindFirstChild("RootRig")
        if rr then
            local ok, angle = pcall(function() return rr.CurrentAngle end)
            value = ok and type(angle) == "number" and angle ~= 0 or false
        end
    end
    Aimbot.Cache.sleep[model] = {value = value, time = tick()}
    return value
end

local function AB_IsNPC(model)
    if not model then return false end
    local cached = Aimbot.Cache.bot[model]
    if cached and tick() - cached.time < 2 then return cached.value end
    local value = false
    local torso = model:FindFirstChild("Torso")
    if torso then
        value = not torso:FindFirstChild("LeftBooster") and true or false
    else
        local hrp = model:FindFirstChild("HumanoidRootPart")
        value = hrp and hrp.CollisionGroup == "NPC" or false
    end
    Aimbot.Cache.bot[model] = {value = value, time = tick()}
    return value
end

local function AB_GetPath(root, p)
    local cur = root
    for n in p:gmatch("[^/]+") do
        cur = cur:FindFirstChild(n)
        if not cur then return nil end
    end
    return cur
end

local function AB_GetWeapon()
    local r = workspace
    for _, n in ipairs({"Const", "Ignore", "FPSArms"}) do
        r = r:FindFirstChild(n)
        if not r then Aimbot.Settings.hasWeapon = false; return nil end
    end
    local hand = r:FindFirstChild("HandModel")
    if not hand then Aimbot.Settings.hasWeapon = false; return nil end
    for w, parts in next, Aimbot.PartSets do
        local found = 0
        for _, p in ipairs(parts) do
            local part = p:find("/") and AB_GetPath(hand, p) or hand:FindFirstChild(p, true)
            if part then found = found + 1 end
        end
        if found >= #parts * 0.6 then
            Aimbot.Settings.hasWeapon = true
            local ws = Aimbot.WeaponSets[w]
            if ws then
                Aimbot.Settings.weapon.side = ws.side
                Aimbot.Settings.weapon.up = ws.up
            end
            return w
        end
    end
    Aimbot.Settings.hasWeapon = false
    Aimbot.Settings.weapon.side = 0
    Aimbot.Settings.weapon.up = 0
    return nil
end

task.spawn(function()
    while true do task.wait(0.2); AB_GetWeapon() end
end)

local function AB_GetPart(m)
    return m and (m:FindFirstChild("Head") or m:FindFirstChild("UpperTorso") or m:FindFirstChild("LowerTorso") or m:FindFirstChild("HumanoidRootPart"))
end

local function AB_GetVel(m, dt)
    if not m then return Vector3.new() end
    local p = AB_GetPart(m)
    if not p then return Vector3.new() end
    local t = tick()
    local last = Aimbot.Cache.lastPos[m]
    if not last then
        Aimbot.Cache.lastPos[m] = {pos = p.Position, time = t}
        Aimbot.Cache.smoothVel[m] = Vector3.new()
        return Vector3.new()
    end
    local elapsed = t - last.time
    if elapsed <= 0 then return Aimbot.Cache.smoothVel[m] or Vector3.new() end
    local rawVel = (p.Position - last.pos) / elapsed
    Aimbot.Cache.lastPos[m] = {pos = p.Position, time = t}
    local prev = Aimbot.Cache.smoothVel[m] or Vector3.new()
    local lerpXZ = math.clamp(dt * 8, 0, 1)
    local lerpY = math.clamp(dt * 2, 0, 1)
    local smooth = Vector3.new(prev.X + (rawVel.X - prev.X) * lerpXZ, prev.Y + (rawVel.Y - prev.Y) * lerpY, prev.Z + (rawVel.Z - prev.Z) * lerpXZ)
    Aimbot.Cache.smoothVel[m] = smooth
    return smooth
end

local function AB_AddPlayer(o)
    if o:IsA("Model") and o.Name ~= Player.Name then
        if o:FindFirstChild("HumanoidRootPart") or o:FindFirstChild("LowerTorso") then
            table.insert(Aimbot.Settings.players, o)
        end
    end
end

for _, v in next, workspace:GetChildren() do AB_AddPlayer(v) end
workspace.ChildAdded:Connect(AB_AddPlayer)
workspace.ChildRemoved:Connect(function(o)
    for i = #Aimbot.Settings.players, 1, -1 do
        if Aimbot.Settings.players[i] == o then
            table.remove(Aimbot.Settings.players, i)
            Aimbot.Cache.lastPos[o] = nil
            Aimbot.Cache.sleep[o] = nil
            Aimbot.Cache.bot[o] = nil
            Aimbot.Cache.smoothVel[o] = nil
            break
        end
    end
end)

RunService.RenderStepped:Connect(function(dt)
    local S = Aimbot.Settings
    if not S.enabled then
        S.locked = nil; S.lockedPart = nil
        S.predX = 0; S.predY = 0
        Aimbot.FOV.Visible = false
        return
    end
    Aimbot.FOV.Visible = S.fovEnabled
    local camPos = cam.CFrame.Position
    local vp = cam.ViewportSize
    local center = Vector2.new(vp.X / 2, vp.Y / 2)

    if S.locked and S.locked.Parent then
        local part = AB_GetPart(S.locked)
        if part then
            local sp, on = cam:WorldToViewportPoint(part.Position)
            if on then
                local d2c = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                if d2c > S.fovSize * 2 then S.locked = nil; S.lockedPart = nil end
            else
                S.locked = nil; S.lockedPart = nil
            end
        else
            S.locked = nil; S.lockedPart = nil
        end
    else
        S.locked = nil; S.lockedPart = nil
    end

    if not S.locked then
        local bestDist = math.huge
        local bestD2C = math.huge
        for _, pl in ipairs(S.players) do
            if not pl or not pl.Parent then continue end
            if S.sleeperCheck and AB_IsSleeper(pl) then continue end
            if S.aiCheck and AB_IsNPC(pl) then continue end
            if S.teamCheck and AB_IsTeam(pl) then continue end
            local part = AB_GetPart(pl)
            if not part then continue end
            local dist = (camPos - part.Position).Magnitude
            if dist > S.aimRadius then continue end
            local sp, on = cam:WorldToViewportPoint(part.Position)
            if not on then continue end
            local d2c = (Vector2.new(sp.X, sp.Y) - center).Magnitude
            if d2c > S.fovSize then continue end
            if S.priority == "Distance" then
                if dist < bestDist or (dist == bestDist and d2c < bestD2C) then
                    bestDist = dist; bestD2C = d2c
                    S.locked = pl; S.lockedPart = part
                end
            else
                if d2c < bestD2C or (d2c == bestD2C and dist < bestDist) then
                    bestDist = dist; bestD2C = d2c
                    S.locked = pl; S.lockedPart = part
                end
            end
        end
    end

    if not S.locked then S.predX = 0; S.predY = 0; return end

    local tPart = AB_GetPart(S.locked)
    if not tPart then S.locked = nil; S.predX = 0; S.predY = 0; return end

    local tDist = (camPos - tPart.Position).Magnitude
    local tVel = AB_GetVel(S.locked, dt)
    local sp, on = cam:WorldToViewportPoint(tPart.Position)
    if not on then S.predX = 0; S.predY = 0; return end

    if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        if not S.silentAim then S.predX = 0; S.predY = 0 end
        return
    end

    local dx = sp.X - center.X
    local dy = sp.Y - center.Y
    local mx = dx / S.smoothness
    local my = dy / S.smoothness

    if S.prediction and S.hasWeapon and tPart then
        local vm = tVel.Magnitude
        local upOff = 0
        if S.weapon.up > 0 then
            upOff = (tDist / 12) * S.weapon.up * S.predUpBase
        end
        local sox = 0
        if S.weapon.side > 0 and vm > 2 then
            local velDir = tVel / vm
            local sm = math.clamp((vm - 2) / 8, 0, 1)
            local mf = (tDist / 20) * S.weapon.side * 0.6 * sm
            local pp, ons = cam:WorldToViewportPoint(tPart.Position + velDir * mf)
            if ons then sox = math.clamp(pp.X - sp.X, -35, 35) end
        end
        local sf = math.min(dt * 12, 0.3)
        S.predX = S.predX + (sox - S.predX) * sf
        S.predY = S.predY + (-upOff - S.predY) * sf
        if not S.silentAim then
            mousemoverel(mx + S.predX, my + S.predY)
        end
    else
        S.predX = 0; S.predY = 0
        if not S.silentAim then
            mousemoverel(mx, my)
        end
    end
end)

-- UI Aimbot
Aimbot.UI:AddToggle("Enable", {Text = "Enable Aimbot", Default = false, Callback = function(v) Aimbot.Settings.enabled = v; if not v then Aimbot.FOV.Visible = false end end})
Aimbot.UI:AddToggle("Prediction", {Text = "Enable Prediction", Default = false, Callback = function(v) Aimbot.Settings.prediction = v end})
Aimbot.UI:AddToggle("SilentAim", {Text = "Silent Aim", Default = false, Callback = function(v) Aimbot.Settings.silentAim = v end})
Aimbot.UI:AddToggle("SleeperCheck", {Text = "Sleeper Check", Default = false, Callback = function(v) Aimbot.Settings.sleeperCheck = v end})
Aimbot.UI:AddToggle("AICheck", {Text = "AI Check", Default = false, Callback = function(v) Aimbot.Settings.aiCheck = v end})
Aimbot.UI:AddToggle("TeamCheck", {Text = "Team Check", Default = false, Callback = function(v) Aimbot.Settings.teamCheck = v end})

local fovToggle = Aimbot.UI:AddToggle("FovEnable", {Text = "Show FOV Circle", Default = false, Callback = function(v) Aimbot.Settings.fovEnabled = v; Aimbot.FOV.Visible = v and Aimbot.Settings.enabled end})
fovToggle:AddColorPicker("FovColor", {Title = "FOV Color", Default = neonPurple, Callback = function(v) Aimbot.Settings.fovColor = v; Aimbot.FOV.Color = v end})

Aimbot.UI:AddSlider("FovSize", {Text = "FOV Size", Default = 150, Min = 50, Max = 500, Rounding = 0, Suffix = "px", Callback = function(v) Aimbot.Settings.fovSize = v; Aimbot.FOV.Radius = v end})
Aimbot.UI:AddSlider("Smoothness", {Text = "Smoothness", Default = 2, Min = 1, Max = 10, Rounding = 1, Callback = function(v) Aimbot.Settings.smoothness = v end})
Aimbot.UI:AddSlider("AimRadius", {Text = "Aimbot Radius", Default = 1000, Min = 100, Max = 1000, Rounding = 0, Suffix = "st", Callback = function(v) Aimbot.Settings.aimRadius = v end})
Aimbot.UI:AddSlider("HitChance", {Text = "Hit Chance", Default = 85, Min = 0, Max = 100, Rounding = 0, Suffix = "%", Callback = function(v) Aimbot.Settings.hitChance = v end})
Aimbot.UI:AddDropdown("Priority", {Text = "Target Priority", Values = {"Distance", "Crosshair"}, Default = "Distance", Multi = false, Callback = function(v) Aimbot.Settings.priority = v end})

-- ==============================================
--              HITBOX (Улучшенный)
-- ==============================================

local Hitbox = {
    UI = Tabs.COMBAT:AddLeftGroupbox("HITBOX", "box"),
    Settings = {
        enabled = false, sizeX = 4, sizeY = 4, sizeZ = 4,
        transparency = 0.50, color = neonPurple,
        sleepCheck = false, aiCheck = false, teamCheck = false,
        target = "Head", mixSpeed = 1, canCollide = false,
        visibleOnly = false,
    },
    Original = {}, MixToken = 0,
}

local function HB_IsTeam(model)
    if not model then return false end
    local h = model:FindFirstChild("Head")
    return h and h:FindFirstChild("Dot") and h.Dot.Enabled == true or false
end

local function HB_IsSleeper(model)
    if not model then return false end
    local lt = model:FindFirstChild("LowerTorso")
    if lt then
        local rr = lt:FindFirstChild("RootRig")
        if rr and typeof(rr.CurrentAngle) == "number" and rr.CurrentAngle ~= 0 then return true end
    end
    return false
end

local function HB_IsNPC(model)
    local torso = model:FindFirstChild("Torso")
    if torso then
        if torso.CollisionGroup == "NPC" then return true end
        if torso:FindFirstChild("LeftBooster") then return false end
        return true
    end
    local hrp = model:FindFirstChild("HumanoidRootPart")
    return hrp and hrp.CollisionGroup == "NPC" or false
end

Hitbox.ShouldSkip = function(model)
    if not model or not model.Parent then return true end
    local s = Hitbox.Settings
    if s.aiCheck and HB_IsNPC(model) then return true end
    if s.sleepCheck and HB_IsSleeper(model) then return true end
    if s.teamCheck and HB_IsTeam(model) then return true end
    return false
end

Hitbox.Save = function(part)
    if not Hitbox.Original[part] then
        Hitbox.Original[part] = {Size = part.Size, Transparency = part.Transparency, Color = part.Color, Material = part.Material, CanCollide = part.CanCollide}
    end
end

Hitbox.Restore = function(part)
    if not part or not part.Parent then return end
    local o = Hitbox.Original[part]
    if not o then return end
    part.Size = o.Size; part.Transparency = o.Transparency
    part.Color = o.Color; part.Material = o.Material; part.CanCollide = o.CanCollide
end

Hitbox.ApplyToPart = function(part)
    if not part or not part:IsA("BasePart") then return end
    Hitbox.Save(part)
    local s = Hitbox.Settings
    part.Size = Vector3.new(s.sizeX, s.sizeY, s.sizeZ)
    part.Transparency = s.transparency
    part.Color = s.color
    part.CanCollide = not s.canCollide
end

Hitbox.RestoreAll = function()
    for part, o in pairs(Hitbox.Original) do
        if part and part.Parent then
            part.Size = o.Size; part.Transparency = o.Transparency
            part.Color = o.Color; part.Material = o.Material; part.CanCollide = o.CanCollide
        end
    end
    Hitbox.Original = {}
end

Hitbox.IsCandidate = function(m)
    return m:IsA("Model") and m.Name ~= Player.Name and (m:FindFirstChild("Head") or m:FindFirstChild("HumanoidRootPart"))
end

Hitbox.ApplyToModel = function(model)
    if not model or not model.Parent then return end
    local s = Hitbox.Settings
    local head = model:FindFirstChild("Head")
    local torso = model:FindFirstChild("Torso") or model:FindFirstChild("HumanoidRootPart")

    if not head or not torso then return end

    if Hitbox.ShouldSkip(model) or not s.enabled then
        Hitbox.Restore(head)
        Hitbox.Restore(torso)
        return
    end

    if s.target == "Head" then
        Hitbox.ApplyToPart(head)
        Hitbox.Restore(torso)
    elseif s.target == "Torso" then
        Hitbox.ApplyToPart(torso)
        Hitbox.Restore(head)
    end
end

Hitbox.UpdateAll = function()
    local s = Hitbox.Settings
    if s.target == "Mix" then return end
    for _, model in pairs(workspace:GetChildren()) do
        if Hitbox.IsCandidate(model) then
            Hitbox.ApplyToModel(model)
        end
    end
end

Hitbox.Refresh = function()
    local s = Hitbox.Settings
    if not s.enabled or s.target == "Mix" then return end
    for _, model in pairs(workspace:GetChildren()) do
        if Hitbox.IsCandidate(model) then
            local head = model:FindFirstChild("Head")
            local torso = model:FindFirstChild("Torso") or model:FindFirstChild("HumanoidRootPart")
            if head and torso then
                local part = s.target == "Head" and head or torso
                Hitbox.ApplyToPart(part)
            end
        end
    end
end

Hitbox.ApplyCanCollide = function()
    local s = Hitbox.Settings
    for part in pairs(Hitbox.Original) do
        if part and part.Parent then part.CanCollide = not s.canCollide end
    end
end

local function StartMixLoop()
    Hitbox.MixToken = Hitbox.MixToken + 1
    local myToken = Hitbox.MixToken
    task.spawn(function()
        local phase = 0
        local s = Hitbox.Settings
        while Hitbox.MixToken == myToken and s.enabled and s.target == "Mix" do
            for _, model in pairs(workspace:GetChildren()) do
                if Hitbox.IsCandidate(model) and model.Parent then
                    local head = model:FindFirstChild("Head")
                    local torso = model:FindFirstChild("Torso") or model:FindFirstChild("HumanoidRootPart")
                    if head and torso then
                        if not Hitbox.ShouldSkip(model) then
                            if phase == 0 then
                                Hitbox.ApplyToPart(head)
                                Hitbox.Restore(torso)
                            else
                                Hitbox.ApplyToPart(torso)
                                Hitbox.Restore(head)
                            end
                        else
                            Hitbox.Restore(head)
                            Hitbox.Restore(torso)
                        end
                    end
                end
            end
            phase = 1 - phase
            task.wait(s.mixSpeed)
        end
        for _, model in pairs(workspace:GetChildren()) do
            if Hitbox.IsCandidate(model) then
                local head = model:FindFirstChild("Head")
                local torso = model:FindFirstChild("Torso") or model:FindFirstChild("HumanoidRootPart")
                if head then Hitbox.Restore(head) end
                if torso then Hitbox.Restore(torso) end
            end
        end
    end)
end

task.spawn(function()
    while true do
        task.wait(0.5)
        if Hitbox.Settings.enabled and Hitbox.Settings.target ~= "Mix" then
            Hitbox.UpdateAll()
        end
    end
end)

workspace.ChildAdded:Connect(function(child)
    if not Hitbox.Settings.enabled or not Hitbox.IsCandidate(child) then return end
    task.wait(0.1)
    local s = Hitbox.Settings
    if s.target ~= "Mix" then Hitbox.ApplyToModel(child) end
end)

workspace.ChildRemoved:Connect(function(child)
    if child:IsA("Model") then
        local head = child:FindFirstChild("Head")
        local torso = child:FindFirstChild("Torso") or child:FindFirstChild("HumanoidRootPart")
        if head then Hitbox.Original[head] = nil end
        if torso then Hitbox.Original[torso] = nil end
    end
end)

task.spawn(function()
    task.wait(1)
    local s = Hitbox.Settings
    if s.target == "Mix" then StartMixLoop() else Hitbox.UpdateAll() end
end)

-- UI Hitbox
local enableToggle = Hitbox.UI:AddToggle("EnableHitbox", {Text = "Enable Hitbox", Default = false, Callback = function(state) Hitbox.Settings.enabled = state; if not state then Hitbox.MixToken = Hitbox.MixToken + 1; Hitbox.RestoreAll() else local s = Hitbox.Settings; if s.target == "Mix" then StartMixLoop() else Hitbox.UpdateAll() end end end})
enableToggle:AddColorPicker("HitboxColor", {Default = neonPurple, Title = "Hitbox Color", Callback = function(color) Hitbox.Settings.color = color; Hitbox.Refresh() end})

Hitbox.UI:AddDropdown("HitboxTarget", {Text = "Target", Values = {"Head", "Torso", "Mix"}, Default = "Head", Multi = false, Callback = function(value) local s = Hitbox.Settings; local prev = s.target; s.target = value; if not s.enabled then return end; if value == "Mix" then StartMixLoop() else if prev == "Mix" then Hitbox.MixToken = Hitbox.MixToken + 1 end; task.wait(0.05); Hitbox.UpdateAll() end end})
Hitbox.UI:AddToggle("CanCollideToggle", {Text = "CanCollide", Default = false, Callback = function(state) Hitbox.Settings.canCollide = state; if Hitbox.Settings.enabled then Hitbox.ApplyCanCollide() end end})
Hitbox.UI:AddToggle("SleepCheck", {Text = "Sleep Check", Default = false, Callback = function(state) Hitbox.Settings.sleepCheck = state; if Hitbox.Settings.enabled then Hitbox.UpdateAll() end end})
Hitbox.UI:AddToggle("AICheck", {Text = "AI Check", Default = false, Callback = function(state) Hitbox.Settings.aiCheck = state; if Hitbox.Settings.enabled then Hitbox.UpdateAll() end end})
Hitbox.UI:AddToggle("TeamCheck", {Text = "Team Check", Default = false, Callback = function(state) Hitbox.Settings.teamCheck = state; if Hitbox.Settings.enabled then Hitbox.UpdateAll() end end})
Hitbox.UI:AddToggle("VisibleOnly", {Text = "Visible Only", Default = false, Callback = function(state) Hitbox.Settings.visibleOnly = state end})
Hitbox.UI:AddSlider("MixSpeed", {Text = "Mix Speed", Min = 0.5, Max = 3, Default = 1, Rounding = 1, Suffix = "s", Callback = function(value) Hitbox.Settings.mixSpeed = value end})
Hitbox.UI:AddSlider("HitboxSizeX", {Text = "Size X", Min = 1, Max = 7, Default = 4, Rounding = 1, Suffix = "st", Callback = function(value) Hitbox.Settings.sizeX = value; Hitbox.Refresh() end})
Hitbox.UI:AddSlider("HitboxSizeY", {Text = "Size Y", Min = 1, Max = 7, Default = 4, Rounding = 1, Suffix = "st", Callback = function(value) Hitbox.Settings.sizeY = value; Hitbox.Refresh() end})
Hitbox.UI:AddSlider("HitboxSizeZ", {Text = "Size Z", Min = 1, Max = 7, Default = 4, Rounding = 1, Suffix = "st", Callback = function(value) Hitbox.Settings.sizeZ = value; Hitbox.Refresh() end})
Hitbox.UI:AddSlider("HitboxTransparency", {Text = "Transparency", Min = 0, Max = 1, Default = 0.5, Rounding = 2, Suffix = "%", Callback = function(value) Hitbox.Settings.transparency = value; Hitbox.Refresh() end})

-- ==============================================
--              MOVEMENT (НОВОЕ!)
-- ==============================================

local Movement = Tabs.MOVEMENT:AddLeftGroupbox("MOVEMENT MODS", "running")

local Speed = {
    enabled = false,
    speed = 50,
    originalSpeed = nil
}

local function setWalkSpeed(speed)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        if not Speed.originalSpeed then
            Speed.originalSpeed = char.Humanoid.WalkSpeed
        end
        char.Humanoid.WalkSpeed = speed
    end
end

Movement:AddToggle("SpeedToggle", {Text = "Speed Hack", Default = false, Callback = function(v) Speed.enabled = v; if v then setWalkSpeed(Speed.speed) else setWalkSpeed(Speed.originalSpeed or 16) end end})
Movement:AddSlider("SpeedValue", {Text = "Speed", Default = 50, Min = 16, Max = 250, Rounding = 0, Suffix = "studs/s", Callback = function(v) Speed.speed = v; if Speed.enabled then setWalkSpeed(v) end end})

local Jump = {
    enabled = false,
    power = 50,
    originalPower = nil
}

local function setJumpPower(power)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        if not Jump.originalPower then
            Jump.originalPower = char.Humanoid.JumpPower
        end
        char.Humanoid.JumpPower = power
    end
end

Movement:AddToggle("JumpToggle", {Text = "Jump Hack", Default = false, Callback = function(v) Jump.enabled = v; if v then setJumpPower(Jump.power) else setJumpPower(Jump.originalPower or 50) end end})
Movement:AddSlider("JumpValue", {Text = "Jump Power", Default = 50, Min = 50, Max = 250, Rounding = 0, Suffix = "power", Callback = function(v) Jump.power = v; if Jump.enabled then setJumpPower(v) end end})

local Noclip = {enabled = false}

local function noclip()
    if not Noclip.enabled then return end
    local char = Player.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

Movement:AddToggle("NoclipToggle", {Text = "Noclip", Default = false, Callback = function(v) Noclip.enabled = v; if not v then noclip() end end})

RunService.Stepped:Connect(function()
    if Noclip.enabled then
        noclip()
    end
end)

local Fly = {
    enabled = false,
    speed = 50,
    bodyVelocity = nil
}

local function startFly()
    local char = Player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if Fly.bodyVelocity then Fly.bodyVelocity:Destroy() end
    
    Fly.bodyVelocity = Instance.new("BodyVelocity")
    Fly.bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
    Fly.bodyVelocity.Parent = hrp
    
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
    end
end

local function stopFly()
    if Fly.bodyVelocity then
        Fly.bodyVelocity:Destroy()
        Fly.bodyVelocity = nil
    end
    local char = Player.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

Movement:AddToggle("FlyToggle", {Text = "Fly", Default = false, Callback = function(v) 
    Fly.enabled = v
    if v then 
        startFly()
    else 
        stopFly()
    end
end})

RunService.RenderStepped:Connect(function(dt)
    if Fly.enabled and Fly.bodyVelocity then
        local move = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
        
        if move.Magnitude > 0 then
            Fly.bodyVelocity.Velocity = move.Unit * Fly.speed
        else
            Fly.bodyVelocity.Velocity = Vector3.zero
        end
    end
end)

Movement:AddSlider("FlySpeed", {Text = "Fly Speed", Default = 50, Min = 10, Max = 200, Rounding = 0, Suffix = "studs/s", Callback = function(v) Fly.speed = v end})

local InfStamina = {enabled = false}

Movement:AddToggle("InfStamina", {Text = "Infinite Stamina", Default = false, Callback = function(v) 
    InfStamina.enabled = v
    if v then
        local stamina = Player.Character:FindFirstChild("Stamina")
        if stamina then
            stamina:Destroy()
        end
    end
end})

-- ==============================================
--              WORLD (Улучшенный)
-- ==============================================

local WRLD = Tabs.WORLD:AddLeftGroupbox("WORLD MODS", "earth")

-- Fake Gamma
local fakeGammaEnabled = false
local gammaValue = 0.5

local function applyFakeGamma()
    local effect = Lighting:FindFirstChild("StimEffect")
    if not effect then
        effect = Instance.new("ColorCorrectionEffect")
        effect.Name = "StimEffect"
        effect.Parent = Lighting
    end
    effect.Enabled = fakeGammaEnabled
    effect.Brightness = gammaValue
    effect.Contrast = 1
    effect.Saturation = 1
    effect.TintColor = Color3.fromRGB(255, 255, 255)
end

WRLD:AddToggle("FakeGammaToggle", {Text = "Fake Gamma", Default = false, Callback = function(s) fakeGammaEnabled = s; applyFakeGamma() end})
WRLD:AddSlider("FakeGammaSlider", {Text = "Gamma Value", Default = 0.5, Min = 0.2, Max = 0.99, Rounding = 2, Suffix = "%", Callback = function(val) gammaValue = val; if fakeGammaEnabled then applyFakeGamma() end end})

-- X-Ray
local XR = {enabled = false, transparency = 0.5}
local xrayMaterials = {
    [Enum.Material.Cobblestone] = true,
    [Enum.Material.WoodPlanks] = true,
    [Enum.Material.Metal] = true,
    [Enum.Material.CorrodedMetal] = true,
    [Enum.Material.Concrete] = true,
    [Enum.Material.Brick] = true,
    [Enum.Material.DiamondPlate] = true,
}
local xrayOriginal = {}
local xrayParts = {}
local xraySet = {}

local function isXrayMat(p) return p:IsA("BasePart") and xrayMaterials[p.Material] end
local function addXrayPart(p)
    if xraySet[p] then return end
    xraySet[p] = true
    table.insert(xrayParts, p)
    xrayOriginal[p] = p.Transparency
end

local function collectXrayParts()
    xrayParts = {}; xrayOriginal = {}; xraySet = {}
    for _, v in ipairs(workspace:GetDescendants()) do
        if isXrayMat(v) then addXrayPart(v) end
    end
end

local function applyXray(state)
    for _, p in ipairs(xrayParts) do
        if p and p.Parent then
            p.Transparency = state and XR.transparency or (xrayOriginal[p] or 0)
        end
    end
end

collectXrayParts()

WRLD:AddToggle("XrayToggle", {Text = "XRAY", Default = false, Callback = function(v) XR.enabled = v; applyXray(v) end})
WRLD:AddSlider("XrayTransparency", {Text = "XRAY Transparency", Min = 0, Max = 1, Default = 0.5, Rounding = 2, Suffix = "%", Callback = function(v) XR.transparency = v; if XR.enabled then applyXray(true) end end})

-- Time Control
local TimeControl = {enabled = false, timeValue = 14}

WRLD:AddToggle("TimeControlToggle", {Text = "Time Control", Default = false, Callback = function(v) TimeControl.enabled = v; if v then Lighting.ClockTime = TimeControl.timeValue else Lighting.ClockTime = 14 end end})
WRLD:AddSlider("TimeValue", {Text = "Time of Day", Default = 14, Min = 0, Max = 24, Rounding = 1, Suffix = "h", Callback = function(v) TimeControl.timeValue = v; if TimeControl.enabled then Lighting.ClockTime = v end end})

-- Fog Control
local FogControl = {enabled = false, fogEnd = 1000}

WRLD:AddToggle("FogControlToggle", {Text = "Fog Control", Default = false, Callback = function(v) FogControl.enabled = v; if v then Lighting.FogEnd = FogControl.fogEnd else Lighting.FogEnd = 1000 end end})
WRLD:AddSlider("FogEndValue", {Text = "Fog Distance", Default = 1000, Min = 100, Max = 5000, Rounding = 0, Suffix = "studs", Callback = function(v) FogControl.fogEnd = v; if FogControl.enabled then Lighting.FogEnd = v end end})

-- ==============================================
--              VISUALS (ESP и другое)
-- ==============================================

local Visuals = Tabs.VISUAL:AddLeftGroupbox("VISUAL MODS", "eye")

-- Triggerbot
local Triggerbot = {enabled = false, delay = 0.05}

local function triggerbot()
    if not Triggerbot.enabled then return end
    local mouse = Player:GetMouse()
    local target = mouse.Target
    if target and target.Parent then
        local humanoid = target.Parent:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health > 0 then
            -- Эмуляция клика
            mouse1click()
        end
    end
end

Visuals:AddToggle("TriggerbotToggle", {Text = "Triggerbot", Default = false, Callback = function(v) Triggerbot.enabled = v end})
Visuals:AddSlider("TriggerbotDelay", {Text = "Trigger Delay", Default = 0.05, Min = 0, Max = 0.5, Rounding = 2, Suffix = "s", Callback = function(v) Triggerbot.delay = v end})

RunService.RenderStepped:Connect(function()
    if Triggerbot.enabled then
        triggerbot()
        task.wait(Triggerbot.delay)
    end
end)

-- Fullbright
local Fullbright = {enabled = false, originalBrightness = nil}

Visuals:AddToggle("FullbrightToggle", {Text = "Fullbright", Default = false, Callback = function(v)
    Fullbright.enabled = v
    if v then
        Fullbright.originalBrightness = Lighting.Brightness
        Lighting.Brightness = 2
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    else
        Lighting.Brightness = Fullbright.originalBrightness or 0.5
        Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
    end
end})

-- Crosshair
local Crosshair = {
    enabled = false,
    color = neonPurple,
    size = 20,
    thickness = 2
}

local crosshairLines = {}

local function createCrosshair()
    for _, line in pairs(crosshairLines) do
        pcall(function() line:Remove() end)
    end
    crosshairLines = {}
    
    local center = cam.ViewportSize / 2
    local s = Crosshair.size
    
    local line1 = Drawing.new("Line")
    line1.From = Vector2.new(center.X - s, center.Y)
    line1.To = Vector2.new(center.X - s/3, center.Y)
    line1.Color = Crosshair.color
    line1.Thickness = Crosshair.thickness
    line1.Visible = true
    
    local line2 = Drawing.new("Line")
    line2.From = Vector2.new(center.X + s/3, center.Y)
    line2.To = Vector2.new(center.X + s, center.Y)
    line2.Color = Crosshair.color
    line2.Thickness = Crosshair.thickness
    line2.Visible = true
    
    local line3 = Drawing.new("Line")
    line3.From = Vector2.new(center.X, center.Y - s)
    line3.To = Vector2.new(center.X, center.Y - s/3)
    line3.Color = Crosshair.color
    line3.Thickness = Crosshair.thickness
    line3.Visible = true
    
    local line4 = Drawing.new("Line")
    line4.From = Vector2.new(center.X, center.Y + s/3)
    line4.To = Vector2.new(center.X, center.Y + s)
    line4.Color = Crosshair.color
    line4.Thickness = Crosshair.thickness
    line4.Visible = true
    
    crosshairLines = {line1, line2, line3, line4}
end

Visuals:AddToggle("CrosshairToggle", {Text = "Custom Crosshair", Default = false, Callback = function(v) 
    Crosshair.enabled = v
    if v then 
        createCrosshair()
    else
        for _, line in pairs(crosshairLines) do
            pcall(function() line:Remove() end)
        end
        crosshairLines = {}
    end
end})
Visuals:AddColorPicker("CrosshairColor", {Default = neonPurple, Title = "Crosshair Color", Callback = function(v) Crosshair.color = v; if Crosshair.enabled then createCrosshair() end end})
Visuals:AddSlider("CrosshairSize", {Text = "Crosshair Size", Default = 20, Min = 10, Max = 50, Rounding = 0, Callback = function(v) Crosshair.size = v; if Crosshair.enabled then createCrosshair() end end})
Visuals:AddSlider("CrosshairThickness", {Text = "Thickness", Default = 2, Min = 1, Max = 5, Rounding = 0, Callback = function(v) Crosshair.thickness = v; if Crosshair.enabled then createCrosshair() end end})

-- ==============================================
--              MISC (Разное)
-- ==============================================

local Misc = Tabs.MISC:AddLeftGroupbox("MISC", "cog")

-- Anti-AFK
local AntiAFK = {enabled = false}

Misc:AddToggle("AntiAFKToggle", {Text = "Anti-AFK", Default = false, Callback = function(v) AntiAFK.enabled = v end})

task.spawn(function()
    while true do
        task.wait(60)
        if AntiAFK.enabled then
            local vk = game:GetService("VirtualUser")
            vk:CaptureController()
            vk:ClickButton2(Vector2.new())
        end
    end
end)

-- FPS Boost
local FPSBoost = {enabled = false}

Misc:AddToggle("FPSBoostToggle", {Text = "FPS Boost", Default = false, Callback = function(v)
    FPSBoost.enabled = v
    if v then
        settings().Rendering.QualityLevel = 1
        sethiddenproperty(Player, "SimulationRadius", 100)
    else
        settings().Rendering.QualityLevel = 10
    end
end})

-- Character Changer (Новое!)
local CharacterChanger = {enabled = false, sizeMultiplier = 1.5}

Misc:AddToggle("GiantToggle", {Text = "Giant Mode", Default = false, Callback = function(v)
    CharacterChanger.enabled = v
    local char = Player.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                if v then
                    part.Size = part.Size * CharacterChanger.sizeMultiplier
                else
                    part.Size = part.Size / CharacterChanger.sizeMultiplier
                end
            end
        end
    end
end})
Misc:AddSlider("GiantSize", {Text = "Size Multiplier", Default = 1.5, Min = 1, Max = 5, Rounding = 1, Callback = function(v) CharacterChanger.sizeMultiplier = v end})

-- Notify on Kill (Новое!)
local KillNotify = {enabled = false}

Misc:AddToggle("KillNotify", {Text = "Kill Notifications", Default = false, Callback = function(v) KillNotify.enabled = v end})

Players.PlayerRemoving:Connect(function(player)
    if KillNotify.enabled and player ~= Player then
        Library:Notify({Text = player.Name .. " was eliminated!", Duration = 3})
    end
end)

-- ==============================================
--              UI SETTINGS
-- ==============================================

local UIGroup = Tabs["UI Settings"]:AddLeftGroupbox("UI Settings")

UIGroup:AddToggle("KeybindMenuOpen", {Default = Library.KeybindFrame.Visible, Text = "Show Keybind Menu", Callback = function(v) Library.KeybindFrame.Visible = v end})
UIGroup:AddToggle("ShowCustomCursor", {Text = "Custom Cursor", Default = true, Callback = function(v) Library.ShowCustomCursor = v end})
UIGroup:AddDropdown("NotificationSide", {Values = {"Left", "Right"}, Default = "Right", Text = "Notification Side", Callback = function(v) Library:SetNotifySide(v) end})
UIGroup:AddDropdown("DPIDropdown", {Values = {"50%", "75%", "100%", "125%", "150%", "175%", "200%"}, Default = "100%", Text = "DPI Scale", Callback = function(v) local dpi = tonumber(v:gsub("%%", "")); Library:SetDPIScale(dpi) end})
UIGroup:AddDivider()

local menuKeyLabel = UIGroup:AddLabel("Menu Keybind")
menuKeyLabel:AddKeyPicker("MenuKeybind", {Default = "RightShift", NoUI = false, Text = "Menu Keybind", Callback = function() end})

UIGroup:AddButton("Unload", function() Library:Unload() end)

-- Применение темы
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("PurpleNebula")
ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})
SaveManager:SetFolder("PurpleNebula")
SaveManager:BuildConfigSection(Tabs["UI Settings"])

ThemeManager.Library:SetFont(Enum.Font.Jura)
ThemeManager.Library:UpdateColorsUsingRegistry()

SaveManager:LoadAutoloadConfig()

if Options and Options.MenuKeybind then
    Library.ToggleKeybind = Options.MenuKeybind
end

-- Уведомление о загрузке
Library:Notify({Text = "Purple Nebula Loaded! Created by @Vezqx", Duration = 5})
