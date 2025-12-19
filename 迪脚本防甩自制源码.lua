local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local enabled = true

-- 创建主框架
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CollisionControlUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- 主容器（采用卡片式设计）
local mainContainer = Instance.new("Frame")
mainContainer.Size = UDim2.new(0, 350, 0, 280)  -- 更大的尺寸
mainContainer.Position = UDim2.new(0.5, -175, 0.5, -140)
mainContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainContainer.BackgroundTransparency = 0.05
mainContainer.BorderSizePixel = 0
mainContainer.ClipsDescendants = true
mainContainer.Parent = screenGui

-- 添加圆角和阴影
local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(0, 20)
containerCorner.Parent = mainContainer

local containerShadow = Instance.new("UIStroke")
containerShadow.Color = Color3.fromRGB(0, 0, 0)
containerShadow.Thickness = 3
containerShadow.Transparency = 0.8
containerShadow.Parent = mainContainer

-- 内阴影效果
local innerGlow = Instance.new("Frame")
innerGlow.Size = UDim2.new(1, 0, 1, 0)
innerGlow.BackgroundTransparency = 1
innerGlow.Parent = mainContainer

local innerStroke = Instance.new("UIStroke")
innerStroke.Color = Color3.fromRGB(255, 255, 255)
innerStroke.Thickness = 1
innerStroke.Transparency = 0.9
innerStroke.Parent = innerGlow

-- ==================== 顶部控制栏 ====================
local topControlBar = Instance.new("Frame")
topControlBar.Size = UDim2.new(1, 0, 0, 70)  -- 更高的控制栏
topControlBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
topControlBar.BorderSizePixel = 0
topControlBar.Parent = mainContainer

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 20)
topBarCorner.Parent = topControlBar

-- 标题
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.6, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🚀 碰撞控制系统"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Position = UDim2.new(0.05, 0, 0, 0)
titleLabel.Parent = topControlBar

-- ==================== 大型窗口切换按钮 ====================
local windowToggleButton = Instance.new("TextButton")
windowToggleButton.Size = UDim2.new(0.35, 0, 0.6, 0)  -- 非常大的按钮
windowToggleButton.Position = UDim2.new(0.6, 0, 0.2, 0)
windowToggleButton.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
windowToggleButton.Text = "📱 展开"
windowToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
windowToggleButton.TextSize = 18
windowToggleButton.Font = Enum.Font.GothamBold
windowToggleButton.Parent = topControlBar

local windowButtonCorner = Instance.new("UICorner")
windowButtonCorner.CornerRadius = UDim.new(0, 12)
windowButtonCorner.Parent = windowToggleButton

local windowButtonStroke = Instance.new("UIStroke")
windowButtonStroke.Color = Color3.fromRGB(255, 255, 255)
windowButtonStroke.Thickness = 2
windowButtonStroke.Transparency = 0.3
windowButtonStroke.Parent = windowToggleButton

-- ==================== 主内容区域 ====================
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -40, 1, -100)
contentArea.Position = UDim2.new(0, 20, 0, 80)
contentArea.BackgroundTransparency = 1
contentArea.Parent = mainContainer

-- ==================== 脚本总开关区域（重新设计） ====================
local scriptControlCard = Instance.new("Frame")
scriptControlCard.Size = UDim2.new(1, 0, 0, 90)  -- 更大的卡片
scriptControlCard.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
scriptControlCard.BorderSizePixel = 0
scriptControlCard.Parent = contentArea

local scriptCardCorner = Instance.new("UICorner")
scriptCardCorner.CornerRadius = UDim.new(0, 15)
scriptCardCorner.Parent = scriptControlCard

local scriptCardStroke = Instance.new("UIStroke")
scriptCardStroke.Color = Color3.fromRGB(80, 80, 90)
scriptCardStroke.Thickness = 2
scriptCardStroke.Parent = scriptControlCard

