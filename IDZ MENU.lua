if not game:IsLoaded() then
	game.Loaded:Wait()
end
local player = game.Players.LocalPlayer
repeat task.wait() until player:FindFirstChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Teams = game:GetService("Teams")

local flyEnabled = false
local speedEnabled = false
local jumpEnabled = false
local noclipEnabled = false
local espEnabled = false
local freecamEnabled = false
local nightVisionEnabled = false
local clickTPEnabled = false
local fpsBoostEnabled = false
local aimbotEnabled = false
local aimbotTargetType = "player"
local aimbotRangeMode = "close"
local aimbotCloseRange = 60
local aimbotFarRange = 220
local flySpeed = 8
local walkSpeed = 16
local jumpPower = 50
local freecamSpeed = 2
local up = false
local down = false
local moveForward = false
local moveBack = false
local moveLeft = false
local moveRight = false

local currentLang = "th"
local L = {
	th = {
		player = "ผู้เล่น",
		tools = "เครื่องมือ",
		settings = "ตั้งค่า",
		fly = "บิน",
		speed = "ความเร็ว",
		jump = "กระโดด",
		noclip = "ทะลุของ",
		night = "มองกลางคืน",
		esp = "ESP",
		freecam = "กล้องอิสระ",
		clicktp = "คลิกวาป",
		fps = "FPS Boost",
		tpSystem = "ระบบวาปผู้เล่น",
		lang = "ภาษา",
		aimbot = "Aimbot",
		targetPlayer = "คน",
		targetNpc = "บอท",
		rangeClose = "ใกล้",
		rangeFar = "ไกล",
		enableAimbot = "เปิด Aimbot",
		aimbotPanel = "IDZ MENU AIMBOT",
		on = "on",
		off = "off"
	},
	en = {
		player = "Player",
		tools = "Tools",
		settings = "Settings",
		fly = "Fly",
		speed = "Speed",
		jump = "Jump",
		noclip = "Noclip",
		night = "Night Vision",
		esp = "ESP",
		freecam = "Freecam",
		clicktp = "Click TP",
		fps = "FPS Boost",
		tpSystem = "Player Teleport",
		lang = "Language",
		aimbot = "Aimbot",
		targetPlayer = "Players",
		targetNpc = "NPCs",
		rangeClose = "Close",
		rangeFar = "Far",
		enableAimbot = "Enable Aimbot",
		aimbotPanel = "IDZ MENU AIMBOT",
		on = "on",
		off = "off"
	}
}
local function T(key)
	return (L[currentLang] and L[currentLang][key]) or key
end

local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end
local function getHumanoid()
	return getChar():WaitForChild("Humanoid")
end
local humanoid = getHumanoid()

pcall(function()
	if player.PlayerGui:FindFirstChild("GUI") then
		player.PlayerGui.GUI:Destroy()
	end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "GUI"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ================= FIXED SIZE =================
local uiW, uiH = 520, 420

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, uiW, 0, uiH)
frame.Position = UDim2.new(0.5, -uiW/2, 0.5, -uiH/2)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
frame.BackgroundTransparency = 0.05
frame.Active = true
frame.Visible = true
frame.ClipsDescendants = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Color = Color3.fromRGB(60, 50, 100)
frameStroke.Thickness = 1.2
frameStroke.Transparency = 0.4

local shadow = Instance.new("ImageLabel", frame)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6014261993"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(49, 49, 450, 450)
shadow.Size = UDim2.new(1, 36, 1, 36)
shadow.Position = UDim2.new(0, -18, 0, -16)
shadow.ZIndex = 0

-- ================= TITLE BAR =================
local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1, 0, 0, 42)
titleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 34)
titleBar.BackgroundTransparency = 0.15
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(0, 160, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Text = "IDZ MENU"
title.TextColor3 = Color3.fromRGB(170, 130, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 28, 0, 26)
minBtn.Position = UDim2.new(1, -68, 0.5, -13)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
minBtn.BackgroundTransparency = 0.4
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18
minBtn.AutoButtonColor = false
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 28, 0, 26)
closeBtn.Position = UDim2.new(1, -34, 0.5, -13)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
closeBtn.BackgroundTransparency = 0.4
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.AutoButtonColor = false
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

