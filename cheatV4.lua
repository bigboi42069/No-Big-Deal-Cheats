-- Settings -----------------------------------------------------------------------------------------------------
local toggleKey = Enum.KeyCode.P
local shutdownKey = nil
local minESPsize = 1
local lazerWidth = 0.02
-----------------------------------------------------------------------------------------------------------------

--[[-------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
         .:':'`:·          ,:´'`;' ‘               ,.-:^*:*:^:~,'       
       /:::::::/`·,      /::::/;‘            ,:´:::::::::::::::/_‚     
      /:·*'`·:/:::::' , /·´'`;/::';'          /::;:-·^*'*'^~-;:/::/`;   '
    ,'         `:;::::'`i    ';:::';         /:´    ,. –.,_,.'´::/:::';' '
    ;            '`;:::'i    'i::::i      ,/    ,:´';         ;'´¯`,:::'i' 
    i               `;:';    'i:::i'   ' ,'     ';:::`,       ,:     ';::i‘ 
    i      ,          \|     '|:::i°   ;      ';:::/:`::^*:´;      i::';'‘
    |     ,'`,                i:;'' ‚   i       `;/::::::::,·´      ';:/'‘ 
    'i    'i:::i',             ';/'      ';         '` *^*'´         .'/‘   
    'i     ;::/ \           ;/'         '\                         /     d
     \    'i/    '`·,      ,''             `·,                ,-·´ '      
      '`~´         '`·–·'´'                 '`*~·––·~^'´  '          
                        ‘                        '                      
      -~·-.'´::`;-:~.~·–.,   °          ',:'/¯/`:,                    __'             
  /:::::/::::/::::::::::::::'`,            /:/_/::::/';'           ,.·:'´::::::::`'·-.      
 /-~·-'·´¯`·-~·––  ::;:::::'i'         /:'     '`:/::;‘        '/::::::::::::::::::';     
 '`·,                       '`;::';        ;         ';:';‘       /;:· '´ ¯¯  `' ·-:::/'     
    '`i       'i*^~;          'i / °      |         'i::i      /.'´      _         ';/' ‘    
     ';       ; / ,·          .'/',        ';        ;'::i    ,:     ,:'´::;'`·.,_.·'´.,    ‘ 
     ';      ;' ;´         ~´;:::'i°      'i        'i::i'   /     /':::::/;::::_::::::::;‘  
   /´:;     ;–·:`:,          '`;:/°       ;       'i::;' ,'     ;':::::'/·´¯     ¯'`·;:::¦‘ 
,/::;:'\,  '/::::::;'           'i/' °       ';       i:/'  'i     ';::::::'\             ';:';‘ 
'.     '` '´·–·~*´           ,'  '          ';     ;/ °   ;      '`·:;:::::`'*;:'´      |/'  
  ` ·-.,                 ,-·´   '            ';   / °      \          '`*^*'´         /'  ‘ 
         '`*^~·- ·^*'´     '                 `'´       °    `·.,               ,.-·´      
                   '                           ‘                  '`*^~·~^*'´            
   ,._., ._                                      ,.-:~:'*:~-.°               ,.-:~:-.                    ___               
  /::::::::::'/:/:~-.,                        .·´:::::::::::::::;             /':::::::::'`,              .:´/::::;'`;     ‘       
 /:-·:;:-·~·';/:::::::::`·-.                /::;:-·~^*^~-:;:/ °          /;:-·~·-:;':::',            /::/::::/:::/'i           
 ';           '`~-:;:::::::::'`,         ,.-/:´     .,       ;/            ,'´          '`:;::`,         /·´¯¯¯'`;/::'i'       ‚   
  ',.                 '`·-:;:::::'i'‘     /::';      ,'::`:~.-:´;           /                `;::\       i          'i::'¦            
    `'i      ,_            '`;:::'¦‘    /;:- ´        `'·–·;:'/' _       ,'                   '`,::;     ';          ¦::;            
     'i      ;::/`:,          i'::/   /     ;:'`:.., __,.·'::/:::';     i'       ,';´'`;         '\:::', ‘  ;         ;::;  °         
    _;     ;:/;;;;:';        ¦'/    ;'      ';:::::::::::::::/;;::/   ,'        ;' /´:`';         ';:::'i‘  ';        ;:,'_ ,.-·~^; °
   /::';   ,':/::::::;'       ,´     ¦         '`·-·:;::·-·'´   ';:/‘   ;        ;/:;::;:';         ',:::;   ';      ';:/:::::::::/::i' 
,/-:;_i  ,'/::::;·´        ,'´      '\                         /'    'i        '´        `'         'i::'/   ,:      '/::;:-·~^';::'/' 
'`·.     `'¯¯     '   , ·'´           `·,                  ,·'  '    ¦       '/`' *^~-·'´\         ';'/'‚  i´        ¯          'i/ ' 
    `' ~·- .,. -·~ ´                    '`~·- . , . -·'´          '`., .·´              `·.,_,.·´  ‚  '`·,_          _ , ·'´‘   
           '                                                                                                 ¯ `'*'´ ¯     '      
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------]]--

