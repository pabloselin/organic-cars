function loadCar()
	-- Load the image of the car.
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
end

function carUpdate( dt )
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

function carKeysPressed(k)
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