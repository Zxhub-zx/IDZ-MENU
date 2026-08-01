if not game:IsLoaded() then
	game.Loaded:Wait()
end
local player = game.Players.LocalPlayer
repeat task.wait() until player:FindFirstChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local flyEnabled = false
local speedEnabled = false
local jumpEnabled = false
local noclipEnabled = false
local espEnabled = false
local freecamEnabled = false
local nightVisionEnabled = false
local clickTPEnabled = false
local fastModeEnabled = false
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

-- Language
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
		fast = "โหมดเร็ว",
		tpSystem = "ระบบวาปผู้เล่น",
		lang = "ภาษา",
		status = "พร้อมใช้งาน"
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
		fast = "Fast Mode",
		tpSystem = "Player Teleport",
		lang = "Language",
		status = "Ready"
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

-- ================= MAIN WINDOW =================
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 620, 0, 420)
frame.Position = UDim2.new(0.5, -310, 0.5, -210)
frame.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
frame.BackgroundTransparency = 0.05
frame.Active = true
frame.Visible = true
frame.ClipsDescendants = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

local outerGlow = Instance.new("ImageLabel", frame)
outerGlow.Name = "OuterGlow"
outerGlow.BackgroundTransparency = 1
outerGlow.Image = "rbxassetid://6014261993"
outerGlow.ImageColor3 = Color3.fromRGB(0, 200, 255)
outerGlow.ImageTransparency = 0.82
outerGlow.ScaleType = Enum.ScaleType.Slice
outerGlow.SliceCenter = Rect.new(49, 49, 450, 450)
outerGlow.Size = UDim2.new(1, 50, 1, 50)
outerGlow.Position = UDim2.new(0, -25, 0, -25)
outerGlow.ZIndex = 0

local softGlow = Instance.new("ImageLabel", frame)
softGlow.BackgroundTransparency = 1
softGlow.Image = "rbxassetid://6014261993"
softGlow.ImageColor3 = Color3.fromRGB(0, 160, 255)
softGlow.ImageTransparency = 0.90
softGlow.ScaleType = Enum.ScaleType.Slice
softGlow.SliceCenter = Rect.new(49, 49, 450, 450)
softGlow.Size = UDim2.new(1, 70, 1, 70)
softGlow.Position = UDim2.new(0, -35, 0, -35)
softGlow.ZIndex = 0

local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Color = Color3.fromRGB(0, 210, 255)
frameStroke.Thickness = 1.6
frameStroke.Transparency = 0.25

local frameGrad = Instance.new("UIGradient", frame)
frameGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(22, 28, 38)),
	ColorSequenceKeypoint.new(0.40, Color3.fromRGB(14, 18, 26)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(8, 10, 16))
})
frameGrad.Rotation = 125

task.spawn(function()
	local t = 0
	while frame and frame.Parent do
		t = t + 0.008
		frameGrad.Rotation = 125 + math.sin(t) * 8
		outerGlow.ImageTransparency = 0.80 + math.sin(t * 1.3) * 0.06
		task.wait(0.03)
	end
end)

-- ================= TITLE BAR =================
local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1, 0, 0, 44)
titleBar.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
titleBar.BackgroundTransparency = 0.25
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 16)

local titleBarGrad = Instance.new("UIGradient", titleBar)
titleBarGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 26, 36)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 14, 20))
})
titleBarGrad.Rotation = 90

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "IDZ"
title.TextColor3 = Color3.fromRGB(0, 230, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Center

local titleStroke = Instance.new("UIStroke", title)
titleStroke.Color = Color3.fromRGB(0, 180, 255)
titleStroke.Thickness = 1.3
titleStroke.Transparency = 0.45

local titleGrad = Instance.new("UIGradient", title)
titleGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 240, 255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 220, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 180, 240))
})
titleGrad.Rotation = 90

-- ================= SIDEBAR =================
local sidebar = Instance.new("Frame", frame)
sidebar.Size = UDim2.new(0, 132, 1, -44)
sidebar.Position = UDim2.new(0, 0, 0, 44)
sidebar.BackgroundColor3 = Color3.fromRGB(12, 15, 22)
sidebar.BackgroundTransparency = 0.2
sidebar.BorderSizePixel = 0

