local userID = 47 -- Changing this dosent do anything.
--[[ 
 __          __     _____  _   _ _____ _   _  _____ _ 
 \ \        / /\   |  __ \| \ | |_   _| \ | |/ ____| |
  \ \  /\  / /  \  | |__) |  \| | | | |  \| | |  __| |
   \ \/  \/ / /\ \ |  _  /| . ` | | | | . ` | | |_ | |
    \  /\  / ____ \| | \ \| |\  |_| |_| |\  | |__| |_|
     \/  \/_/    \_\_|  \_\_| \_|_____|_| \_|\_____(_)
                                                      
                                                      
This script is only usable by whitelisted users. If you are not on the whitelist, you will not be able to use this script.
This script is not authorized by Roblox. Using this script may result in your account being banned.
This script is highly secrued. Attempting to bypass this script will result into a automated blacklist.

DATA WE LOG:
- UserID
- Executor (Synapse & Krnl only.)
- And the game JOBID.
]]
-- Script below.


























local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Rain-Design/Unnamed/main/Library.lua'))()
Library.Theme = "Tokyo Night"
local Flags = Library.Flags

getgenv().SettingsRedbox2 = {
    GrenadeAura = {
        Toggle = false;
        Type = "";
    };
    MeleeAura = {
        Toggle = false;
        Type = "";
        Range = 25;
        HitPart = "Head";
        IgnoreFriends = true;
    };
    Misc = {
        AntiScreenEffects = false;
    }
}


    function GrenadeAuraFunction()
        warn("oooooooooo")
        function giveItem(item)
            local args = {
                [1] = game:GetService("Players").LocalPlayer.Character,
                [2] = game:GetService("ReplicatedStorage").Assets.Loadout.Primary:FindFirstChild("Pump Shotgun")
            }
            
            game:GetService("ReplicatedStorage").AddTool:FireServer(unpack(args))    
        end
        
        function throwGrenade(direction)
            local args = {
                [1] = direction,
                [2] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Frag Grenade") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Incendiary Grenade")
            }
            
            game:GetService("ReplicatedStorage").Assets.Remotes.throwGrenade:FireServer(unpack(args)) 
        end

        local function GetClosest()
            local Players = game:GetService("Players")
            local LocalPlayer = game.Players.LocalPlayer
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            if not (Character or HumanoidRootPart) then return end
        
            local TargetDistance = math.huge
            local Target
        
            for i,v in ipairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local TargetHRP = v.Character.HumanoidRootPart
                    local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
                    if mag < TargetDistance then
                        TargetDistance = mag
                        Target = v
                    end
                end
            end
        
            return Target
        end


        coroutine.wrap(function()
            if game.Players.LocalPlayer.Character.Humanoid and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
                if getgenv().SettingsRedbox2.GrenadeAura.Type == "Mouse Position" then
                    local tool = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Frag Grenade") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Incendiary Grenade")
                    if tool ~= nil then
                        tool.Parent = game.Players.LocalPlayer.Character
                        local mouse = game.Players.LocalPlayer:GetMouse()
                        local pos = mouse.Hit.Position
                        throwGrenade(pos)
                        warn("Mouse Position")
                    end
                elseif getgenv().SettingsRedbox2.GrenadeAura.Type == "Closest" then
                    local tool = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Frag Grenade") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Incendiary Grenade")
                    if tool ~= nil and GetClosest() then
                        warn("Closest")
                        tool.Parent = game.Players.LocalPlayer.Character
                        throwGrenade(GetClosest().Character.HumanoidRootPart.Position)
                    end
                end
            end
        end)()
    end

    function MeleeAura()
        local function GetClosest()
            local Players = game:GetService("Players")
            local LocalPlayer = game.Players.LocalPlayer
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            if not (Character or HumanoidRootPart) then return end
        
            local TargetDistance = getgenv().SettingsRedbox2.MeleeAura.Range
            local Target
        
            for i,v in ipairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local TargetHRP = v.Character.HumanoidRootPart
                    local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
                    if mag < TargetDistance then
                        if getgenv().SettingsRedbox2.MeleeAura.IgnoreFriends == true then
                            if not v:IsFriendsWith(game.Players.LocalPlayer.UserId) then
                                TargetDistance = mag
                                Target = v
                            end
                        else
                            TargetDistance = mag
                            Target = v
                        end
                    end
                    
                end
            end
        
            return Target
        end

        local function damage(hitpart,tool)
            local args = {
                [1] = hitpart,
                [2] = Vector3.new(182.07310485839844, 5.787327289581299, -430.5772705078125),
                [3] = Vector3.new(-0.783150851726532, 0.18024331331253052, -0.5951363444328308),
                [4] = Enum.Material.Plastic,
                [5] = CFrame.new(Vector3.new(-0.159149169921875, -0.2970867156982422, 1.0000152587890625), Vector3.new(0.00001424551010131836, 7.227063179016113e-07, 1.0000001192092896)),
                [6] = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool")
            }
            
            
            game:GetService("ReplicatedStorage").Assets.Remotes.hitMelee:FireServer(unpack(args))
            game:GetService("ReplicatedStorage").Assets.Remotes.hitMelee:FireServer(unpack(args))
        end

        if game.Players.LocalPlayer.Character.Humanoid and game.Players.LocalPlayer.Character.Humanoid.Health > 0 and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and GetClosest() then
            warn("meeeeee me me mee")
            local melee = game.Players.LocalPlayer:FindFirstChildOfClass("Tool")
            if GetClosest().Character:FindFirstChild(getgenv().SettingsRedbox2.MeleeAura.HitPart) then
                damage(GetClosest().Character:FindFirstChild(getgenv().SettingsRedbox2.MeleeAura.HitPart),melee)
            end
        end
    end