minBtn.MouseEnter:Connect(function()
	TweenService:Create(minBtn, TweenInfo.new(0.12), {BackgroundTransparency = 0.1, BackgroundColor3 = Color3.fromRGB(70, 70, 95)}):Play()
end)
minBtn.MouseLeave:Connect(function()
	TweenService:Create(minBtn, TweenInfo.new(0.12), {BackgroundTransparency = 0.4, BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
end)
closeBtn.MouseEnter:Connect(function()
	TweenService:Create(closeBtn, TweenInfo.new(0.12), {BackgroundTransparency = 0.1, BackgroundColor3 = Color3.fromRGB(180, 50, 70)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
	TweenService:Create(closeBtn, TweenInfo.new(0.12), {BackgroundTransparency = 0.4, BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
end)

-- ================= SIDEBAR =================
local sideW = 130
local sidebar = Instance.new("Frame", frame)
sidebar.Size = UDim2.new(0, sideW, 1, -42)
sidebar.Position = UDim2.new(0, 0, 0, 42)
sidebar.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
sidebar.BackgroundTransparency = 0.1
sidebar.BorderSizePixel = 0

local function createSidebarBtn(text, icon, y)
	local btn = Instance.new("TextButton", sidebar)
	btn.Size = UDim2.new(1, -12, 0, 38)
	btn.Position = UDim2.new(0, 6, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(50, 40, 90)
	btn.BackgroundTransparency = 1
	btn.Text = ""
	btn.AutoButtonColor = false
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	local iconLbl = Instance.new("TextLabel", btn)
	iconLbl.Size = UDim2.new(0, 26, 1, 0)
	iconLbl.Position = UDim2.new(0, 6, 0, 0)
	iconLbl.BackgroundTransparency = 1
	iconLbl.Text = icon
	iconLbl.TextColor3 = Color3.fromRGB(140, 140, 170)
	iconLbl.Font = Enum.Font.GothamBold
	iconLbl.TextSize = 14
	iconLbl.TextXAlignment = Enum.TextXAlignment.Center
	local txt = Instance.new("TextLabel", btn)
	txt.Size = UDim2.new(1, -36, 1, 0)
	txt.Position = UDim2.new(0, 32, 0, 0)
	txt.BackgroundTransparency = 1
	txt.Text = text
	txt.TextColor3 = Color3.fromRGB(160, 160, 190)
	txt.Font = Enum.Font.GothamBold
	txt.TextSize = 12
	txt.TextXAlignment = Enum.TextXAlignment.Left
	txt.TextTruncate = Enum.TextTruncate.AtEnd
	return btn, iconLbl, txt
end

local tab1Btn, tab1Icon, tab1Text = createSidebarBtn(T("player"), "👤", 10)
local tab2Btn, tab2Icon, tab2Text = createSidebarBtn(T("tools"), "🛠", 54)
local tab3Btn, tab3Icon, tab3Text = createSidebarBtn(T("settings"), "⚙", 98)

local function setActiveTab(active)
	local function style(btn, icon, txt, isActive)
		if isActive then
			btn.BackgroundTransparency = 0.15
			btn.BackgroundColor3 = Color3.fromRGB(90, 60, 180)
			icon.TextColor3 = Color3.fromRGB(200, 170, 255)
			txt.TextColor3 = Color3.fromRGB(220, 200, 255)
		else
			btn.BackgroundTransparency = 1
			icon.TextColor3 = Color3.fromRGB(140, 140, 170)
			txt.TextColor3 = Color3.fromRGB(160, 160, 190)
		end
	end
	style(tab1Btn, tab1Icon, tab1Text, active == 1)
	style(tab2Btn, tab2Icon, tab2Text, active == 2)
	style(tab3Btn, tab3Icon, tab3Text, active == 3)
end
setActiveTab(1)

-- ================= CONTENT =================
local content = Instance.new("Frame", frame)
content.Size = UDim2.new(1, -(sideW + 8), 1, -42)
content.Position = UDim2.new(0, sideW + 6, 0, 42)
content.BackgroundTransparency = 1
content.ClipsDescendants = true

local page1 = Instance.new("ScrollingFrame", content)
page1.Size = UDim2.new(1, 0, 1, -6)
page1.BackgroundTransparency = 1
page1.Visible = true
page1.ScrollBarThickness = 3
page1.ScrollBarImageColor3 = Color3.fromRGB(140, 100, 255)
page1.ScrollBarImageTransparency = 0.4
page1.CanvasSize = UDim2.new(0, 0, 0, 360)
page1.BorderSizePixel = 0
Instance.new("UIPadding", page1).PaddingTop = UDim.new(0, 8)

local page2 = Instance.new("ScrollingFrame", content)
page2.Size = UDim2.new(1, 0, 1, -6)
page2.BackgroundTransparency = 1
page2.Visible = false
page2.ScrollBarThickness = 3
page2.ScrollBarImageColor3 = Color3.fromRGB(140, 100, 255)
page2.ScrollBarImageTransparency = 0.4
page2.CanvasSize = UDim2.new(0, 0, 0, 480)
page2.BorderSizePixel = 0
Instance.new("UIPadding", page2).PaddingTop = UDim.new(0, 8)

local page3 = Instance.new("Frame", content)
page3.Size = UDim2.new(1, 0, 1, -6)
page3.BackgroundTransparency = 1
page3.Visible = false

local function switchTab(n)
	page1.Visible = n == 1
	page2.Visible = n == 2
	page3.Visible = n == 3
	setActiveTab(n)
end
tab1Btn.MouseButton1Click:Connect(function() switchTab(1) end)
tab2Btn.MouseButton1Click:Connect(function() switchTab(2) end)
tab3Btn.MouseButton1Click:Connect(function() switchTab(3) end)

-- ================= MINIMIZE =================
local isMinimized = false
local frameOpenSize = frame.Size

local minBar = Instance.new("TextButton", gui)
minBar.Size = UDim2.new(0, 150, 0, 30)
minBar.Position = UDim2.new(0.5, -75, 0, 12)
minBar.BackgroundColor3 = Color3.fromRGB(22, 20, 36)
minBar.BackgroundTransparency = 0.1
minBar.Text = ""
minBar.AutoButtonColor = false
minBar.Visible = false
minBar.ZIndex = 80
Instance.new("UICorner", minBar).CornerRadius = UDim.new(0, 9)
local minBarStroke = Instance.new("UIStroke", minBar)
minBarStroke.Color = Color3.fromRGB(140, 100, 255)
minBarStroke.Thickness = 1.1
minBarStroke.Transparency = 0.35
local minBarLabel = Instance.new("TextLabel", minBar)
minBarLabel.Size = UDim2.new(1, 0, 1, 0)
minBarLabel.BackgroundTransparency = 1
minBarLabel.Text = "▼  IDZ MENU"
minBarLabel.TextColor3 = Color3.fromRGB(180, 150, 255)
minBarLabel.Font = Enum.Font.GothamBold
minBarLabel.TextSize = 12

local function setMinimized(state)
	isMinimized = state
	if state then
		local t = TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
			Size = UDim2.new(0, uiW, 0, 0),
			BackgroundTransparency = 1
		})
		t:Play()
		t.Completed:Connect(function()
			if isMinimized then frame.Visible = false end
		end)
		minBar.Visible = true
	else
		minBar.Visible = false
		frame.Visible = true
		frame.Size = UDim2.new(0, uiW, 0, 0)
		frame.BackgroundTransparency = 1
		TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
			Size = frameOpenSize,
			BackgroundTransparency = 0.05
		}):Play()
	end
end

minBtn.MouseButton1Click:Connect(function() setMinimized(true) end)
closeBtn.MouseButton1Click:Connect(function() setMinimized(true) end)
minBar.MouseButton1Click:Connect(function() setMinimized(false) end)

do
	local drag, start, pos = false
	minBar.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			drag = true
			start = i.Position
			pos = minBar.Position
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if drag then
			local d = i.Position - start
			minBar.Position = UDim2.new(pos.X.Scale, pos.X.Offset + d.X, pos.Y.Scale, pos.Y.Offset + d.Y)
		end
	end)
	UIS.InputEnded:Connect(function() drag = false end)
end

local function dragify(target, handle)
	local drag, start, pos = false
	handle.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			drag = true
			start = i.Position
			pos = target.Position
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if drag then
			local d = i.Position - start
			target.Position = UDim2.new(pos.X.Scale, pos.X.Offset + d.X, pos.Y.Scale, pos.Y.Offset + d.Y)
		end
	end)
	UIS.InputEnded:Connect(function() drag = false end)
end
dragify(frame, titleBar)

frame.BackgroundTransparency = 1
frame.Size = UDim2.new(0, uiW, 0, 0)
task.defer(function()
	TweenService:Create(frame, TweenInfo.new(0.32, Enum.EasingStyle.Quint), {
		Size = UDim2.new(0, uiW, 0, uiH),
		BackgroundTransparency = 0.05
	}):Play()
end)

-- ================= MOBILE =================
local function styleMobile(btn)
	btn.BackgroundColor3 = Color3.fromRGB(28, 26, 42)
	btn.BackgroundTransparency = 0.15
	btn.TextColor3 = Color3.fromRGB(180, 150, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 18
	btn.AutoButtonColor = false
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	local s = Instance.new("UIStroke", btn)
	s.Color = Color3.fromRGB(120, 90, 220)
	s.Thickness = 1
	s.Transparency = 0.45
end
local btnSize = 48
local upBtn = Instance.new("TextButton", gui)
upBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
upBtn.Position = UDim2.new(1, -62, 0.68, 0)
upBtn.Text = "↑"
upBtn.Visible = false
styleMobile(upBtn)
local downBtn = Instance.new("TextButton", gui)
downBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
downBtn.Position = UDim2.new(1, -62, 0.78, 0)
downBtn.Text = "↓"
downBtn.Visible = false
styleMobile(downBtn)
local moveForwardBtn = Instance.new("TextButton", gui)
moveForwardBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
moveForwardBtn.Position = UDim2.new(0, 62, 0.68, 0)
moveForwardBtn.Text = "▲"
moveForwardBtn.Visible = false
styleMobile(moveForwardBtn)
local moveBackBtn = Instance.new("TextButton", gui)
moveBackBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
moveBackBtn.Position = UDim2.new(0, 62, 0.78, 0)
moveBackBtn.Text = "▼"
moveBackBtn.Visible = false
styleMobile(moveBackBtn)
local moveLeftBtn = Instance.new("TextButton", gui)
moveLeftBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
moveLeftBtn.Position = UDim2.new(0, 10, 0.73, 0)
moveLeftBtn.Text = "◄"
moveLeftBtn.Visible = false
styleMobile(moveLeftBtn)
local moveRightBtn = Instance.new("TextButton", gui)
moveRightBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
moveRightBtn.Position = UDim2.new(0, 114, 0.73, 0)
moveRightBtn.Text = "►"
moveRightBtn.Visible = false
styleMobile(moveRightBtn)

local function bind(btn, flag)
	btn.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
			if flag == "up" then up = true elseif flag == "down" then down = true
			elseif flag == "fwd" then moveForward = true elseif flag == "back" then moveBack = true
			elseif flag == "left" then moveLeft = true elseif flag == "right" then moveRight = true end
		end
	end)
	btn.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
			if flag == "up" then up = false elseif flag == "down" then down = false
			elseif flag == "fwd" then moveForward = false elseif flag == "back" then moveBack = false
			elseif flag == "left" then moveLeft = false elseif flag == "right" then moveRight = false end
		end
	end)