local sidebarGrad = Instance.new("UIGradient", sidebar)
sidebarGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 24, 34)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 12, 18))
})
sidebarGrad.Rotation = 90

local function createSidebarBtn(text, icon, y)
	local btn = Instance.new("TextButton", sidebar)
	btn.Size = UDim2.new(1, -14, 0, 44)
	btn.Position = UDim2.new(0, 7, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(20, 26, 36)
	btn.BackgroundTransparency = 1
	btn.Text = ""
	btn.AutoButtonColor = false
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

	local accent = Instance.new("Frame", btn)
	accent.Size = UDim2.new(0, 3, 0.55, 0)
	accent.Position = UDim2.new(0, 0, 0.225, 0)
	accent.BackgroundColor3 = Color3.fromRGB(0, 220, 255)
	accent.BackgroundTransparency = 1
	accent.BorderSizePixel = 0
	Instance.new("UICorner", accent).CornerRadius = UDim.new(1, 0)

	local iconLbl = Instance.new("TextLabel", btn)
	iconLbl.Size = UDim2.new(0, 30, 1, 0)
	iconLbl.Position = UDim2.new(0, 10, 0, 0)
	iconLbl.BackgroundTransparency = 1
	iconLbl.Text = icon
	iconLbl.TextColor3 = Color3.fromRGB(130, 145, 165)
	iconLbl.Font = Enum.Font.GothamBold
	iconLbl.TextSize = 16
	iconLbl.TextXAlignment = Enum.TextXAlignment.Center

	local txt = Instance.new("TextLabel", btn)
	txt.Size = UDim2.new(1, -48, 1, 0)
	txt.Position = UDim2.new(0, 42, 0, 0)
	txt.BackgroundTransparency = 1
	txt.Text = text
	txt.TextColor3 = Color3.fromRGB(150, 165, 185)
	txt.Font = Enum.Font.GothamBold
	txt.TextSize = 13
	txt.TextXAlignment = Enum.TextXAlignment.Left

	return btn, accent, iconLbl, txt
end

local tab1Btn, tab1Accent, tab1Icon, tab1Text = createSidebarBtn(T("player"), "👤", 14)
local tab2Btn, tab2Accent, tab2Icon, tab2Text = createSidebarBtn(T("tools"), "🛠", 66)
local tab3Btn, tab3Accent, tab3Icon, tab3Text = createSidebarBtn(T("settings"), "⚙", 118)

local function setActiveTab(active)
	local function style(btn, accent, icon, txt, isActive)
		if isActive then
			btn.BackgroundTransparency = 0.12
			btn.BackgroundColor3 = Color3.fromRGB(0, 100, 160)
			accent.BackgroundTransparency = 0
			icon.TextColor3 = Color3.fromRGB(0, 230, 255)
			txt.TextColor3 = Color3.fromRGB(0, 230, 255)
		else
			btn.BackgroundTransparency = 1
			accent.BackgroundTransparency = 1
			icon.TextColor3 = Color3.fromRGB(130, 145, 165)
			txt.TextColor3 = Color3.fromRGB(150, 165, 185)
		end
	end
	style(tab1Btn, tab1Accent, tab1Icon, tab1Text, active == 1)
	style(tab2Btn, tab2Accent, tab2Icon, tab2Text, active == 2)
	style(tab3Btn, tab3Accent, tab3Icon, tab3Text, active == 3)
end
setActiveTab(1)

-- ================= CONTENT =================
local content = Instance.new("Frame", frame)
content.Size = UDim2.new(1, -142, 1, -44)
content.Position = UDim2.new(0, 138, 0, 44)
content.BackgroundTransparency = 1
content.ClipsDescendants = true

local page1 = Instance.new("ScrollingFrame", content)
page1.Size = UDim2.new(1, 0, 1, -28)
page1.BackgroundTransparency = 1
page1.Visible = true
page1.ScrollBarThickness = 3
page1.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
page1.ScrollBarImageTransparency = 0.35
page1.CanvasSize = UDim2.new(0, 0, 0, 380)
page1.BorderSizePixel = 0
Instance.new("UIPadding", page1).PaddingTop = UDim.new(0, 8)

local page2 = Instance.new("ScrollingFrame", content)
page2.Size = UDim2.new(1, 0, 1, -28)
page2.BackgroundTransparency = 1
page2.Visible = false
page2.ScrollBarThickness = 3
page2.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
page2.ScrollBarImageTransparency = 0.35
page2.CanvasSize = UDim2.new(0, 0, 0, 480)
page2.BorderSizePixel = 0
Instance.new("UIPadding", page2).PaddingTop = UDim.new(0, 8)

local page3 = Instance.new("Frame", content)
page3.Size = UDim2.new(1, 0, 1, -28)
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

local statusBar = Instance.new("Frame", content)
statusBar.Size = UDim2.new(1, 0, 0, 26)
statusBar.Position = UDim2.new(0, 0, 1, -26)
statusBar.BackgroundColor3 = Color3.fromRGB(12, 15, 22)
statusBar.BackgroundTransparency = 0.35
statusBar.BorderSizePixel = 0

local statusText = Instance.new("TextLabel", statusBar)
statusText.Size = UDim2.new(1, -16, 1, 0)
statusText.Position = UDim2.new(0, 10, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "STATUS: " .. T("status") .. "  •  IDZ"
statusText.TextColor3 = Color3.fromRGB(0, 220, 180)
statusText.Font = Enum.Font.Gotham
statusText.TextSize = 11
statusText.TextXAlignment = Enum.TextXAlignment.Left

-- ================= MINIMIZE BAR (Modern redesign) =================
local minBar = Instance.new("TextButton", gui)
minBar.Name = "MinimizeBar"
minBar.Size = UDim2.new(0, 180, 0, 34)
minBar.Position = UDim2.new(0.5, -90, 0, 14)
minBar.BackgroundColor3 = Color3.fromRGB(12, 16, 24)
minBar.BackgroundTransparency = 0.08
minBar.Text = ""
minBar.AutoButtonColor = false
minBar.ZIndex = 60
Instance.new("UICorner", minBar).CornerRadius = UDim.new(0, 12)

-- Soft glow behind the bar
local minGlow = Instance.new("ImageLabel", minBar)
minGlow.BackgroundTransparency = 1
minGlow.Image = "rbxassetid://6014261993"
minGlow.ImageColor3 = Color3.fromRGB(0, 190, 255)
minGlow.ImageTransparency = 0.78
minGlow.ScaleType = Enum.ScaleType.Slice
minGlow.SliceCenter = Rect.new(49, 49, 450, 450)
minGlow.Size = UDim2.new(1, 28, 1, 28)
minGlow.Position = UDim2.new(0, -14, 0, -14)
minGlow.ZIndex = 59

local minStroke = Instance.new("UIStroke", minBar)
minStroke.Color = Color3.fromRGB(0, 200, 255)
minStroke.Thickness = 1.4
minStroke.Transparency = 0.25

local minGrad = Instance.new("UIGradient", minBar)
minGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 30, 42)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(14, 18, 28)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 24, 36))
})
minGrad.Rotation = 90

