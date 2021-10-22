local exploit = is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or secure_load and "Sentinel" or KRNL_LOADED and "KRNL" or SONA_LOADED and "Sona" or isexecutorclosure and "Script-Ware" or "Some shitty exploit idk"

local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win = lib:Window("Moon Hub - Build A Boat",Color3.fromRGB(44, 120, 224))

local hometab = win:Tab("Home")
local maintab = win:Tab("Main")
local uitab = win:Tab("UI Setting")
--home
hometab:Button("Copy Discord", function()
        setclipboard("https://discord.gg/SFnBS6ag43")
end)

hometab:Label("Exploit: ".. exploit)
hometab:Label("Thx For using Moon Hub")
--main
maintab:Toggle("Gold Farm",false, function(r)
 if r == true then
                getgenv().farmer = true
                while wait() do
                    if getgenv().farmer == true then
                        function Tween(time, pos)
                            pcall(
                                function()
                                    workspace.Gravity = 0
                                    game:GetService("TweenService"):Create(
                                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                                        TweenInfo.new(time, Enum.EasingStyle.Linear),
                                        {CFrame = pos}
                                    ):Play()
                                    wait(time)
                                    workspace.Gravity = 196.19999694824
                                end
                            )
                        end
                        Tween(1, game:GetService("Workspace").BoatStages.NormalStages.CaveStage1.DarknessPart.CFrame)
                        Tween(18, game:GetService("Workspace").BoatStages.NormalStages.CaveStage10.DarknessPart.CFrame)
                        wait(0.1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                            CFrame.new(Vector3.new(-60.1396255, -350.350006, 9500.14648))
                        pcall(
                            function()
                                firetouchinterest(
                                    game.Players.LocalPlayer.Character.HumanoidRootPart,
                                    game:GetService("Workspace").GoldenChest.Collider,
                                    0
                                )
                            end
                        )
                    elseif r == false then
                        getgenv().farmer = false
                    end
                end
            end
end)


maintab:Toggle("Auto Claim Gold",false, function(r)
            if r == true then
                getgenv().farmer = true
                while wait() do
                    if getgenv().farmer == true then
                        workspace.ClaimRiverResultsGold:FireServer()
                    elseif r == false then
                        getgenv().farmer = false
                    end
                end
            end
        end)
        
        maintab:Toggle("Anti Afk",false, function(r)
            for i, v in next, getconnections(game.Players.LocalPlayer.Idled) do
                v:Disable()
            end
        end)
        --ui
        uitab:Colorpicker("Change UI Color",Color3.fromRGB(44, 120, 224), function(t)
lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)