end
bind(upBtn, "up")
bind(downBtn, "down")
bind(moveForwardBtn, "fwd")
bind(moveBackBtn, "back")
bind(moveLeftBtn, "left")
bind(moveRightBtn, "right")

-- ================= FEATURES (เดิม) =================
local freecamPart, freecamConn
local function setMoveButtonsVisible(v)
	moveForwardBtn.Visible = v
	moveBackBtn.Visible = v
	moveLeftBtn.Visible = v
	moveRightBtn.Visible = v
end
local function startFreecam()
	local char = getChar()
	local root = char:WaitForChild("HumanoidRootPart")
	local cam = workspace.CurrentCamera
	root.Anchored = true
	freecamPart = Instance.new("Part")
	freecamPart.Size = Vector3.new(1,1,1)
	freecamPart.Transparency = 1
	freecamPart.CanCollide = false
	freecamPart.Anchored = true
	freecamPart.CFrame = cam.CFrame
	freecamPart.Parent = workspace
	cam.CameraSubject = freecamPart
	upBtn.Visible = true
	downBtn.Visible = true
	setMoveButtonsVisible(true)
	freecamConn = RunService.RenderStepped:Connect(function()
		local dir = Vector3.zero
		local cf = cam.CFrame
		if UIS:IsKeyDown(Enum.KeyCode.W) or moveForward then dir += cf.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) or moveBack then dir -= cf.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) or moveLeft then dir -= cf.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) or moveRight then dir += cf.RightVector end
		if up then dir += Vector3.new(0,1,0) end
		if down then dir -= Vector3.new(0,1,0) end
		if dir.Magnitude > 0 then
			freecamPart.CFrame = freecamPart.CFrame + (dir.Unit * freecamSpeed)
		end
	end)
end
local function stopFreecam()
	if freecamConn then freecamConn:Disconnect() freecamConn = nil end
	if freecamPart then freecamPart:Destroy() freecamPart = nil end
	local char = getChar()
	char:WaitForChild("HumanoidRootPart").Anchored = false
	workspace.CurrentCamera.CameraSubject = char:WaitForChild("Humanoid")
	upBtn.Visible = false
	downBtn.Visible = false
	setMoveButtonsVisible(false)
end

local flyConn, flyBV, flyBG
local function startFly()
	local char = getChar()
	local root = char:WaitForChild("HumanoidRootPart")
	local hum = char:WaitForChild("Humanoid")
	hum.PlatformStand = true
	flyBG = Instance.new("BodyGyro", root)
	flyBG.MaxTorque = Vector3.new(1e5,1e5,1e5)
	flyBG.D = 50
	flyBV = Instance.new("BodyVelocity", root)
	flyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
	flyBV.Velocity = Vector3.zero
	upBtn.Visible = true
	downBtn.Visible = true
	flyConn = RunService.Heartbeat:Connect(function()
		local cam = workspace.CurrentCamera
		local dir = Vector3.zero
		local hum2 = char:FindFirstChildOfClass("Humanoid")
		if hum2 and hum2.MoveDirection.Magnitude > 0.1 then
			dir += Vector3.new(hum2.MoveDirection.X, 0, hum2.MoveDirection.Z)
		end
		if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
		if up then dir += Vector3.new(0,1,0) end
		if down then dir -= Vector3.new(0,1,0) end
		if dir.Magnitude > 1 then dir = dir.Unit end
		flyBV.Velocity = dir * flySpeed
		flyBG.CFrame = cam.CFrame
	end)
end
local function stopFly()
	if flyConn then flyConn:Disconnect() flyConn = nil end
	if flyBV then flyBV:Destroy() flyBV = nil end
	if flyBG then flyBG:Destroy() flyBG = nil end
	upBtn.Visible = false
	downBtn.Visible = false
	pcall(function() getChar():WaitForChild("Humanoid").PlatformStand = false end)
end

local noclipConn
local function startNoclip()
	noclipConn = RunService.Stepped:Connect(function()
		local char = player.Character
		if not char then return end
		for _, p in ipairs(char:GetDescendants()) do
			if p:IsA("BasePart") then p.CanCollide = false end
		end
	end)
end
local function stopNoclip()
	if noclipConn then noclipConn:Disconnect() noclipConn = nil end
	local char = player.Character
	if char then
		for _, p in ipairs(char:GetDescendants()) do
			if p:IsA("BasePart") then p.CanCollide = true end
		end
	end
end

local espObjects, espConnections = {}, {}
local function clearESPFor(t)
	if espObjects[t] then
		for _, o in ipairs(espObjects[t]) do pcall(function() o:Destroy() end) end
		espObjects[t] = nil
	end
	if espConnections[t] then
		for _, c in ipairs(espConnections[t]) do pcall(function() c:Disconnect() end) end
		espConnections[t] = nil
	end
end
local function addESP(target)
	if target == player then return end
	clearESPFor(target)
	local function createVisuals(char)
		if not char or not espEnabled then return end
		local root = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart", 3)
		if not root then return end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local hl = Instance.new("Highlight")
		hl.Adornee = char
		hl.FillColor = Color3.fromRGB(160, 120, 255)
		hl.OutlineColor = Color3.fromRGB(180, 140, 255)
		hl.FillTransparency = 0.8
		hl.OutlineTransparency = 0
		hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		hl.Parent = gui
		local bb = Instance.new("BillboardGui")
		bb.Adornee = root
		bb.Size = UDim2.new(0, 100, 0, 22)
		bb.StudsOffset = Vector3.new(0, 3, 0)
		bb.AlwaysOnTop = true
		bb.Parent = gui
		local nl = Instance.new("TextLabel", bb)
		nl.Size = UDim2.new(1, 0, 1, 0)
		nl.BackgroundTransparency = 1
		nl.Text = target.Name
		nl.TextColor3 = Color3.fromRGB(255, 255, 255)
		nl.Font = Enum.Font.GothamBold
		nl.TextSize = 11
		nl.TextStrokeTransparency = 0.4
		espObjects[target] = {hl, bb}
		local conns = {}
		if hum then table.insert(conns, hum.Died:Connect(function() clearESPFor(target) end)) end
		table.insert(conns, char.AncestryChanged:Connect(function(_, p) if not p then clearESPFor(target) end end))
		espConnections[target] = conns
	end
	if target.Character then createVisuals(target.Character) end
	local c1 = target.CharacterAdded:Connect(function(c)
		task.wait(0.3)
		if espEnabled then createVisuals(c) end
	end)
	local c2 = target.CharacterRemoving:Connect(function() clearESPFor(target) end)
	if not espConnections[target] then espConnections[target] = {} end
	table.insert(espConnections[target], c1)
	table.insert(espConnections[target], c2)
