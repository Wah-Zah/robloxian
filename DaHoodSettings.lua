-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Wah-Zah/robloxian/main/Aiming.lua"))()
Aiming.TeamCheck(false)

-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera

local DaHoodSettings = {
    Prediction = 0.165,

    SilentAim = true,
    PingBasedPred = false,
    AimLock = false,
    AimLockKeybind = Enum.KeyCode.E,
    BeizerLock = {
        Enabled = true,
        Smoothness = 0.05,
        CurvePoints = {
            Vector2.new(0.83, 0),
            Vector2.new(0.17, 1)
        }
    }
}
getgenv().DaHoodSettings = DaHoodSettings

-- // Overwrite to account downed
function Aiming.Check()
    -- // Check A
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end

    -- // Check if downed
    local Character = Aiming.Character(Aiming.Selected)
    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil

    -- // Check B
    if (KOd or Grabbed) then
        return false
    end

    -- //
    return true
end

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check if it trying to get our mouse's hit or target and see if we can use it
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        -- // Vars
        local SelectedPart = Aiming.SelectedPart

        -- // Hit/Target
        if (DaHoodSettings.SilentAim and (k == "Hit" or k == "Target")) then
            -- // Hit to account prediction
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

            -- // Return modded val
            return (k == "Hit" and Hit or SelectedPart)
        end
    end

    -- // Return
    return __index(t, k)
end)

-- // Aimlock
RunService:BindToRenderStep("AimLock", 0, function()
    if (DaHoodSettings.AimLock and Aiming.Check() and UserInputService:IsKeyDown(DaHoodSettings.AimLockKeybind)) then
        -- // Vars
        local SelectedPart = Aiming.SelectedPart

        -- // Hit to account prediction
        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)
        local HitPosition = Hit.Position

        -- //
        local BeizerLock = DaHoodSettings.BeizerLock
        if (BeizerLock.Enabled) then
            -- // Work out in 2d
            local Vector, _ = CurrentCamera:WorldToViewportPoint(HitPosition)
            local Vector2D = Vector2.new(Vector.X, Vector.Y)

            -- // Aim
            Aiming.BeizerCurve.AimTo({
                TargetPosition = Vector2D,
                Smoothness = BeizerLock.Smoothness,
                CurvePoints = BeizerLock.CurvePoints
            })
        else
            -- // Set the camera to face towards the Hit
            CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, HitPosition)
        end
    end
end)
-- // Auto Prediction
if DaHoodSettings.PingBasedPred == true then
    wait(1.5)
        local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        local split = string.split(pingvalue,'(')
        local ping = tonumber(split[1])
            local PingNumber = pingValue[1]

 if  ping < 300 then
    DaHoodSettings.Prediction = 0.610
elseif ping < 290 then
    DaHoodSettings.Prediction = 0.515
elseif ping < 280 then
    DaHoodSettings.Prediction = 0.500
elseif ping < 270 then
    DaHoodSettings.Prediction = 0.470
        elseif ping < 260 then
            DaHoodSettings.Prediction = 0.459
        elseif ping < 250 then
            DaHoodSettings.Prediction = 0.440
        elseif ping < 240 then
            DaHoodSettings.Prediction = 0.439
        elseif ping < 230 then
            DaHoodSettings.Prediction = 0.359
        elseif ping < 220 then
            DaHoodSettings.Prediction = 0.326
        elseif ping < 210 then
            DaHoodSettings.Prediction = 0.249
        elseif ping < 200 then
            DaHoodSettings.Prediction = 0.210
        elseif ping < 190 then
            DaHoodSettings.Prediction = 0.197
        elseif ping < 180 then
            DaHoodSettings.Prediction = 0.185
        elseif ping < 170 then
            DaHoodSettings.Prediction = 0.180
        elseif ping < 160 then
            DaHoodSettings.Prediction = 0.175
        elseif ping < 150 then
            DaHoodSettings.Prediction = 0.170
        elseif ping < 130 then
            DaHoodSettings.Prediction = 0.146
        elseif ping < 120 then
            DaHoodSettings.Prediction = 0.140
        elseif ping < 110 then
            DaHoodSettings.Prediction = 0.140
        elseif ping < 105 then
            DaHoodSettings.Prediction = 0.140
        elseif ping < 90 then
            DaHoodSettings.Prediction = 0.137
        elseif ping < 80 then
            DaHoodSettings.Prediction = 0.135
        elseif ping < 70 then
            DaHoodSettings.Prediction = 0.132
        elseif ping < 60 then
            DaHoodSettings.Prediction = 0.130
        elseif ping < 50 then
            DaHoodSettings.Prediction = 0.125
        elseif ping < 40 then
            DaHoodSettings.Prediction = 0.125
        end
    end
