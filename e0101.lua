-- Example: Mini Physics Callbacks
-- Updated 0.8.0 by Bartoleo

text = "No collision yet."
grav = "Not seted yet"
particleImage = love.graphics.newImage("images/love-ball.png")
invertG = false
onGround = false
isJumping = false
impulse = -600
piValue = 3.14
--Particle Variables
systems = {}
current = 1

function love.load()

	-- Particle Start
	part1 = love.graphics.newImage("part1.png");
	cloud = love.graphics.newImage("cloud.png");
	square = love.graphics.newImage("square.png")
	font = love.graphics.newFont(love._vera_ttf, 10)

	love.graphics.setFont(font)
	love.graphics.setColor(200, 200, 200);
	
	local p = love.graphics.newParticleSystem(part1, 1000)
	p:setEmissionRate(100)
	p:setSpeed(300, 400)
	p:setGravity(0)
	p:setSizes(2, 1)
	p:setColors(255, 1, 1, 255, 58, 128, 255, 0)
	p:setPosition(400, 300)
	p:setLifetime(0.1)
	p:setParticleLife(1)
	p:setDirection(90)
	p:setSpread(300)
	p:setRadialAcceleration(-2000)
	p:setTangentialAcceleration(1000)
	p:stop()
	table.insert(systems, p)
	--Particle end

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
	
	




	-- Load the image of the ball.
	ball = love.graphics.newImage("images/love-ball.png")
	car = love.graphics.newImage("images/cars.png")

	-- Create a Body for the circle.
	body = love.physics.newBody(world, 400, 200, "dynamic")
	
	-- Attatch a shape to the body.
	--circle_shape = love.physics.newCircleShape(0,0, 32)
	car_shape = love.physics.newRectangleShape(0,0,car:getWidth(),car:getHeight())

    -- Create fixture between body and shape
    fixture = love.physics.newFixture( body, car_shape)

	fixture:setUserData("Car") -- Set a string userdata
	
    -- Calculate the mass of the body based on attatched shapes.
	-- This gives realistic simulations.
	body:setMassData(car_shape:computeMass( 1 ))	

	-- Set the collision callback.
	world:setCallbacks(beginContact,endContact)

	pSystem = love.graphics.newParticleSystem(particleImage , 5)

end

function love.update(dt)
	-- Update the world.
	world:update(dt)
	systems[current]:update(dt)

	if love.keyboard.isDown(" ") and isJumping then
		body:applyLinearImpulse(0, impulse*3*dt)
	else 
		isJumping = false
	end

	if  invertG then
		if body:getAngle() < piValue then
			body:setAngle( body:getAngle() + piValue *2*dt )
			if body:getAngle() > piValue then
				body:setAngle( piValue )
			end
		end
	else 
		if body:getAngle() > 0 then
			body:setAngle( body:getAngle() - piValue *2*dt )
			if body:getAngle() < 0 then
				body:setAngle( 0 )
			end			
		end
	end
end

function love.draw()
	-- Draws the ground.
	love.graphics.polygon("line", groundShape:getPoints())
	love.graphics.polygon("line", floorShape:getPoints())
	-- Draw the circle.
	love.graphics.draw(car,body:getX(), body:getY(), body:getAngle(),1,1,car:getWidth()/2,car:getHeight()/2)

	-- Draw text.
	love.graphics.print(text, 5, 25)
	love.graphics.print(grav, 5, 40)

	--Particle Draw
	love.graphics.setColorMode("modulate")
	love.graphics.setBlendMode("additive")
	love.graphics.draw(systems[current], 0, 0)
end

function love.keypressed(k)
	if k == " " then
		-- Apply a jump impulse
		if onGround then
			body:applyLinearImpulse(0, impulse)
			isJumping = true
		end
	end
	if k == "g" then
		invertG =  not invertG
		body:applyLinearImpulse(0,1)
		gx, gy = world:getGravity()
		world:setGravity(0, -gy)
		impulse = -impulse
	end
end

-- This is called every time a collision begin.
function beginContact(a, b, c)
	local aa=a:getUserData()
	local bb=b:getUserData()
	cx,cy, fx, fy = c:getPositions()
	text = "Collided: " .. aa .. " and " .. bb
	systems[current]:setPosition(cx, cy)
	systems[current]:start()
	onGround = true
end

-- This is called every time a collision end.
function endContact(a, b, c)
	local aa=a:getUserData()
	local bb=b:getUserData()
	text = "Collision ended: " .. aa .. " and " .. bb
	systems[current]:stop()
	onGround = false
end
