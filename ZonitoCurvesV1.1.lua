local ZC = {}

--[[   Introduction   ]]--
--[[


��_____�����������_�_��������
�|__��/___��_�__�(_)�|_�___��
���/�//�_�\|�'_�\|�|�__/�_�\�
��/�/|�(_)�|�|�|�|�|�||�(_)�|
�/____\___/|_|�|_|_|\__\___/�
�����������������������������


Most recent update
12/08/2023 
15:30 UTC+1
�����������
*Added hitboxes*
�������������������������
made this
hi :)

Ok so heres a quick explanation of how to use this, plus some examples

This module generates a bezier curve using math, then moves a part across the curve.
To be used for VFX or general visual effects

CubicCurve1() will automatically generate the correct speed and distance to move your part at.

CubicCurve2() will move the part across a Cubic bezier with a 100% chance for the part to reach the end, no matter what speed you give it.

QuadraticCurve2() will move the part across a Quadratic bezier with a 100% chance for the part to reach the end, no matter what speed you give it.

### *CubicCurve1* ###

	CubicCurve1(Bullet, StartPosition, EndPosition, Rotation, Velocity, Lifetime, HitFunction)
	
	Bullet = The part you're moving across the curve
	StartPosition = The Vector3 position of where the Bullet should start
	EndPosition = The Vector3 position of where the Bullet should end
	Rotation = The angle that the curve should base off of... eg: Vector3.new(10,90,0)
	Velocity = The base speed of the Bullet, integer only pls :)
	Lifetime = How long the Bullet has to finish the curve; if it doesn't finish the curve in this time... it will end the function early
	LookAtCurve = Determines if the Bullet will point towards the next direction (Boolean)
	HitFunction = The function that will run after the curve is finished, or hits something
	MoveFunction = The function that will run every time the Bullet moves
	
	Notes:
	
	1# You **DO** have to set the Bullets parent under workspace beforehand. The script does not do it automatically
	2# The script **DOES** include a hitbox. 'HitFunction' will be given everything that was hit, use that to your advantage
	
	
### *CubicCurve2* ###

	CubicCurve2(Bullet, StartPosition, EndPosition, Speed, Key1, Key2, Key3, HitFunction)
	
	Bullet = The part you're moving across the curve
	StartPosition = The Vector3 position of where the Bullet should start
	EndPosition = The Vector3 position of where the Bullet should end
	Speed = The base speed of the Bullet, Minimum: 0.01 Maximum 0.1
	Key1 = The first Vector3 KeyPoint
	Key2 = The second Vector3 KeyPoint
	Key3 = The third Vector3 KeyPoint
	LookAtCurve = Determines if the Bullet will point towards the next direction (Boolean)
	HitFunction = The function that will run after the curve is finished, or hits something
	MoveFunction = The function that will run every time the Bullet moves
		
	Notes:
	
	1# You **DO** have to set the Bullets parent under workspace beforehand. The script does not do it automatically
	2# The script **DOES** include a hitbox. 'HitFunction' will be given everything that was hit, use that to your advantage
	
	
### *QuadraticCurve2* ###

	QuadraticCurve2(Bullet, StartPosition, EndPosition, Speed, Key, HitFunction)
	
	Bullet = The part you're moving across the curve
	StartPosition = The Vector3 position of where the Bullet should start
	EndPosition = The Vector3 position of where the Bullet should end
	Speed = The base speed of the Bullet, Minimum: 0.01 Maximum 0.1
	Key = The Vector3 Keypoint
	LookAtCurve = Determines if the Bullet will point towards the next direction (Boolean)
	HitFunction = The function that will run after the curve is finished, or hits something
	MoveFunction = The function that will run every time the Bullet moves
	
	1# You **DO** have to set the Bullets parent under workspace beforehand. The script does not do it automatically
	2# The script **DOES** include a hitbox. 'HitFunction' will be given everything that was hit, use that to your advantage
	

