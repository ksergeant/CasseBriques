local game = {}

game.mySpriteManager = require("spriteManager")
game.background = love.graphics.newImage("graphiques/Background/Background1.png")

game.myBalle = {}
game.myRaquette = {} 
game.myBrique = {}
game.myWall = {}

game.largeur = {}
game.hauteur = {}

game.myBalle = game.mySpriteManager:CreateSprite("Balle", "Balle", 335, 480)

game.myCoeur = game.mySpriteManager:CreateSprite("Coeur", "Coeur", 10, 560)

game.myCoeur2 = game.mySpriteManager:CreateSprite("Coeur", "Coeur2", 60, 560)

game.myCoeur3 = game.mySpriteManager:CreateSprite("Coeur", "Coeur3",  110, 560)

game.myRaquette = game.mySpriteManager:CreateSprite("Raquette", "Raquette", 300, 500)

game.myBrique = game.mySpriteManager:CreateSprite("Brique", "Brique", 50, 50)

game.myWall = game.mySpriteManager:CreateSprite("Wall", "Wall", 200, 300)

function game:Load()

self.largeur = love.graphics.getWidth()
self.hauteur = love.graphics.getHeight()
self.myBalle.colle = true

end

function game:Update(dt)

    self.myRaquette.posX = love.mouse.getX()
  
-- si la souris sort de l'écran elle est replacée
  if love.mouse.getX() >= self.largeur -50 then
    love.mouse.setX(self.largeur-50)
  end

if love.mouse.getX() <= 50 then
  love.mouse.setX(50)
end

if love.mouse.getY() >= self.hauteur-40 then
  love.mouse.setY(self.hauteur -40)
end

if love.mouse.getY() <= 40 then
  love.mouse.setY(40)
end

if self.myBalle.posX > self.largeur then
    self.myBalle.vx =  0 - self.myBalle.vx
    self.myBalle.posX = self.largeur
  end
  
  if self.myBalle.posX < 0 then
    self.myBalle.vx = 0 - self.myBalle.vx
    self.myBalle.posX = 0
  end
  
  if self.myBalle.posY < 0 then
     self.myBalle.vy = 0 - self.myBalle.vy
     self.myBalle.posY = 0
  end
  
  if self.myBalle.posY > self.hauteur then 
    -- on perd une balle
    --sonPerteBalle:play()
   -- mesVies.valeur = mesVies.valeur - 1
    self.myBalle.colle = true
  end

if self.myBalle.colle == true then
    self.myBalle.posX = self.myRaquette.posX 
    self.myBalle.posY = self.myRaquette.posY - 20
  else
    self.myBalle.posX = self.myBalle.posX +(self.myBalle.vx*dt)
    self.myBalle.posY = self.myBalle.posY +(self.myBalle.vy*dt)
  end


  -- Tester collision avec la raquette
  local posCollisionRaquette = self.myRaquette.posY - (self.myRaquette.hauteur/2) - 10
  if self.myBalle.posY > posCollisionRaquette then
    local dist = math.abs(self.myRaquette.posX - self.myBalle.posX)
    if dist < self.myRaquette.largeur/2 then
      --sonCollisonRaquette:play()
      self.myBalle.vy = 0 - self.myBalle.vy
      self.myBalle.posY = posCollisionRaquette
    end
  end

  self.mySpriteManager:Update(dt)

  
  
end

function game:Draw()
  
   love.graphics.draw(self.background, 0, 0)  
  
   self.mySpriteManager:Draw()
  
end

return game