-- Global Variables ---------------------------------------------------------------------------------------------
local plr = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("StarterGui")
-----------------------------------------------------------------------------------------------------------------

local library
if RunService:IsStudio() then
	library = require(script:WaitForChild("ErisModularGuiV2"))
else
	library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Eri-Yoshimi/Eri-s-Modular-Gui/refs/heads/main/v2.lua'))()
end

local Style = {
	name = "No Big Deal script by CSWC",
	size = UDim2.new(0, 600, 0, 420),
	primaryColor = Color3.new(0.4, 0.4, 0.3),
	secondaryColor = Color3.new(0.5, 0.5, 0.3),
	backgroundColor = Color3.new(0, 0.2, 0.4),
	draggable = true,
	centered = false,
	freemouse = true,
	maxPages = 3,
	barY = 20,
	startMinimized = false,
	toggleBind = toggleKey,
}

-- Init window
local window = library:Initialize(Style)

if shutdownKey ~= nil then
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == shutdownKey then
            window:Destroy()
        end
    end)
end

-- Caches & Vars
local ESPCache = {}
local createdPlayerESPs = {}
local espTextVisible = false
local borderThickness = 2

local function CreateESP(basepart, color, isPlayerESP)
    if not basepart or not basepart:IsA("BasePart") then return end

    local newEspGui = Instance.new("BillboardGui")
    newEspGui.Adornee = basepart
    newEspGui.AlwaysOnTop = true
    newEspGui.ResetOnSpawn = false
    newEspGui.Parent = window.GUI

    task.delay(5, function()
        if newEspGui then newEspGui.ResetOnSpawn = true end
    end)

    -- Set ESP size: full size for players, half size for items
    local baseSize = math.max(basepart.Size.X, basepart.Size.Z, 2)
    local espSize = isPlayerESP and baseSize or baseSize * 0.5
    newEspGui.Size = UDim2.new(espSize, minESPsize, espSize, minESPsize)

    local espFrame = Instance.new("TextLabel")
    espFrame.Text = string.upper(string.sub(basepart.Parent.Name, 1, 1))
    espFrame.TextTransparency = espTextVisible and 0 or 1
    espFrame.TextScaled = true
    espFrame.Size = UDim2.new(1, 0, 1, 0)
    espFrame.BackgroundTransparency = 1
    espFrame.Parent = newEspGui

    local newStroke = Instance.new("UIStroke")
    newStroke.Transparency = espTextVisible and 1 or 0
    newStroke.Color = color or basepart.Color
    espFrame.TextColor3 = newStroke.Color
    newStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    newStroke.LineJoinMode = Enum.LineJoinMode.Miter
    newStroke.Thickness = borderThickness
    newStroke.Parent = espFrame

    table.insert(ESPCache, newEspGui)
    return newEspGui
end

