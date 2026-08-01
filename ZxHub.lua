if not game:IsLoaded() then
	game.Loaded:Wait()
end
local player = game.Players.LocalPlayer
repeat task.wait() until player:FindFirstChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local flyEnabled = false
local speedEnabled = false
local jumpEnabled = false
local noclipEnabled = false
local espEnabled = false
local freecamEnabled = false
local nightVisionEnabled = false
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
-- ================= MAIN WINDOW (Glassmorphism) =================
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 520, 0, 360)
frame.Position = UDim2.new(0.5, -260, 0.5, -180)
frame.BackgroundColor3 = Color3.fromRGB(18, 20, 22)
frame.BackgroundTransparency = 0.18
frame.Active = true
frame.Visible = true
frame.ClipsDescendants = true
local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0, 17)
local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Color = Color3.fromRGB(0, 220, 130)
frameStroke.Thickness = 1.2
frameStroke.Transparency = 0.35
local frameGrad = Instance.new("UIGradient", frame)
frameGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 32, 36)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 20, 24)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 16, 18))
})
frameGrad.Rotation = 125
local frameShadow = Instance.new("ImageLabel", frame)
frameShadow.Name = "SoftShadow"
frameShadow.BackgroundTransparency = 1
frameShadow.Image = "rbxassetid://6014261993"
frameShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
frameShadow.ImageTransparency = 0.72
frameShadow.ScaleType = Enum.ScaleType.Slice
frameShadow.SliceCenter = Rect.new(49, 49, 450, 450)
frameShadow.Size = UDim2.new(1, 40, 1, 40)
frameShadow.Position = UDim2.new(0, -20, 0, -16)
frameShadow.ZIndex = 0
-- ================= TOP BAR =================
local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, 42)
topBar.BackgroundColor3 = Color3.fromRGB(22, 24, 28)
topBar.BackgroundTransparency = 0.35
topBar.BorderSizePixel = 0
local topBarCorner = Instance.new("UICorner", topBar)
topBarCorner.CornerRadius = UDim.new(0, 17)
local topBarGrad = Instance.new("UIGradient", topBar)
topBarGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 34, 38)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 20, 24))
})
topBarGrad.Rotation = 90
local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "IDZ"
title.TextColor3 = Color3.fromRGB(0, 255, 140)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextTransparency = 0.05
-- ================= MINIMIZE BAR (top-center, always visible, draggable) =================
local minBar = Instance.new("TextButton", gui)
minBar.Name = "MinimizeBar"
minBar.Size = UDim2.new(0, 180, 0, 32)
minBar.Position = UDim2.new(0.5, -90, 0, 12)
minBar.BackgroundColor3 = Color3.fromRGB(18, 20, 22)
minBar.BackgroundTransparency = 0.15
minBar.Text = ""
minBar.AutoButtonColor = false
minBar.ZIndex = 50
local minBarCorner = Instance.new("UICorner", minBar)
minBarCorner.CornerRadius = UDim.new(0, 10)
local minBarStroke = Instance.new("UIStroke", minBar)
minBarStroke.Color = Color3.fromRGB(0, 220, 130)
minBarStroke.Thickness = 1.1
minBarStroke.Transparency = 0.4
local minBarGrad = Instance.new("UIGradient", minBar)
minBarGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 32, 36)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 18, 20))
})
minBarGrad.Rotation = 90
local minBarLabel = Instance.new("TextLabel", minBar)
minBarLabel.Size = UDim2.new(1, 0, 1, 0)
minBarLabel.BackgroundTransparency = 1
minBarLabel.Text = "▲  IDZ"
minBarLabel.TextColor3 = Color3.fromRGB(0, 255, 140)
minBarLabel.Font = Enum.Font.GothamBold
minBarLabel.TextSize = 13
minBarLabel.ZIndex = 51
local isMinimized = false
local frameOpenPos = frame.Position
local frameOpenSize = frame.Size
local tweenInfoFast = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local tweenInfoSoft = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local function setMinimized(state)
	isMinimized = state
	if state then
		minBarLabel.Text = "▼  IDZ"
		local t1 = TweenService:Create(frame, tweenInfoSoft, {
			Size = UDim2.new(0, 520, 0, 0),
			BackgroundTransparency = 1
		})
		t1:Play()
		t1.Completed:Connect(function()
			if isMinimized then
				frame.Visible = false
			end
		end)
		for _, child in ipairs(frame:GetDescendants()) do
			if child:IsA("GuiObject") and child ~= frameShadow then
				pcall(function()
					TweenService:Create(child, TweenInfo.new(0.18), {BackgroundTransparency = 1, TextTransparency = 1, ImageTransparency = 1}):Play()
				end)
			end
		end
	else
		minBarLabel.Text = "▲  IDZ"
		frame.Visible = true
		frame.Size = UDim2.new(0, 520, 0, 0)
		frame.BackgroundTransparency = 1
		local t2 = TweenService:Create(frame, tweenInfoSoft, {
			Size = frameOpenSize,
			BackgroundTransparency = 0.18
		})
		t2:Play()
		for _, child in ipairs(frame:GetDescendants()) do
			if child:IsA("GuiObject") and child ~= frameShadow then
				pcall(function()
					if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
						TweenService:Create(child, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
					elseif child:IsA("ImageLabel") or child:IsA("ImageButton") then
						TweenService:Create(child, TweenInfo.new(0.25), {ImageTransparency = 0}):Play()
					else
						TweenService:Create(child, TweenInfo.new(0.25), {BackgroundTransparency = child.BackgroundTransparency}):Play()
					end
				end)
			end
		end
	end
end
minBar.MouseButton1Click:Connect(function()
	setMinimized(not isMinimized)
end)
-- Hover effect for minBar
minBar.MouseEnter:Connect(function()
	TweenService:Create(minBar, TweenInfo.new(0.15), {BackgroundTransparency = 0.05}):Play()
	TweenService:Create(minBarStroke, TweenInfo.new(0.15), {Transparency = 0.15}):Play()
end)
minBar.MouseLeave:Connect(function()
	TweenService:Create(minBar, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
	TweenService:Create(minBarStroke, TweenInfo.new(0.15), {Transparency = 0.4}):Play()
end)
-- Drag for minimize bar
do
	local drag = false
	local start, pos
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
	UIS.InputEnded:Connect(function()
		drag = false
	end)
end
-- ================= TAB BUTTONS =================
local tabContainer = Instance.new("Frame", frame)
tabContainer.Size = UDim2.new(1, -24, 0, 34)
tabContainer.Position = UDim2.new(0, 12, 0, 48)
tabContainer.BackgroundTransparency = 1
local function styleTab(btn, active)
	if active then
		btn.BackgroundColor3 = Color3.fromRGB(0, 200, 120)
		btn.TextColor3 = Color3.fromRGB(10, 12, 14)
		btn.BackgroundTransparency = 0.05
	else
		btn.BackgroundColor3 = Color3.fromRGB(35, 38, 42)
		btn.TextColor3 = Color3.fromRGB(200, 205, 210)
		btn.BackgroundTransparency = 0.25
	end
end
local tab1Btn = Instance.new("TextButton", tabContainer)
tab1Btn.Size = UDim2.new(0, 110, 0, 30)
tab1Btn.Position = UDim2.new(0, 0, 0, 2)
tab1Btn.Text = "หน้า 1"
tab1Btn.Font = Enum.Font.GothamBold
tab1Btn.TextSize = 13
tab1Btn.AutoButtonColor = false
Instance.new("UICorner", tab1Btn).CornerRadius = UDim.new(0, 9)
local tab1Stroke = Instance.new("UIStroke", tab1Btn)
tab1Stroke.Thickness = 1
tab1Stroke.Color = Color3.fromRGB(0, 220, 130)
tab1Stroke.Transparency = 0.7
styleTab(tab1Btn, true)
local tab2Btn = Instance.new("TextButton", tabContainer)
tab2Btn.Size = UDim2.new(0, 110, 0, 30)
tab2Btn.Position = UDim2.new(0, 118, 0, 2)
tab2Btn.Text = "หน้า 2"
tab2Btn.Font = Enum.Font.GothamBold
tab2Btn.TextSize = 13
tab2Btn.AutoButtonColor = false
Instance.new("UICorner", tab2Btn).CornerRadius = UDim.new(0, 9)
local tab2Stroke = Instance.new("UIStroke", tab2Btn)
tab2Stroke.Thickness = 1
tab2Stroke.Color = Color3.fromRGB(0, 220, 130)
tab2Stroke.Transparency = 0.85
styleTab(tab2Btn, false)
local tab3Btn = Instance.new("TextButton", tabContainer)
tab3Btn.Size = UDim2.new(0, 110, 0, 30)
tab3Btn.Position = UDim2.new(0, 236, 0, 2)
tab3Btn.Text = "หน้า 3"
tab3Btn.Font = Enum.Font.GothamBold
tab3Btn.TextSize = 13
tab3Btn.AutoButtonColor = false
Instance.new("UICorner", tab3Btn).CornerRadius = UDim.new(0, 9)
local tab3Stroke = Instance.new("UIStroke", tab3Btn)
tab3Stroke.Thickness = 1
tab3Stroke.Color = Color3.fromRGB(0, 220, 130)
tab3Stroke.Transparency = 0.85
styleTab(tab3Btn, false)
local function addTabHover(btn, stroke)
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.08}):Play()
		TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.4}):Play()
	end)
	btn.MouseLeave:Connect(function()
		local isActive = (btn.BackgroundColor3 == Color3.fromRGB(0, 200, 120))
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = isActive and 0.05 or 0.25}):Play()
		TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = isActive and 0.55 or 0.85}):Play()
	end)
