-- Cheat made by Eri --------------------------------------------------------------------------------------------

-- Settings -----------------------------------------------------------------------------------------------------
local toggleShowKey = Enum.KeyCode.P
local shutdownKey = Enum.KeyCode.U
local minESPsize = 2
local lazerWidth = 0.05
-----------------------------------------------------------------------------------------------------------------

-- Global Variables ---------------------------------------------------------------------------------------------
local plr = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("StarterGui")
-----------------------------------------------------------------------------------------------------------------

-- Setup --------------------------------------------------------------------------------------------------------
local GUI = Instance.new("ScreenGui")
local FreeMouse = Instance.new("TextButton")
local Main = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local UIGridLayout = Instance.new("UIGridLayout")
local UIPadding = Instance.new("UIPadding")
local UICorner = Instance.new("UICorner")

GUI.Name = "NoBigDeal"
GUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.DisplayOrder = 5
GUI.ResetOnSpawn = false

Main.Name = "Main"
Main.Parent = GUI
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 400, 0, 300)
Main.Visible = false
Main.AutomaticSize = Enum.AutomaticSize.Y

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(162, 162, 162))}
UIGradient.Rotation = 90
UIGradient.Parent = Main

UIGridLayout.Parent = Main
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellSize = UDim2.new(0, 70, 0, 70)
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

UIPadding.Parent = Main
UIPadding.PaddingBottom = UDim.new(0, 10)
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingRight = UDim.new(0, 10)
UIPadding.PaddingTop = UDim.new(0, 10)

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Main

FreeMouse.Name = "FreeMouse"
FreeMouse.Parent = GUI
FreeMouse.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FreeMouse.BackgroundTransparency = 1.000
FreeMouse.BorderColor3 = Color3.fromRGB(0, 0, 0)
FreeMouse.BorderSizePixel = 0
FreeMouse.Selectable = false
FreeMouse.Size = UDim2.new(1, 0, 1, 0)
FreeMouse.Visible = false
FreeMouse.Modal = true
FreeMouse.Font = Enum.Font.SourceSans
FreeMouse.Text = ""
FreeMouse.TextColor3 = Color3.fromRGB(0, 0, 0)
FreeMouse.TextSize = 14.000
FreeMouse.TextTransparency = 1.000

local function createButton(name)
	local newButton = Instance.new("TextButton", Main)
	newButton.Name = name
	newButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	newButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	newButton.BorderSizePixel = 0
	newButton.Size = UDim2.new(0, 200, 0, 50)
	newButton.Font = Enum.Font.SourceSans
	newButton.Text = name
	newButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	newButton.TextSize = 14
	newButton.TextScaled = true
	newButton.Modal = true

	local newUICorner = Instance.new("UICorner", newButton)
	newUICorner.CornerRadius = UDim.new(0, 10)

	local newUIPadding = Instance.new("UIPadding", newButton)
	newUIPadding.PaddingTop = UDim.new(0, 5)
	newUIPadding.PaddingBottom = UDim.new(0, 5)
	newUIPadding.PaddingLeft = UDim.new(0, 5)
	newUIPadding.PaddingRight = UDim.new(0, 5)

	return newButton
end
-----------------------------------------------------------------------------------------------------------------

-- Toggle Handler -----------------------------------------------------------------------------------------------
local uis = game:GetService("UserInputService")

uis.InputBegan:Connect(function(key)
	if key.KeyCode == toggleShowKey then
		Main.Visible = not Main.Visible
		FreeMouse.Visible = FreeMouse.Visible
	elseif key.KeyCode == shutdownKey then
		GUI:Destroy()
	end
end)
-----------------------------------------------------------------------------------------------------------------

-- Functions ----------------------------------------------------------------------------------------------------
local ESPCache = {}

local function CreateESP(basepart, color)
	local newEspGui = Instance.new("BillboardGui", basepart)
	newEspGui.AlwaysOnTop = true
	local espSize = basepart.Size.X > basepart.Size.Z and basepart.Size.X or basepart.Size.Z
	newEspGui.Size = UDim2.new(espSize, minESPsize, espSize, minESPsize)
	local espFrame = Instance.new("Frame", newEspGui)
	espFrame.Size = UDim2.new(1, 0, 1, 0)
	espFrame.BackgroundTransparency = 1
	local newStroke = Instance.new("UIStroke", espFrame)
	if color then
		newStroke.Color = color
	else
		newStroke.Color = basepart.Color
	end
	newStroke.Thickness = 1
	table.insert(ESPCache, newEspGui)
end

