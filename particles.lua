--Particle Variables
systems = {}
current = 1

function loadParticles()

	part1 = love.graphics.newImage("images/particle.png");	
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

end