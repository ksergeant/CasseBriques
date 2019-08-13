local game = {}

game.mySpriteManager = require("spriteManager")
game.background = love.graphics.newImage("graphiques/Background/Background1.png")

local ImgBalle = {}
local ImgCoeur = {} 
local ImgRaquetteIdle = {} 
local ImgBrique1 = {}
local ImgWall1 = {}

ImgBalle[1] = "graphiques/Star/Balle.png" 

ImgCoeur[1] = "graphiques/Star/Coeur.png"

ImgRaquetteIdle[1] = "graphiques/Raquette/RaquetteIdle1.png"
ImgRaquetteIdle[2] = "graphiques/Raquette/RaquetteIdle2.png"
ImgRaquetteIdle[3] = "graphiques/Raquette/RaquetteIdle3.png"

ImgBrique1[1] = "graphiques/Brick/Brick1.png"
ImgBrique1[2] = "graphiques/Brick/Brick1Broken.png"

ImgWall1[1] = "graphiques/Wall/Wall1.png"

game.myBalle = game.mySpriteManager:CreateSprite("Balle", ImgBalle, 1)
game.myCoeur = game.mySpriteManager:CreateSprite("Coeur", ImgCoeur, 1)
game.mySpriteManager:SettingSprite("Coeur", 10, 500, 0.3, 0.3, 0, 0, 1,false)

game.myRaquette = game.mySpriteManager:CreateSprite("Raquette",ImgRaquetteIdle, 3)
game.mySpriteManager:SettingSprite("Raquette", 300, 500, 0.2, 0.2, 0, 0, 1, true)

game.myBrick1 = game.mySpriteManager:CreateSprite("Brick1", ImgBrique1, 2)
game.mySpriteManager:SettingSprite("Brick1", 400, 500, 0.2, 0.2, 0, 0, 1, false)

game.myWall1 = game.mySpriteManager:CreateSprite("Wall1", ImgWall1, 1)
game.mySpriteManager:SettingSprite("Wall1", 500, 500, 0.3, 0.3, 0, 0, 1, false)

function game:Load()
 
end

function game:Update(dt)
  
  self.mySpriteManager:Update(dt)
  
end

function game:Draw()
  
   love.graphics.draw(self.background, 0, 0)  
   self.mySpriteManager:Draw()
  
end

return game