local function lookAtBoard(board)
	local connection
	local goin = true

	task.delay(5, function()
		goin = false
		if connection then
			connection:Disconnect()
		end
	end)

	connection = RunService.RenderStepped:Connect(function()
		if goin then
			camera.CFrame = CFrame.new(board.CFrame.Position + board.CFrame.LookVector * 10, board.CFrame.Position)
		end
	end)
end

local function toggleHearAllPlayers()
    if plr:FindFirstChild("HearAllPlayers") then
        plr:FindFirstChild("HearAllPlayers"):Destroy()
        return
    end
    local output = Instance.new("AudioDeviceOutput", plr)
    output.Name = "HearAllPlayers"
    output.Player = plr

    for i, p in game.Players:GetPlayers() do
        if p == plr then continue end
        local mic = p:FindFirstChildOfClass("AudioDeviceInput")
        if mic then
            newWire = Instance.new("Wire", output)
            newWire.SourceInstance = mic
            newWire.TargetInstance = output
            print(newWire)
        end
    end
end

local function addLaser(part)
    if not part or not part:IsA("BasePart") then
        return
    end

    local laserPart = Instance.new("Part")
    laserPart.Parent = workspace
    laserPart.Anchored = true
    laserPart.CanCollide = false
    laserPart.CastShadow = false
    laserPart.Material = Enum.Material.Neon
    laserPart.Color = Color3.fromRGB(255, 0, 0)
    laserPart.Size = Vector3.new(lazerWidth, lazerWidth, 1)

    local function updateLaser()
        if not part or not part.Parent then
            laserPart:Destroy()
            return
        end

        local startPos = part.Position + (part.CFrame.UpVector / 3.5)
        local direction = part.CFrame.LookVector * 5000
        local rayOrigin = startPos
        local rayDirection = direction

        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {part.Parent, workspace:WaitForChild(plr.Name)}
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.IgnoreWater = true

        local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

        if raycastResult then
            local hitPoint = raycastResult.Position
            local laserLength = (hitPoint - startPos).Magnitude

            laserPart.Size = Vector3.new(lazerWidth, lazerWidth, laserLength)
            laserPart.CFrame = CFrame.new(startPos, hitPoint) * CFrame.new(0, 0, -laserLength / 2)
        else
            local maxEnd = startPos + direction
            local laserLength = (maxEnd - startPos).Magnitude

            laserPart.Size = Vector3.new(lazerWidth, lazerWidth, laserLength)
            laserPart.CFrame = CFrame.new(startPos, maxEnd) * CFrame.new(0, 0, -laserLength / 2)
        end
    end

    game:GetService("RunService").Heartbeat:Connect(updateLaser)
end

-- Buttons ------------------------------------------------------------------------------------------------------
local CashESP = createButton("Cash ESP")
CashESP.Activated:Connect(function()
	for i, d in workspace:GetDescendants() do
		if string.lower(d.Name) == "cash" and d:IsA("Model") then
			local part = d:FindFirstChild("Root")
			if part:IsA("BasePart") then
				CreateESP(part, Color3.new(0, 1, 0))
			end
		end
	end
end)

local FakeCashESP = createButton("Fake Cash ESP")
FakeCashESP.Activated:Connect(function()
	for i, d in workspace:GetDescendants() do
		if string.lower(d.Name) == "fakecash" and d:IsA("Model") then
			local part = d:FindFirstChild("Root")
			if part:IsA("BasePart") then
				CreateESP(part, Color3.new(1, 0.666667, 0))
			end
		end
	end
end)

local DiskESP = createButton("Disk ESP")
DiskESP.Activated:Connect(function()
	for i, d in workspace:GetDescendants() do
		if string.lower(d.Name) == "disk" and d:IsA("Model") then
			local part = d:FindFirstChild("Color")
			if part:IsA("BasePart") then
				CreateESP(part, Color3.new(0, 0, 0))
			end
		end
	end
end)

local GrenadeESP = createButton("Grenade ESP")
GrenadeESP.Activated:Connect(function()
	for i, d in workspace:GetDescendants() do
		if string.lower(d.Name) == "grenade" and d:IsA("Model") then
			local part = d:FindFirstChild("Root")
			if part:IsA("BasePart") then
				CreateESP(part, Color3.new(1, 0, 0))
			end
		end
	end
end)

local SeltzerESP = createButton("Seltzer Bottle ESP")
SeltzerESP.Activated:Connect(function()
	for i, d in workspace:GetDescendants() do
		if string.lower(d.Name) == "bottle" and d:IsA("Model") then
			local part = d:FindFirstChild("Fluid")
			if part:IsA("BasePart") then
				CreateESP(part, Color3.new(0.666667, 0, 0.498039))
			end
		end
	end
end)