-- 脚本图标和标题
local scriptIcon = Instance.new("TextLabel")
scriptIcon.Size = UDim2.new(0, 50, 0, 50)
scriptIcon.Position = UDim2.new(0.05, 0, 0.2, 0)
scriptIcon.BackgroundTransparency = 1
scriptIcon.Text = "⚡"
scriptIcon.TextColor3 = Color3.fromRGB(255, 255, 100)
scriptIcon.TextSize = 32
scriptIcon.Font = Enum.Font.GothamBold
scriptIcon.Parent = scriptControlCard

local scriptTitle = Instance.new("TextLabel")
scriptTitle.Size = UDim2.new(0.4, 0, 0, 30)
scriptTitle.Position = UDim2.new(0.2, 0, 0.1, 0)
scriptTitle.BackgroundTransparency = 1
scriptTitle.Text = "脚本总开关"
scriptTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
scriptTitle.TextSize = 20
scriptTitle.Font = Enum.Font.GothamBold
scriptTitle.TextXAlignment = Enum.TextXAlignment.Left
scriptTitle.Parent = scriptControlCard

local scriptStatusLabel = Instance.new("TextLabel")
scriptStatusLabel.Size = UDim2.new(0.4, 0, 0, 25)
scriptStatusLabel.Position = UDim2.new(0.2, 0, 0.55, 0)
scriptStatusLabel.BackgroundTransparency = 1
scriptStatusLabel.Text = "状态: 运行中"
scriptStatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
scriptStatusLabel.TextSize = 16
scriptStatusLabel.Font = Enum.Font.Gotham
scriptStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
scriptStatusLabel.Parent = scriptControlCard

-- 脚本开关按钮（大型滑动开关）
local scriptSwitchContainer = Instance.new("Frame")
scriptSwitchContainer.Size = UDim2.new(0.3, 0, 0.6, 0)
scriptSwitchContainer.Position = UDim2.new(0.65, 0, 0.2, 0)
scriptSwitchContainer.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
scriptSwitchContainer.BackgroundTransparency = 0
scriptSwitchContainer.Parent = scriptControlCard

local scriptSwitchCorner = Instance.new("UICorner")
scriptSwitchCorner.CornerRadius = UDim.new(1, 0)
scriptSwitchCorner.Parent = scriptSwitchContainer

-- 脚本开关滑块（大型）
local scriptSwitchKnob = Instance.new("Frame")
scriptSwitchKnob.Size = UDim2.new(0.45, 0, 0.8, 0)
scriptSwitchKnob.Position = UDim2.new(0.5, 0, 0.1, 0)
scriptSwitchKnob.BackgroundColor3 = Color3.fromRGB(0, 230, 120)
scriptSwitchKnob.BackgroundTransparency = 0
scriptSwitchKnob.Parent = scriptSwitchContainer

local scriptKnobCorner = Instance.new("UICorner")
scriptKnobCorner.CornerRadius = UDim.new(1, 0)
scriptKnobCorner.Parent = scriptSwitchKnob

local scriptKnobIcon = Instance.new("TextLabel")
scriptKnobIcon.Size = UDim2.new(1, 0, 1, 0)
scriptKnobIcon.BackgroundTransparency = 1
scriptKnobIcon.Text = "✓"
scriptKnobIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
scriptKnobIcon.TextSize = 20
scriptKnobIcon.Font = Enum.Font.GothamBold
scriptKnobIcon.Parent = scriptSwitchKnob

-- ==================== 碰撞控制区域（重新设计） ====================
local collisionControlCard = Instance.new("Frame")
collisionControlCard.Size = UDim2.new(1, 0, 0, 90)
collisionControlCard.Position = UDim2.new(0, 0, 0, 110)  -- 放在脚本卡片下面
collisionControlCard.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
collisionControlCard.BorderSizePixel = 0
collisionControlCard.Parent = contentArea

local collisionCardCorner = Instance.new("UICorner")
collisionCardCorner.CornerRadius = UDim.new(0, 15)
collisionCardCorner.Parent = collisionControlCard