-- Look at Board
local function lookAtBoard(board)
    if not board or not board:IsA("BasePart") then return end
    local connection
    local active = true

    task.delay(5, function()
        active = false
        if connection then connection:Disconnect() end
    end)

    connection = RunService.RenderStepped:Connect(function()
        if active then
            camera.CFrame = CFrame.new(board.CFrame.Position + board.CFrame.LookVector * 10, board.CFrame.Position)
        end
    end)
end

-- Lazers
local raylazertype = true

local LaserManager = {
    map = setmetatable({}, {__mode = "k"})
}

local function cleanupLaserEntry(attachment)
    local entry = LaserManager.map[attachment]
    if not entry then return end
    if entry.conn and entry.conn.Connected then
        entry.conn:Disconnect()
    end
    if entry.part and entry.part.Parent then
        entry.part:Destroy()
    end
    LaserManager.map[attachment] = nil
end

local function addLaser(attachment: Attachment)
    if not attachment or not attachment:IsA("Attachment") then return end

    if LaserManager.map[attachment] then
        cleanupLaserEntry(attachment)
    end

    local laserPart = Instance.new("Part")
    laserPart.Name = "CSWC_LaserPart"
    laserPart.Anchored = true
    laserPart.CanCollide = false
    laserPart.CastShadow = false
    laserPart.Material = Enum.Material.Neon
    laserPart.Color = Color3.fromRGB(255, 0, 0)
    laserPart.Size = Vector3.new(lazerWidth, lazerWidth, 100)
    laserPart.Parent = workspace

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.IgnoreWater = true

    local function updateLaser()
        if not attachment or not attachment.Parent or not laserPart or not laserPart.Parent then
            cleanupLaserEntry(attachment)
            return
        end

        local filterList = {}
        local parentModel = attachment.Parent and attachment.Parent.Parent
        if parentModel then table.insert(filterList, parentModel) end
        table.insert(filterList, laserPart)
        local ownModel = workspace:FindFirstChild(plr.Name)
        if ownModel then table.insert(filterList, ownModel) end
        raycastParams.FilterDescendantsInstances = filterList

        local startPos = attachment.WorldCFrame.Position
        local direction = attachment.WorldCFrame.LookVector * 5000

        local result = workspace:Raycast(startPos, direction, raycastParams)
        local endPoint = result and result.Position or (startPos + direction)
        local laserLength = (endPoint - startPos).Magnitude
        if laserLength < 1 then laserLength = 10 end

        laserPart.Size = Vector3.new(lazerWidth, lazerWidth, laserLength)
        laserPart.CFrame = CFrame.new(startPos, endPoint) * CFrame.new(0, 0, -laserLength / 2)
    end

    local conn
    if raylazertype then
        conn = RunService.Heartbeat:Connect(updateLaser)
    else
        conn = RunService.Heartbeat:Connect(function()
            if not attachment or not attachment.Parent then
                cleanupLaserEntry(attachment)
                return
            end
            if laserPart and laserPart.Parent then
                laserPart.CFrame = attachment.WorldCFrame * CFrame.new(0, 0, -laserPart.Size.Z/2)
            end
        end)
    end
    LaserManager.map[attachment] = { part = laserPart, conn = conn }
end

-- Cash system
local cash = {}
local markers = {}
local showGroups = false

local function getDistance(p1, p2)
    return (p1.Position - p2.Position).Magnitude
end

local function getAveragePosition(group)
    local total = Vector3.zero
    for _, obj in ipairs(group) do
        total += obj.Position
    end
    return total / #group
end