end
local playerAddedConn
local function startESP()
	for _, p in ipairs(game.Players:GetPlayers()) do addESP(p) end
	if playerAddedConn then playerAddedConn:Disconnect() end
	playerAddedConn = game.Players.PlayerAdded:Connect(function(p)
		if espEnabled then addESP(p) end
	end)
	game.Players.PlayerRemoving:Connect(function(p) clearESPFor(p) end)
end
local function stopESP()
	for _, p in ipairs(game.Players:GetPlayers()) do clearESPFor(p) end
	if playerAddedConn then playerAddedConn:Disconnect() playerAddedConn = nil end
end

local nightVisionLight, nightVisionConn
local savedLighting = {}
local function startNightVision()
	savedLighting.Ambient = Lighting.Ambient
	savedLighting.OutdoorAmbient = Lighting.OutdoorAmbient
	savedLighting.Brightness = Lighting.Brightness
	savedLighting.FogEnd = Lighting.FogEnd
	savedLighting.FogStart = Lighting.FogStart
	savedLighting.GlobalShadows = Lighting.GlobalShadows
	local function force()
		Lighting.Ambient = Color3.fromRGB(255, 255, 255)
		Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
		Lighting.Brightness = 3
		Lighting.FogEnd = 100000
		Lighting.FogStart = 0
		Lighting.GlobalShadows = false
	end
	force()
	if nightVisionConn then nightVisionConn:Disconnect() end
	nightVisionConn = RunService.RenderStepped:Connect(force)
	local root = getChar():FindFirstChild("HumanoidRootPart")
	if root then
		if nightVisionLight then pcall(function() nightVisionLight:Destroy() end) end
		nightVisionLight = Instance.new("PointLight")
		nightVisionLight.Brightness = 8
		nightVisionLight.Range = 120
		nightVisionLight.Color = Color3.fromRGB(255, 255, 255)
		nightVisionLight.Shadows = false
		nightVisionLight.Parent = root
	end
end
local function stopNightVision()
	if nightVisionConn then nightVisionConn:Disconnect() nightVisionConn = nil end
	if savedLighting.Ambient then Lighting.Ambient = savedLighting.Ambient end
	if savedLighting.OutdoorAmbient then Lighting.OutdoorAmbient = savedLighting.OutdoorAmbient end
	if savedLighting.Brightness then Lighting.Brightness = savedLighting.Brightness end
	if savedLighting.FogEnd then Lighting.FogEnd = savedLighting.FogEnd end
	if savedLighting.FogStart then Lighting.FogStart = savedLighting.FogStart end
	if savedLighting.GlobalShadows ~= nil then Lighting.GlobalShadows = savedLighting.GlobalShadows end
	if nightVisionLight then pcall(function() nightVisionLight:Destroy() end) nightVisionLight = nil end
	savedLighting = {}
end

local clickTPTool, clickTPConn
local function doClickTeleport(pos)
	if not pos then return end
	local root = getChar():FindFirstChild("HumanoidRootPart")
	if root then root.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0)) end
end
local function startClickTP()
	if clickTPTool then pcall(function() clickTPTool:Destroy() end) clickTPTool = nil end
	clickTPTool = Instance.new("Tool")
	clickTPTool.Name = "Click TP"
	clickTPTool.RequiresHandle = false
	clickTPTool.CanBeDropped = false
	clickTPTool.Parent = player.Backpack
	clickTPTool.Activated:Connect(function()
		local m = player:GetMouse()
		if m and m.Hit then doClickTeleport(m.Hit.Position) end
	end)
	if clickTPConn then clickTPConn:Disconnect() end
	clickTPConn = UIS.InputBegan:Connect(function(input, gpe)
		if gpe or not clickTPEnabled then return end
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			local char = player.Character
			if not char or char:FindFirstChildOfClass("Tool") ~= clickTPTool then return end
			local cam = workspace.CurrentCamera
			if not cam then return end
			local ray = cam:ViewportPointToRay(input.Position.X, input.Position.Y)
			local params = RaycastParams.new()
			params.FilterDescendantsInstances = {char}
			params.FilterType = Enum.RaycastFilterType.Exclude
			local res = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
			if res then doClickTeleport(res.Position) end
		end
	end)
	task.defer(function()
		local h = getHumanoid()
		if h and clickTPTool then h:EquipTool(clickTPTool) end
	end)
end
local function stopClickTP()
	if clickTPConn then clickTPConn:Disconnect() clickTPConn = nil end
	if clickTPTool then
		pcall(function()
			local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if h then h:UnequipTools() end
			clickTPTool:Destroy()
		end)
		clickTPTool = nil
	end
end

local savedShadows, savedFogEnd, savedFogStart
local fpsConn
local function startFPSBoost()
	savedShadows = Lighting.GlobalShadows
	savedFogEnd = Lighting.FogEnd
	savedFogStart = Lighting.FogStart
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 100000
	Lighting.FogStart = 0
	pcall(function()
		local terrain = workspace:FindFirstChildOfClass("Terrain")
		if terrain then terrain.Decoration = false end
	end)
	fpsConn = RunService.Heartbeat:Connect(function()
		if Lighting.GlobalShadows then Lighting.GlobalShadows = false end
	end)
end
local function stopFPSBoost()
	if fpsConn then fpsConn:Disconnect() fpsConn = nil end
	if savedShadows ~= nil then Lighting.GlobalShadows = savedShadows end
	if savedFogEnd then Lighting.FogEnd = savedFogEnd end
	if savedFogStart then Lighting.FogStart = savedFogStart end
	pcall(function()
		local terrain = workspace:FindFirstChildOfClass("Terrain")
		if terrain then terrain.Decoration = true end
	end)
end

-- ================= AIMBOT + TEAM SYSTEM =================
local aimbotConn
local teamHighlights = {} -- [player] = Highlight

local TEAM_COLORS = {
	own = Color3.fromRGB(40, 120, 255),      -- น้ำเงิน (ทีมเรา)
	enemy = Color3.fromRGB(220, 40, 40),     -- แดง (ศัตรู)
	third = Color3.fromRGB(255, 180, 40),    -- ส้ม (ทีมที่ 3)
	fourth = Color3.fromRGB(40, 220, 120),   -- เขียว
	neutral = Color3.fromRGB(180, 180, 200)
}

