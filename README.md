# ZonitoCurves
A module made to make Bezier Curves easier to manage in Roblox LuaU




 #######                              
      #   ####  #    # # #####  ####  
     #   #    # ##   # #   #   #    # 
    #    #    # # #  # #   #   #    # 
   #     #    # #  # # #   #   #    # 
  #      #    # #   ## #   #   #    # 
 #######  ####  #    # #   #    ####  
                                      

made this
hi :)

Ok so heres a quick explanation of how to use this, plus some examples

This module generates a bezier curve using math, then moves a part across the curve.
To be used for VFX or general visual effects

CubicCurve1() will automatically generate the correct speed and distance to move your part at.
CubicCurve2() will move the part with a 100% chance for the part to reach the end, no matter what speed you give it.

### *CubicCurve1* ###

	CubicCurve1(Bullet, StartPosition, EndPosition, Rotation, Velocity, Lifetime)
	
	Bullet = The part you're moving across the curve
	StartPosition = The Vector3 position of where the Bullet should start
	EndPosition = The Vector3 position of where the Bullet should end
	Rotation = The angle that the curve should base off of... eg: Vector3.new(10,90,0)
	Velocity = The base speed of the Bullet, integer only pls :)
	Lifetime = How long the Bullet has to finish the curve; if it doesn't finish the curve in this time... it will end the function early
	
	Notes:
	
	1# You **DO** have to set the Bullets parent under workspace beforehand. The script does not do it automatically
	2# The script doesn't include a hitbox. You have to do that yourself, the script returns 'Curve finished' once the lifetime or curve is up. Use that to your advantage.
	
	
### *CubicCurve2* ###

	CubicCurve2(Bullet, StartPosition, EndPosition, Speed, XCurve , YCurve, ZCurve)
	
	Bullet = The part you're moving across the curve
	StartPosition = The Vector3 position of where the Bullet should start
	EndPosition = The Vector3 position of where the Bullet should end
	Speed = The base speed of the Bullet, Minimum: 0.01 Maximum 0.1
	XCurve = The X value of the Vector3 that the curve will use
	YCurve = The Y value of the Vector3 that the curve will use
	ZCurve = The Z value of the Vector3 that the curve will use
		
	Notes:
	
	1# You **DO** have to set the Bullets parent under workspace beforehand. The script does not do it automatically
	2# The script doesn't include a hitbox. You have to do that yourself, the script returns 'Curve finished' once the lifetime or curve is up. Use that to your advantage.	
	
	
### EXAMPLES ###

	CubicCurve1(
	workspace.Part,
	game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
	game.Players.LocalPlayer:GetMouse().Hit.Position,
	Vector3.new(0,90,0),
	20.0,
	10.0
	)

	CubicCurve2(
	workspace.Part,
	game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
	game.Players.LocalPlayer:GetMouse().Hit.Position,
	0.03,
	0,
	90,
	0
	)

