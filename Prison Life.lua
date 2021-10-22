--localandfunction
local MarketPlaceService = game:GetService("MarketplaceService")

	local Players = game.Players
	local LocalPlayer = Players.LocalPlayer
	local GetPlayers = Players.GetPlayers
	local Camera = workspace.CurrentCamera
	local WTSP = Camera.WorldToScreenPoint
	local FindFirstChild = game.FindFirstChild
	local Vector2_new = Vector2.new
	local Mouse = LocalPlayer.GetMouse(LocalPlayer)
--e	
function checkgamepass(userid, gamepassid)
    local xy = MarketPlaceService:UserOwnsGamePassAsync(userid,gamepassid)
    return xy
end
---ESDAG
local exploit = is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or secure_load and "Sentinel" or KRNL_LOADED and "KRNL" or SONA_LOADED and "Sona" or isexecutorclosure and "Script-Ware" or "Some shitty exploit idk"
--GGEz
local aimbotsettings = {
    enabled = false,
    freeforall = false,
    radius = 2500,
    wallcheck = true
}

local players = game:GetService("Players")
local client = players.LocalPlayer
local inputservice = game:GetService("UserInputService")
local mouse = client:GetMouse()
local runservice = game:GetService("RunService")
local aim = false

function GetMouse()
    return Vector2.new(mouse.X, mouse.Y)
end

inputservice.InputBegan:Connect(function(key)
    if key.UserInputType == Enum.UserInputType.MouseButton2 then
        aim = true
    end
end)

inputservice.InputEnded:Connect(function(key)
    if key.UserInputType == Enum.UserInputType.MouseButton2 then
        aim = false
    end
end)

function FreeForAll(targetplayer)
    if aimbotsettings.freeforall == false then
        if client.Team == targetplayer.Team then return false
        else return true end
    else return true end
end

function NotObstructing(destination, ignore)
    if aimbotsettings.wallcheck then
        Origin = workspace.CurrentCamera.CFrame.p
        CheckRay = Ray.new(Origin, destination- Origin)
        Hit = workspace:FindPartOnRayWithIgnoreList(CheckRay, ignore)
        return Hit == nil
    else
        return true
    end
end

function GetClosestToCuror()
    MousePos = GetMouse()
    Radius = aimbotsettings.radius
    Closest = math.huge
    Target = nil
    for _,v in pairs(game:GetService("Players"):GetPlayers()) do
        if FreeForAll(v) then
            if v.Character:FindFirstChild("Head") and v ~= game.Players.LocalPlayer then
                Point,OnScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character.Head.Position)
                clientchar = client.Character
                if OnScreen and NotObstructing(v.Character.Head.Position,{clientchar,v.Character}) then
                    Distance = (Vector2.new(Point.X,Point.Y) - MousePos).magnitude
                    if Distance < math.min(Radius,Closest) then
                        Closest = Distance
                        Target = v
                    end
                end
            end
        end
    end
    return Target
end 

runservice.RenderStepped:Connect(function()
    if aimbotsettings.enabled == false or aim == false then return end
    ClosestPlayer = GetClosestToCuror()
    if ClosestPlayer then
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p,ClosestPlayer.Character.Head.CFrame.p)
    end
end)
--ESp
local ESPEnabled = false
local DistanceEnabled = false
local TracersEnabled = false

