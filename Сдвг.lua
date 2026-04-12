-- ========== NEO CASE FARM BY ROBIN ==========
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- ВСЕ КЕЙСЫ
local Cases = {
    "Trash", "Daily", "Photon Core", "Divine", "Beggar", "Plodder",
    "Office Clerk", "Manager", "Director", "Oligarch", "Frozen Heart",
    "Bubble Gum", "Cats", "Glitch", "Dream", "Bloody Night", "Heavenfall",
    "M5 F90", "G63", "Porsche 911", "URUS", "Gold", "Dark", "Palm",
    "Burj", "Luxury", "Marina", "Cursed Demon"
}

-- НАСТРОЙКИ ПО УМОЛЧАНИЮ
local SelectedCases = {}
local AutoSellEnabled = false
local AutoBuyEnabled = false
local Farming = false
local FarmDelay = 0.01
local OpenAmount = 10
local LuckEnabled = false
local LuckMultiplier = 2
local LuckTimeLeft = 0
local AutoBuySpeed = 1.0
local CasesMenuOpen = false
local
