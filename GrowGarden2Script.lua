-- Script Grow a Garden 2 - Delta Executor
-- Kode awal random untuk identifikasi
local randomCode = math.random(1000, 9999)
print("=== SCRIPT AKTIF - KODE: "..randomCode.." ===")
wait()
print("Tekan ENTER untuk melanjutkan ke halaman utama...")

-- Deteksi tombol ENTER untuk masuk
local userInputService = game:GetService("UserInputService")
local enterPressed = false

userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Return and not enterPressed then
        enterPressed = true
        print("Memuat halaman utama...")
        
        -- Loading 10 detik
        wait(10)
        print("=== HALAMAN UTAMA SIAP ===")

        -- Variabel kontrol fitur
        local speedActive = false
        local flyActive = false
        local dupeActive = false
        local visible = false

        -- UI Fitur (sederhana di layar atas kanan)
        local gui = Instance.new("ScreenGui")
        gui.Name = "GardenHackGui"
        gui.Parent = game.Players.LocalPlayer.PlayerGui

        -- Fitur Kecepatan
        local speedFrame = Instance.new("Frame")
        speedFrame.Size = UDim2.new(0, 150, 0, 50)
        speedFrame.Position = UDim2.new(1, -160, 0, 20)
        speedFrame.BackgroundColor3 = Color3.new(0,0,0)
        speedFrame.BackgroundTransparency = 0.5
        speedFrame.Parent = gui

        local speedLabel = Instance.new("TextLabel")
        speedLabel.Size = UDim2.new(1,0,0.5,0)
        speedLabel.Position = UDim2.new(0,0,0,0)
        speedLabel.Text = "Kecepatan: Normal (1)"
        speedLabel.TextColor3 = Color3.new(1,1,1)
        speedLabel.BackgroundTransparency = 1
        speedLabel.Parent = speedFrame

        local speedPlusLabel = Instance.new("TextLabel")
        speedPlusLabel.Size = UDim2.new(1,0,0.5,0)
        speedPlusLabel.Position = UDim2.new(0,0,0.5,0)
        speedPlusLabel.Text = "+20 Tambahan"
        speedPlusLabel.TextColor3 = Color3.new(0,1,0)
        speedPlusLabel.BackgroundTransparency = 1
        speedPlusLabel.Parent = speedFrame

        -- Fitur Fly
        local flyFrame = Instance.new("Frame")
        flyFrame.Size = UDim2.new(0, 150, 0, 50)
        flyFrame.Position = UDim2.new(1, -160, 0, 80)
        flyFrame.BackgroundColor3 = Color3.new(0,0,0)
        flyFrame.BackgroundTransparency = 0.5
        flyFrame.Parent = gui

        local flyLabel = Instance.new("TextLabel")
        flyLabel.Size = UDim2.new(1,0,1,0)
        flyLabel.Text = "Fly: Non-Aktif (Kecepatan 10)"
        flyLabel.TextColor3 = Color3.new(1,1,1)
        flyLabel.BackgroundTransparency = 1
        flyLabel.Parent = flyFrame

        -- Fitur Dupe & Invisible
        local controlFrame = Instance.new("Frame")
        controlFrame.Size = UDim2.new(0, 150, 0, 60)
        flyFrame.Position = UDim2.new(1, -160, 0, 140)
        controlFrame.BackgroundColor3 = Color3.new(0,0,0)
        controlFrame.BackgroundTransparency = 0.5
        controlFrame.Parent = gui

        local controlLabel = Instance.new("TextLabel")
        controlLabel.Size = UDim2.new(1,0,0.6,0)
        controlLabel.Text = "Dupe Aktif | Invisible ON"
        controlLabel.TextColor3 = Color3.new(1,1,1)
        controlLabel.BackgroundTransparency = 1
        controlLabel.Parent = controlFrame

        local enterLabel = Instance.new("TextLabel")
        enterLabel.Size = UDim2.new(1,0,0.4,0)
        enterLabel.Position = UDim2.new(0,0,0.6,0)
        enterLabel.Text = "ENTER = Berhenti Semua"
        enterLabel.TextColor3 = Color3.new(1,0,0)
        enterLabel.BackgroundTransparency = 1
        enterLabel.Parent = controlFrame

        -- Fungsi Kecepatan
        local function setSpeed(active)
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                if active then
                    char.Humanoid.WalkSpeed = 21
                    speedLabel.Text = "Kecepatan: Aktif (21)"
                else
                    char.Humanoid.WalkSpeed = 1
                    speedLabel.Text = "Kecepatan: Normal (1)"
                end
                speedActive = active
            end
        end

        -- Fungsi Fly (gerakan layar ke atas 3 unit)
        local flySpeed = 10
        local function flyControl()
            while flyActive do
                wait()
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    -- Gerakan layar ke atas 3 unit setiap detik
                    char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 3/flySpeed, 0)
                end
            end
        end

        -- Fungsi Dupe Buah (metode dasar untuk game baru, bisa perlu disesuaikan)
        local function duplicateFruit()
            while dupeActive do
                wait(1)
                local player = game.Players.LocalPlayer
                local inventory = player:FindFirstChild("Inventory")
                if inventory then
                    for _, fruit in pairs(inventory:GetChildren()) do
                        if fruit:IsA("IntValue") or fruit:IsA("NumberValue") then
                            -- Salin jumlah buah dan tambahkan
                            local newCount = fruit.Value * 2
                            fruit.Value = newCount
                        end
                    end
                end
            end
        end

        -- Fungsi Invisible
        local function setInvisible(active)
            local char = game.Players.LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") or part:IsA("Decal") then
                        part.Transparency = active and 1 or 0
                    end
                end
                visible = not active
            end
        end

        -- Aktifkan semua fitur awal
        setSpeed(true)
        flyActive = true
        flyLabel.Text = "Fly: Aktif (Kecepatan 10)"
        spawn(flyControl)
        dupeActive = true
        spawn(duplicateFruit)
        setInvisible(true)

        -- Deteksi ENTER untuk berhenti
        userInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Return and enterPressed then
                -- Matikan semua fitur
                setSpeed(false)
                flyActive = false
                flyLabel.Text = "Fly: Non-Aktif (Kecepatan 10)"
                dupeActive = false
                setInvisible(false)
                gui:Destroy()
                print("=== SEMUA FITUR DIHENTIKAN ===")
            end
        end)
    end
end)