local function updateGroupMarkers(groups)
    while #markers > #groups do
        local marker = table.remove(markers)
        if marker then
            marker.marker:Destroy()
            marker.text.Parent:Destroy()
        end
    end

    for i, group in ipairs(groups) do
        if #group > 0 then
            local avg = getAveragePosition(group) + Vector3.new(0, 2, 0)
            if markers[i] then
                markers[i].marker.StudsOffsetWorldSpace = avg
                markers[i].text.Text = "$"..#group
            else
                local newBill = Instance.new("BillboardGui")
                newBill.StudsOffsetWorldSpace = avg
                newBill.AlwaysOnTop = true
                newBill.ResetOnSpawn = false
                newBill.Size = UDim2.new(0, 50, 0, 50)
                newBill.Parent = window.GUI
                task.delay(5, function() if newBill then newBill.ResetOnSpawn = true end end)
                local markerText = Instance.new("TextLabel")
                markerText.TextScaled = true
                markerText.Size = UDim2.new(1,0,1,0)
                markerText.BackgroundTransparency = 1
                markerText.TextColor3 = Color3.new(0.33, 1, 0)
                markerText.TextTransparency = showGroups and 0 or 1
                markerText.Text = "$"..#group
                markerText.Parent = newBill
                markers[i] = {marker = newBill, text = markerText}
            end
        elseif markers[i] then
            markers[i].marker:Destroy()
            markers[i].text.Parent:Destroy()
            table.remove(markers, i)
        end
    end
end

local function groupCashObjects()
    for i = #cash,1,-1 do
        local c = cash[i]
        if not c or not c.Parent then
            table.remove(cash, i)
        end
    end
    local groups = {}
    local visited = {}
    for i = 1, #cash do
        local c = cash[i]
        if not c then continue end
        if not visited[c] then
            visited[c] = true
            local group = {c}
            for j = i+1, #cash do
                local other = cash[j]
                if other and not visited[other] then
                    if getDistance(c, other) <= 25 then
                        table.insert(group, other)
                        visited[other] = true
                    end
                end
            end
            table.insert(groups, group)
        end
    end
    updateGroupMarkers(groups)
end

-- Init cash scan
for _, d in ipairs(workspace:GetDescendants()) do
    if d:IsA("Model") and d.Name:lower() == "cash" then
        local part = d:FindFirstChild("Root")
        if part and part:IsA("BasePart") then table.insert(cash, part) end
    end
end

workspace.DescendantAdded:Connect(function(d)
    task.wait(1)
    if d:IsA("Model") and d.Name:lower() == "cash" then
        local part = d:FindFirstChild("Root")
        if part and part:IsA("BasePart") then table.insert(cash, part) end
    end
end)

RunService.Heartbeat:Connect(groupCashObjects)

do
    local last = 0
    RunService.Heartbeat:Connect(function(dt)
        last = last + dt
        if last >= 0.1 then
            last = 0
            task.spawn(function()
                groupCashObjects()
            end)
        end
    end)
end

-- ESP Module
local espModule = window:createNewModule("ESP")
local function createESPButton(ButtonText, lookfor, bodyPart, color)
    local createdESPs = {}
    local newBtn, newState = espModule:AddToggle(ButtonText)
    newBtn.Activated:Connect(function()
        if not newState:GetState() then
            for _, ce in ipairs(createdESPs) do
                if ce and ce.Parent then ce:Destroy() end
            end
            table.clear(createdESPs)
            return
        end
        for _, d in ipairs(workspace:GetDescendants()) do
            if d:IsA("Model") and d.Name:lower() == lookfor then
                local part = d:FindFirstChild(bodyPart)
                if part and part:IsA("BasePart") then
                    local e = CreateESP(part, color)
                    table.insert(createdESPs, e)
                end
            end
        end
    end)
    workspace.DescendantAdded:Connect(function(d)
        if not newState:GetState() then return end
        if d:IsA("Model") and d.Name:lower() == lookfor then
            local part = d:FindFirstChild(bodyPart)
            if part and part:IsA("BasePart") then
                local e = CreateESP(part, color)
                table.insert(createdESPs, e)
            end
        end
    end)
end

