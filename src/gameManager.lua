local game = {}

math.randomseed(os.time())
myGameState = require("gameState")
game.mySpriteManager = require("spriteManager")
game.myBriqueManager = require("briqueManager")
game.myWallManager = require("wallManager")
game.myBonusManager = require("bonusManager")
game.background = love.graphics.newImage("graphiques/Background/Background1.png")

sonPerteBalle = love.audio.newSource("sons/sfx_deathscream_human2.wav","static")
sonCollisonBrique = love.audio.newSource("sons/sfx_sounds_impact5.wav","static")
sonCollisonRaquette = love.audio.newSource("sons/DM-CGS-07.wav","static")

game.myBalle = {}
game.myRaquette = {} 
game.myBrique = {}
game.myWall = {}

game.largeur = {}
game.hauteur = {}

game.listCoeur = {}

game.myBalle = game.mySpriteManager:CreateSprite("Balle", "Balle", 335, 440)

game.myRaquette = game.mySpriteManager:CreateSprite("Raquette", "Raquette", 300, 500)

--game.myWall = game.mySpriteManager:CreateSprite("Wall", "Wall", 200, 300)

function collideBonus(a1, a2)
  local x1,y1,x2,y2
  x1 = a1.posX-a1.largeur/2
  x2 = a2.posX-a2.largeur/2
  y1 = a1.posY-a1.hauteur/2
  y2 = a2.posY-a2.hauteur/2
  return x1 < x2+a2.largeur and
         x2 < x1+a1.largeur and
         y1 < y2+a2.hauteur and
         y2 < y1+a1.hauteur
end

function collideWall(a1, a2)
  local x1,y1,x2,y2
  x1 = a1.posX-a1.largeur/2
  x2 = a2.posX-a2.largeur/2
  y1 = a1.posY-a1.hauteur/2
  y2 = a2.posY-a2.hauteur/2
  return x1 < x2+a2.largeur and
         x2 < x1+a1.largeur and
         y1 < y2+a2.hauteur and
         y2 < y1+a1.hauteur
end

function collideBrique(a1, a2)
  local x1,y1,x2,y2
  x1 = a1.posX-a1.largeur/2
  x2 = a2.posX-a2.largeur/2
  y1 = a1.posY-a1.hauteur/2
  y2 = a2.posY-a2.hauteur/2
  return x1 < x2+a2.largeur and
         x2 < x1+a1.largeur and
         y1 < y2+a2.hauteur and
         y2 < y1+a1.hauteur
end

function collideRaquette(a1, a2)
  local x1,y1,x2,y2
  x1 = a1.posX-a1.largeur/2
  x2 = a2.posX-a2.largeur/2
  y1 = a1.posY-a1.hauteur/2
  y2 = a2.posY-a2.hauteur/2
  return x1 < x2+a2.largeur and
         x2 < x1+a1.largeur and
         y1 < y2+a2.hauteur and
         y2 < y1+a1.hauteur
end


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

    -- Crée les Briques du niveau
    local decalBriqueY = 28
    local nbBrique = 0
    for n = 1, 5 do
      local decalBriqueX = 40
      for i = 1, 13 do
        game.myBriqueManager:CreateBrick("Brique", "Brique"..tostring(nbBrique), 0  + decalBriqueX, 0 + decalBriqueY, math.random(1, 10) )
        nbBrique = nbBrique + 1
        decalBriqueX = decalBriqueX + 77
      end
      decalBriqueY = decalBriqueY + 26
    end

    game.myWallManager:CreateWall("Wall", "Wall1", 200, 250, 1)  
    game.myWallManager:CreateWall("Wall", "Wall2", 400, 250, 2)
    game.myWallManager:CreateWall("Wall", "Wall3", 600, 250, 3)
    game.myWallManager:CreateWall("Wall", "Wall4", 800, 250, 4)
    
end

