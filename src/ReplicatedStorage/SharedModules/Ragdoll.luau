-- / MAIN
local Ragdoll = {}

function Ragdoll.SetupRagdoll(char: Model)
	for _, joint in pairs(char:GetDescendants()) do
		if joint:IsA("Motor6D") then
			local a0 = Instance.new("Attachment")
			local a1 = Instance.new("Attachment")

			a0.Parent = joint.Part0
			a1.Parent = joint.Part1

			a0.CFrame = joint.C0
			a1.CFrame = joint.C1

			local bsc = Instance.new("BallSocketConstraint")
			bsc.Parent = joint.Parent
			bsc.Enabled = false
			bsc.Attachment0 = a0
			bsc.Attachment1 = a1

		end
	end
end

function Ragdoll.Ragdoll(char)
	local hum: Humanoid = char:WaitForChild("Humanoid")
	local hrp = char:WaitForChild("HumanoidRootPart")

	hum.PlatformStand = true

	for _, charObj in pairs(char:GetDescendants()) do
		if charObj:IsA("Motor6D") then
			local joint: Motor6D = charObj

			joint.Enabled = false
            continue
        end
		if charObj:IsA("BallSocketConstraint") then
			local bsc = charObj

			bsc.Enabled = true
            continue
        end
		if charObj.Name == "Head" then
			if not charObj:IsA("BasePart") then continue end

			local head = charObj				
			if head:FindFirstChild("HeadWeld") then continue end

			local hWeld = Instance.new("WeldConstraint")
			hWeld.Name = "HeadWeld"
			hWeld.Part1 = head
			hWeld.Part0 = hrp

			hWeld.Parent = head
		end

	end
end

function Ragdoll.Unragdoll(char)
	local hum: Humanoid = char:WaitForChild("Humanoid")

	hum.PlatformStand = false

	for _, charObj in pairs(char:GetDescendants()) do
		if charObj:IsA("Motor6D") then
			local joint: Motor6D = charObj

			joint.Enabled = true

		elseif charObj:IsA("bsc") then
			local bsc = charObj

			bsc.Enabled = false

		elseif charObj.Name == "Head" then
			if not charObj:IsA("BasePart") then	continue end			
			local head = charObj

			local hWeld = head:FindFirstChild("HeadWeld")
			if hWeld then
				hWeld:Destroy()

			end

		end
	end
end

function Ragdoll.SetCollision(char: Model)
	for _, limb in pairs(char:GetChildren()) do
		if not limb:IsA("BasePart") then continue end

		local collision = Instance.new("Part")
		collision.Size = limb.Size / 2 
		collision.CFrame = limb.CFrame * CFrame.new(0, -(limb.Size.Y / 2) + (collision.Size.Y / 2), 0)
		collision.Transparency = 1
		collision.Shape = Enum.PartType.Cylinder
		collision.Name = "Collision"
		
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = collision
		weld.Part1 = limb

		weld.Parent = collision
		collision.Parent = limb

		collision.CollisionGroup = "LimbsCollision"
	end

end

function Ragdoll.RemoveCollision(char)
	local hum: Humanoid = char:WaitForChild("Humanoid")

	for _, limb in pairs(char:GetChildren()) do
		local collision = limb:FindFirstChild("Collision")
		if not collision then continue end

		collision:Destroy()
	end

	hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

end

return Ragdoll