local collisionCardStroke = Instance.new("UIStroke")
collisionCardStroke.Color = Color3.fromRGB(80, 80, 90)
collisionCardStroke.Thickness = 2
collisionCardStroke.Parent = collisionControlCard

-- 碰撞图标和标题
local collisionIcon = Instance.new("TextLabel")
collisionIcon.Size = UDim2.new(0, 50, 0, 50)
collisionIcon.Position = UDim2.new(0.05, 0, 0.2, 0)
collisionIcon.BackgroundTransparency = 1
collisionIcon.Text = "🛡️"
collisionIcon.TextColor3 = Color3.fromRGB(100, 200, 255)
collisionIcon.TextSize = 32
collisionIcon.Font = Enum.Font.GothamBold
collisionIcon.Parent = collisionControlCard

local collisionTitle = Instance.new("TextLabel")
collisionTitle.Size = UDim2.new(0.4, 0, 0, 30)
collisionTitle.Position = UDim2.new(0.2, 0, 0.1, 0)
collisionTitle.BackgroundTransparency = 1
collisionTitle.Text = "碰撞移除"
collisionTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
collisionTitle.TextSize = 20
collisionTitle.Font = Enum.Font.GothamBold
collisionTitle.TextXAlignment = Enum.TextXAlignment.Left
collisionTitle.Parent = collisionControlCard

local collisionStatusLabel = Instance.new("TextLabel")
collisionStatusLabel.Size = UDim2.new(0.4, 0, 0, 25)
collisionStatusLabel.Position = UDim2.new(0.2, 0, 0.55, 0)
collisionStatusLabel.BackgroundTransparency = 1
collisionStatusLabel.Text = "状态: 已启用"
collisionStatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
collisionStatusLabel.TextSize = 16
collisionStatusLabel.Font = Enum.Font.Gotham
collisionStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
collisionStatusLabel.Parent = collisionControlCard

-- 碰撞开关按钮（大型滑动开关）
local collisionSwitchContainer = Instance.new("Frame")
collisionSwitchContainer.Size = UDim2.new(0.3, 0, 0.6, 0)
collisionSwitchContainer.Position = UDim2.new(0.65, 0, 0.2, 0)
collisionSwitchContainer.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
collisionSwitchContainer.BackgroundTransparency = 0
collisionSwitchContainer.Parent = collisionControlCard

local collisionSwitchCorner = Instance.new("UICorner")
collisionSwitchCorner.CornerRadius = UDim.new(1, 0)
collisionSwitchCorner.Parent = collisionSwitchContainer

-- 碰撞开关滑块（大型）
local collisionSwitchKnob = Instance.new("Frame")
collisionSwitchKnob.Size = UDim2.new(0.45, 0, 0.8, 0)
collisionSwitchKnob.Position = UDim2.new(0.5, 0, 0.1, 0)
collisionSwitchKnob.BackgroundColor3 = Color3.fromRGB(0, 230, 120)
collisionSwitchKnob.BackgroundTransparency = 0
collisionSwitchKnob.Parent = collisionSwitchContainer

local collisionKnobCorner = Instance.new("UICorner")
collisionKnobCorner.CornerRadius = UDim.new(1, 0)
collisionKnobCorner.Parent = collisionSwitchKnob

local collisionKnobIcon = Instance.new("TextLabel")
collisionKnobIcon.Size = UDim2.new(1, 0, 1, 0)
collisionKnobIcon.BackgroundTransparency = 1
collisionKnobIcon.Text = "✓"
collisionKnobIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
collisionKnobIcon.TextSize = 20
collisionKnobIcon.Font = Enum.Font.GothamBold
collisionKnobIcon.Parent = collisionSwitchKnob

-- ==================== 底部状态栏 ====================
local bottomStatusBar = Instance.new("Frame")
bottomStatusBar.Size = UDim2.new(1, 0, 0, 40)
bottomStatusBar.Position = UDim2.new(0, 0, 1, -40)
bottomStatusBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
bottomStatusBar.BorderSizePixel = 0
bottomStatusBar.Parent = mainContainer