end
addTabHover(tab1Btn, tab1Stroke)
addTabHover(tab2Btn, tab2Stroke)
addTabHover(tab3Btn, tab3Stroke)
-- ================= PAGE CONTAINERS =================
local page1 = Instance.new("ScrollingFrame", frame)
page1.Size = UDim2.new(1, -8, 1, -92)
page1.Position = UDim2.new(0, 4, 0, 88)
page1.BackgroundTransparency = 1
page1.Visible = true
page1.ScrollBarThickness = 3
page1.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 120)
page1.ScrollBarImageTransparency = 0.4
page1.CanvasSize = UDim2.new(0, 0, 0, 450)
page1.BorderSizePixel = 0
local page1Pad = Instance.new("UIPadding", page1)
page1Pad.PaddingTop = UDim.new(0, 6)
page1Pad.PaddingBottom = UDim.new(0, 12)
page1Pad.PaddingLeft = UDim.new(0, 6)
page1Pad.PaddingRight = UDim.new(0, 6)
local page2 = Instance.new("ScrollingFrame", frame)
page2.Size = UDim2.new(1, -8, 1, -92)
page2.Position = UDim2.new(0, 4, 0, 88)
page2.BackgroundTransparency = 1
page2.Visible = false
page2.ScrollBarThickness = 3
page2.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 120)
page2.ScrollBarImageTransparency = 0.4
page2.CanvasSize = UDim2.new(0, 0, 0, 600)
page2.BorderSizePixel = 0
local page2Pad = Instance.new("UIPadding", page2)
page2Pad.PaddingTop = UDim.new(0, 6)
page2Pad.PaddingBottom = UDim.new(0, 12)
page2Pad.PaddingLeft = UDim.new(0, 6)
page2Pad.PaddingRight = UDim.new(0, 6)
local page3 = Instance.new("ScrollingFrame", frame)
page3.Size = UDim2.new(1, -8, 1, -92)
page3.Position = UDim2.new(0, 4, 0, 88)
page3.BackgroundTransparency = 1
page3.Visible = false
page3.ScrollBarThickness = 3
page3.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 120)
page3.ScrollBarImageTransparency = 0.4
page3.CanvasSize = UDim2.new(0, 0, 0, 600)
page3.BorderSizePixel = 0
local page3Pad = Instance.new("UIPadding", page3)
page3Pad.PaddingTop = UDim.new(0, 6)
page3Pad.PaddingBottom = UDim.new(0, 12)
page3Pad.PaddingLeft = UDim.new(0, 6)
page3Pad.PaddingRight = UDim.new(0, 6)
local function switchTab(pg)
	local function fadePage(p, show)
		if show then
			p.Visible = true
			p.CanvasPosition = Vector2.new(0, 0)
		else
			p.Visible = false
		end
	end
	if pg == 1 then
		fadePage(page1, true)
		fadePage(page2, false)
		fadePage(page3, false)
		styleTab(tab1Btn, true)
		styleTab(tab2Btn, false)
		styleTab(tab3Btn, false)
		tab1Stroke.Transparency = 0.55
		tab2Stroke.Transparency = 0.85
		tab3Stroke.Transparency = 0.85
	elseif pg == 2 then
		fadePage(page1, false)
		fadePage(page2, true)
		fadePage(page3, false)
		styleTab(tab1Btn, false)
		styleTab(tab2Btn, true)
		styleTab(tab3Btn, false)
		tab1Stroke.Transparency = 0.85
		tab2Stroke.Transparency = 0.55
		tab3Stroke.Transparency = 0.85
	else
		fadePage(page1, false)
		fadePage(page2, false)
		fadePage(page3, true)
		styleTab(tab1Btn, false)
		styleTab(tab2Btn, false)
		styleTab(tab3Btn, true)
		tab1Stroke.Transparency = 0.85
		tab2Stroke.Transparency = 0.85
		tab3Stroke.Transparency = 0.55
	end
