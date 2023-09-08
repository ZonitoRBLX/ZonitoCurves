# ZonitoCurves
A module made to make Bezier Curves easier to manage in Roblox LuaU

[Click here to download the model](https://www.roblox.com/library/14393828608/ZonitoCurves)

[My roblox profile](https://www.roblox.com/users/3204456279/profile)

[ZonitoVisuals plugin](https://www.roblox.com/library/14693803086/ZonitoVisuals-v0-1) -- A plugin I made to visualise these curves and generate KeyPoints for this module.

Made by zonit0 on discord


Most recent update
08/09/2023
19:43 UTC+1


**Changelog**
+ Added HitFunction and MoveFunction
+ Fixed a bug where you'd be forced to use HitFunction
+ Improved flexibility
+ Improved readability
+ Updated example place


Ok so heres a quick explanation of how to use this, plus some examples

This module generates a bezier curve using math, then moves a part across the curve.
To be used for VFX or general visual effects

CubicCurve1() will automatically generate the correct speed and distance to move your part at.

CubicCurve2() will move the part across a Cubic bezier with a 100% chance for the part to reach the end, no matter what speed you give it.

QuadraticCurve2() will move the part across a Quadratic bezier with a 100% chance for the part to reach the end, no matter what speed you give it.

### *CubicCurve1* ###

	CubicCurve1(Bullet, StartPosition, EndPosition, Rotation, Velocity, Lifetime, HitFunction)
	
	Bullet = The part you're moving across the curve (Instance)
	StartPosition = The Vector3 position of where the Bullet should start (Position)
	EndPosition = The Vector3 position of where the Bullet should end (Position)
	Rotation = The angle that the curve should base off of (Vector3)
	Velocity = The base speed of the Bullet (Number)
	Lifetime = How long the Bullet has to finish the curve; if it doesn't finish the curve in this time... it will end the function early (Number)
 	LookTo = If the bullet will point towards / look at the next position on the curve. (Boolean)
	HitFunction = The function that will run after the curve is finished, or hits something (Function)
 	MoveFunction = The function that will run every time the Bullet moves (Function)
	
	Notes:
	
	1# You **DO** have to set the Bullets parent under workspace beforehand. The script does not do it automatically
	2# The script **DOES** include a hitbox. 'HitFunction' will be given everything that was hit, use that to your advantage
	
	
### *CubicCurve2* ###

	CubicCurve2(Bullet, StartPosition, EndPosition, Speed, Key1, Key2, Key3, HitFunction)
	
	Bullet = The part you're moving across the curve (Instance)
	StartPosition = The Vector3 position of where the Bullet should start (Position)
	EndPosition = The Vector3 position of where the Bullet should end (Position)
	Speed = The base speed of the Bullet, Minimum: 0.01 Maximum 0.1 (Number)
	Key1 = The first Vector3 KeyPoint (Vector3)
	Key2 = The second Vector3 KeyPoint (Vector3)
	Key3 = The third Vector3 KeyPoint (Vector3)
 	LookTo = If the bullet will point towards / look at the next position on the curve. (Boolean)
	HitFunction = The function that will run after the curve is finished, or hits something (Function)
	MoveFunction = The function that will run every time the Bullet moves (Function)
		
	Notes:
	
	1# You **DO** have to set the Bullets parent under workspace beforehand. The script does not do it automatically
	2# The script **DOES** include a hitbox. 'HitFunction' will be given everything that was hit, use that to your advantage
	
	
### *QuadraticCurve2* ###

	QuadraticCurve2(Bullet, StartPosition, EndPosition, Speed, Key, HitFunction)
	
	Bullet = The part you're moving across the curve (Instance)
	StartPosition = The Vector3 position of where the Bullet should start (Position)
	EndPosition = The Vector3 position of where the Bullet should end (Position)
	Speed = The base speed of the Bullet, Minimum: 0.01 Maximum 0.1 (Number)
	Key = The Vector3 Keypoint (Vector3)
 	LookTo = If the bullet will point towards / look at the next position on the curve. (Boolean)
	HitFunction = The function that will run after the curve is finished, or hits something (Function)
 	MoveFunction = The function that will run every time the Bullet moves (Function)
	
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

	local function Hitfunction(Projectile)

		print(`{Projectile} Has finished curving!`)

	end

	local function MoveFunction(Projectile)

		print(`{Projectile} Has moved!`)

  	end
   
	CubicCurve1(
	workspace.Part,
	game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
	game.Players.LocalPlayer:GetMouse().Hit.Position,
	Vector3.new(0,90,0),
	20.0,
	10.0,
 	true,
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
 	true,
	Hitfunction,
 	MoveFunction
	)

	QuadraticCurve2(
	workspace.Part,
	game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
	game.Players.LocalPlayer:GetMouse().Hit.Position,
	0.03,
	Vector3.new(0,90,0),
 	true,
	Hitfunction,
 	MoveFunction
	)
	
	CreateHitbox(
	workspace.Part,
	{game.Players.LocalPlayer.Character,workspace.Ignore},
	Hitfunction,
	5
	)
	