### *CreateHitbox* ###

	CreateHitbox(HitboxPart, IgnoreParams, HitFunction, Cooldown)
	
	HitboxPart = The part that the hitbox will form on
	IgnoreParams = A table of things you want to hitbox to ignore, such as your own character
	HitFunction = The function that will fire once the hitbox hits a Character, is returned with the Hit Humanoid
	Cooldown = How long the script waits before allowing the hit character to be hit by a hitbox again
	
	1# This hitbox will only look for Characters with Humanoids: It will only be useful in Combat or VFX
	
	
### EXAMPLES ###

	local function Hitfunction(projectile)

		print("Function fired!")

	end
	
	local function MoveFunction(projectile)
	
		print(projectile.Name.." Moved!")
	
	end
	
	CubicCurve1(
	workspace.Part,
	game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
	game.Players.LocalPlayer:GetMouse().Hit.Position,
	90,
	20.0,
	10.0,
	false,
	Hitfunction,
	MoveFunction
	)

	CubicCurve2(
	workspace.Part,
	game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
	game.Players.LocalPlayer:GetMouse().Hit.Position,
	0.03,
	Vector3.new(0,90,0),
	Vector3.new(30,90,0),
	Vector3.new(10,90,0),
	false,
	Hitfunction,
	MoveFunction
	)



	
	QuadraticCurve2(
	workspace.Part,
	game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
	game.Players.LocalPlayer:GetMouse().Hit.Position,
	0.03,
	Vector3.new(0,90,0),
	false,
	Hitfunction,
	MoveFunction
	)
	
	CreateHitbox(
	workspace.Part,
	{game.Players.LocalPlayer.Character,workspace.Ignore},
	Hitfunction,
	5
	)
	
]]


local BZ_NUM_SAMPLE_POINTS = 1000 -- Used for math, dont change unless ur high iq
local BZ_ARC_RADIUS = 20 -- self explanatory, dont change unless ur high iq

--- You customize these in the functions, these are just the default settings if u forget to define them

local BULLET_VELOCITY = 20.0 -- studs / second 
local BULLET_MAX_LIFETIME = 60.0 -- seconds

--- Services

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

--- Functions

function lerp(a, b, c) -- Linear interpolation 
	
	return a + (b - a) * c
	
end;
local function CubicBezier(t, p0, p1, p2, p3) -- This is the squashed formula... we aren't using this bc I wanted to leave an example of how it works in the script
	return (1-t)^3*p0+3*(1-t)^2*t*p1+3*(1-t)^2*p2+t^3*p3
end;
local function QuadraticBezier(t,p0,p1,p2)

	return (1-t)^2*p0+2*(1-t)*t*p1+t^2*p2 -- Squashing this down cus there's really no point in doing it all manually

end;

function LookToFunction(Speed,StartPosition,KeyPoint1,KeyPoint2,KeyPoint3,EndPosition,i)
	
	local i2 = i+Speed
	
	local One=lerp(StartPosition,KeyPoint1,i2)
	local Two=lerp(KeyPoint1,EndPosition,i2)
	local Three=lerp(KeyPoint2,EndPosition,i2)
	local Four=lerp(KeyPoint3,EndPosition,i2)

	local One_Two=lerp(One,Two,i2)
	local Two_Two=lerp(Two,Three,i2)
	local Three_Two=lerp(Three,Four,i2)

	local One_Three=lerp(One_Two,Two_Two,i2)
	local Two_Three=lerp(Two_Two,Three_Two,i2)
	local Path=lerp(One_Three,Two_Three,i2)
	
	return Path
	
end

local function LookToFunction1(Speed,StartPosition,EndPosition,KeyPoint1,KeyPoint2)
	
	local i2 = Speed+0.001
	
	local A = cubicBezier(i2,StartPosition,KeyPoint1,KeyPoint2,EndPosition)
	
	return A

end

local function LookToFunction2(Speed,StartPosition,EndPosition,KeyPoint1,i)
	
	local i2 = i+Speed
	local A = QuadraticBezier(i2,StartPosition,KeyPoint1,EndPosition)
	return A
end

function cubicBezier(t, p0, p1, p2, p3)
	
	-- t = % Of completion from 0 - 1
	-- p0 = Start position
	-- p1 = First control point
	-- p2 = Second control point
	-- p3 = End position
	
	local l1 = lerp(p0, p1, t)
	local l2 = lerp(p1, p2, t)
	local l3 = lerp(p2, p3, t)
	
	local a = lerp(l1, l2, t)
	local b = lerp(l2, l3, t)
	
	local cubic = lerp(a, b, t)
	
	return cubic
	
