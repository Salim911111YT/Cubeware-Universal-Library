local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/magbux/BorealisUiLib/refs/heads/main/Library.Lua"))()
local plr = game:GetService("Players").LocalPlayer

local connections = {
	["ESP"] = nil
}

-- Create A Window (Put The Tab Name Behind The Section Name)
local Window = Library.new("CubeWare")

-- Create A Tab
local CombatTab = Window:MakeTab("Combat");
local TpTab = Window:MakeTab("Teleports");
local PerformanceTab = Window:MakeTab("Performance")

CombatTab:AddSlider({
	Name = "Hitbox Expander",
	Max = 80;
	Default = tonumber(plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed);
	Callback = function(Value)
		while task.wait(0.2) do
			for _, v in pairs(game:GetService("Players"):GetPlayers()) do
			if v ~= plr then
				local success, message = pcall(function()
					if Value > 0 then
						v.Character.HumanoidRootPart.Size = Vector3.new(Value, Value, Value)
						v.Character.HumanoidRootPart.CanCollide = false;
						v.Character.HumanoidRootPart.Transparency = 0.6;
						v.Character.HumanoidRootPart.Color = Color3.new(1, 0, 0)

						for _, y in pairs(v.Character:GetChildren()) do
							if y then
								if y:IsA("BasePart") then
									if v.Character:FindFirstAncestorOfClass("Humanoid").Health <= 0 then
										y.CanCollide = false
									end
								end
							end
						end
					elseif Value <= 0 then
						v.Character.HumanoidRootPart.Size = Vector3.new(2, 4, 2)
						v.Character.HumanoidRootPart.CanCollide = false;
						v.Character.HumanoidRootPart.Transparency = 0.6;
						v.Character.HumanoidRootPart.Color = Color3.new(1, 0, 0)

						for _, y in pairs(v.Character:GetChildren()) do
							if y then
								if y:IsA("BasePart") then
									if v.Character:FindFirstAncestorOfClass("Humanoid").Health <= 0 then
										y.CanCollide = false
									end
								end

								task.wait(0.025)
							end

							task.wait(0.025)
						end
					end
				end)
			end
		end
		end
	end
})

CombatTab:AddSlider({
	Name = "Speed Increaser",
	Max = 60;
	Default = 16;
	Callback = function(Value)
		while task.wait(0.05) do
			pcall(function()
				if plr.Character:FindFirstChildOfClass("Humanoid") then
					plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = tonumber(Value)
				end
			end)
		end
	end
})

CombatTab:AddSlider({
	Name = "Jump Height Increaser",
	Max = 20;
	Default = 7.2;
	Callback = function(Value)
		while task.wait(0.05) do
			pcall(function()
				if plr.Character:FindFirstChildOfClass("Humanoid") then
					plr.Character:FindFirstChildOfClass("Humanoid").JumpHeight = tonumber(Value)
				end
			end)
		end
	end
})

CombatTab:AddToggle({
	Name = "Anti Void";
	Callback = function(Value)
		if Value == true then
			local s = Instance.new("Part", workspace);

			s.Name = "AntiVoid";
			s.CanCollide = true;
			s.CFrame = plr.Character.PrimaryPart.CFrame - Vector3.new(0, 5, 0)
			s.Transparency = 0.6;
			s.Color = Color3.new(1, 1, 1);
			s.Anchored = true;
		elseif Value == false then
			if workspace:FindFirstChild("AntiVoid") then
				workspace:WaitForChild("AntiVoid"):Destroy()
			end
		end
	end
})

CombatTab:AddToggle({
	Name = "ESP (See All)";
	Callback = function(Value)
		if Value == true then
			for _, v in pairs(game:GetService("Players"):GetPlayers()) do
				if v ~= plr then
					if not v.Character:FindFirstChildOfClass("Highlight") then
						local h = Instance.new("Highlight", v.Character);

						h.Adoornee = v.Character.PrimaryPart;
						h.FillTransparency = 1;
						h.OutlineTransparency = 0;
						h.Name = "CubeWareHighlight"

						if #game:GetService("Teams"):GetChildren() >= 2 then
							print("hello")
						end
					end
				end
			end

			connections["ESP"] = game:GetService("Players").PlayerAdded:Connect(function(plr)
				plr.CharacterAdded:Connect(function()
					if not plr.Character:FindFirstChildOfClass("Highlight") then
						local h = Instance.new("Highlight", plr.Character);

						h.Adoornee = v.Character.PrimaryPart;
						h.FillTransparency = 1;
						h.OutlineTransparency = 0;
						h.Name = "CubeWareHighlight"

						if #game:GetService("Teams"):GetChildren() >= 2 then
							print("hello")
						end
					end
				end)
			end)
		elseif Value == false then
			for _ , v in pairs(game:GetService("Players"):GetPlayers()) do
				if v ~= plr then
					if v.Character:FindFirstChild("CubeWareHighlight") then
						v.Character:FindFirstChild("CubeWareHighlight"):Destroy()
					end
				end
			end

			if connections["ESP"] then
				connections["ESP"]:Disconnect()
				connections["ESP"] = nil
			end
		end	
	end
})

TpTab:AddButton({
	Name = "Invincible (Sends u to blackbox)";
	Callback = function()
		plr.Character.PrimaryPart.CFrame = CFrame.new(0, 10^15, 0)
	end
})

TpTab:AddButton({
	Name = "Home (Sends u to the origin of the game).";
	Callback = function()
		plr.Character.PrimaryPart.CFrame = CFrame.new(0, 0, 0)
	end
})

PerformanceTab:AddButton({
	Name = "No Textures",
	Callback = function()
		pcall(function()
			for _, v in pairs(game:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Material = Enum.Material["SmoothPlastic"]

					if v:FindFirstChildOfClass("SpecialMesh") then
						v.TextureId = "rbxassetid://0"
					end

					if v:FindFirstChildOfClass("Decal") or v:FindFirstChildOfClass("Texture") then
						for _, y in pairs(v:GetChildren()) do
							if y:IsA("Decal") or y:IsA("Texture") then
								y:Destroy()
							end	
						end
					end
				end
			end
		end)
	end
});

PerformanceTab:AddButton({
	Name = "No Meshes",
	Callback = function()
		pcall(function()
			for _, v in pairs(game:GetDescendants()) do
				if v:IsA("SpecialMesh") then
					v:Destroy()
				end
			end
		end)
	end
});

PerformanceTab:AddSlider({
	Name = "Brightness",
	Max = 5;
	Default = 0;
	Callback = function(Value)
		pcall(function()
			 game:GetService("Lighting").Brightness = Value;
			 game:GetService("Lighting").ExposureCompensation = Value 
		end)
	end
})
