function loadWorld()

    -- One meter is 32px in physics engine
	love.physics.setMeter( 32 )

	-- Create a world with standard gravity
	world = love.physics.newWorld(0, 9.81*32, true)
	bg = love.graphics.newImage("images/bg.jpg")

	-- Create the ground body at (0, 0) static
	ground = love.physics.newBody(world, 0, 0, "static")
	-- Create the ground shape at (400,500) with size (600,10).
	groundShape = love.physics.newRectangleShape(400, 580, 4000, 10)

 	-- Create fixture between body and shape
	ground_fixture = love.physics.newFixture( ground, groundShape)
	ground_fixture:setUserData("Ground") -- Set a string userdata

	-- Create the floor body at (0 ,0) static
	floor = love.physics.newBody(world, 0, 0, "static")
	-- Create the floor shape at (400,500) with size (600,10).
	floorShape = love.physics.newRectangleShape(400, 10, 4000, 10)
	-- Create fixture between body and shape
	floor_fixture = love.physics.newFixture( floor, floorShape)
	floor_fixture:setUserData("Floor") -- Set a string userdata	

	-- Create walls so the car doesnt fall
	-- Create the ground body at (0, 0) static
	wallLeft = love.physics.newBody(world, 0, 0, "static")
	wallLeftShape = love.physics.newRectangleShape(-1600, 15, 10, 1200)

	-- Create fixture between body and platform
	wallLeft_fixture = love.physics.newFixture( wallLeft, wallLeftShape)
	wallLeft_fixture:setUserData("Wall Left") -- Set a string userdata	

	-- Create walls so the car doesnt fall
	-- Create the ground body at (0, 0) static
	wallRight = love.physics.newBody(world, 0, 0, "static")
	wallRightShape = love.physics.newRectangleShape(1600, 15, 10, 1200)

	-- Create fixture between body and platform
	wallRight_fixture = love.physics.newFixture( wallRight, wallRightShape)
	wallRight_fixture:setUserData("Wall Left") -- Set a string userdata	

	randomPlatform()
	
end

-- TODO a Platform class function

function randomPlatform()
	-- Create a test platform
	-- Create the ground body at (0, 0) static
	plat = love.physics.newBody(world, 0, 0, "static")
	--Creates a random platform
	platShape = love.physics.newRectangleShape(math.random(100,1600), math.random(200,900), math.random(3000), 10)

	-- Create fixture between body and platform
	plat_fixture = love.physics.newFixture( plat, platShape)
	plat_fixture:setUserData("Platform") -- Set a string userdata	
end
