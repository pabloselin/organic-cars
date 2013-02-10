function loadWorld()

    -- One meter is 32px in physics engine
	love.physics.setMeter( 32 )

	-- Create a world with standard gravity
	world = love.physics.newWorld(0, 9.81*32, true)

	-- Create the ground body at (0, 0) static
	ground = love.physics.newBody(world, 0, 0, "static")
	-- Create the ground shape at (400,500) with size (600,10).
	groundShape = love.physics.newRectangleShape(400, 500, 600, 10)
 	-- Create fixture between body and shape
	ground_fixture = love.physics.newFixture( ground, groundShape)
	ground_fixture:setUserData("Ground") -- Set a string userdata

	-- Create the floor body at (0 ,0) static
	floor = love.physics.newBody(world, 0, 0, "static")
	-- Create the floor shape at (400,500) with size (600,10).
	floorShape = love.physics.newRectangleShape(400, 100, 600, 10)
	-- Create fixture between body and shape
	floor_fixture = love.physics.newFixture( floor, floorShape)
	floor_fixture:setUserData("Floor") -- Set a string userdata
	
end