local function getPlayerTeam(plr)
	if plr.Team then return plr.Team end
	return nil
end

local function isEnemy(plr)
	if plr == player then return false end
	local myTeam = getPlayerTeam(player)
	local theirTeam = getPlayerTeam(plr)
	if myTeam and theirTeam then
		return myTeam ~= theirTeam
	end
	-- ถ้าไม่มีทีม ถือว่าเป็นศัตรูได้ (โหมด FFA)
	return true
end

local function detectRole(plr)
	-- ตรวจบทบาทแบบง่าย (Murder Mystery / เกมที่มีบทบาท)
	if not plr.Character then return "normal" end
	local char = plr.Character
	local tool = char:FindFirstChildOfClass("Tool")
	if tool then
		local n = string.lower(tool.Name)
		if n:find("knife") or n:find("sword") or n:find("murder") or n:find("killer") or n:find("assassin") then
			return "murderer"
		end
		if n:find("gun") or n:find("revolver") or n:find("pistol") or n:find("sheriff") or n:find("police") then
			return "sheriff"
		end
	end
	-- ตรวจจาก Attribute / Value ที่เกมนิยมใช้
	local roleVal = plr:FindFirstChild("Role") or char:FindFirstChild("Role")
	if roleVal and roleVal:IsA("StringValue") then
		local r = string.lower(roleVal.Value)
		if r:find("murder") or r:find("killer") or r:find("assassin") then return "murderer" end
		if r:find("sheriff") or r:find("police") or r:find("hero") then return "sheriff" end
	end
	return "normal"
end

local function getTeamColor(plr)
	if plr == player then return TEAM_COLORS.own end
	local myTeam = getPlayerTeam(player)
	local theirTeam = getPlayerTeam(plr)
	if not myTeam or not theirTeam then
		return TEAM_COLORS.enemy
	end
	if myTeam == theirTeam then
		return TEAM_COLORS.own
	end
	-- หลายทีม
	local teamsList = Teams:GetTeams()
	if #teamsList <= 2 then
		return TEAM_COLORS.enemy
	end
	-- หา index ของทีม
	local idx = 1
	for i, t in ipairs(teamsList) do
		if t == theirTeam then idx = i break end
	end
	if idx == 1 then return TEAM_COLORS.enemy
	elseif idx == 2 then return TEAM_COLORS.third
	else return TEAM_COLORS.fourth end
end

local function clearTeamHighlights()
	for plr, hl in pairs(teamHighlights) do
		pcall(function() hl:Destroy() end)
	end
	teamHighlights = {}
end

local function updateTeamHighlight(plr)
	if not plr.Character then return end
	local existing = teamHighlights[plr]
	if existing then
		existing.FillColor = getTeamColor(plr)
		existing.OutlineColor = getTeamColor(plr)
		return
	end
	local hl = Instance.new("Highlight")
	hl.Adornee = plr.Character
	hl.FillColor = getTeamColor(plr)
	hl.OutlineColor = getTeamColor(plr)
	hl.FillTransparency = 0.75
	hl.OutlineTransparency = 0.2
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = gui
	teamHighlights[plr] = hl
end

local function refreshAllTeamHighlights()
	for _, p in ipairs(game.Players:GetPlayers()) do
		if p ~= player and p.Character then
			updateTeamHighlight(p)
		end
	end
end

local function getAimbotTargets()
	local myRoot = getChar():FindFirstChild("HumanoidRootPart")
	if not myRoot then return {} end
	local range = aimbotRangeMode == "close" and aimbotCloseRange or aimbotFarRange
	local list = {}

	if aimbotTargetType == "player" then
		local myRole = detectRole(player)
		for _, p in ipairs(game.Players:GetPlayers()) do
			if p ~= player and p.Character then
				local hum = p.Character:FindFirstChildOfClass("Humanoid")
				local root = p.Character:FindFirstChild("HumanoidRootPart")
				if hum and hum.Health > 0 and root then
					local dist = (root.Position - myRoot.Position).Magnitude
					if dist <= range and isEnemy(p) then
						local role = detectRole(p)
						local priority = 1
						-- ถ้าเราเป็นตำรวจ → ล็อกฆาตกรก่อน
						if myRole == "sheriff" and role == "murderer" then
							priority = 10
						-- ถ้าเราเป็นฆาตกร → ล็อกคนทั่วไป / ตำรวจ
						elseif myRole == "murderer" and role ~= "murderer" then
							priority = 8
						elseif role == "murderer" then
							priority = 6
						end
						table.insert(list, {root = root, dist = dist, priority = priority, plr = p})
					end
				end
			end
		end
	else
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("Humanoid") and obj.Health > 0 then
				local model = obj.Parent
				if model and not game.Players:GetPlayerFromCharacter(model) then
					local root = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso")
					if root then
						local dist = (root.Position - myRoot.Position).Magnitude
						if dist <= range then
							table.insert(list, {root = root, dist = dist, priority = 1})
						end
					end
				end
			end
		end
	end

	table.sort(list, function(a, b)
		if a.priority ~= b.priority then return a.priority > b.priority end
		return a.dist < b.dist
	end)
	return list
end

local function startAimbot()
	if aimbotConn then aimbotConn:Disconnect() end
	refreshAllTeamHighlights()
	aimbotConn = RunService.RenderStepped:Connect(function()
		if not aimbotEnabled then return end
		-- อัปเดตไฮไลต์ทีม
		for _, p in ipairs(game.Players:GetPlayers()) do
			if p ~= player and p.Character then
				updateTeamHighlight(p)
			end
		end
		local targets = getAimbotTargets()
		if #targets == 0 then return end
		local targetRoot = targets[1].root
		local cam = workspace.CurrentCamera
		if not cam then return end
		local targetPos = targetRoot.Position + Vector3.new(0, 1.5, 0)
		local currentCF = cam.CFrame
		local goalCF = CFrame.lookAt(currentCF.Position, targetPos)
		cam.CFrame = currentCF:Lerp(goalCF, 0.32)
	end)
end

local function stopAimbot()
	if aimbotConn then aimbotConn:Disconnect() aimbotConn = nil end
	clearTeamHighlights()
end

-- ================= SEPARATE AIMBOT UI =================
local aimbotPanel = Instance.new("Frame", gui)
aimbotPanel.Size = UDim2.new(0, 220, 0, 100)
aimbotPanel.Position = UDim2.new(0.5, -110, 0.15, 0)
aimbotPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
aimbotPanel.BackgroundTransparency = 0.08
aimbotPanel.Visible = false
aimbotPanel.ZIndex = 90
Instance.new("UICorner", aimbotPanel).CornerRadius = UDim.new(0, 14)
local apStroke = Instance.new("UIStroke", aimbotPanel)
apStroke.Color = Color3.fromRGB(100, 70, 180)
apStroke.Thickness = 1.4
apStroke.Transparency = 0.3

local apTitle = Instance.new("TextLabel", aimbotPanel)
apTitle.Size = UDim2.new(1, -20, 0, 28)
apTitle.Position = UDim2.new(0, 10, 0, 8)
apTitle.BackgroundTransparency = 1
apTitle.Text = T("aimbotPanel")
apTitle.TextColor3 = Color3.fromRGB(140, 220, 140)
apTitle.Font = Enum.Font.GothamBold
apTitle.TextSize = 15
apTitle.TextXAlignment = Enum.TextXAlignment.Center
apTitle.ZIndex = 91