local minLabel = Instance.new("TextLabel", minBar)
minLabel.Size = UDim2.new(1, 0, 1, 0)
minLabel.BackgroundTransparency = 1
minLabel.Text = "▲  IDZ"
minLabel.TextColor3 = Color3.fromRGB(0, 230, 255)
minLabel.Font = Enum.Font.GothamBold
minLabel.TextSize = 14
minLabel.ZIndex = 61

local minLabelStroke = Instance.new("UIStroke", minLabel)
minLabelStroke.Color = Color3.fromRGB(0, 160, 220)
minLabelStroke.Thickness = 1
minLabelStroke.Transparency = 0.55

-- Hover effect
minBar.MouseEnter:Connect(function()
	TweenService:Create(minBar, TweenInfo.new(0.18), {BackgroundTransparency = 0}):Play()
	TweenService:Create(minStroke, TweenInfo.new(0.18), {Transparency = 0.08}):Play()
	TweenService:Create(minGlow, TweenInfo.new(0.18), {ImageTransparency = 0.65}):Play()
	TweenService:Create(minLabel, TweenInfo.new(0.18), {TextColor3 = Color3.fromRGB(120, 245, 255)}):Play()
end)
minBar.MouseLeave:Connect(function()
	TweenService:Create(minBar, TweenInfo.new(0.18), {BackgroundTransparency = 0.08}):Play()
	TweenService:Create(minStroke, TweenInfo.new(0.18), {Transparency = 0.25}):Play()
	TweenService:Create(minGlow, TweenInfo.new(0.18), {ImageTransparency = 0.78}):Play()
	TweenService:Create(minLabel, TweenInfo.new(0.18), {TextColor3 = Color3.fromRGB(0, 230, 255)}):Play()
end)