end
tab1Btn.MouseButton1Click:Connect(function() switchTab(1) end)
tab2Btn.MouseButton1Click:Connect(function() switchTab(2) end)
tab3Btn.MouseButton1Click:Connect(function() switchTab(3) end)
-- ================= MOBILE CONTROLS (redesigned rounded rect) =================
local function styleMobileBtn(btn)
	btn.BackgroundColor3 = Color3.fromRGB(22, 24, 28)
	btn.BackgroundTransparency = 0.12
	btn.TextColor3 = Color3.fromRGB(0, 255, 140)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 22
	btn.AutoButtonColor = false
	local c = Instance.new("UICorner", btn)
	c.CornerRadius = UDim.new(0, 12)
	local s = Instance.new("UIStroke", btn)
	s.Color = Color3.fromRGB(0, 200, 120)
	s.Thickness = 1.1
	s.Transparency = 0.45
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundTransparency = 0.02, Size = btn.Size + UDim2.new(0, 4, 0, 4)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundTransparency = 0.12, Size = UDim2.new(0, 58, 0, 58)}):Play()
	end)
end
local upBtn = Instance.new("TextButton", gui)
upBtn.Size = UDim2.new(0, 58, 0, 58)
upBtn.Position = UDim2.new(1, -78, 0.68, 0)
upBtn.Text = "↑"
upBtn.Visible = false
styleMobileBtn(upBtn)
local downBtn = Instance.new("TextButton", gui)
downBtn.Size = UDim2.new(0, 58, 0, 58)
downBtn.Position = UDim2.new(1, -78, 0.78, 0)
downBtn.Text = "↓"
downBtn.Visible = false
styleMobileBtn(downBtn)
local moveForwardBtn = Instance.new("TextButton", gui)
moveForwardBtn.Size = UDim2.new(0, 58, 0, 58)
moveForwardBtn.Position = UDim2.new(0, 78, 0.68, 0)
moveForwardBtn.Text = "▲"
moveForwardBtn.Visible = false
styleMobileBtn(moveForwardBtn)
local moveBackBtn = Instance.new("TextButton", gui)
moveBackBtn.Size = UDim2.new(0, 58, 0, 58)
moveBackBtn.Position = UDim2.new(0, 78, 0.78, 0)
moveBackBtn.Text = "▼"
moveBackBtn.Visible = false
styleMobileBtn(moveBackBtn)
local moveLeftBtn = Instance.new("TextButton", gui)
moveLeftBtn.Size = UDim2.new(0, 58, 0, 58)
moveLeftBtn.Position = UDim2.new(0, 14, 0.73, 0)
moveLeftBtn.Text = "◄"
moveLeftBtn.Visible = false
styleMobileBtn(moveLeftBtn)
local moveRightBtn = Instance.new("TextButton", gui)
moveRightBtn.Size = UDim2.new(0, 58, 0, 58)
moveRightBtn.Position = UDim2.new(0, 142, 0.73, 0)
moveRightBtn.Text = "►"
moveRightBtn.Visible = false
styleMobileBtn(moveRightBtn)
moveForwardBtn.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then moveForward = true end
end)
moveForwardBtn.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then moveForward = false end
end)
moveBackBtn.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then moveBack = true end
end)
moveBackBtn.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then moveBack = false end
end)
moveLeftBtn.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then moveLeft = true end
end)
moveLeftBtn.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then moveLeft = false end
end)
moveRightBtn.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then moveRight = true end
end)
moveRightBtn.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then moveRight = false end
end)
upBtn.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then up = true end
end)
upBtn.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then up = false end
end)
downBtn.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then down = true end
end)
downBtn.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then down = false end
end)
local function dragify(target, handle)
	local drag = false
	local start, pos
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
dragify(frame, topBar)
-- Opening animation
frame.BackgroundTransparency = 1
frame.Size = UDim2.new(0, 520, 0, 0)
task.defer(function()
	local openTween = TweenService:Create(frame, TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, 520, 0, 360),
		BackgroundTransparency = 0.18
	})
	openTween:Play()