local bottomBarCorner = Instance.new("UICorner")
bottomBarCorner.CornerRadius = UDim.new(0, 20)
bottomBarCorner.Parent = bottomStatusBar

-- 状态指示灯（大型）
local statusIndicator = Instance.new("Frame")
statusIndicator.Size = UDim2.new(0, 20, 0, 20)
statusIndicator.Position = UDim2.new(0.05, 0, 0.5, -10)
statusIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
statusIndicator.BorderSizePixel = 0
statusIndicator.Parent = bottomStatusBar

local statusIndicatorCorner = Instance.new("UICorner")
statusIndicatorCorner.CornerRadius = UDim.new(1, 0)
statusIndicatorCorner.Parent = statusIndicator

-- 状态文本
local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(0.8, 0, 1, 0)
statusText.Position = UDim2.new(0.15, 0, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "✅ 系统正常运行中"
statusText.TextColor3 = Color3.fromRGB(200, 200, 220)
statusText.TextSize = 16
statusText.Font = Enum.Font.Gotham
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = bottomStatusBar

-- ==================== 控制变量 ====================
local scriptEnabled = true
local isWindowMinimized = false

-- ==================== 更新函数 ====================
-- 更新窗口按钮
local function updateWindowButton()
    if not isWindowMinimized then
        windowToggleButton.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
        windowToggleButton.Text = "📱 最小化"
        
        -- 展开窗口
        TweenService:Create(mainContainer, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 350, 0, 280)
        }):Play()
        TweenService:Create(contentArea, TweenInfo.new(0.3), {
            Size = UDim2.new(1, -40, 1, -100)
        }):Play()
        
        print("窗口状态: 展开")
    else
        windowToggleButton.BackgroundColor3 = Color3.fromRGB(150, 150, 180)
        windowToggleButton.Text = "📱 展开"
        
        -- 最小化窗口
        TweenService:Create(mainContainer, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 350, 0, 70)
        }):Play()
        TweenService:Create(contentArea, TweenInfo.new(0.3), {
            Size = UDim2.new(1, -40, 0, 0)
        }):Play()
        
        print("窗口状态: 最小化")
    end
end

-- 更新脚本开关
local function updateScriptSwitch()
    if scriptEnabled then
        -- 开启状态
        TweenService:Create(scriptSwitchKnob, TweenInfo.new(0.2), {
            Position = UDim2.new(0.5, 0, 0.1, 0),
            BackgroundColor3 = Color3.fromRGB(0, 230, 120)
        }):Play()
        scriptKnobIcon.Text = "✓"
        scriptStatusLabel.Text = "状态: 运行中"
        scriptStatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        
        collisionControlCard.Visible = true
        collisionControlCard.BackgroundTransparency = 0
        statusText.Text = "✅ 系统正常运行中"
        statusIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        
        print("脚本总开关: 开启")
    else
        -- 关闭状态
        TweenService:Create(scriptSwitchKnob, TweenInfo.new(0.2), {
            Position = UDim2.new(0.05, 0, 0.1, 0),
            BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        }):Play()
        scriptKnobIcon.Text = "✗"
        scriptStatusLabel.Text = "状态: 已停止"
        scriptStatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        
        collisionControlCard.Visible = false
        statusText.Text = "⛔ 系统已停止"
        statusIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        
        print("脚本总开关: 关闭")
    end
end

-- 更新碰撞开关
local function updateCollisionSwitch()
    if enabled then
        -- 开启状态
        TweenService:Create(collisionSwitchKnob, TweenInfo.new(0.2), {
            Position = UDim2.new(0.5, 0, 0.1, 0),
            BackgroundColor3 = Color3.fromRGB(0, 230, 120)
        }):Play()
        collisionKnobIcon.Text = "✓"
        collisionStatusLabel.Text = "状态: 已启用"
        collisionStatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        
        print("碰撞移除: 开启")
    else
        -- 关闭状态
        TweenService:Create(collisionSwitchKnob, TweenInfo.new(0.2), {
            Position = UDim2.new(0.05, 0, 0.1, 0),
            BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        }):Play()
        collisionKnobIcon.Text = "✗"
        collisionStatusLabel.Text = "状态: 已禁用"
        collisionStatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        
        print("碰撞移除: 关闭")
    end