local isMinimized = false
local frameOpenSize = frame.Size
local function setMinimized(state)
	isMinimized = state
	if state then
		minLabel.Text = "▼  IDZ"
		local t = TweenService:Create(frame, TweenInfo.new(0.28, Enum.EasingStyle.Quint), {
			Size = UDim2.new(0, 620, 0, 0),
			BackgroundTransparency = 1
		})
		t:Play()
		t.Completed:Connect(function()
			if isMinimized then frame.Visible = false end
		end)
	else
		minLabel.Text = "▲  IDZ"
		frame.Visible = true
		frame.Size = UDim2.new(0, 620, 0, 0)
		frame.BackgroundTransparency = 1
		TweenService:Create(frame, TweenInfo.new(0.28, Enum.EasingStyle.Quint), {
			Size = frameOpenSize,
			BackgroundTransparency = 0.05
		}):Play()
	end
end
minBar.MouseButton1Click:Connect(function() setMinimized(not isMinimized) end)

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

-- Opening
frame.BackgroundTransparency = 1
frame.Size = UDim2.new(0, 620, 0, 0)
task.defer(function()
	TweenService:Create(frame, TweenInfo.new(0.38, Enum.EasingStyle.Quint), {
		Size = UDim2.new(0, 620, 0, 420),
		BackgroundTransparency = 0.05
	}):Play()
end)

-- ================= MOBILE =================
local function styleMobile(btn)
	btn.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
	btn.BackgroundTransparency = 0.12
	btn.TextColor3 = Color3.fromRGB(0, 220, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 20
	btn.AutoButtonColor = false
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 11)
	local s = Instance.new("UIStroke", btn)
	s.Color = Color3.fromRGB(0, 180, 240)
	s.Thickness = 1.1
	s.Transparency = 0.4
end
local upBtn = Instance.new("TextButton", gui)
upBtn.Size = UDim2.new(0, 54, 0, 54)
upBtn.Position = UDim2.new(1, -72, 0.68, 0)
upBtn.Text = "↑"
upBtn.Visible = false
styleMobile(upBtn)
local downBtn = Instance.new("TextButton", gui)
downBtn.Size = UDim2.new(0, 54, 0, 54)
downBtn.Position = UDim2.new(1, -72, 0.78, 0)
downBtn.Text = "↓"
downBtn.Visible = false
styleMobile(downBtn)
local moveForwardBtn = Instance.new("TextButton", gui)
moveForwardBtn.Size = UDim2.new(0, 54, 0, 54)
moveForwardBtn.Position = UDim2.new(0, 72, 0.68, 0)
moveForwardBtn.Text = "▲"
moveForwardBtn.Visible = false
styleMobile(moveForwardBtn)
local moveBackBtn = Instance.new("TextButton", gui)
moveBackBtn.Size = UDim2.new(0, 54, 0, 54)
moveBackBtn.Position = UDim2.new(0, 72, 0.78, 0)
moveBackBtn.Text = "▼"
moveBackBtn.Visible = false
styleMobile(moveBackBtn)
local moveLeftBtn = Instance.new("TextButton", gui)
moveLeftBtn.Size = UDim2.new(0, 54, 0, 54)
moveLeftBtn.Position = UDim2.new(0, 12, 0.73, 0)
moveLeftBtn.Text = "◄"
moveLeftBtn.Visible = false
styleMobile(moveLeftBtn)
local moveRightBtn = Instance.new("TextButton", gui)
moveRightBtn.Size = UDim2.new(0, 54, 0, 54)
moveRightBtn.Position = UDim2.new(0, 132, 0.73, 0)
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

-- ================= FEATURES =================
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