local apBtn = Instance.new("TextButton", aimbotPanel)
apBtn.Size = UDim2.new(1, -24, 0, 42)
apBtn.Position = UDim2.new(0, 12, 0, 42)
apBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 40)
apBtn.Text = T("off")
apBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
apBtn.Font = Enum.Font.GothamBold
apBtn.TextSize = 20
apBtn.AutoButtonColor = false
apBtn.ZIndex = 91
Instance.new("UICorner", apBtn).CornerRadius = UDim.new(0, 10)

local function updateAimbotPanelVisual(state)
	if state then
		apBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
		apBtn.Text = T("on")
	else
		apBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 40)
		apBtn.Text = T("off")
	end
end

apBtn.MouseButton1Click:Connect(function()
	aimbotEnabled = not aimbotEnabled
	updateAimbotPanelVisual(aimbotEnabled)
	if aimbotEnabled then
		startAimbot()
	else
		stopAimbot()
	end
end)

-- ลากแผง Aimbot ได้
do
	local drag, start, pos = false
	aimbotPanel.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			drag = true
			start = i.Position
			pos = aimbotPanel.Position
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if drag then
			local d = i.Position - start
			aimbotPanel.Position = UDim2.new(pos.X.Scale, pos.X.Offset + d.X, pos.Y.Scale, pos.Y.Offset + d.Y)
		end
	end)
	UIS.InputEnded:Connect(function() drag = false end)
end

local function showAimbotPanel(show)
	aimbotPanel.Visible = show
	if show then
		updateAimbotPanelVisual(aimbotEnabled)
	end
end

-- ================= CREATE ROW =================
local rowLabels = {}
local function createRow(parent, key, y, getVal, setVal, toggle, noSlider, maxOverride)
	local row = Instance.new("Frame", parent)
	row.Size = UDim2.new(1, -16, 0, 44)
	row.Position = UDim2.new(0, 8, 0, y)
	row.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
	row.BackgroundTransparency = 0.25
	row.BorderSizePixel = 0
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 9)
	local label = Instance.new("TextLabel", row)
	label.Size = UDim2.new(0, 130, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = T(key)
	label.TextColor3 = Color3.fromRGB(210, 210, 230)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	table.insert(rowLabels, {label = label, key = key})
	local track = Instance.new("Frame", row)
	track.Size = UDim2.new(0, 40, 0, 20)
	track.Position = UDim2.new(1, -50, 0.5, -10)
	track.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
	Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
	local thumb = Instance.new("Frame", track)
	thumb.Size = UDim2.new(0, 16, 0, 16)
	thumb.Position = UDim2.new(0, 2, 0.5, -8)
	thumb.BackgroundColor3 = Color3.fromRGB(180, 180, 200)
	Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)
	local hit = Instance.new("TextButton", track)
	hit.Size = UDim2.new(1, 0, 1, 0)
	hit.BackgroundTransparency = 1
	hit.Text = ""
	hit.ZIndex = 5
	local on = false
	local function setVisual(state)
		on = state
		if state then
			TweenService:Create(track, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(140, 100, 255)}):Play()
			TweenService:Create(thumb, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {
				Position = UDim2.new(1, -18, 0.5, -8),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			}):Play()
		else
			TweenService:Create(track, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}):Play()
			TweenService:Create(thumb, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {
				Position = UDim2.new(0, 2, 0.5, -8),
				BackgroundColor3 = Color3.fromRGB(180, 180, 200)
			}):Play()
		end
	end
	hit.MouseButton1Click:Connect(function()
		setVisual(not on)
		toggle(on)
	end)
	if not noSlider then
		local maxV = maxOverride or 500
		local bg = Instance.new("Frame", row)
		bg.Size = UDim2.new(0, 120, 0, 5)
		bg.Position = UDim2.new(0, 140, 0.5, -2.5)
		bg.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
		Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
		local fill = Instance.new("Frame", bg)
		fill.Size = UDim2.new(math.clamp(getVal()/maxV, 0, 1), 0, 1, 0)
		fill.BackgroundColor3 = Color3.fromRGB(150, 110, 255)
		Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
		local th = Instance.new("Frame", bg)
		th.Size = UDim2.new(0, 12, 0, 12)
		th.Position = UDim2.new(math.clamp(getVal()/maxV, 0, 1), -6, 0.5, -6)
		th.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		th.ZIndex = 3
		Instance.new("UICorner", th).CornerRadius = UDim.new(1, 0)
		local box = Instance.new("TextBox", row)
		box.Size = UDim2.new(0, 38, 0, 22)
		box.Position = UDim2.new(0, 270, 0.5, -11)
		box.BackgroundColor3 = Color3.fromRGB(35, 35, 52)
		box.TextColor3 = Color3.fromRGB(180, 150, 255)
		box.Font = Enum.Font.GothamBold
		box.TextSize = 11
		box.Text = tostring(getVal())
		box.ClearTextOnFocus = true
		box.TextXAlignment = Enum.TextXAlignment.Center
		Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
		local function apply(v)
			v = math.clamp(math.floor(v), 0, maxV)
			local r = v / maxV
			fill.Size = UDim2.new(r, 0, 1, 0)
			th.Position = UDim2.new(r, -6, 0.5, -6)
			box.Text = tostring(v)
			setVal(v)
		end
		box.FocusLost:Connect(function()
			local n = tonumber(box.Text)
			if n then apply(n) else box.Text = tostring(getVal()) end
		end)
		local dragging = false
		local function upd(i)
			local rel = (i.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X
			apply(math.floor(math.clamp(rel, 0, 1) * maxV))
		end
		bg.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				upd(i)
			end
		end)
		UIS.InputChanged:Connect(function(i) if dragging then upd(i) end end)
		UIS.InputEnded:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end
		end)
	end
end

-- PAGE 1
createRow(page1, "fly", 6, function() return flySpeed end, function(v) flySpeed = v end, function(s) flyEnabled = s if s then startFly() else stopFly() end end)
createRow(page1, "speed", 58, function() return walkSpeed end, function(v) walkSpeed = v if speedEnabled then humanoid.WalkSpeed = v end end, function(s) speedEnabled = s humanoid.WalkSpeed = s and walkSpeed or 16 end)
createRow(page1, "jump", 110, function() return jumpPower end, function(v) jumpPower = v if jumpEnabled then humanoid.JumpPower = v end end, function(s) jumpEnabled = s humanoid.JumpPower = s and jumpPower or 50 end)
createRow(page1, "noclip", 162, function() return 0 end, function() end, function(s) noclipEnabled = s if s then startNoclip() else stopNoclip() end end, true)
createRow(page1, "night", 214, function() return 0 end, function() end, function(s) nightVisionEnabled = s if s then startNightVision() else stopNightVision() end end, true)