end

-- ==================== 点击处理函数 ====================
-- 切换窗口状态
local function toggleWindow()
    isWindowMinimized = not isWindowMinimized
    updateWindowButton()
end

-- 切换脚本状态
local function toggleScript()
    scriptEnabled = not scriptEnabled
    updateScriptSwitch()
    
    -- 如果关闭脚本，也自动关闭碰撞
    if not scriptEnabled then
        enabled = false
        updateCollisionSwitch()
    end
end

-- 切换碰撞状态
local function toggleCollision()
    if scriptEnabled then
        enabled = not enabled
        updateCollisionSwitch()
    else
        print("脚本已关闭，无法切换碰撞开关")
    end
end

-- ==================== 按钮交互效果 ====================
-- 为按钮添加交互效果
local function addButtonEffects(button, callback)
    local originalColor = button.BackgroundColor3
    local pressedColor = Color3.fromRGB(
        math.min(255, originalColor.R * 255 * 0.8),
        math.min(255, originalColor.G * 255 * 0.8),
        math.min(255, originalColor.B * 255 * 0.8)
    )
    
    local hoverColor = Color3.fromRGB(
        math.min(255, originalColor.R * 255 * 1.2),
        math.min(255, originalColor.G * 255 * 1.2),
        math.min(255, originalColor.B * 255 * 1.2)
    )
    
    -- PC鼠标效果
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = hoverColor
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = originalColor
        }):Play()
    end)
    
    -- 点击效果（PC和手机）
    button.MouseButton1Click:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = pressedColor
        }):Play()
        task.wait(0.1)
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = originalColor
        }):Play()
        callback()
    end)
    
    button.TouchTap:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = pressedColor
        }):Play()
        task.wait(0.1)
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = originalColor
        }):Play()
        callback()
    end)
end

-- 为滑动开关添加交互效果
local function addSwitchEffects(container, knob, callback)
    container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(container, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(80, 80, 90)
            }):Play()
        end
    end)
    
    container.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(container, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            }):Play()
            callback()
        end
    end)
    
    -- 滑块也可以点击
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(container, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(80, 80, 90)
            }):Play()
        end
    end)
    
    knob.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(container, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            }):Play()
            callback()
        end
    end)
end

-- 应用交互效果
addButtonEffects(windowToggleButton, toggleWindow)
addSwitchEffects(scriptSwitchContainer, scriptSwitchKnob, toggleScript)
addSwitchEffects(collisionSwitchContainer, collisionSwitchKnob, toggleCollision)

-- ==================== 拖动功能 ====================
local dragging = false
local dragStart
local startPos

topControlBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainContainer.Position
        
        TweenService:Create(mainContainer, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.2
        }):Play()
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                     input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainContainer.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or 
                     input.UserInputType == Enum.UserInputType.Touch) then
        dragging = false
        TweenService:Create(mainContainer, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.05
        }):Play()
    end
end)

-- ==================== 状态指示灯动画 ====================
RunService.Heartbeat:Connect(function()
    if scriptEnabled and enabled then
        local pulse = math.sin(tick() * 5) * 0.3 + 0.7
        statusIndicator.BackgroundTransparency = 1 - pulse
    elseif scriptEnabled and not enabled then
        statusIndicator.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
        statusIndicator.BackgroundTransparency = 0.3
    end
end)

-- ==================== 初始化 ====================
updateWindowButton()
updateScriptSwitch()
updateCollisionSwitch()

-- ==================== 主循环（保持你的原逻辑） ====================
while true do
    task.wait(0.3)
    
    if scriptEnabled and enabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                for _, part in ipairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
        
        print("玩家碰撞已移除")
    end
end