-- Toggle text on ESP
local espTextToggle, espTextToggled = espModule:AddToggle("Use Text")
espTextToggle.Activated:Connect(function()
    espTextVisible = espTextToggled:GetState()
    for _, v in ipairs(ESPCache) do
		wait(0.01)
        local espFrame = v:FindFirstChildOfClass("TextLabel")
        if espFrame then
            espFrame.TextTransparency = espTextVisible and 0 or 1
            local espBorder = espFrame:FindFirstChildOfClass("UIStroke")
            if espBorder then espBorder.Transparency = espTextVisible and 1 or 0 end
        end
    end
end)

-- Border thickness slider
local thicknessSlider = espModule:AddSlider("ESP Border Thickness", 1, 4)
thicknessSlider.OnValueChanged:Connect(function(value)
	borderThickness = value

	for _, v in ipairs(ESPCache) do
		local label = v:FindFirstChildOfClass("TextLabel")
		if label then
			local stroke = label:FindFirstChildOfClass("UIStroke")
			if stroke then
				stroke.Thickness = value
			end
		end
	end

	for _, v in ipairs(createdPlayerESPs) do
		local label = v:FindFirstChildOfClass("TextLabel")
		if label then
			local stroke = label:FindFirstChildOfClass("UIStroke")
			if stroke then
				stroke.Thickness = value
			end
		end
	end
end)

espModule:AddDivider()

-- Grouped cash toggle
local groupedCash, groupedCashToggled = espModule:AddToggle("Grouped Cash")
groupedCash.Activated:Connect(function()
    showGroups = groupedCashToggled:GetState()
    for _, gc in ipairs(markers) do
        gc.text.TextTransparency = showGroups and 0 or 1
    end
end)

createESPButton("Cash ESP", "cash", "Root", Color3.new(0, 1, 0))
createESPButton("Fake Cash ESP", "fakecash", "Root", Color3.new(1, 0.666667, 0))
createESPButton("Disk ESP", "disk", "Color", Color3.new(0, 0, 0))
createESPButton("Grenade ESP", "grenade", "Root", Color3.new(1, 0, 0))
createESPButton("Seltzer Bottle ESP", "bottle", "Fluid", Color3.new(0.666667, 0, 0.498039))

espModule:AddDivider()

local useTeamColor, useTeamColorToggled = espModule:AddToggle("Use Team Colors")
local PlayerESP, playerESPtoggled = espModule:AddToggle("Player ESP")
PlayerESP.Activated:Connect(function()
	if playerESPtoggled:GetState() == false then
		for _, ce in createdPlayerESPs do
			ce:Destroy()
		end
		return
	end
	for i, p in game.Players:GetPlayers() do
		wait(0.01)
		local playerChar = workspace:FindFirstChild(p.Name)
		if playerChar then
            local teamColor = Color3.new(1, 1, 1)
            if playerChar:FindFirstChild("SuitBody"):FindFirstChild("Handle"):FindFirstChild("Jacket") and useTeamColorToggled:GetState() == true then
                teamColor = playerChar:FindFirstChild("SuitBody"):FindFirstChild("Handle"):FindFirstChild("Jacket").Color
            end
			if playerChar:FindFirstChild("Head") then
				local createdESP = CreateESP(playerChar:FindFirstChild("Head"), teamColor, true)
				createdESP:FindFirstChildOfClass("TextLabel").TextTransparency = 1
				createdESP:FindFirstChildOfClass("TextLabel"):FindFirstChildOfClass("UIStroke").Thickness = borderThickness
				table.remove(ESPCache, table.find(ESPCache, createdESP))
				table.insert(createdPlayerESPs, createdESP)
			end
			if playerChar:FindFirstChild("Torso") then
				local createdESP = CreateESP(playerChar:FindFirstChild("Torso"), teamColor, true)
				createdESP:FindFirstChildOfClass("TextLabel").TextTransparency = 1
				createdESP:FindFirstChildOfClass("TextLabel"):FindFirstChildOfClass("UIStroke").Thickness = borderThickness
				table.remove(ESPCache, table.find(ESPCache, createdESP))
				table.insert(createdPlayerESPs, createdESP)
			end
		end
	end
end)

