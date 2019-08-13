local Raquette = {}

Raquette.x = 0
Raquette.y = 0
Raquette.image = love.graphics.newImage("graphiques/Raquette/RaquetteIdle1.png")
Raquette.largeur = Raquette.image:getWidth() * 0.2
Raquette.hauteur = Raquette.image:getHeight() * 0.2
return Raquette 