pcall(function()
	
	Camera = game:GetService("Workspace").CurrentCamera
	RunService = game:GetService("RunService")
	camera = workspace.CurrentCamera
	Bottom = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)

	function GetPoint(vector3)
		local vector, onScreen = camera:WorldToScreenPoint(vector3)
		return {Vector2.new(vector.X,vector.Y),onScreen,vector.Z}
	end
	
	function MakeESP(model)
		local CurrentParent = model.Parent
	
		local TopL = Drawing.new("Line")
		local BottomL = Drawing.new("Line")
		local LeftL = Drawing.new("Line")
		local RightL = Drawing.new("Line")
		local Tracer = Drawing.new("Line")
		local Display = Drawing.new("Text")

        coroutine.resume(coroutine.create(function()
			while model.Parent == CurrentParent do
				
				local Distance = (Camera.CFrame.Position - model.HumanoidRootPart.Position).Magnitude
                local GetP = GetPoint(model.Head.Position)
                local headps = model.Head.CFrame
                
				if ESPEnabled and GetP[2] then
					
                    -- Calculate Cords
                    local topright = headps * CFrame.new(3,0.5, 0)
                    local topleft = headps * CFrame.new(-3,0.5, 0)
                    local bottomleft = headps * CFrame.new(-3,-7,0)
                    local bottomright = headps * CFrame.new(3,-7,0)
					topright = GetPoint(topright.p)[1]
					topleft = GetPoint(topleft.p)[1]
					bottomleft = GetPoint(bottomleft.p)[1]
					bottomright = GetPoint(bottomright.p)[1]

                    local teamcolor = game:GetService("Players")[model.Name].TeamColor.Color or Color3.fromRGB(0,0,0)
                    TopL.Color, BottomL.Color, RightL.Color, LeftL.Color = teamcolor, teamcolor, teamcolor, teamcolor
                    TopL.From, BottomL.From, RightL.From, LeftL.From = topleft, bottomleft, topright, topleft
                    TopL.To, BottomL.To, RightL.To, LeftL.To = topright, bottomright, bottomright, bottomleft
					TopL.Visible, BottomL.Visible, RightL.Visible, LeftL.Visible = true, true, true, true
				else
					TopL.Visible, BottomL.Visible, RightL.Visible, LeftL.Visible = false, false, false, false
                end
                
				if ESPEnabled and TracersEnabled and GetP[2] then
					Tracer.Color = game:GetService("Players")[model.Name].TeamColor.Color or Color3.fromRGB(0,0,0)
					Tracer.From = Bottom
					Tracer.To = GetPoint(headps.p)[1]
					Tracer.Thickness = 1.5
					Tracer.Visible = true
				else
					Tracer.Visible = false
                end
                
				if ESPEnabled and DistanceEnabled and GetP[2] then
					Display.Visible = true
					Display.Position = GetPoint(headps.p + Vector3.new(0,0.5,0))[1]
					Display.Center = true
					Display.Text = tostring(math.floor(Distance)).." studs"
				else
					Display.Visible = false
                end
                
				RunService.RenderStepped:Wait()
			end
	
			TopL:Remove()
			BottomL:Remove()
			RightL:Remove()
			LeftL:Remove()
			Tracer:Remove()
			Display:Remove()
        
        end))
    end
    
	for _, Player in next, game:GetService("Players"):GetChildren() do
		if Player.Name ~= game.Players.LocalPlayer.Name then
			MakeESP(Player.Character)
			Player.CharacterAdded:Connect(function()
				delay(0.5, function()
					MakeESP(Player.Character)
				end)
			end)
		end	
	end
	
	game:GetService("Players").PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            delay(0.5, function()
                MakeESP(player.Character)
            end)
		end)
	end)
	
end)
--easb
local Players = game:GetService("Players")
--Playerss
local plr = Players.LocalPlayer.Character.HumanoidRootPart
--das
    local LP = game.Players.LocalPlayer
    local RE = LP.Character.HumanoidRootPart.Position



local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win = lib:Window("Moon Hub - Prison Life",Color3.fromRGB(44, 120, 224))

local hometab = win:Tab("Home")
local Aimbotab = win:Tab("AimBot")
local guntab = win:Tab("Guns and knife")
local ESPtab = win:Tab("ESP")
local teamstab = win:Tab("Teams")
local playertab = win:Tab("Player")
local teleporttab = win:Tab("Teleports")
local settingstab = win:Tab("Ui Settings")

--Hometab

hometab:Button("Copy Discord", function()
        setclipboard("https://discord.gg/SFnBS6ag43")
end)

hometab:Label("Exploit: ".. exploit)
hometab:Label("Thx For using Moon Hub")


--Combat
guntab:Button("Give all Gun", function()
   pcall(function()
if checkgamepass(game.Players.LocalPlayer.UserId,96651) then

		local Weapon = {"M4A1"}
		for i,v in pairs(workspace.Prison_ITEMS.giver:GetChildren()) do
		    if v.Name == Weapon[1] then
		        local lol = workspace.Remote.ItemHandler:InvokeServer(v.ITEMPICKUP)
		    end
		end
	end
	local Weapon = {"AK-47"}
	for i,v in pairs(workspace.Prison_ITEMS.giver:GetChildren()) do
	    if v.Name == Weapon[1] then
	        local lol = workspace.Remote.ItemHandler:InvokeServer(v.ITEMPICKUP)
	    end
	end
	
	local Weapon = {"Remington 870"}
	for i,v in pairs(workspace.Prison_ITEMS.giver:GetChildren()) do
	    if v.Name == Weapon[1] then
	        local lol = workspace.Remote.ItemHandler:InvokeServer(v.ITEMPICKUP)
	    end
	end
	
	local Weapon = {"M9"}
	for i,v in pairs(workspace.Prison_ITEMS.giver:GetChildren()) do
	    if v.Name == Weapon[1] then
	        local lol = workspace.Remote.ItemHandler:InvokeServer(v.ITEMPICKUP)
	    end
	end  
end)
   end)    