-- PAGE 2
createRow(page2, "esp", 6, function() return 0 end, function() end, function(s) espEnabled = s if s then startESP() else stopESP() end end, true)
createRow(page2, "freecam", 58, function() return freecamSpeed end, function(v) freecamSpeed = v end, function(s) freecamEnabled = s if s then startFreecam() else stopFreecam() end end, false, 5)
createRow(page2, "clicktp", 110, function() return 0 end, function() end, function(s) clickTPEnabled = s if s then startClickTP() else stopClickTP() end end, true)
createRow(page2, "fps", 162, function() return 0 end, function() end, function(s) fpsBoostEnabled = s if s then startFPSBoost() else stopFPSBoost() end end, true)

-- ================= AIMBOT (ในเมนู) =================
local AIM_ROW_Y = 214
local AIM_PANEL_HEIGHT = 148

local aimRow = Instance.new("Frame", page2)
aimRow.Size = UDim2.new(1, -16, 0, 42)
aimRow.Position = UDim2.new(0, 8, 0, AIM_ROW_Y)
aimRow.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
aimRow.BackgroundTransparency = 0.25
Instance.new("UICorner", aimRow).CornerRadius = UDim.new(0, 9)

local aimLabel = Instance.new("TextLabel", aimRow)
aimLabel.Size = UDim2.new(1, -40, 1, 0)
aimLabel.Position = UDim2.new(0, 12, 0, 0)
aimLabel.BackgroundTransparency = 1
aimLabel.Text = T("aimbot")
aimLabel.TextColor3 = Color3.fromRGB(210, 210, 230)
aimLabel.Font = Enum.Font.GothamBold
aimLabel.TextSize = 12
aimLabel.TextXAlignment = Enum.TextXAlignment.Left
table.insert(rowLabels, {label = aimLabel, key = "aimbot"})

local aimArrow = Instance.new("TextLabel", aimRow)
aimArrow.Size = UDim2.new(0, 28, 1, 0)
aimArrow.Position = UDim2.new(1, -32, 0, 0)
aimArrow.BackgroundTransparency = 1
aimArrow.Text = "▼"
aimArrow.TextColor3 = Color3.fromRGB(160, 140, 220)
aimArrow.Font = Enum.Font.GothamBold
aimArrow.TextSize = 13

local aimPanel = Instance.new("Frame", page2)
aimPanel.Size = UDim2.new(1, -16, 0, 0)
aimPanel.Position = UDim2.new(0, 8, 0, AIM_ROW_Y + 46)
aimPanel.BackgroundColor3 = Color3.fromRGB(22, 22, 34)
aimPanel.BackgroundTransparency = 0.15
aimPanel.ClipsDescendants = true
Instance.new("UICorner", aimPanel).CornerRadius = UDim.new(0, 9)

local function makeOptBtn(parent, text, x, y)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0, 90, 0, 28)
	b.Position = UDim2.new(0, x, 0, y)
	b.BackgroundColor3 = Color3.fromRGB(40, 40, 58)
	b.Text = text
	b.TextColor3 = Color3.fromRGB(180, 180, 200)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 11
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	return b
end

local targetTitle = Instance.new("TextLabel", aimPanel)
targetTitle.Size = UDim2.new(1, -14, 0, 18)
targetTitle.Position = UDim2.new(0, 10, 0, 6)
targetTitle.BackgroundTransparency = 1
targetTitle.Text = "เป้าหมาย"
targetTitle.TextColor3 = Color3.fromRGB(160, 150, 200)
targetTitle.Font = Enum.Font.GothamBold
targetTitle.TextSize = 11
targetTitle.TextXAlignment = Enum.TextXAlignment.Left

local playerOpt = makeOptBtn(aimPanel, T("targetPlayer"), 10, 28)
local npcOpt = makeOptBtn(aimPanel, T("targetNpc"), 108, 28)

local function updateTargetVisual()
	if aimbotTargetType == "player" then
		playerOpt.BackgroundColor3 = Color3.fromRGB(120, 80, 220)
		playerOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
		npcOpt.BackgroundColor3 = Color3.fromRGB(40, 40, 58)
		npcOpt.TextColor3 = Color3.fromRGB(180, 180, 200)
	else
		npcOpt.BackgroundColor3 = Color3.fromRGB(120, 80, 220)
		npcOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
		playerOpt.BackgroundColor3 = Color3.fromRGB(40, 40, 58)
		playerOpt.TextColor3 = Color3.fromRGB(180, 180, 200)
	end
end
playerOpt.MouseButton1Click:Connect(function()
	aimbotTargetType = "player"
	updateTargetVisual()
end)
npcOpt.MouseButton1Click:Connect(function()
	aimbotTargetType = "npc"
	updateTargetVisual()
end)
updateTargetVisual()

local rangeTitle = Instance.new("TextLabel", aimPanel)
rangeTitle.Size = UDim2.new(1, -14, 0, 18)
rangeTitle.Position = UDim2.new(0, 10, 0, 64)
rangeTitle.BackgroundTransparency = 1
rangeTitle.Text = "ระยะ"
rangeTitle.TextColor3 = Color3.fromRGB(160, 150, 200)
rangeTitle.Font = Enum.Font.GothamBold
rangeTitle.TextSize = 11
rangeTitle.TextXAlignment = Enum.TextXAlignment.Left

local closeOpt = makeOptBtn(aimPanel, T("rangeClose"), 10, 86)
local farOpt = makeOptBtn(aimPanel, T("rangeFar"), 108, 86)

local function updateRangeVisual()
	if aimbotRangeMode == "close" then
		closeOpt.BackgroundColor3 = Color3.fromRGB(120, 80, 220)
		closeOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
		farOpt.BackgroundColor3 = Color3.fromRGB(40, 40, 58)
		farOpt.TextColor3 = Color3.fromRGB(180, 180, 200)
	else
		farOpt.BackgroundColor3 = Color3.fromRGB(120, 80, 220)
		farOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
		closeOpt.BackgroundColor3 = Color3.fromRGB(40, 40, 58)
		closeOpt.TextColor3 = Color3.fromRGB(180, 180, 200)
	end
end
closeOpt.MouseButton1Click:Connect(function()
	aimbotRangeMode = "close"
	updateRangeVisual()
end)
farOpt.MouseButton1Click:Connect(function()
	aimbotRangeMode = "far"
	updateRangeVisual()
end)
updateRangeVisual()

-- ปุ่มเรียก UI แยก (แทน toggle เดิม)
local callPanelBtn = Instance.new("TextButton", aimPanel)
callPanelBtn.Size = UDim2.new(1, -20, 0, 32)
callPanelBtn.Position = UDim2.new(0, 10, 0, 120)
callPanelBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 200)
callPanelBtn.Text = "เรียก UI Aimbot"
callPanelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
callPanelBtn.Font = Enum.Font.GothamBold
callPanelBtn.TextSize = 13
callPanelBtn.AutoButtonColor = false
Instance.new("UICorner", callPanelBtn).CornerRadius = UDim.new(0, 8)

callPanelBtn.MouseButton1Click:Connect(function()
	showAimbotPanel(not aimbotPanel.Visible)
end)

-- ================= TELEPORT =================
local tpRow = Instance.new("Frame", page2)
tpRow.Size = UDim2.new(1, -16, 0, 42)
tpRow.Position = UDim2.new(0, 8, 0, 268)
tpRow.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
tpRow.BackgroundTransparency = 0.25
Instance.new("UICorner", tpRow).CornerRadius = UDim.new(0, 9)