end


function cubicBzLength(p0, p1, p2, p3) -- This function takes a bezier curve and calculates the correct speed to travel at
	
	local calcLength = function(n, func, ...)
		
		local sum, ranges, sums = 0, {}, {}
		
		for i = 0, n-1 do
			
			local p1, p2 = func(i/n, ...), func((i+1)/n, ...)
			
			local dist = (p2 - p1).magnitude
			
			ranges[sum] = {dist, p1, p2}
			
			table.insert(sums, sum)
			
			sum = sum + dist
			
		end
		
		return sum, ranges, sums
		
	end

	local sum = calcLength(BZ_NUM_SAMPLE_POINTS, cubicBezier, p0, p1, p2, p3)
	
	return sum
	
end

--- The actual module functions

function ZC.CubicCurve1(Bullet, StartPosition, EndPosition, Rotation, Velocity, Lifetime, LookTo, HitFunction, MoveFunction) -- Calculates bullet speed for u :)
	
	local RayParams = RaycastParams.new()
	RayParams.FilterDescendantsInstances = {}
	RayParams.FilterType = Enum.RaycastFilterType.Exclude
	
	coroutine.wrap(function()
		
		local bullet = Bullet
		local Db = false
		-- calculate the path
		local startingCFrame = CFrame.new(StartPosition,EndPosition)
		local targetCFrame = CFrame.new(EndPosition,StartPosition)

		-- calculate the control points as Vector3s
		-- p1 and p2 will be right angles to the starting and ending positions, but rotated based on input
		local p0 = (startingCFrame).Position
		local p1 = (startingCFrame + (startingCFrame:ToWorldSpace(CFrame.Angles(0, 0, math.rad(Rotation))).RightVector * BZ_ARC_RADIUS)).Position
		local p2 = (targetCFrame + (targetCFrame:ToWorldSpace(CFrame.Angles(0, 0, math.rad(-Rotation))).RightVector * -BZ_ARC_RADIUS)).Position -- EUW MATH
		local p3 = (targetCFrame).Position

		-- calculate the length of the curve
		local distance = cubicBzLength(p0, p1, p2, p3) -- Distance in studs

		-- Calculate length / time
		local totalTime = distance / (Velocity or BULLET_VELOCITY) -- Time in seconds
		local startingTime = tick()

		-- Localization
		local connection -- naming it connection cus im so creative

		connection = RunService.Heartbeat:Connect(function(step)
			
			-- calculate the percentage complete based on how much time has passed
			local passedTime = tick() - startingTime
			local alpha = passedTime / totalTime

			-- Moving the projectile
			local updatedPos = cubicBezier(alpha, p0, p1, p2, p3) -- Alpha = %
			bullet.Position = updatedPos
			if LookTo then
				
				local Next=LookToFunction1(alpha,p0,p3,p1,p2)
				
				bullet.CFrame = CFrame.lookAt(bullet.Position,Next)
				
			end
			if MoveFunction then MoveFunction(bullet) end
			
			if  totalTime > (Lifetime or BULLET_MAX_LIFETIME) then
				if Db == false then
				Db = true
					task.delay(Lifetime,function()
					
						connection:Disconnect()
						return "Curve finished"
					
					end)
				end
				
			end
			
			if alpha > 1 then -- Once the curve ends, or the projectile runs out of time...

				
				connection:Disconnect() -- Stop
				
				if HitFunction then HitFunction(bullet) end
				
				return "Curve finished" -- In your script you can check for this being returned, then do hitboxes or whatever
				
			end
			
		end)
		
	end)()
	
end