-- ESP
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
		hl.FillColor = Color3.fromRGB(0, 200, 255)
		hl.OutlineColor = Color3.fromRGB(0, 230, 255)
		hl.FillTransparency = 0.8
		hl.OutlineTransparency = 0
		hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		hl.Parent = gui
		local bb = Instance.new("BillboardGui")
		bb.Adornee = root
		bb.Size = UDim2.new(0, 110, 0, 24)
		bb.StudsOffset = Vector3.new(0, 3, 0)
		bb.AlwaysOnTop = true
		bb.Parent = gui
		local nl = Instance.new("TextLabel", bb)
		nl.Size = UDim2.new(1, 0, 1, 0)
		nl.BackgroundTransparency = 1
		nl.Text = target.Name
		nl.TextColor3 = Color3.fromRGB(255, 255, 255)
		nl.Font = Enum.Font.GothamBold
		nl.TextSize = 12
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

-- Night Vision
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

-- Click TP
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

-- Fast Mode
local normalFly, normalWalk, normalFreecam = flySpeed, walkSpeed, freecamSpeed
local savedShadows
local function startFastMode()
	normalFly, normalWalk, normalFreecam = flySpeed, walkSpeed, freecamSpeed
	flySpeed = math.max(flySpeed * 2.5, 50)
	walkSpeed = math.max(walkSpeed * 2.2, 40)
	freecamSpeed = math.max(freecamSpeed * 3, 8)
	if speedEnabled then humanoid.WalkSpeed = walkSpeed end
	savedShadows = Lighting.GlobalShadows
	Lighting.GlobalShadows = false
end
local function stopFastMode()
	flySpeed = normalFly
	walkSpeed = normalWalk
	freecamSpeed = normalFreecam
	if speedEnabled then humanoid.WalkSpeed = walkSpeed end
	if savedShadows ~= nil then Lighting.GlobalShadows = savedShadows end
end

