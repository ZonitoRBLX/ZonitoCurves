# ZonitoCurves
A module made to make Bezier Curves easier to manage in Roblox LuaU

https://www.roblox.com/library/14393828608/ZonitoCurves

Made by zonit0 on discord


Most recent update
12/08/2023 
15:30 UTC+1
           
*Added hitboxes*


hi :3

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
	HitFunction = The function that will run after the curve is finished, or hits something
	
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
	HitFunction = The function that will run after the curve is finished, or hits something
		
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
	HitFunction = The function that will run after the curve is finished, or hits something
	
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

	local function Hitfunction()

		print("Function fired!")

	end
		
	CubicCurve1(
	workspace.Part,
	game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
	game.Players.LocalPlayer:GetMouse().Hit.Position,
	Vector3.new(0,90,0),
	20.0,
	10.0,
	Hitfunction
	)

	CubicCurve2(
	workspace.Part,
	game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
	game.Players.LocalPlayer:GetMouse().Hit.Position,
	0.03,
	Vector3.new(0,90,0),
	Vector3.new(30,90,0),
	Vector3.new(10,90,0),
	Hitfunction
	)



	
	QuadraticCurve2(
	workspace.Part,
	game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
	game.Players.LocalPlayer:GetMouse().Hit.Position,
	0.03,
	Vector3.new(0,90,0),
	Hitfunction
	)
	
	CreateHitbox(
	workspace.Part,
	{game.Players.LocalPlayer.Character,workspace.Ignore},
	Hitfunction,
	5
	)
	