local PlayerESP = createButton("Player ESP")
PlayerESP.Activated:Connect(function()
	for i, p in game.Players:GetPlayers() do
		local playerChar = workspace:FindFirstChild(p.Name)
		if playerChar then
			if playerChar:FindFirstChild("Head") then
				CreateESP(playerChar:FindFirstChild("Head"), Color3.new(1, 1, 1))				
			end
			if playerChar:FindFirstChild("Torso") then
				CreateESP(playerChar:FindFirstChild("Torso"), Color3.new(1, 1, 1))
			end
		end
	end
end)

local LookAtMissionBoard1 = createButton("Look At Alamont's Board")
LookAtMissionBoard1.Activated:Connect(function()
	local board = workspace:WaitForChild("CurrentMap"):WaitForChild("Round"):WaitForChild("Core"):WaitForChild("Bases"):WaitForChild("1"):WaitForChild("MissionBoard")
	lookAtBoard(board)
end)

local LookAtMissionBoard2 = createButton("Look At Halfwell's Board")
LookAtMissionBoard2.Activated:Connect(function()
	local board = workspace:WaitForChild("CurrentMap"):WaitForChild("Round"):WaitForChild("Core"):WaitForChild("Bases"):WaitForChild("2"):WaitForChild("MissionBoard")
	lookAtBoard(board)
end)

local LookAtMissionBoard3 = createButton("Look At Bergmann's Board")
LookAtMissionBoard3.Activated:Connect(function()
	local board = workspace:WaitForChild("CurrentMap"):WaitForChild("Round"):WaitForChild("Core"):WaitForChild("Bases"):WaitForChild("3"):WaitForChild("MissionBoard")
	lookAtBoard(board)
end)

local MonitorChat = createButton("Chat Monitor")
local chatMonitor = false
local chatEvent = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ToClient"):WaitForChild("Chat")
if chatEvent then
    chatEvent.OnClientEvent:Connect(function(plr, part, message)
        if chatMonitor then
            print(plr.Name .. " sent: ".. message)
            CoreGui:SetCore("SendNotification", {
                Title = plr.Name;
                Text = message;
                Duration = 3;
            })
        end
    end)
end
MonitorChat.Activated:Connect(function()
    chatMonitor = not chatMonitor
end)

local pistolLazers = createButton("Pistol Lazers")
pistolLazers.Activated:Connect(function()
    for i, g in workspace:GetChildren() do
        if g.Name == "Pistol" or g.Name == "Snub" and g:FindFirstChild("Root") then
            addLaser(g:FindFirstChild("Root"))
        end
    end
end)

local kickLazers = createButton("Kick-10 Lazers")
kickLazers.Activated:Connect(function()
    for i, g in workspace:GetChildren() do
        if g.Name == "ToolboxMAC10" and g:FindFirstChild("Root") then
            addLaser(g:FindFirstChild("Root"))
        end
    end
end)

local carcosaLazers = createButton("Carcosa Rifle Lazers")
carcosaLazers.Activated:Connect(function()
    for i, g in workspace:GetChildren() do
        if g.Name == "Sniper" and g:FindFirstChild("Root") then
            addLaser(g:FindFirstChild("Root"))
        end
    end
end)

local aceLazers = createButton("Ace Lazers")
aceLazers.Activated:Connect(function()
    for i, g in workspace:GetChildren() do
        if g.Name == "AceCarbine" and g:FindFirstChild("Root") then
            addLaser(g:FindFirstChild("Root"))
        end
    end
end)

local magnumLazers = createButton("Magnum Lazers")
magnumLazers.Activated:Connect(function()
    for i, g in workspace:GetChildren() do
        if g.Name == "MAGNUM" and g:FindFirstChild("Root") then
            addLaser(g:FindFirstChild("Root"))
        end
    end
end)

local showOwnHealth = createButton("Show own health")
showOwnHealth.Activated:Connect(function()
    local characterHealthFrame = plr.PlayerGui:WaitForChild("RootGui"):WaitForChild("CharacterFrame"):WaitForChild("PaperDoll")
    for i, v in characterHealthFrame:GetChildren() do
        if v:IsA("TextLabel") then
            v.TextTransparency = 0
        end
    end
end)

local hearAllPlayers = createButton("Toggle hearing all players")
hearAllPlayers.Activated:Connect(function()
    toggleHearAllPlayers()
end)
-----------------------------------------------------------------------------------------------------------------

-- Credit Notification ------------------------------------------------------------------------------------------
CoreGui:SetCore("SendNotification", {
	Title = "No Big Deal Cheat Injected";
	Text = "Made by Eri";
	Duration = 5;
})
-----------------------------------------------------------------------------------------------------------------