function ZC.CubicCurve2(Bullet, StartPosition, EndPosition, Speed, Key1, Key2, Key3, LookAtCurve, HitFunction, MoveFunction)
	
	coroutine.wrap(function() -- "EWW WHY R U USING COROUTINES???" shut up :(
		
		local Projectile = Bullet
		Projectile.Name = Bullet.Name

		Projectile.Position = StartPosition

		local StartPosition = StartPosition
		local EndPosition = EndPosition
		
		local KeyPoint1 = (StartPosition + EndPosition) / 2 + Key1
		local KeyPoint2 = (StartPosition + EndPosition) / 2 + Key2
		local KeyPoint3 = (StartPosition + EndPosition) / 2 + Key3
		-- StartPosition + EndPosition / 2 = The middle point between start and end



		for i = 0,1,Speed do -- Keep speed under 0.05 pls
			
			
			local One=lerp(StartPosition,KeyPoint1,i) -- ok i literally cba to explain whats going on here so um
			local Two=lerp(KeyPoint1,EndPosition,i) -- math is happening ok
			local Three=lerp(KeyPoint2,EndPosition,i)
			local Four=lerp(KeyPoint3,EndPosition,i)

			local One_Two=lerp(One,Two,i)
			local Two_Two=lerp(Two,Three,i)
			local Three_Two=lerp(Three,Four,i)

			local One_Three=lerp(One_Two,Two_Two,i)
			local Two_Three=lerp(Two_Two,Three_Two,i)
			local Path=lerp(One_Three,Two_Three,i)
		
			Projectile.Position = Path -- yes and it moves projectile to that position. yes.
			if LookAtCurve then local Next=LookToFunction(Speed,StartPosition,KeyPoint1,KeyPoint2,KeyPoint3,EndPosition,i); Projectile.CFrame = CFrame.lookAt(Projectile.Position,Next) end
			if MoveFunction then MoveFunction(Projectile) end
			
			task.wait() -- do NNOT REMOVE THE GOSH DARN WAIT PLS
			
		end
		
		HitFunction(Projectile)
		
		return "Curve finished" -- In your script you can check for this being returned, then do hitboxes or whatever
		
	end)()
	
end

function ZC.QuadraticCurve2(Bullet, StartPosition, EndPosition, Speed, Key, LookTo, HitFunction, MoveFunction)
	
	coroutine.wrap(function() -- "EWW WHY R U USING COROUTINES???" shut up :(

		local Projectile = Bullet

		Projectile.Position = StartPosition

		local StartPosition = StartPosition
		local EndPosition = EndPosition

		local KeyPoint = (StartPosition + EndPosition) / 2 + Key

		-- StartPosition + EndPosition / 2 = The middle point between start and end



		for i = 0,1,Speed do -- Keep speed under 0.05 pls

			local Path = QuadraticBezier(i,StartPosition,KeyPoint,EndPosition)
			
			Projectile.Position = Path -- yes and it moves projectile to that position. yes.
			if LookTo then 
				
				local Next = LookToFunction2(Speed,StartPosition,EndPosition,KeyPoint,i)
				Projectile.CFrame = CFrame.lookAt(Projectile.Position,Next)
				
			end
			if MoveFunction then MoveFunction(Projectile) end

			task.wait() -- do NNOT REMOVE THE GOSH DARN WAIT PLS

		end
		
		
		if HitFunction then HitFunction(Projectile) end
		
		return "Curve finished" -- In your script you can check for this being returned, then do hitboxes or whatever

	end)()
	
	
end
	
function ZC.CreateHitbox(HitboxPart, IgnoreParams, HitFunction, Cooldown)
	
	local OP = OverlapParams.new()
	OP.FilterDescendantsInstances = IgnoreParams
	OP.FilterType = Enum.RaycastFilterType.Exclude
	
	local Hitbox = workspace:GetPartsInPart(HitboxPart,OP)
	
	for _,Hit in pairs(Hitbox) do
		
		local Hit_Character = Hit.Parent
		local Hit_Humanoid = Hit_Character:FindFirstChildOfClass("Humanoid")
		
		if Hit_Humanoid then
			
			if not Hit_Humanoid:FindFirstChild("ZonitoDebounce") then
				
				local Debounce = Instance.new("BoolValue")
				Debounce.Name = "ZonitoDebounce"
				Debounce.Parent = Hit_Humanoid
				
				task.delay(Cooldown,function()
					
					Debounce:Destroy()
					
				end)
				
				HitFunction(Hit_Humanoid) 
				
			end
			
		end
		
	end
	
end
	
	
	
	
	
--- End

return ZC
