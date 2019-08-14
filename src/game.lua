local game = {}

game.mySpriteManager = require("spriteManager")
game.background = love.graphics.newImage("graphiques/Background/Background1.png")

game.myBalle = require("balle")
game.myRaquette = require("raquette")
game.myBrique = require("brique")
game.myVie = require("vies")
game.myWall = require("wall")

game.myBalle = game.mySpriteManager:CreateSprite("Balle", game.myBalle.images, 1)
game.mySpriteManager:SettingSprite("Balle", 335, 480, 0.2, 0.2, 0, 0, 1,false)

game.myCoeur = game.mySpriteManager:CreateSprite("Coeur", game.myVie.images, 1)
game.mySpriteManager:SettingSprite("Coeur", 10, 500, 0.3, 0.3, 0, 0, 1,false)

game.myRaquette = game.mySpriteManager:CreateSprite("Raquette",game.myRaquette.images, 3)
game.mySpriteManager:SettingSprite("Raquette", 300, 500, 0.2, 0.2, 0, 0, 1, true)

game.myBrique = game.mySpriteManager:CreateSprite("Brique", game.myBrique.images, 2)
game.mySpriteManager:SettingSprite("Brique", 50, 50, 0.2, 0.2, 0, 0, 1, false)

game.myWall = game.mySpriteManager:CreateSprite("Wall", game.myWall.images, 1)
game.mySpriteManager:SettingSprite("Wall", 200, 300, 0.35, 0.35, 0, 0, 1, false)

function game:Load()

self.myVie:initialisation()
 
end

function game:Update(dt)
  
  self.mySpriteManager:Update(dt)
  
end

function game:Draw()
  
   love.graphics.draw(self.background, 0, 0)  
   self.mySpriteManager:Draw()
  
end

return game