local game = {}

game.mySpriteManager = require("spriteManager")
game.background = love.graphics.newImage("graphiques/Background/Background1.png")

game.myBalle = require("balle")
game.myRaquette = require("raquette")
game.myBrique = require("brique")
game.myVie = require("vies")
game.myWall = require("wall")

game.largeur = {}
game.hauteur = {}

game.myBalle = game.mySpriteManager:CreateSprite("Balle", game.myBalle.images, 1)
game.mySpriteManager:SettingSprite("Balle", 335, 480, 0.2, 0.2, game.myBalle.largeur/2, game.myBalle.hauteur/2, 1, false)

game.myCoeur = game.mySpriteManager:CreateSprite("Coeur", game.myVie.images, 1)
game.mySpriteManager:SettingSprite("Coeur", 10, 560, 0.3, 0.3, 0, 0, 1, false)

game.myCoeur2 = game.mySpriteManager:CreateSprite("Coeur2", game.myVie.images, 1)
game.mySpriteManager:SettingSprite("Coeur2", 60, 560, 0.3, 0.3, 0, 0, 1, false)

game.myCoeur3 = game.mySpriteManager:CreateSprite("Coeur3", game.myVie.images, 1)
game.mySpriteManager:SettingSprite("Coeur3", 110, 560, 0.3, 0.3, 0, 0, 1, false)

game.myRaquette = game.mySpriteManager:CreateSprite("Raquette",game.myRaquette.images, 3)
game.mySpriteManager:SettingSprite("Raquette", 300, 500, 0.2, 0.2, game.myRaquette.largeur/2, game.myRaquette.hauteur/2, 1, true)

game.myBrique = game.mySpriteManager:CreateSprite("Brique", game.myBrique.images, 2)
game.mySpriteManager:SettingSprite("Brique", 50, 50, 0.2, 0.2, 0, 0, 1, false)

game.myWall = game.mySpriteManager:CreateSprite("Wall", game.myWall.images, 1)
game.mySpriteManager:SettingSprite("Wall", 200, 300, 0.35, 0.35, 0, 0, 1, false)


function game:Load()

self.largeur = love.graphics.getWidth()
self.hauteur = love.graphics.getHeight()
self.myVie:initialisation()
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


if self.myBalle.colle == true then
    self.myBalle.posX = self.myRaquette.posX 
    self.myBalle.posY = self.myRaquette.posY - 20
  else
    self.myBalle.posX = self.myBalle.posX +(self.myBalle.vx*dt)
    self.myBalle.posY = self.myBalle.posY +(self.myBalle.vy*dt)
  end


  self.mySpriteManager:Update(dt)

  
  
end

function game:Draw()
  
   love.graphics.draw(self.background, 0, 0)  
  
   self.mySpriteManager:Draw()
  
end

return game