-- ================= CREATE ROW =================
local rowLabels = {}
local function createRow(parent, key, y, getVal, setVal, toggle, noSlider, maxOverride)
	local row = Instance.new("Frame", parent)
	row.Size = UDim2.new(1, -16, 0, 48)
	row.Position = UDim2.new(0, 8, 0, y)
	row.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
	row.BackgroundTransparency = 0.22
	row.BorderSizePixel = 0
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 11)
	local stroke = Instance.new("UIStroke", row)
	stroke.Color = Color3.fromRGB(0, 160, 230)
	stroke.Thickness = 1
	stroke.Transparency = 0.72

	local label = Instance.new("TextLabel", row)
	label.Size = UDim2.new(0, 150, 1, 0)
	label.Position = UDim2.new(0, 14, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = T(key)
	label.TextColor3 = Color3.fromRGB(220, 230, 245)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	table.insert(rowLabels, {label = label, key = key})

	local track = Instance.new("Frame", row)
	track.Size = UDim2.new(0, 42, 0, 22)
	track.Position = UDim2.new(1, -54, 0.5, -11)
	track.BackgroundColor3 = Color3.fromRGB(42, 48, 60)
	Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
	local thumb = Instance.new("Frame", track)
	thumb.Size = UDim2.new(0, 18, 0, 18)
	thumb.Position = UDim2.new(0, 2, 0.5, -9)
	thumb.BackgroundColor3 = Color3.fromRGB(170, 180, 195)
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
			TweenService:Create(track, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 190, 255)}):Play()
			TweenService:Create(thumb, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {
				Position = UDim2.new(1, -20, 0.5, -9),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			}):Play()
		else
			TweenService:Create(track, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(42, 48, 60)}):Play()
			TweenService:Create(thumb, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {
				Position = UDim2.new(0, 2, 0.5, -9),
				BackgroundColor3 = Color3.fromRGB(170, 180, 195)
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
		bg.Size = UDim2.new(0, 140, 0, 6)
		bg.Position = UDim2.new(0, 165, 0.5, -3)
		bg.BackgroundColor3 = Color3.fromRGB(38, 44, 56)
		Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
		local fill = Instance.new("Frame", bg)
		fill.Size = UDim2.new(math.clamp(getVal()/maxV, 0, 1), 0, 1, 0)
		fill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
		Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
		local th = Instance.new("Frame", bg)
		th.Size = UDim2.new(0, 14, 0, 14)
		th.Position = UDim2.new(math.clamp(getVal()/maxV, 0, 1), -7, 0.5, -7)
		th.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		th.ZIndex = 3
		Instance.new("UICorner", th).CornerRadius = UDim.new(1, 0)
		local box = Instance.new("TextBox", row)
		box.Size = UDim2.new(0, 42, 0, 22)
		box.Position = UDim2.new(0, 315, 0.5, -11)
		box.BackgroundColor3 = Color3.fromRGB(26, 30, 40)
		box.TextColor3 = Color3.fromRGB(0, 220, 255)
		box.Font = Enum.Font.GothamBold
		box.TextSize = 11
		box.Text = tostring(getVal())
		box.ClearTextOnFocus = true
		box.TextXAlignment = Enum.TextXAlignment.Center
		Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

		local function apply(v)
			v = math.clamp(math.floor(v), 0, maxV)
			local r = v / maxV
			fill.Size = UDim2.new(r, 0, 1, 0)
			th.Position = UDim2.new(r, -7, 0.5, -7)
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
createRow(page1, "fly", 6,
	function() return flySpeed end,
	function(v) flySpeed = v end,
	function(s) flyEnabled = s if s then startFly() else stopFly() end end
)
createRow(page1, "speed", 62,
	function() return walkSpeed end,
	function(v) walkSpeed = v if speedEnabled then humanoid.WalkSpeed = v end end,
	function(s) speedEnabled = s humanoid.WalkSpeed = s and walkSpeed or 16 end
)
createRow(page1, "jump", 118,
	function() return jumpPower end,
	function(v) jumpPower = v if jumpEnabled then humanoid.JumpPower = v end end,
	function(s) jumpEnabled = s humanoid.JumpPower = s and jumpPower or 50 end
)
createRow(page1, "noclip", 174,
	function() return 0 end, function() end,
	function(s) noclipEnabled = s if s then startNoclip() else stopNoclip() end end, true
)
createRow(page1, "night", 230,
	function() return 0 end, function() end,
	function(s) nightVisionEnabled = s if s then startNightVision() else stopNightVision() end end, true
)

-- PAGE 2
createRow(page2, "esp", 6,
	function() return 0 end, function() end,
	function(s) espEnabled = s if s then startESP() else stopESP() end end, true
)
createRow(page2, "freecam", 62,
	function() return freecamSpeed end,
	function(v) freecamSpeed = v end,
	function(s) freecamEnabled = s if s then startFreecam() else stopFreecam() end end, false, 5
)
createRow(page2, "clicktp", 118,
	function() return 0 end, function() end,
	function(s) clickTPEnabled = s if s then startClickTP() else stopClickTP() end end, true
)
createRow(page2, "fast", 174,
	function() return 0 end, function() end,
	function(s) fastModeEnabled = s if s then startFastMode() else stopFastMode() end end, true
)

-- Teleport
local tpRow = Instance.new("Frame", page2)
tpRow.Size = UDim2.new(1, -16, 0, 44)
tpRow.Position = UDim2.new(0, 8, 0, 230)
tpRow.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
tpRow.BackgroundTransparency = 0.22
Instance.new("UICorner", tpRow).CornerRadius = UDim.new(0, 11)
local tpS = Instance.new("UIStroke", tpRow)
tpS.Color = Color3.fromRGB(0, 160, 230)
tpS.Thickness = 1
tpS.Transparency = 0.72
local tpL = Instance.new("TextLabel", tpRow)
tpL.Size = UDim2.new(1, -20, 1, 0)
tpL.Position = UDim2.new(0, 14, 0, 0)
tpL.BackgroundTransparency = 1
tpL.Text = T("tpSystem")
tpL.TextColor3 = Color3.fromRGB(220, 230, 245)
tpL.Font = Enum.Font.GothamBold
tpL.TextSize = 13
tpL.TextXAlignment = Enum.TextXAlignment.Left
table.insert(rowLabels, {label = tpL, key = "tpSystem"})

local tpList = Instance.new("Frame", page2)
tpList.Size = UDim2.new(1, -16, 0, 160)
tpList.Position = UDim2.new(0, 8, 0, 284)
tpList.BackgroundColor3 = Color3.fromRGB(12, 15, 22)
tpList.BackgroundTransparency = 0.18
tpList.Visible = false
Instance.new("UICorner", tpList).CornerRadius = UDim.new(0, 11)
local listScroll = Instance.new("ScrollingFrame", tpList)
listScroll.Size = UDim2.new(1, -10, 1, -10)
listScroll.Position = UDim2.new(0, 5, 0, 5)
listScroll.BackgroundTransparency = 1
listScroll.ScrollBarThickness = 3
listScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
local listLayout = Instance.new("UIListLayout", listScroll)
listLayout.Padding = UDim.new(0, 4)
local function updateTPList()
	for _, v in pairs(listScroll:GetChildren()) do
		if v:IsA("TextButton") then v:Destroy() end
	end
	for _, p in pairs(game.Players:GetPlayers()) do
		if p ~= player then
			local b = Instance.new("TextButton", listScroll)
			b.Size = UDim2.new(1, 0, 0, 28)
			b.BackgroundColor3 = Color3.fromRGB(26, 30, 40)
			b.Text = p.Name
			b.TextColor3 = Color3.fromRGB(220, 230, 245)
			b.Font = Enum.Font.GothamBold
			b.TextSize = 12
			b.AutoButtonColor = false
			Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
			b.MouseButton1Click:Connect(function()
				if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
					getChar():SetPrimaryPartCFrame(p.Character.HumanoidRootPart.CFrame)
				end
			end)
		end
	end
	listScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 4)
end
local tpBtn = Instance.new("TextButton", tpRow)
tpBtn.Size = UDim2.new(1, 0, 1, 0)
tpBtn.BackgroundTransparency = 1
tpBtn.Text = ""
tpBtn.MouseButton1Click:Connect(function()
	tpList.Visible = not tpList.Visible
	if tpList.Visible then updateTPList() end
end)

-- PAGE 3 - Settings
local langTitle = Instance.new("TextLabel", page3)
langTitle.Size = UDim2.new(1, -20, 0, 30)
langTitle.Position = UDim2.new(0, 12, 0, 20)
langTitle.BackgroundTransparency = 1
langTitle.Text = T("lang")
langTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
langTitle.Font = Enum.Font.GothamBold
langTitle.TextSize = 15
langTitle.TextXAlignment = Enum.TextXAlignment.Left

local langBtn = Instance.new("TextButton", page3)
langBtn.Size = UDim2.new(0, 170, 0, 38)
langBtn.Position = UDim2.new(0, 12, 0, 60)
langBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 230)
langBtn.Text = currentLang == "th" and "ไทย  →  English" or "English  →  ไทย"
langBtn.TextColor3 = Color3.fromRGB(8, 10, 16)
langBtn.Font = Enum.Font.GothamBold
langBtn.TextSize = 13
langBtn.AutoButtonColor = false
Instance.new("UICorner", langBtn).CornerRadius = UDim.new(0, 10)

local function refreshLanguage()
	tab1Text.Text = T("player")
	tab2Text.Text = T("tools")
	tab3Text.Text = T("settings")
	langTitle.Text = T("lang")
	langBtn.Text = currentLang == "th" and "ไทย  →  English" or "English  →  ไทย"
	statusText.Text = "STATUS: " .. T("status") .. "  •  IDZ"
	for _, item in ipairs(rowLabels) do
		item.label.Text = T(item.key)
	end
end

langBtn.MouseButton1Click:Connect(function()
	currentLang = currentLang == "th" and "en" or "th"
	refreshLanguage()
end)

-- Character reload
player.CharacterAdded:Connect(function()
	humanoid = getHumanoid()
	if flyEnabled then task.wait(0.5) startFly() end
	if speedEnabled then humanoid.WalkSpeed = walkSpeed end
	if jumpEnabled then humanoid.JumpPower = jumpPower end
	if noclipEnabled then startNoclip() end
	if nightVisionEnabled then task.wait(0.8) startNightVision() end
	if clickTPEnabled then task.wait(0.6) startClickTP() end
	if fastModeEnabled then task.wait(0.3) startFastMode() end
end)