end)
-- ================= FREECAM =================
local freecamPart
local freecamConn
local function setMoveButtonsVisible(val)
	moveForwardBtn.Visible = val
	moveBackBtn.Visible = val
	moveLeftBtn.Visible = val
	moveRightBtn.Visible = val
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
		local moveDir = Vector3.new(0,0,0)
		local cf = cam.CFrame
		if UIS:IsKeyDown(Enum.KeyCode.W) or moveForward then moveDir += cf.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) or moveBack then moveDir -= cf.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) or moveLeft then moveDir -= cf.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) or moveRight then moveDir += cf.RightVector end
		if up then moveDir += Vector3.new(0,1,0) end
		if down then moveDir -= Vector3.new(0,1,0) end
		if moveDir.Magnitude > 0 then
			freecamPart.CFrame = freecamPart.CFrame + (moveDir.Unit * freecamSpeed)
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
-- ================= FLY =================
local flyConn
local flyBV, flyBG
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
		if hum2 then
			local md = hum2.MoveDirection
			if md.Magnitude > 0.1 then
				dir += Vector3.new(md.X, 0, md.Z)
			end
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
-- ================= NOCLIP =================
local noclipConn
local function startNoclip()
	noclipConn = RunService.Stepped:Connect(function()
		local char = player.Character
		if not char then return end
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end)
end
local function stopNoclip()
	if noclipConn then noclipConn:Disconnect() noclipConn = nil end
	local char = player.Character
	if char then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = true end
		end
	end
