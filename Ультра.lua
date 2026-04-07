local p="mr.comcom"
local s=Instance.new("ScreenGui")
s.Parent=game.Players.LocalPlayer:WaitForChild("PlayerGui")
local b=Instance.new("BlurEffect")
b.Parent=game:GetService("Lighting")
b.Size=0
spawn(function()for i=0,1,0.05 do b.Size=i*12 wait(0.02)end end)
local m=Instance.new("Frame")
m.Parent=s
m.Size=UDim2.new(0,300,0,220)
m.Position=UDim2.new(0.5,-150,0.5,-110)
m.BackgroundColor3=Color3.fromRGB(15,12,35)
m.BorderSizePixel=0
local c=Instance.new("UICorner")
c.CornerRadius=UDim.new(0,15)
c.Parent=m
local g=Instance.new("UIGradient")
g.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,0,255)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(0,255,150)),ColorSequenceKeypoint.new(1,Color3.fromRGB(180,0,255))})
g.Rotation=45
g.Parent=m
local t=Instance.new("TextLabel")
t.Parent=m
t.Size=UDim2.new(1,0,0,35)
t.Position=UDim2.new(0,0,0.02,0)
t.BackgroundTransparency=1
t.Text="🔐 АВТОРИЗАЦИЯ"
t.TextColor3=Color3.fromRGB(255,255,255)
t.Font=Enum.Font.GothamBold
t.TextSize=18
local bx=Instance.new("TextBox")
bx.Parent=m
bx.Size=UDim2.new(0.75,0,0,35)
bx.Position=UDim2.new(0.125,0,0.35,0)
bx.BackgroundColor3=Color3.fromRGB(25,20,50)
bx.BorderSizePixel=0
bx.Font=Enum.Font.Gotham
bx.PlaceholderText="Введите пароль"
bx.Text=""
bx.TextColor3=Color3.fromRGB(255,255,255)
bx.TextSize=14
local bxc=Instance.new("UICorner")
bxc.CornerRadius=UDim.new(0,8)
bxc.Parent=bx
local btn=Instance.new("TextButton")
btn.Parent=m
btn.Size=UDim2.new(0.5,0,0,35)
btn.Position=UDim2.new(0.25,0,0.6,0)
btn.BackgroundColor3=Color3.fromRGB(0,200,100)
btn.BorderSizePixel=0
btn.Font=Enum.Font.GothamBold
btn.Text="ВОЙТИ"
btn.TextColor3=Color3.fromRGB(0,0,0)
btn.TextSize=15
local btnc=Instance.new("UICorner")
btnc.CornerRadius=UDim.new(0,8)
btnc.Parent=btn
local st=Instance.new("TextLabel")
st.Parent=m
st.Size=UDim2.new(1,0,0,20)
st.Position=UDim2.new(0,0,0.85,0)
st.BackgroundTransparency=1
st.Text=""
st.TextColor3=Color3.fromRGB(255,100,100)
st.Font=Enum.Font.Gotham
st.TextSize=10
local function main()
s:Destroy()
b:Destroy()
local a={"Trash","Daily","Photon Core","Divine","Beggar","Plodder","Office Clerk","Manager","Director","Oligarch","Frozen Heart","Bubble Gum","Cats","Glitch","Dream","Bloody Night","Heavenfall","M5 F90","G63","Porsche 911","URUS","Gold","Dark","Palm","Burj","Luxury","Marina","Cursed Demon"}
local cs={}
for i,v in ipairs(a) do table.insert(cs,v) end
local sel="Heavenfall"
local amt=10
local sell=false
local farm=false
local sg=Instance.new("ScreenGui")
sg.Name="FarmGUI"
sg.Parent=game.Players.LocalPlayer:WaitForChild("PlayerGui")
local mf=Instance.new("Frame")
mf.Parent=sg
mf.BackgroundColor3=Color3.fromRGB(8,5,20)
mf.BackgroundTransparency=0.05
mf.BorderColor3=Color3.fromRGB(180,0,255)
mf.BorderSizePixel=2
mf.Position=UDim2.new(0.45,0,0.4,0)
mf.Size=UDim2.new(0,300,0,380)
mf.Active=true
mf.Draggable=true
local mfc=Instance.new("UICorner")
mfc.CornerRadius=UDim.new(0,12)
mfc.Parent=mf
local mfg=Instance.new("UIGradient")
mfg.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,0,255)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(0,255,150)),ColorSequenceKeypoint.new(1,Color3.fromRGB(180,0,255))})
mfg.Rotation=60
mfg.Parent=mf
local cl=Instance.new("TextButton")
cl.Parent=mf
cl.BackgroundColor3=Color3.fromRGB(255,50,50)
cl.BackgroundTransparency=0.2
cl.BorderSizePixel=0
cl.Position=UDim2.new(0.88,0,0.02,0)
cl.Size=UDim2.new(0,22,0,22)
cl.Font=Enum.Font.GothamBold
cl.Text="✕"
cl.TextColor3=Color3.fromRGB(255,255,255)
cl.TextSize=14
local clc=Instance.new("UICorner")
clc.CornerRadius=UDim.new(0,6)
clc.Parent=cl
cl.MouseButton1Click:Connect(function() mf.Visible=false end)
local ti=Instance.new("TextLabel")
ti.Parent=mf
ti.BackgroundTransparency=1
ti.Position=UDim2.new(0.05,0,0.02,0)
ti.Size=UDim2.new(0,180,0,25)
ti.Font=Enum.Font.GothamBold
ti.Text="⚡ TON BATTLE ⚡"
ti.TextColor3=Color3.fromRGB(180,0,255)
ti.TextSize=14
local selL=Instance.new("TextLabel")
selL.Parent=mf
selL.BackgroundColor3=Color3.fromRGB(25,20,45)
selL.BorderColor3=Color3.fromRGB(0,255,150)
selL.BorderSizePixel=1
selL.Position=UDim2.new(0.05,0,0.1,0)
selL.Size=UDim2.new(0.9,0,0,25)
selL.Font=Enum.Font.GothamBold
selL.Text="🎯 "..sel
selL.TextColor3=Color3.fromRGB(0,255,150)
selL.TextSize=11
local selc=Instance.new("UICorner")
selc.CornerRadius=UDim.new(0,6)
selc.Parent=selL
local sc=Instance.new("ScrollingFrame")
sc.Parent=mf
sc.BackgroundColor3=Color3.fromRGB(15,10,30)
sc.BorderColor3=Color3.fromRGB(180,0,255)
sc.BorderSizePixel=1
sc.Position=UDim2.new(0.05,0,0.19,0)
sc.Size=UDim2.new(0.9,0,0,120)
sc.CanvasSize=UDim2.new(0,0,0,0)
sc.ScrollBarThickness=4
local scc=Instance.new("UICorner")
scc.CornerRadius=UDim.new(0,8)
scc.Parent=sc
local scl=Instance.new("UIListLayout")
scl.Parent=sc
scl.Padding=UDim.new(0,3)
local ab=Instance.new("TextBox")
ab.Parent=mf
ab.BackgroundColor3=Color3.fromRGB(25,20,45)
ab.BorderColor3=Color3.fromRGB(0,255,150)
ab.BorderSizePixel=1
ab.Position=UDim2.new(0.05,0,0.48,0)
ab.Size=UDim2.new(0.6,0,0,25)
ab.Font=Enum.Font.Gotham
ab.PlaceholderText="+ свой кейс"
ab.Text=""
ab.TextColor3=Color3.fromRGB(255,255,255)
ab.TextSize=10
local abc=Instance.new("UICorner")
abc.CornerRadius=UDim.new(0,6)
abc.Parent=ab
local ad=Instance.new("TextButton")
ad.Parent=mf
ad.BackgroundColor3=Color3.fromRGB(0,150,100)
ad.BorderColor3=Color3.fromRGB(0,255,150)
ad.BorderSizePixel=1
ad.Position=UDim2.new(0.68,0,0.48,0)
ad.Size=UDim2.new(0.27,0,0,25)
ad.Font=Enum.Font.GothamBold
ad.Text="+"
ad.TextColor3=Color3.fromRGB(255,255,255)
ad.TextSize=14
local adc=Instance.new("UICorner")
adc.CornerRadius=UDim.new(0,6)
adc.Parent=ad
local sellB=Instance.new("TextButton")
sellB.Parent=mf
sellB.BackgroundColor3=Color3.fromRGB(40,35,60)
sellB.BorderColor3=Color3.fromRGB(255,100,100)
sellB.BorderSizePixel=1
sellB.Position=UDim2.new(0.05,0,0.6,0)
sellB.Size=UDim2.new(0.43,0,0,30)
sellB.Font=Enum.Font.GothamBold
sellB.Text="🔴 ПРОД:ВЫКЛ"
sellB.TextColor3=Color3.fromRGB(255,100,100)
sellB.TextSize=10
local sellBc=Instance.new("UICorner")
sellBc.CornerRadius=UDim.new(0,6)
sellBc.Parent=sellB
local startB=Instance.new("TextButton")
startB.Parent=mf
startB.BackgroundColor3=Color3.fromRGB(0,200,100)
startB.BorderColor3=Color3.fromRGB(0,255,150)
startB.BorderSizePixel=2
startB.Position=UDim2.new(0.52,0,0.6,0)
startB.Size=UDim2.new(0.43,0,0,30)
startB.Font=Enum.Font.GothamBold
startB.Text="▶"
startB.TextColor3=Color3.fromRGB(0,0,0)
startB.TextSize=16
local startBc=Instance.new("UICorner")
startBc.CornerRadius=UDim.new(0,6)
startBc.Parent=startB
local statL=Instance.new("TextLabel")
statL.Parent=mf
statL.BackgroundTransparency=1
statL.Position=UDim2.new(0.05,0,0.72,0)
statL.Size=UDim2.new(0.9,0,0,18)
statL.Font=Enum.Font.Gotham
statL.Text="⚡ СТОП"
statL.TextColor3=Color3.fromRGB(150,150,200)
statL.TextSize=9
local setB=Instance.new("TextButton")
setB.Parent=mf
setB.BackgroundColor3=Color3.fromRGB(40,35,60)
setB.BorderColor3=Color3.fromRGB(180,0,255)
setB.BorderSizePixel=1
setB.Position=UDim2.new(0.05,0,0.82,0)
setB.Size=UDim2.new(0.9,0,0,25)
setB.Font=Enum.Font.GothamBold
setB.Text="⚙ НАСТРОЙКИ"
setB.TextColor3=Color3.fromRGB(0,255,150)
setB.TextSize=10
local setBc=Instance.new("UICorner")
setBc.CornerRadius=UDim.new(0,6)
setBc.Parent=setB
local sf=Instance.new("Frame")
sf.Parent=sg
sf.BackgroundColor3=Color3.fromRGB(10,8,25)
sf.BackgroundTransparency=0.05
sf.BorderColor3=Color3.fromRGB(0,255,150)
sf.BorderSizePixel=2
sf.Position=UDim2.new(0.45,0,0.4,0)
sf.Size=UDim2.new(0,280,0,200)
sf.Active=true
sf.Draggable=true
sf.Visible=false
local sfc=Instance.new("UICorner")
sfc.CornerRadius=UDim.new(0,12)
sfc.Parent=sf
local sfg=Instance.new("UIGradient")
sfg.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,0,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,255,150))})
sfg.Rotation=45
sfg.Parent=sf
local sft=Instance.new("TextLabel")
sft.Parent=sf
sft.BackgroundTransparency=1
sft.Position=UDim2.new(0,0,0,0)
sft.Size=UDim2.new(1,0,0,30)
sft.Font=Enum.Font.GothamBold
sft.Text="⚙ НАСТРОЙКИ"
sft.TextColor3=Color3.fromRGB(0,255,150)
sft.TextSize=14
local clsf=Instance.new("TextButton")
clsf.Parent=sf
clsf.BackgroundColor3=Color3.fromRGB(255,50,50)
clsf.BackgroundTransparency=0.2
clsf.BorderSizePixel=0
clsf.Position=UDim2.new(0.86,0,0.02,0)
clsf.Size=UDim2.new(0,22,0,22)
clsf.Font=Enum.Font.GothamBold
clsf.Text="✕"
clsf.TextColor3=Color3.fromRGB(255,255,255)
clsf.TextSize=12
local clsfc=Instance.new("UICorner")
clsfc.CornerRadius=UDim.new(0,6)
clsfc.Parent=clsf
clsf.MouseButton1Click:Connect(function() sf.Visible=false end)
local amtL=Instance.new("TextLabel")
amtL.Parent=sf
amtL.BackgroundTransparency=1
amtL.Position=UDim2.new(0.05,0,0.12,0)
amtL.Size=UDim2.new(0.6,0,0,20)
amtL.Font=Enum.Font.Gotham
amtL.Text="📦 Кейсов за раз (1-10):"
amtL.TextColor3=Color3.fromRGB(255,255,255)
amtL.TextSize=10
local amtB=Instance.new("TextBox")
amtB.Parent=sf
amtB.BackgroundColor3=Color3.fromRGB(25,20,45)
amtB.BorderColor3=Color3.fromRGB(0,255,150)
amtB.BorderSizePixel=1
amtB.Position=UDim2.new(0.65,0,0.12,0)
amtB.Size=UDim2.new(0.3,0,0,25)
amtB.Font=Enum.Font.GothamBold
amtB.Text="10"
amtB.TextColor3=Color3.fromRGB(255,255,255)
amtB.TextSize=12
local amtBc=Instance.new("UICorner")
amtBc.CornerRadius=UDim.new(0,6)
amtBc.Parent=amtB
local delL=Instance.new("TextLabel")
delL.Parent=sf
delL.BackgroundTransparency=1
delL.Position=UDim2.new(0.05,0,0.35,0)
delL.Size=UDim2.new(0.6,0,0,20)
delL.Font=Enum.Font.Gotham
delL.Text="⚡ Задержка (сек):"
delL.TextColor3=Color3.fromRGB(255,255,255)
delL.TextSize=10
local delB=Instance.new("TextBox")
delB.Parent=sf
delB.BackgroundColor3=Color3.fromRGB(25,20,45)
delB.BorderColor3=Color3.fromRGB(0,255,150)
delB.BorderSizePixel=1
delB.Position=UDim2.new(0.65,0,0.35,0)
delB.Size=UDim2.new(0.3,0,0,25)
delB.Font=Enum.Font.GothamBold
delB.Text="0.3"
delB.TextColor3=Color3.fromRGB(255,255,255)
delB.TextSize=12
local delBc=Instance.new("UICorner")
delBc.CornerRadius=UDim.new(0,6)
delBc.Parent=delB
local creL=Instance.new("TextLabel")
creL.Parent=sf
creL.BackgroundTransparency=1
creL.Position=UDim2.new(0.05,0,0.65,0)
creL.Size=UDim2.new(0.9,0,0,30)
creL.Font=Enum.Font.Gotham
creL.Text="👑 @NoMentalProblem & @Vezqx"
creL.TextColor3=Color3.fromRGB(180,0,255)
creL.TextSize=9
local function ref()
for _,ch in pairs(sc:GetChildren())do if ch:IsA("TextButton")then ch:Destroy()end end
for i,cn in ipairs(cs)do
local b=Instance.new("TextButton")
b.Parent=sc
b.BackgroundColor3=Color3.fromRGB(30,25,55)
b.BorderColor3=Color3.fromRGB(0,255,150)
b.BorderSizePixel=1
b.Size=UDim2.new(1,0,0,24)
b.Font=Enum.Font.Gotham
b.Text=cn
b.TextColor3=Color3.fromRGB(255,255,255)
b.TextSize=10
local bc=Instance.new("UICorner")
bc.CornerRadius=UDim.new(0,5)
bc.Parent=b
if cn==sel then
b.BackgroundColor3=Color3.fromRGB(180,0,255)
b.TextColor3=Color3.fromRGB(255,255,255)
end
b.MouseButton1Click:Connect(function()
sel=cn
selL.Text="🎯 "..sel
ref()
end)
end
local cc=#sc:GetChildren()-2
sc.CanvasSize=UDim2.new(0,0,0,cc*28+10)
end
ad.MouseButton1Click:Connect(function()
local nc=ab.Text
if nc~=""then
local ex=false
for _,v in ipairs(cs)do if v==nc then ex=true break end end
if not ex then
table.insert(cs,nc)
ref()
ab.Text=""
ad.Text="✅"
wait(0.8)
ad.Text="+"
else
ad.Text="❌"
wait(0.8)
ad.Text="+"
end
end
end)
local function us()
if sell then
sellB.BackgroundColor3=Color3.fromRGB(0,150,50)
sellB.Text="🟢 ПРОД:ВКЛ"
sellB.TextColor3=Color3.fromRGB(0,255,100)
else
sellB.BackgroundColor3=Color3.fromRGB(40,35,60)
sellB.Text="🔴 ПРОД:ВЫКЛ"
sellB.TextColor3=Color3.fromRGB(255,100,100)
end
end
sellB.MouseButton1Click:Connect(function()
sell=not sell
us()
end)
amtB.FocusLost:Connect(function()
local n=tonumber(amtB.Text)
if n and n>=1 and n<=10 then amt=math.floor(n) amtB.Text=tostring(amt) else amt=10 amtB.Text="10" end
end)
local delay=0.3
delB.FocusLost:Connect(function()
local n=tonumber(delB.Text)
if n and n>=0.1 then delay=n delB.Text=tostring(delay) else delay=0.3 delB.Text="0.3" end
end)
setB.MouseButton1Click:Connect(function()
sf.Visible=true
sf.Position=mf.Position
amtB.Text=tostring(amt)
delB.Text=tostring(delay)
end)
local function loop()
while farm do
pcall(function()
local ev=game:GetService("ReplicatedStorage"):FindFirstChild("Events")
if ev then
local oc=ev:FindFirstChild("OpenCase")
if oc then oc:InvokeServer(sel,amt) end
if sell then
local inv=ev:FindFirstChild("Inventory")
if inv then inv:FireServer("Sell","ALL") end
end
end
end)
wait(delay)
end
farm=false
startB.BackgroundColor3=Color3.fromRGB(0,200,100)
startB.Text="▶"
statL.Text="⚡ СТОП"
statL.TextColor3=Color3.fromRGB(150,150,200)
end
startB.MouseButton1Click:Connect(function()
if not farm then
farm=true
startB.BackgroundColor3=Color3.fromRGB(0,100,200)
startB.Text="⏹"
statL.Text="⚡ ФАРМ"
statL.TextColor3=Color3.fromRGB(0,255,150)
spawn(loop)
else
farm=false
end
end)
spawn(function()
local tt=0
while true do
tt=tt+0.03
local i2=(math.sin(tt)+1)/4+0.5
mf.BorderColor3=Color3.new(i2*0.7,i2*0.5,i2)
sf.BorderColor3=Color3.new(i2*0.7,i2*0.5,i2)
wait(0.05)
end
end)
ref()
us()
print("✅ ЗАГРУЖЕНО | Кейс: "..sel.." | Кол-во: "..amt)
end
btn.MouseButton1Click:Connect(function()
if bx.Text==p then
main()
else
st.Text="❌ НЕВЕРНЫЙ ПАРОЛЬ!"
bx.Text=""
end
end)
end