workspace.ChildAdded:Connect(function(c)
	if playerESPtoggled:GetState() == false then return end
	task.wait(1)
	if game.Players:FindFirstChild(c.Name) and c:IsA("Model") then
        local teamColor = Color3.new(1, 1, 1)
        if c:FindFirstChild("SuitBody"):FindFirstChild("Handle"):FindFirstChild("Jacket") and useTeamColorToggled:GetState() == true then
            teamColor = c:FindFirstChild("SuitBody"):FindFirstChild("Handle"):FindFirstChild("Jacket").Color
        end
		if c:FindFirstChild("Head") then
			local createdESP = CreateESP(c:FindFirstChild("Head"), teamColor, true)
			createdESP:FindFirstChildOfClass("TextLabel").TextTransparency = 1
			createdESP:FindFirstChildOfClass("TextLabel"):FindFirstChildOfClass("UIStroke").Thickness = borderThickness
			table.remove(ESPCache, table.find(ESPCache, createdESP))
			table.insert(createdPlayerESPs, createdESP)
		end
		if c:FindFirstChild("Torso") then
			local createdESP = CreateESP(c:FindFirstChild("Torso"), teamColor, true)
			createdESP:FindFirstChildOfClass("TextLabel").TextTransparency = 1
			createdESP:FindFirstChildOfClass("TextLabel"):FindFirstChildOfClass("UIStroke").Thickness = borderThickness
			table.remove(ESPCache, table.find(ESPCache, createdESP))
			table.insert(createdPlayerESPs, createdESP)
		end
	end
end)

local lazerModule = window:createNewModule("Lazers")

local jjxenoFix, jjxenoFixToggled = lazerModule:AddToggle("JJ/Xeno lazer fix")
jjxenoFix.Activated:Connect(function()
	raylazertype = not jjxenoFixToggled:GetState()
end)

local function hasValidMuzzle(g)
    if not g then return false end
    local root = g:FindFirstChild("Root")
    if not root then return false end
    local muzzle = root:FindFirstChild("Muzzle")
    return muzzle and muzzle:IsA("Attachment")
end

local handgunLazers = lazerModule:AddButton("Handguns")
handgunLazers.Activated:Connect(function()
	for i, g in ipairs(workspace:GetChildren()) do
		if (g.Name == "Pistol" or g.Name == "Snub" or g.Name == "MAGNUM" or g.Name == "Deagle" or g.Name == "TheFix") and hasValidMuzzle(g) then
			addLaser(g.Root.Muzzle)
		end
	end
end)

local shotgunLazers = lazerModule:AddButton("Shotguns")
shotgunLazers.Activated:Connect(function()
	for i, g in ipairs(workspace:GetChildren()) do
		if (g.Name == "DB") and hasValidMuzzle(g) then
			addLaser(g.Root.Muzzle)
		end
	end
end)

local machineLazers = lazerModule:AddButton("Machine Guns")
machineLazers.Activated:Connect(function()
	for i, g in ipairs(workspace:GetChildren()) do
		if (g.Name == "Kick10" or g.Name == "PitchGun" or g.Name == "Jericho") and hasValidMuzzle(g) then
			addLaser(g.Root.Muzzle)
		end
	end
end)

local assaultLazers = lazerModule:AddButton("Assault Rifles")
assaultLazers.Activated:Connect(function()
	for i, g in ipairs(workspace:GetChildren()) do
		if (g.Name == "AceCarbine" or g.Name == "AK47") and hasValidMuzzle(g) then
			addLaser(g.Root.Muzzle)
		end
	end
end)

local sniperLazers = lazerModule:AddButton("Sniper Rifles")
sniperLazers.Activated:Connect(function()
	for i, g in ipairs(workspace:GetChildren()) do
		if (g.Name == "Sniper") and hasValidMuzzle(g) then
			addLaser(g.Root.Muzzle)
		end
	end
end)