end
-- ================= ESP (Real-time + proper cleanup) =================
local espObjects = {}
local espConnections = {}

local function clearESPFor(target)
	if espObjects[target] then
		for _, obj in ipairs(espObjects[target]) do
			pcall(function() obj:Destroy() end)
		end
		espObjects[target] = nil
	end
	if espConnections[target] then
		for _, conn in ipairs(espConnections[target]) do
			pcall(function() conn:Disconnect() end)
		end
		espConnections[target] = nil
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
		hl.FillColor = Color3.fromRGB(255, 255, 255)
		hl.OutlineColor = Color3.fromRGB(0, 255, 140)
		hl.FillTransparency = 0.75
		hl.OutlineTransparency = 0
		hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		hl.Parent = gui

		local bb = Instance.new("BillboardGui")
		bb.Adornee = root
		bb.Size = UDim2.new(0, 120, 0, 28)
		bb.StudsOffset = Vector3.new(0, 3.2, 0)
		bb.AlwaysOnTop = true
		bb.Parent = gui

		local nameLabel = Instance.new("TextLabel", bb)
		nameLabel.Size = UDim2.new(1, 0, 1, 0)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = target.Name
		nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.TextSize = 14
		nameLabel.TextStrokeTransparency = 0.3
		nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

		espObjects[target] = {hl, bb}

		local conns = {}
		if hum then
			table.insert(conns, hum.Died:Connect(function()
				clearESPFor(target)
			end))
		end
		table.insert(conns, char.AncestryChanged:Connect(function(_, parent)
			if not parent then
				clearESPFor(target)
			end
		end))
		espConnections[target] = conns
	end

	if target.Character then
		createVisuals(target.Character)
	end

	local charConn = target.CharacterAdded:Connect(function(char)
		task.wait(0.35)
		if espEnabled then
			createVisuals(char)
		end
	end)
	local remConn = target.CharacterRemoving:Connect(function()
		clearESPFor(target)
	end)

	if not espConnections[target] then
		espConnections[target] = {}
	end
	table.insert(espConnections[target], charConn)
	table.insert(espConnections[target], remConn)
end

local function removeESP(target)
	clearESPFor(target)
end

local playerAddedConn
local function startESP()
	for _, p in ipairs(game.Players:GetPlayers()) do
		addESP(p)
	end
	if playerAddedConn then playerAddedConn:Disconnect() end
	playerAddedConn = game.Players.PlayerAdded:Connect(function(p)
		if espEnabled then
			addESP(p)
		end
	end)
	game.Players.PlayerRemoving:Connect(function(p)
		clearESPFor(p)
	end)
end

local function stopESP()
	for _, p in ipairs(game.Players:GetPlayers()) do
		clearESPFor(p)
	end
	if playerAddedConn then
		playerAddedConn:Disconnect()
		playerAddedConn = nil
	end
end

-- ================= NIGHT VISION (true full visibility) =================
local nightVisionLight
local nightVisionConn
local savedLighting = {}

local function startNightVision()
	local Lighting = game:GetService("Lighting")
	-- Save current values
	savedLighting.Ambient = Lighting.Ambient
	savedLighting.OutdoorAmbient = Lighting.OutdoorAmbient
	savedLighting.Brightness = Lighting.Brightness
	savedLighting.FogEnd = Lighting.FogEnd
	savedLighting.FogStart = Lighting.FogStart
	savedLighting.ClockTime = Lighting.ClockTime
	savedLighting.GlobalShadows = Lighting.GlobalShadows

	local function forceBright()
		Lighting.Ambient = Color3.fromRGB(255, 255, 255)
		Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
		Lighting.Brightness = 3
		Lighting.FogEnd = 100000
		Lighting.FogStart = 0
		Lighting.GlobalShadows = false
	end
	forceBright()

	-- Keep forcing every frame so other scripts can't override
	if nightVisionConn then nightVisionConn:Disconnect() end
	nightVisionConn = RunService.RenderStepped:Connect(forceBright)

	local function attachLight(char)
		if nightVisionLight then
			pcall(function() nightVisionLight:Destroy() end)
			nightVisionLight = nil
		end
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if root then
			nightVisionLight = Instance.new("PointLight")
			nightVisionLight.Brightness = 8
			nightVisionLight.Range = 120
			nightVisionLight.Color = Color3.fromRGB(255, 255, 255)
			nightVisionLight.Shadows = false
			nightVisionLight.Parent = root
		end
	end
	attachLight(getChar())