guntab:Button("Give all knife", function()
   pcall(function()
            local weapons = {"Crude Knife", "Sharpened stick", "Extendo mirror"}
	for i, v in pairs(game.ReplicatedStorage.Tools:GetChildren()) do
	    for j, k in pairs(weapons) do
	        if v.Name == k then
	            v:Clone().Parent = game.Players.LocalPlayer.Backpack
	        end
	    end
	end
end)
   end)   
   
   Aimbotab:Button("Silent Aim", function()
      pcall(function()
function ClosestChar()
		local Max, Close = math.huge
		for I,V in pairs(GetPlayers(Players)) do
			if V ~= LocalPlayer and V.Team ~= LocalPlayer.Team and V.Character then
				local Head = FindFirstChild(V.Character, "Head")
				if Head then
					local Pos, OnScreen = WTSP(Camera, Head.Position)
					if OnScreen then
						local Dist = (Vector2_new(Pos.X, Pos.Y) - Vector2_new(Mouse.X, Mouse.Y)).Magnitude
						if Dist < Max then
							Max = Dist
							Close = V.Character
						end
					end
				end
			end
		end
		return Close
	end
	
	local MT = getrawmetatable(game)
	local __namecall = MT.__namecall
	setreadonly(MT, false)
	MT.__namecall = newcclosure(function(self, ...)
		local Method = getnamecallmethod()
		if Method == "FindPartOnRay" and not checkcaller() and tostring(getfenv(0).script) == "GunInterface" then
			local Character = ClosestChar()
			if Character then
				return Character.Head, Character.Head.Position
			end
		end
	
		return __namecall(self, ...)
	end)
	setreadonly(MT, true)
end)
end)

Aimbotab:Toggle("AimBot",false, function(value)
   pcall(function()
aimbotsettings.enabled = value
   end)  
end)

Aimbotab:Toggle("Wall Check",false, function(value)
   pcall(function()
    aimbotsettings.wallcheck = value
   end)  
end)
  
  Aimbotab:Toggle("Free For All",false, function(value)
   pcall(function()
aimbotsettings.freeforall = value
   end)  
end)
--ESP
ESPtab:Toggle("ESP",false, function(value)
   pcall(function()
ESPEnabled = value
   end)  
end)

ESPtab:Toggle("Tracers",false, function(value)
   pcall(function()
TracersEnabled = value
   end)  
end)

ESPtab:Toggle("Distance Display",false, function(value)
   pcall(function()
DistanceEnabled = value
   end)  
end)
--Teams
teamstab:Button("Prisoner", function()
    workspace.Remote.TeamEvent:FireServer("Bright orange") 
end)

teamstab:Button("Criminal", function()
    local LP = game.Players.LocalPlayer
    local RE = LP.Character.HumanoidRootPart.Position
    LP.Character.HumanoidRootPart.CFrame = CFrame.new(-919.958, 95.327, 2138.189)
    wait(0.075)
    LP.Character.HumanoidRootPart.CFrame = CFrame.new(RE)
end)

teamstab:Button("Police", function()
    workspace.Remote.TeamEvent:FireServer("Bright blue")
end)

teamstab:Button("Neatral", function()
    workspace.Remote.TeamEvent:FireServer("Medium stone grey") 
end)

--Teleport

teleporttab:Textbox("Teleport to player",true, function(arg)
   pcall(function()
       local plr = Players.LocalPlayer.Character.HumanoidRootPart
       local target = Players[arg].Character.HumanoidRootPart
       plr.CFrame = target.CFrame
end)
   end)
   
   teleporttab:Button("Gaurd Room", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(798.664368, 99.9900055, 2264.11157)
end)

teleporttab:Button("Yard", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(767.570129, 97.9999466, 2461.25659)
end)

teleporttab:Button("Kitchen", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(941.972778, 99.9899597, 2222.83716)
end)

teleporttab:Button("Police Garager", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(614.918396, 98.2000275, 2512.02368)
end)

teleporttab:Button("Main Tower", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(823.287292, 130.039948, 2587.73975)
end)

teleporttab:Button("Prison Entrance", "Teleport to Prison Entrance", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(474.655701, 98.1900101, 2250.36841)
end)

teleporttab:Button("Criminal WareHouse", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-919.958, 95.327, 2128.1180)
end)

teleporttab:Button("Cafe", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-919.958, 95.327, 2128.1180)
end)

--gamingtb
playertab:Slider("Walk Speed",16,100,16, function(cc)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = cc
end)

--gamingtb
playertab:Slider("JumpPower",50,250,50, function(t)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t
end)

  
  