local allLazers = lazerModule:AddButton("All Guns")
allLazers.Activated:Connect(function()
	for i, g in ipairs(workspace:GetChildren()) do
		local names = {
            Snub=true, Pistol=true, DB=true, Jericho=true, AK47=true, Kick10=true, PitchGun=true,
            Sniper=true, AceCarbine=true, MAGNUM=true, Strikeout=true, TheFix=true, Liquidator=true, Forte=true, Deagle=true
        }
		if names[g.Name] and hasValidMuzzle(g) then
			addLaser(g.Root.Muzzle)
		end
	end
end)

local miscModule = window:createNewModule("Miscellaneous")

local removeExtraAssetsButton = miscModule:AddButton("Remove Extra Assets")

removeExtraAssetsButton.Activated:Connect(function()
    local Lighting = game:GetService("Lighting")
    Lighting.GlobalShadows = false
    Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
    Lighting.Brightness = 1
    Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "BulletHole2" or obj.Name == "Casing" then
            obj:Destroy()
        end
    end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
            obj.Enabled = false
        elseif obj:IsA("ParticleEmitter") then
            obj.Enabled = false
        end
    end

    local streetLightsFolder = workspace:FindFirstChild("StreetLights")
    if streetLightsFolder then
        for _, lightObj in pairs(streetLightsFolder:GetDescendants()) do
            if lightObj:IsA("PointLight") or lightObj:IsA("SpotLight") or lightObj:IsA("SurfaceLight") then
                lightObj.Enabled = false
            end
        end
    end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
            pcall(function() obj.Enabled = false end)
        end
    end
end)


local baseTeamNames = {
	"Alamont",
	"Bergman",
	"Halfwell",
	"Renetti",
	"Yoromoto",
}

local lookAtMissionBoardList = miscModule:AddList("Look at board")
for i, t in baseTeamNames do
	lookAtMissionBoardList:AddListItem(t, i)
end

lookAtMissionBoardList.OnItemChanged:Connect(function(boardID)
	local board = workspace:WaitForChild("CurrentMap"):WaitForChild("Round"):WaitForChild("Core"):WaitForChild("Bases"):WaitForChild(boardID):WaitForChild("MissionBoard")
	lookAtBoard(board)
end)

local showOwnHealth, showingOwnHealth = miscModule:AddToggle("Show own health")
showOwnHealth.Activated:Connect(function()
	local characterHealthFrame = plr.PlayerGui:WaitForChild("RootGui"):WaitForChild("CharacterFrame"):WaitForChild("PaperDoll")
	for i, v in characterHealthFrame:GetChildren() do
		if v:IsA("TextLabel") then
			v.TextTransparency = showingOwnHealth:GetState() and 0 or 1
		end
	end
end)

local MonitorChat, monotoringChat = miscModule:AddToggle("Chat Monitor")
if game.ReplicatedStorage:FindFirstChild("Remotes") then
	local chatMonitor = false
	local chatEvent = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ToClient"):WaitForChild("Chat")
	if chatEvent then
		chatEvent.OnClientEvent:Connect(function(plr, part, message)
			if monotoringChat:GetState() then
				print(plr.Name .. " sent: ".. message)
				CoreGui:SetCore("SendNotification", {
					Title = plr.Name;
					Text = message;
					Duration = 3;
				})
			end
		end)
	end
end

local hearAllPlayersOutput = Instance.new("AudioDeviceOutput", window.GUI)
hearAllPlayersOutput.Name = "HearAllPlayers"
hearAllPlayersOutput.Player = plr
local hearAllPlayersVolumeControl = Instance.new("AudioFader", hearAllPlayersOutput)
local newVolumeWire = Instance.new("Wire", hearAllPlayersVolumeControl)
newVolumeWire.SourceInstance = hearAllPlayersVolumeControl
newVolumeWire.TargetInstance = hearAllPlayersOutput
for i, p in game.Players:GetPlayers() do
	if p == plr then continue end
	local mic = p:FindFirstChildOfClass("AudioDeviceInput")
	if mic then
		local newWire = Instance.new("Wire", hearAllPlayersOutput)
		newWire.SourceInstance = mic
		newWire.TargetInstance = hearAllPlayersVolumeControl
	end
