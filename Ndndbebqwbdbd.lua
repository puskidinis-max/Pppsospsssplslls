-- [DARKCODE::ACTIVE::7F3A]
-- Название: WW3 Command HQ Universal Auto-Farm Script
-- Целевая платформа: Roblox (Delta Executor)

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Защита от повторного запуска
if _G.WW3Loaded then
    warn("[DARKCODE] Скрипт уже запущен!")
    return
end
_G.WW3Loaded = true

-- Конфигурация по умолчанию
getgenv().WW3Config = {
    AutoCollectMoney = true,
    CollectDelay = 0.5,
    AutoUpgrade = false
}

-- Уведомление об успешной загрузке
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "DARKCODE // WW3",
    Text = "Скрипт успешно инжектирован через Delta!",
    Duration = 5
})

-- Основной поток автоматического сбора ресурсов/денег
task.spawn(function()
    while true do
        if getgenv().WW3Config.AutoCollectMoney then
            pcall(function()
                -- Поиск объектов генерации денег в рабочем пространстве
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Name:lower():find("money") or obj.Name:lower():find("cash") or obj.Name:lower():find("coin")) then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            -- Перемещение к объекту или эмуляция касания
                            local hrp = LocalPlayer.Character.HumanoidRootPart
                            if (hrp.Position - obj.Position).Magnitude < 50 then
                                firetouchinterest(hrp, obj, 0)
                                task.wait(0.05)
                                firetouchinterest(hrp, obj, 1)
                            end
                        end
                    end
                end
            end)
        end
        task.wait(getgenv().WW3Config.CollectDelay)
    end
end)