function game:Update(dt)

  local nbBonus = #self.myBonusManager.list_bonus
    self.myRaquette.posX = love.mouse.getX()

    if #self.myBriqueManager.list_briques~=0 then
      
      local nbCollision = 0

      for i = #self.myBriqueManager.list_briques, 1, -1 do
      
        local b = self.myBriqueManager.list_briques[i]
        
        if collideBrique(self.myBalle, b) == true and nbCollision == 0 then
       
          b.durability = b.durability - 1
          if b.durability < 1 then

            b.delete = true
            myGameState.score = myGameState.score + 100
            local probaBonus = math.random( 1,20)
            if probaBonus >= 15 then 
              self.myBonusManager:CreateBonus("Bonus","Bonus"..tostring(nbBonus), b.posX, b.posY + 10, math.random(1, 12))
            end
          end
          
          self.myBalle.vy = 0 -self.myBalle.vy
          
          sonCollisonBrique:play()
          nbCollision = 1
          print("brique touché")
        end
      end
    end


    if #self.myWallManager.list_walls~=0 then
      
      local nbCollision = 0

      for i = #self.myWallManager.list_walls, 1, -1 do
      
        local w = self.myWallManager.list_walls[i]
        
        if collideWall(self.myBalle, w) == true and nbCollision == 0 then
       
          self.myBalle.vy = 0 - self.myBalle.vy
          
          sonCollisonBrique:play()
          nbCollision = 1
          print("Wall touché")
        end
      end
    end


     
    if #self.myBonusManager.list_bonus~=0 then

      for i = #self.myBonusManager.list_bonus, 1, -1 do

          local bo = self.myBonusManager.list_bonus[i] 

          if collideBonus(self.myRaquette, bo) == true then
            
            bo.delete = true
            print("Bonus ", bo.currentImage," Récupèré")
            if bo.currentImage == 2 then
              self.myBalle.vx = 350
              self.myBalle.vy = -350
            elseif bo.currentImage == 6 then
              myGameState.score = myGameState.score + 50
            elseif bo.currentImage == 7 then
              myGameState.score = myGameState.score + 100
            elseif bo.currentImage == 8 then
              myGameState.score = myGameState.score + 250
            elseif bo.currentImage == 9 then
              myGameState.score = myGameState.score + 500   
            elseif bo.currentImage == 11 then
              self.myBalle.vx = 250
              self.myBalle.vy = -250   
            end

          end

      end

    end

    


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

if self.myBalle.posX + self.myBalle.largeur/2 > self.largeur then
    self.myBalle.vx =  0 - self.myBalle.vx
    self.myBalle.posX = self.largeur - self.myBalle.largeur/2
  end
  
  if self.myBalle.posX - self.myBalle.largeur/2 < 0 then
    self.myBalle.vx = 0 - self.myBalle.vx
    self.myBalle.posX = 0 + self.myBalle.largeur/2
  end
  
  if self.myBalle.posY - self.myBalle.hauteur/2 < 0 then
     self.myBalle.vy = 0 - self.myBalle.vy
     self.myBalle.posY = 0 +self.myBalle.hauteur/2
  end
  
  if self.myBalle.posY + self.myBalle.hauteur/2> self.hauteur then 
    -- on perd une balle
    sonPerteBalle:play()
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
    self.myBalle.posY = self.myRaquette.posY - 26
  else
    self.myBalle.posX = self.myBalle.posX +(self.myBalle.vx*dt)
    self.myBalle.posY = self.myBalle.posY +(self.myBalle.vy*dt)
  end

  -- Tester collision avec la raquette
if collideRaquette(self.myBalle, self.myRaquette) == true then

  -- cote gauche
  if self.myBalle.posX + self.myBalle.largeur/2 < self.myRaquette.posX - self.myRaquette.largeur/2 then
    
    self.myBalle.vy = 0 - self.myBalle.vy
    self.myBalle.vx = 0 - self.myBalle.vx
    sonCollisonRaquette:play()
  else
  
    sonCollisonRaquette:play()
    self.myBalle.vy = 0 - self.myBalle.vy
  end

end

--[[
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
]]--

  if myGameState.vies == 0 then
    love.event.quit()
  end

  self.mySpriteManager:Update(dt)
  self.myBriqueManager:Update(dt)
  self.myWallManager:Update(dt)
  self.myBonusManager:Update(dt)
end

function game:Draw()
  
   love.graphics.draw(self.background, 0, 0)  
  
   self.mySpriteManager:Draw()
   
   if myGameState.Debug == true then
    
    love.graphics.print("Nombre de vies "..myGameState.vies
    .." listeCoeur "..#self.listCoeur
    .." listeSprite "..#self.mySpriteManager.list_sprites 
    .." listreBrique "..#self.myBriqueManager.list_briques, 0, 0)
   
    
    end
    
    love.graphics.print("Niveau      "..myGameState.niveauActuel, 810, 520)
    love.graphics.print("Score                   "..myGameState.score, 765, 550)
    love.graphics.print("Meilleur                           "..myGameState.meilleurScore, 720, 580)
    
end


return game