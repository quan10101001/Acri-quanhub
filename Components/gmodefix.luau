-- gmodefix.luau
-- Làm chân player thụt xuống đất (thân chạm sàn) trong khi vẫn di chuyển bình thường

local gmodefix = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Connection = nil
local Active = false

local SINK_HIP_HEIGHT = -2.35  -- HipHeight khi bật (âm = thân chạm sàn, chân hoàn toàn dưới đất)
local NORMAL_HIP_HEIGHT = 2.396 -- HipHeight mặc định của Roblox R15

function gmodefix.Enable()
    if Active then return end
    Active = true

    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")

    -- Set HipHeight thấp để chân thụt xuống đất, thân chạm sàn
    Humanoid.HipHeight = SINK_HIP_HEIGHT

    -- Giữ HipHeight ổn định mỗi frame (game có thể reset nó)
    Connection = RunService.Heartbeat:Connect(function()
        local Char = LocalPlayer.Character
        if not Char then return end
        local Hum = Char:FindFirstChildOfClass("Humanoid")
        if not Hum then return end

        if Active then
            Hum.HipHeight = SINK_HIP_HEIGHT
        end
    end)
end

function gmodefix.Disable()
    if not Active then return end
    Active = false

    if Connection then
        Connection:Disconnect()
        Connection = nil
    end

    local Character = LocalPlayer.Character
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid.HipHeight = NORMAL_HIP_HEIGHT
        end
    end
end

function gmodefix.Toggle()
    if Active then
        gmodefix.Disable()
    else
        gmodefix.Enable()
    end
end

function gmodefix.IsActive()
    return Active
end

-- Reset khi respawn
LocalPlayer.CharacterAdded:Connect(function(Character)
    if Active then
        local Humanoid = Character:WaitForChild("Humanoid")
        task.wait(0.1)
        Humanoid.HipHeight = SINK_HIP_HEIGHT
    end
end)

return gmodefix