end

local function stopNightVision()
	if nightVisionConn then
		nightVisionConn:Disconnect()
		nightVisionConn = nil
	end
	local Lighting = game:GetService("Lighting")
	if savedLighting.Ambient then Lighting.Ambient = savedLighting.Ambient end
	if savedLighting.OutdoorAmbient then Lighting.OutdoorAmbient = savedLighting.OutdoorAmbient end
	if savedLighting.Brightness then Lighting.Brightness = savedLighting.Brightness end
	if savedLighting.FogEnd then Lighting.FogEnd = savedLighting.FogEnd end
	if savedLighting.FogStart then Lighting.FogStart = savedLighting.FogStart end
	if savedLighting.ClockTime then Lighting.ClockTime = savedLighting.ClockTime end
	if savedLighting.GlobalShadows ~= nil then Lighting.GlobalShadows = savedLighting.GlobalShadows end
	if nightVisionLight then
		pcall(function() nightVisionLight:Destroy() end)
		nightVisionLight = nil
	end
	savedLighting = {}
end

-- ================= CREATE ROW (modern cards + sliding switch + improved slider) =================
local function createRow(parent, name, yPos, getVal, setVal, toggle, noSlider, maxOverride)
	local row = Instance.new("Frame", parent)
	row.Size = UDim2.new(1, -12, 0, 58)
	row.Position = UDim2.new(0, 6, 0, yPos)
	row.BackgroundColor3 = Color3.fromRGB(26, 28, 32)
	row.BackgroundTransparency = 0.22
	row.BorderSizePixel = 0
	local rowCorner = Instance.new("UICorner", row)
	rowCorner.CornerRadius = UDim.new(0, 12)
	local rowStroke = Instance.new("UIStroke", row)
	rowStroke.Color = Color3.fromRGB(0, 180, 110)
	rowStroke.Thickness = 1
	rowStroke.Transparency = 0.78
	local rowGrad = Instance.new("UIGradient", row)
	rowGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 36, 40)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 22, 26))
	})
	rowGrad.Rotation = 110
	local label = Instance.new("TextLabel", row)
	label.Size = UDim2.new(0, 110, 1, 0)
	label.Position = UDim2.new(0, 14, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.fromRGB(235, 240, 245)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	-- Modern sliding switch
	local switchTrack = Instance.new("Frame", row)
	switchTrack.Size = UDim2.new(0, 46, 0, 24)
	switchTrack.Position = UDim2.new(1, -60, 0.5, -12)
	switchTrack.BackgroundColor3 = Color3.fromRGB(55, 58, 64)
	switchTrack.BorderSizePixel = 0
	Instance.new("UICorner", switchTrack).CornerRadius = UDim.new(1, 0)
	local switchThumb = Instance.new("Frame", switchTrack)
	switchThumb.Size = UDim2.new(0, 20, 0, 20)
	switchThumb.Position = UDim2.new(0, 2, 0.5, -10)
	switchThumb.BackgroundColor3 = Color3.fromRGB(210, 215, 220)
	switchThumb.BorderSizePixel = 0
	Instance.new("UICorner", switchThumb).CornerRadius = UDim.new(1, 0)
	local switchHit = Instance.new("TextButton", switchTrack)
	switchHit.Size = UDim2.new(1, 0, 1, 0)
	switchHit.BackgroundTransparency = 1
	switchHit.Text = ""
	switchHit.ZIndex = 5
	local on = false
	local function setSwitchVisual(state)
		on = state
		if state then
			TweenService:Create(switchTrack, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(0, 190, 115)}):Play()
			TweenService:Create(switchThumb, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
				Position = UDim2.new(1, -22, 0.5, -10),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			}):Play()
		else
			TweenService:Create(switchTrack, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(55, 58, 64)}):Play()
			TweenService:Create(switchThumb, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
				Position = UDim2.new(0, 2, 0.5, -10),
				BackgroundColor3 = Color3.fromRGB(210, 215, 220)
			}):Play()
		end
	end
	switchHit.MouseButton1Click:Connect(function()
		setSwitchVisual(not on)
		toggle(on)
	end)
	if not noSlider then
		local maxVal = maxOverride or 500
		local sliderBg = Instance.new("Frame", row)
		sliderBg.Size = UDim2.new(0, 148, 0, 8)
		sliderBg.Position = UDim2.new(0, 128, 0.5, -4)
		sliderBg.BackgroundColor3 = Color3.fromRGB(45, 48, 54)
		sliderBg.BorderSizePixel = 0
		Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)
		local fill = Instance.new("Frame", sliderBg)
		fill.Size = UDim2.new(math.clamp(getVal() / maxVal, 0, 1), 0, 1, 0)
		fill.BackgroundColor3 = Color3.fromRGB(0, 220, 130)
		fill.BorderSizePixel = 0
		Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
		local thumb = Instance.new("Frame", sliderBg)
		thumb.Size = UDim2.new(0, 16, 0, 16)
		thumb.Position = UDim2.new(math.clamp(getVal() / maxVal, 0, 1), -8, 0.5, -8)
		thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		thumb.BorderSizePixel = 0
		thumb.ZIndex = 3
		Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)
		local thumbStroke = Instance.new("UIStroke", thumb)
		thumbStroke.Color = Color3.fromRGB(0, 200, 120)
		thumbStroke.Thickness = 1.5
		thumbStroke.Transparency = 0.3
		local valBox = Instance.new("TextBox", row)
		valBox.Size = UDim2.new(0, 44, 0, 24)
		valBox.Position = UDim2.new(0, 286, 0.5, -12)
		valBox.BackgroundColor3 = Color3.fromRGB(35, 38, 44)
		valBox.BackgroundTransparency = 0.15
		valBox.TextColor3 = Color3.fromRGB(0, 255, 140)
		valBox.Font = Enum.Font.GothamBold
		valBox.TextSize = 12
		valBox.Text = tostring(getVal())
		valBox.ClearTextOnFocus = true
		valBox.TextXAlignment = Enum.TextXAlignment.Center
		Instance.new("UICorner", valBox).CornerRadius = UDim.new(0, 7)
		local valStroke = Instance.new("UIStroke", valBox)
		valStroke.Color = Color3.fromRGB(0, 180, 110)
		valStroke.Thickness = 1
		valStroke.Transparency = 0.65
		local function applyVal(v)
			v = math.clamp(math.floor(v), 0, maxVal)
			local ratio = v / maxVal
			fill.Size = UDim2.new(ratio, 0, 1, 0)
			thumb.Position = UDim2.new(ratio, -8, 0.5, -8)
			valBox.Text = tostring(v)
			setVal(v)
		end
		valBox.FocusLost:Connect(function()
			local num = tonumber(valBox.Text)
			if num then applyVal(num) else valBox.Text = tostring(getVal()) end
		end)
		local dragging = false
		local function updateSlider(input)
			local rel = (input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X
			rel = math.clamp(rel, 0, 1)
			applyVal(math.floor(rel * maxVal))
		end
		sliderBg.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				updateSlider(i)
			end
		end)
		thumb.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				dragging = true
			end
		end)
		UIS.InputChanged:Connect(function(i) if dragging then updateSlider(i) end end)
		UIS.InputEnded:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)
	end
