local game = {}

myGameState = require("gameState")
game.mySpriteManager = require("spriteManager")
game.background = love.graphics.newImage("graphiques/Background/Background1.png")

game.myBalle = {}
game.myRaquette = {} 
game.myBrique = {}
game.myWall = {}

game.largeur = {}
game.hauteur = {}

game.listCoeur = {}

game.myBalle = game.mySpriteManager:CreateSprite("Balle", "Balle", 335, 480)

game.myRaquette = game.mySpriteManager:CreateSprite("Raquette", "Raquette", 300, 500)

game.myBrique = game.mySpriteManager:CreateSprite("Brique", "Brique", 50, 50)

game.myWall = game.mySpriteManager:CreateSprite("Wall", "Wall", 200, 300)

function game:Load()

self.largeur = love.graphics.getWidth()
self.hauteur = love.graphics.getHeight()
self.myBalle.colle = true
local decal = 0
    for i = 1, myGameState.vies do
        
        local CoeurTempo = {}
        CoeurTempo = self.mySpriteManager:CreateSprite("Coeur", "Coeur"..tostring(i), 10 + decal, 560)
        table.insert( self.listCoeur, CoeurTempo)
        decal = decal + 50
    end




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
    myGameState.vies = myGameState.vies - 1

    if #self.listCoeur ~=0 then
        local i = #self.listCoeur 
        self.listCoeur[i].delete = true
        table.remove( self.listCoeur, i )
    end

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
  local posCollisionRaquette = self.myRaquette.posY - (self.myRaquette.hauteur/2) 
  if self.myBalle.posY > posCollisionRaquette then
    local dist = math.abs(self.myRaquette.posX - self.myBalle.posX)
    if dist < self.myRaquette.largeur/2 then
      --sonCollisonRaquette:play()
      self.myBalle.vy = 0 - self.myBalle.vy
      self.myBalle.posY = posCollisionRaquette
    end
  end


  if myGameState.vies == 0 then
    love.event.quit()
  end

  self.mySpriteManager:Update(dt)

end

function game:Draw()
  
   love.graphics.draw(self.background, 0, 0)  
  
   self.mySpriteManager:Draw()
   
   if myGameState.Debug == true then

    love.graphics.print("Nombre de vies "..myGameState.vies
    .." listeCoeur "..#self.listCoeur
    .." listeSprite "..#self.mySpriteManager.list_sprites, 0, 0)
    
    end
    
    love.graphics.print("Niveau      "..myGameState.niveauActuel, 810, 520)
    love.graphics.print("Score                   "..myGameState.score, 765, 550)
    love.graphics.print("Meilleur                           "..myGameState.meilleurScore, 720, 580)
    
end


return game