end
game.Players.PlayerAdded:Connect(function(plr)
	task.wait(1)
	local mic = plr:FindFirstChildOfClass("AudioDeviceInput")
	if mic then
		local newWire = Instance.new("Wire", hearAllPlayersVolumeControl)
		newWire.SourceInstance = mic
		newWire.TargetInstance = hearAllPlayersVolumeControl
	end
end)
local volumeSlider = miscModule:AddSlider("Global voice chat volume", 0, 1)
volumeSlider.OnValueChanged:Connect(function(value)
	if hearAllPlayersOutput then
		hearAllPlayersVolumeControl.Volume = value
	end
end)

hearAllPlayersVolumeControl.Volume = volumeSlider:GetValue() or 0

local removeVCWarning = miscModule:AddButton("Remove VC Warning Gui")
removeVCWarning.Activated:Connect(function()
	local vcWarningGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("VCWarning")
	if vcWarningGui then
		vcWarningGui:Destroy()
	end
end)

local teleportModule = window:createNewModule("Teleport")

local function teleportTo(part)
	local char: Model = workspace:WaitForChild(game.Players.LocalPlayer.Name)
	for i = 1, 2 do
		for i = 1, 10 do
			char:PivotTo(part.CFrame + Vector3.new(0, 130, 0))
			char:FindFirstChild("HumanoidRootPart").Velocity = Vector3.zero
			wait()
			char:PivotTo(part.CFrame + Vector3.new(0, 125, 0))
			wait()
		end
		wait(1)
	end
end

teleportModule:AddText("!!! WARNING: THIS IS VERY LIKELY TO GET YOU CAUGHT !!!")
teleportModule:AddText("To teleport you have to be in ragdoll mode first.")
local deadDropTPs = teleportModule:AddList("Place Teleports")
if workspace:FindFirstChild("CurrentMap") then
	for i, v in workspace:WaitForChild("CurrentMap"):WaitForChild("Round"):WaitForChild("Core"):WaitForChild("DeadDrops"):GetChildren() do
		deadDropTPs:AddListItem(v.Name, v)
	end
end
deadDropTPs.OnItemChanged:Connect(function(place)
	teleportTo(place)
end)
local baseTPs = teleportModule:AddList("Base Teleports")
for i, t in baseTeamNames do
	baseTPs:AddListItem(t, i)
end
baseTPs.OnItemChanged:Connect(function(baseID)
	local base = workspace:WaitForChild("CurrentMap"):WaitForChild("Round"):WaitForChild("Core"):WaitForChild("Bases"):WaitForChild(baseID):WaitForChild("Bounds")
	teleportTo(base)
end)

local trollModule = window:createNewModule("Troll")

trollModule:AddText("!!! WARNING: THIS WILL GET YOU CAUGHT !!!")
trollModule:AddText("Get in a driver seat in a car and toggle this on to start killing everyone.")
local carKill, carKillToggled = trollModule:AddToggle("Car Kill")
carKill.Activated:Connect(function()
	task.spawn(function()
		while wait(math.random(5, 25)/50) and plr.Character and carKillToggled:GetState() == true do
			local randmPLR: Player = game.Players:GetPlayers()[math.random(1, #game.Players:GetChildren())]
			if randmPLR.Character == nil and randmPLR ~= game.Players.LocalPlayer then continue end
			if randmPLR.Character:GetPivot().Y <= -100 then continue end
			for i = 1, 25 do
				plr.Character:PivotTo(randmPLR.Character:GetPivot())
				wait(math.random(0, 10) / 200)
				plr.Character:PivotTo(plr.Character:GetPivot() + Vector3.new(0, 25, 0))
			end
			plr.Character:PivotTo(CFrame.new(0, 250, 0))
			if plr.Character:FindFirstChild("HumanoidRootPart") then plr.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, 0, 0) end
		end
	end)
end)