end
-- ================= PAGE 1 ROWS =================
createRow(page1, "FLY", 5,
	function() return flySpeed end,
	function(v) flySpeed = v end,
	function(s) flyEnabled = s if s then startFly() else stopFly() end end
)
createRow(page1, "SPEED", 72,
	function() return walkSpeed end,
	function(v) walkSpeed = v if speedEnabled then humanoid.WalkSpeed = v end end,
	function(s) speedEnabled = s humanoid.WalkSpeed = s and walkSpeed or 16 end
)
createRow(page1, "JUMP", 139,
	function() return jumpPower end,
	function(v) jumpPower = v if jumpEnabled then humanoid.JumpPower = v end end,
	function(s) jumpEnabled = s humanoid.JumpPower = s and jumpPower or 50 end
)
createRow(page1, "NOCLIP", 206,
	function() return 0 end,
	function() end,
	function(s) noclipEnabled = s if s then startNoclip() else stopNoclip() end end,
	true
)
-- ================= PAGE 2 ROWS =================
createRow(page2, "ESP", 5,
	function() return 0 end,
	function() end,
	function(s) espEnabled = s if s then startESP() else stopESP() end end,
	true
)
createRow(page2, "FREECAM", 72,
	function() return freecamSpeed end,
	function(v) freecamSpeed = v end,
	function(s) freecamEnabled = s if s then startFreecam() else stopFreecam() end end,
	false,
	5
)
-- ================= TELEPORT SYSTEM =================
local tpRow = Instance.new("Frame", page2)
tpRow.Size = UDim2.new(1, -12, 0, 52)
tpRow.Position = UDim2.new(0, 6, 0, 139)
tpRow.BackgroundColor3 = Color3.fromRGB(26, 28, 32)
tpRow.BackgroundTransparency = 0.22
Instance.new("UICorner", tpRow).CornerRadius = UDim.new(0, 12)
local tpStroke = Instance.new("UIStroke", tpRow)
tpStroke.Color = Color3.fromRGB(0, 180, 110)
tpStroke.Thickness = 1
tpStroke.Transparency = 0.78
local tpGrad = Instance.new("UIGradient", tpRow)
tpGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 36, 40)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 22, 26))
})
tpGrad.Rotation = 110
local tpLabel = Instance.new("TextLabel", tpRow)
tpLabel.Size = UDim2.new(1, -20, 1, 0)
tpLabel.Position = UDim2.new(0, 14, 0, 0)
tpLabel.BackgroundTransparency = 1
tpLabel.Text = "TELEPORT SYSTEM"
tpLabel.TextColor3 = Color3.fromRGB(235, 240, 245)
tpLabel.Font = Enum.Font.GothamBold
tpLabel.TextSize = 14
tpLabel.TextXAlignment = Enum.TextXAlignment.Left
local tpList = Instance.new("Frame", page2)
tpList.Size = UDim2.new(1, -12, 0, 200)
tpList.Position = UDim2.new(0, 6, 0, 200)
tpList.BackgroundColor3 = Color3.fromRGB(16, 18, 22)
tpList.BackgroundTransparency = 0.15
tpList.Visible = false
Instance.new("UICorner", tpList).CornerRadius = UDim.new(0, 12)
local tpListStroke = Instance.new("UIStroke", tpList)
tpListStroke.Color = Color3.fromRGB(0, 180, 110)
tpListStroke.Thickness = 1
tpListStroke.Transparency = 0.7
local listScroll = Instance.new("ScrollingFrame", tpList)
listScroll.Size = UDim2.new(1, -12, 1, -12)
listScroll.Position = UDim2.new(0, 6, 0, 6)
listScroll.BackgroundTransparency = 1
listScroll.ScrollBarThickness = 3
listScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 120)
listScroll.ScrollBarImageTransparency = 0.4
local listLayout = Instance.new("UIListLayout", listScroll)
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
local function updateTPList()
	for _, v in pairs(listScroll:GetChildren()) do
		if v:IsA("TextButton") then v:Destroy() end
	end
	for _, p in pairs(game.Players:GetPlayers()) do
		if p ~= player then
			local btn = Instance.new("TextButton", listScroll)
			btn.Size = UDim2.new(1, 0, 0, 32)
			btn.BackgroundColor3 = Color3.fromRGB(32, 36, 42)
			btn.BackgroundTransparency = 0.15
			btn.Text = p.Name
			btn.TextColor3 = Color3.fromRGB(230, 235, 240)
			btn.Font = Enum.Font.GothamBold
			btn.TextSize = 13
			btn.AutoButtonColor = false
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
			local bs = Instance.new("UIStroke", btn)
			bs.Color = Color3.fromRGB(0, 180, 110)
			bs.Thickness = 1
			bs.Transparency = 0.75
			btn.MouseEnter:Connect(function()
				TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundTransparency = 0.02}):Play()
				TweenService:Create(bs, TweenInfo.new(0.12), {Transparency = 0.35}):Play()
			end)
			btn.MouseLeave:Connect(function()
				TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundTransparency = 0.15}):Play()
				TweenService:Create(bs, TweenInfo.new(0.12), {Transparency = 0.75}):Play()
			end)
			btn.MouseButton1Click:Connect(function()
				if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
					getChar():SetPrimaryPartCFrame(p.Character.HumanoidRootPart.CFrame)
				end
			end)
		end
	end
	listScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 8)
end
local tpMainBtn = Instance.new("TextButton", tpRow)
tpMainBtn.Size = UDim2.new(1, 0, 1, 0)
tpMainBtn.BackgroundTransparency = 1
tpMainBtn.Text = ""
tpMainBtn.MouseButton1Click:Connect(function()
	tpList.Visible = not tpList.Visible
	if tpList.Visible then updateTPList() end
end)
-- ================= PAGE 3 ROWS =================
createRow(page3, "NIGHT VISION", 5,
	function() return 0 end,
	function() end,
	function(s)
		nightVisionEnabled = s
		if s then startNightVision() else stopNightVision() end
	end,
	true
)
-- ================= CHARACTER RELOAD =================
player.CharacterAdded:Connect(function()
	humanoid = getHumanoid()
	if flyEnabled then task.wait(0.5) startFly() end
	if speedEnabled then humanoid.WalkSpeed = walkSpeed end
	if jumpEnabled then humanoid.JumpPower = jumpPower end
	if noclipEnabled then startNoclip() end
	if nightVisionEnabled then
		task.wait(0.8)
		startNightVision()
	end
end)