local Window = Library:Window({
   Text = "Redbox 2 - GtaModMenu"
})

local Tab = Window:Tab({
   Text = "Grenade Aura"
})

local Tab2 = Window:Tab({
    Text = "Melee Aura"
 })

 local Tab3 = Window:Tab({
    Text = "Misc"
 })

local Section = Tab:Section({
   Text = "Main"
})

local Section2 = Tab2:Section({
    Text = "Main"
 })

 local Section3 = Tab3:Section({
    Text = "Main"
 })

 local Section4 = Tab3:Section({
    Text = "Mass Items"
 })


 
Section:Toggle({
    Text = "Grenade Aura",
    Callback = function(bool)
        getgenv().SettingsRedbox2.GrenadeAura.Toggle = bool;
    end
 })

 Section2:Toggle({
    Text = "Melee Aura",
    Callback = function(bool)
        getgenv().SettingsRedbox2.MeleeAura.Toggle = bool;
    end
 })

local drop = Section:Dropdown({
   Text = "Type",
   List = {"Closest", "Mouse Position"},
   Callback = function(v)
    warn(v)
    getgenv().SettingsRedbox2.GrenadeAura.Type = v
   end
})

Section2:Slider({
   Text = "Range",
   Default = 25,
   Minimum = 0,
   Maximum = 1000,
   Callback = function(v)
      --warn(v)
      getgenv().SettingsRedbox2.MeleeAura.Range = v
   end
})

Section2:Toggle({
    Text = "Ignore Friends",
    Callback = function(bool)
        getgenv().SettingsRedbox2.MeleeAura.IgnoreFriends = bool;
    end
 })

local drop = Section2:Dropdown({
    Text = "Hit Part",
    List = {"Head", "HumanoidRootPart","Left Arm","Right Arm","Left Leg","Right Leg"},
    Callback = function(v)
     --warn(v)
     getgenv().SettingsRedbox2.MeleeAura.HitPart = v
    end
 })

 Section3:Toggle({
    Text = "Anti-Screen Effects",
    Callback = function(bool)
        getgenv().SettingsRedbox2.Misc.AntiScreenEffects = bool;
    end
 })

local e
local amount

 local drop = Section4:Dropdown({
    Text = "Item",
    List = {"Frag Grenade","Incendiary Grenade"},
    Callback = function(v)
        e = v
    end
 })

 Section4:Slider({
    Text = "Amount",
    Default = 400,
    Minimum = 0,
    Maximum = 600,
    Callback = function(v)
       --warn(v)
       amount = v
    end
 })
 


 Section4:Button({
    Text = "Spawn Items",
    Callback = function()
        if e and amount then
            for i = 1,tonumber(amount) do
                local args = {
                    [1] = game:GetService("Players").LocalPlayer.Character,
                    [2] = game:GetService("ReplicatedStorage").Assets.Loadout.Misc:FindFirstChild(e)
                }
                
                game:GetService("ReplicatedStorage").AddTool:FireServer(unpack(args)) 
            end   
        end
    end
 })


--[[Section:Slider({
   Text = "Speed",
   Default = 25,
   Minimum = 0,
   Maximum = 200
}})
]]



--[[
    Section:Button({
   Text = "Refresh Dropdown",
   Callback = function()
       drop:Remove("Test")
       wait(2)
       drop:Add("123")
   end
})
]]

Tab:Select()

task.spawn(function()
    coroutine.wrap(function()
        while wait(.1) do
            if getgenv().SettingsRedbox2.GrenadeAura.Toggle == true then
                GrenadeAuraFunction();
            end

            if getgenv().SettingsRedbox2.MeleeAura.Toggle == true then
                MeleeAura();
            end

            if getgenv().SettingsRedbox2.Misc.AntiScreenEffects == true then
                coroutine.wrap(function()
                    while wait() do
                        if game.Workspace.CurrentCamera:FindFirstChildOfClass("ColorCorrectionEffect") then
                            game.Workspace.CurrentCamera:FindFirstChildOfClass("ColorCorrectionEffect"):Destroy()
                        elseif game.Workspace.CurrentCamera:FindFirstChildOfClass("BlurEffect") then
                            game.Workspace.CurrentCamera:FindFirstChildOfClass("BlurEffect"):Destroy()
                        end
                    end
                end)()
            end
        end
    end)()
end)