local tpL = Instance.new("TextLabel", tpRow)
tpL.Size = UDim2.new(1, -40, 1, 0)
tpL.Position = UDim2.new(0, 12, 0, 0)
tpL.BackgroundTransparency = 1
tpL.Text = T("tpSystem")
tpL.TextColor3 = Color3.fromRGB(210, 210, 230)
tpL.Font = Enum.Font.GothamBold
tpL.TextSize = 12
tpL.TextXAlignment = Enum.TextXAlignment.Left
table.insert(rowLabels, {label = tpL, key = "tpSystem"})

local tpArrow = Instance.new("TextLabel", tpRow)
tpArrow.Size = UDim2.new(0, 28, 1, 0)
tpArrow.Position = UDim2.new(1, -32, 0, 0)
tpArrow.BackgroundTransparency = 1
tpArrow.Text = "▼"
tpArrow.TextColor3 = Color3.fromRGB(160, 140, 220)
tpArrow.Font = Enum.Font.GothamBold
tpArrow.TextSize = 13

local tpList = Instance.new("Frame", page2)
tpList.Size = UDim2.new(1, -16, 0, 0)
tpList.Position = UDim2.new(0, 8, 0, 316)
tpList.BackgroundColor3 = Color3.fromRGB(22, 22, 34)
tpList.BackgroundTransparency = 0.15
tpList.ClipsDescendants = true
Instance.new("UICorner", tpList).CornerRadius = UDim.new(0, 9)

local listScroll = Instance.new("ScrollingFrame", tpList)
listScroll.Size = UDim2.new(1, -8, 1, -8)
listScroll.Position = UDim2.new(0, 4, 0, 4)
listScroll.BackgroundTransparency = 1
listScroll.ScrollBarThickness = 3
listScroll.ScrollBarImageColor3 = Color3.fromRGB(140, 100, 255)
local listLayout = Instance.new("UIListLayout", listScroll)
listLayout.Padding = UDim.new(0, 4)

local function updateTPList()
	for _, v in pairs(listScroll:GetChildren()) do
		if v:IsA("TextButton") then v:Destroy() end
	end
	for _, p in pairs(game.Players:GetPlayers()) do
		if p ~= player then
			local b = Instance.new("TextButton", listScroll)
			b.Size = UDim2.new(1, 0, 0, 26)
			b.BackgroundColor3 = Color3.fromRGB(35, 35, 52)
			b.Text = p.Name
			b.TextColor3 = Color3.fromRGB(210, 210, 230)
			b.Font = Enum.Font.GothamBold
			b.TextSize = 11
			b.AutoButtonColor = false
			Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
			b.MouseButton1Click:Connect(function()
				if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
					getChar():SetPrimaryPartCFrame(p.Character.HumanoidRootPart.CFrame)
				end
			end)
		end
	end
	listScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 4)
end

local aimOpen = false
local tpOpen = false

local function refreshLayout()
	local aimH = aimOpen and AIM_PANEL_HEIGHT or 0
	local tpH = tpOpen and 140 or 0
	TweenService:Create(aimPanel, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
		Size = UDim2.new(1, -16, 0, aimH)
	}):Play()
	local tpY = AIM_ROW_Y + 46 + aimH + 6
	TweenService:Create(tpRow, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
		Position = UDim2.new(0, 8, 0, tpY)
	}):Play()
	TweenService:Create(tpList, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
		Position = UDim2.new(0, 8, 0, tpY + 46),
		Size = UDim2.new(1, -16, 0, tpH)
	}):Play()
	page2.CanvasSize = UDim2.new(0, 0, 0, math.max(tpY + 46 + tpH + 24, 360))
end

local aimClick = Instance.new("TextButton", aimRow)
aimClick.Size = UDim2.new(1, 0, 1, 0)
aimClick.BackgroundTransparency = 1
aimClick.Text = ""
aimClick.MouseButton1Click:Connect(function()
	aimOpen = not aimOpen
	aimArrow.Text = aimOpen and "▲" or "▼"
	refreshLayout()
end)

local tpClick = Instance.new("TextButton", tpRow)
tpClick.Size = UDim2.new(1, 0, 1, 0)
tpClick.BackgroundTransparency = 1
tpClick.Text = ""
tpClick.MouseButton1Click:Connect(function()
	tpOpen = not tpOpen
	tpArrow.Text = tpOpen and "▲" or "▼"
	if tpOpen then updateTPList() end
	refreshLayout()
end)
refreshLayout()

-- PAGE 3
local langTitle = Instance.new("TextLabel", page3)
langTitle.Size = UDim2.new(1, -16, 0, 26)
langTitle.Position = UDim2.new(0, 12, 0, 16)
langTitle.BackgroundTransparency = 1
langTitle.Text = T("lang")
langTitle.TextColor3 = Color3.fromRGB(170, 140, 255)
langTitle.Font = Enum.Font.GothamBold
langTitle.TextSize = 14
langTitle.TextXAlignment = Enum.TextXAlignment.Left

local langBtn = Instance.new("TextButton", page3)
langBtn.Size = UDim2.new(0, 160, 0, 36)
langBtn.Position = UDim2.new(0, 12, 0, 50)
langBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 220)
langBtn.Text = currentLang == "th" and "ไทย  →  English" or "English  →  ไทย"
langBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
langBtn.Font = Enum.Font.GothamBold
langBtn.TextSize = 12
langBtn.AutoButtonColor = false
Instance.new("UICorner", langBtn).CornerRadius = UDim.new(0, 8)

local function refreshLanguage()
	tab1Text.Text = T("player")
	tab2Text.Text = T("tools")
	tab3Text.Text = T("settings")
	langTitle.Text = T("lang")
	langBtn.Text = currentLang == "th" and "ไทย  →  English" or "English  →  ไทย"
	playerOpt.Text = T("targetPlayer")
	npcOpt.Text = T("targetNpc")
	closeOpt.Text = T("rangeClose")
	farOpt.Text = T("rangeFar")
	apTitle.Text = T("aimbotPanel")
	updateAimbotPanelVisual(aimbotEnabled)
	for _, item in ipairs(rowLabels) do
		item.label.Text = T(item.key)
	end
end

langBtn.MouseButton1Click:Connect(function()
	currentLang = currentLang == "th" and "en" or "th"
	refreshLanguage()
end)

player.CharacterAdded:Connect(function()
	humanoid = getHumanoid()
	if flyEnabled then task.wait(0.5) startFly() end
	if speedEnabled then humanoid.WalkSpeed = walkSpeed end
	if jumpEnabled then humanoid.JumpPower = jumpPower end
	if noclipEnabled then startNoclip() end
	if nightVisionEnabled then task.wait(0.8) startNightVision() end
	if clickTPEnabled then task.wait(0.6) startClickTP() end
	if fpsBoostEnabled then task.wait(0.3) startFPSBoost() end
	if aimbotEnabled then task.wait(0.4) startAimbot() end
end)

-- เคลียร์ highlight เมื่อผู้เล่นออก
game.Players.PlayerRemoving:Connect(function(p)
	if teamHighlights[p] then
		pcall(function() teamHighlights[p]:Destroy() end)
		teamHighlights[p] = nil
	end
end)
