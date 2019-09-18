local game = {}

math.randomseed(os.time())
myGameState = require("gameState")
game.mySpriteManager = require("spriteManager")
game.myBriqueManager = require("briqueManager")
game.myWallManager = require("wallManager")
game.myBonusManager = require("bonusManager")
game.myBalleManager = require("balleManager")
game.background = love.graphics.newImage("graphiques/Background/Background1.png")

sonPerteBalle = love.audio.newSource("sons/sfx_deathscream_human2.wav","static")
sonCollisonBrique = love.audio.newSource("sons/sfx_sounds_impact5.wav","static")
sonCollisonRaquette = love.audio.newSource("sons/DM-CGS-07.wav","static")
sonPowerUp = love.audio.newSource("sons/Powerup18.wav","static")

game.myBalle = {}
game.myRaquette = {} 

myGameState.myBalle = game.myBalleManager:CreateBall("Balle", "Balle", 335, 440)

game.listCoeur = {}

game.myRaquette = game.mySpriteManager:CreateSprite("Raquette", "Raquette", 300, 500)
game.BonusActif = false

game.collisionRaquette = {}
game.collisionRaquette.x = 0
game.collisionRaquette.y = 0

game.collisionBrique = {}
game.collisionBrique.x = 0
game.collisionBrique.y = 0

game.timeBonus = 0

-- Calcul d'un angle entre 2 coordonnées
function math.angle(x1,y1, x2,y2)
  return math.atan2(y2-y1, x2-x1)
end



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

myGameState.myBalle.colle = true
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

   -- game.myWallManager:CreateWall("Wall", "Wall1", 200, 250, 1)  
  --  game.myWallManager:CreateWall("Wall", "Wall2", 400, 250, 2)
  --  game.myWallManager:CreateWall("Wall", "Wall3", 600, 250, 3)
  --  game.myWallManager:CreateWall("Wall", "Wall4", 800, 250, 4)
    
end

function game:Update(dt)

  local nbBonus = #self.myBonusManager.list_bonus
    self.myRaquette.posX = love.mouse.getX()

    if #self.myBriqueManager.list_briques~=0 then
      
      local nbCollision = 0

      for i = #self.myBriqueManager.list_briques, 1, -1 do
      
        local b = self.myBriqueManager.list_briques[i]
        
        if collideBrique(myGameState.myBalle, b) == true and nbCollision == 0 then
          
         -- myGameState.myBalle.destinationX = 
          -- Point de collision
          self.collisionBrique.x = myGameState.myBalle.posX
          self.collisionBrique.y = myGameState.myBalle.posY - myGameState.myBalle.hauteur /2

          b.durability = b.durability - 1
          if b.durability < 1 then

            b.delete = true
            myGameState.score = myGameState.score + 100
            local probaBonus = math.random( 1,20)
            if probaBonus >= 15 then 
              self.myBonusManager:CreateBonus("Bonus","Bonus"..tostring(nbBonus), b.posX, b.posY + 10, math.random(1, 12))
            end
          end
          
          myGameState.myBalle.vy = 0 -myGameState.myBalle.vy
          
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
        
        if collideWall(myGameState.myBalle, w) == true and nbCollision == 0 then
       
          myGameState.myBalle.vy = 0 - myGameState.myBalle.vy
          
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
            sonPowerUp:play()
            if bo.currentImage == 2 then

              self.BonusActif = true
              self.timeBonus = 0
              myGameState.myBalle.vitesse = 1.3
              
            elseif bo.currentImage == 6 then
              myGameState.score = myGameState.score + 50
            elseif bo.currentImage == 7 then
              myGameState.score = myGameState.score + 100
            elseif bo.currentImage == 8 then
              myGameState.score = myGameState.score + 250
            elseif bo.currentImage == 9 then
              myGameState.score = myGameState.score + 500   
            elseif bo.currentImage == 11 then
              self.BonusActif = true
              self.timeBonus = 0
              myGameState.myBalle.vitesse = 0.7  
            end

          end

      end

    end

    


-- si la souris sort de l'écran elle est replacée
  if love.mouse.getX() >= myGameState.largeur -50 then
    love.mouse.setX(myGameState.largeur-50)
  end

if love.mouse.getX() <= 50 then
  love.mouse.setX(50)
end

if love.mouse.getY() >= myGameState.hauteur-40 then
  love.mouse.setY(myGameState.hauteur -40)
end

if love.mouse.getY() <= 40 then
  love.mouse.setY(40)
end

if myGameState.myBalle.posX + myGameState.myBalle.largeur/2 > myGameState.largeur then
  myGameState.myBalle.vx =  0 - myGameState.myBalle.vx
  myGameState.myBalle.posX = myGameState.largeur - myGameState.myBalle.largeur/2
  end
  
  if myGameState.myBalle.posX - myGameState.myBalle.largeur/2 < 0 then
    myGameState.myBalle.vx = 0 - myGameState.myBalle.vx
    myGameState.myBalle.posX = 0 + myGameState.myBalle.largeur/2
  end
  
  if myGameState.myBalle.posY - myGameState.myBalle.hauteur/2 < 0 then
    myGameState.myBalle.vy = 0 - myGameState.myBalle.vy
    myGameState.myBalle.posY = 0 + myGameState.myBalle.hauteur/2
  end
  
  if myGameState.myBalle.posY + myGameState.myBalle.hauteur/2> myGameState.hauteur then 
    -- on perd une balle
    sonPerteBalle:play()
    myGameState.vies = myGameState.vies - 1

    if #self.listCoeur ~=0 then
        local i = #self.listCoeur 
        self.listCoeur[i].delete = true
        table.remove( self.listCoeur, i )
    end

    myGameState.myBalle.colle = true
  end

if myGameState.myBalle.colle == true then

  -- animation de la balle
  local limiteHauteurBalle = self.myRaquette.posY - 50
  local limiteRaquette = self.myRaquette.posY - 26
  
  myGameState.myBalle.posX = self.myRaquette.posX 
  myGameState.myBalle.posY = myGameState.myBalle.posY + limiteHauteurBalle * dt /20

  if myGameState.myBalle.posY >= limiteRaquette then
      myGameState.myBalle.posY = limiteHauteurBalle
  end

  else

    --local angle = math.angle(psZombie.x,psZombie.y,math.random(0,screenWidth),math.random(0,screenHeight))
    --   psZombie.vx = psZombie.speed * 60 * math.cos(angle)
    --   psZombie.vy = psZombie.speed * 60 * math.sin(angle)

    myGameState.myBalle.destinationAngle = math.angle(myGameState.myBalle.posX, myGameState.myBalle.posY,
    myGameState.myBalle.destinationX, myGameState.myBalle.destinationY)
    
    myGameState.myBalle.vx = 300 * math.cos(myGameState.myBalle.destinationAngle)
    myGameState.myBalle.vy = 300 * math.sin(myGameState.myBalle.destinationAngle)

    myGameState.myBalle.posX = myGameState.myBalle.posX + myGameState.myBalle.vx * dt
    myGameState.myBalle.posY = myGameState.myBalle.posY + myGameState.myBalle.vy * dt

   -- myGameState.myBalle.posX = myGameState.myBalle.posX +(myGameState.myBalle.vx*dt*myGameState.myBalle.vitesse)
   -- myGameState.myBalle.posY = myGameState.myBalle.posY +(myGameState.myBalle.vy*dt*myGameState.myBalle.vitesse)
  end

  -- Tester collision avec la raquette
if collideRaquette(myGameState.myBalle, self.myRaquette) == true then

    -- Point de collision
    self.collisionRaquette.x = myGameState.myBalle.posX
    self.collisionRaquette.y = myGameState.myBalle.posY + myGameState.myBalle.hauteur /2

    -- Pourcentage point de collision
    local pointOrigineRaquette = {}
    pointOrigineRaquette.x = self.myRaquette.posX - self.myRaquette.largeur/2
    pointOrigineRaquette.y = self.myRaquette.posY - self.myRaquette.hauteur/2
    pointOrigineRaquette.fullPourcent = pointOrigineRaquette.x + self.myRaquette.largeur
    
    self.collisionRaquette.restant = pointOrigineRaquette.fullPourcent - self.collisionRaquette.x
    self.collisionRaquette.pourcent = self.myRaquette.largeur - self.collisionRaquette.restant
    self.collisionRaquette.pourcentFinal = (self.collisionRaquette.pourcent / self.myRaquette.largeur) * 100

  -- cote gauche
  if myGameState.myBalle.posX + myGameState.myBalle.largeur/2 < self.myRaquette.posX - self.myRaquette.largeur/2 then
    
    myGameState.myBalle.vy = 0 - myGameState.myBalle.vy
    myGameState.myBalle.vx = 0 - myGameState.myBalle.vx
    sonCollisonRaquette:play()
  else
  
    sonCollisonRaquette:play()
    myGameState.myBalle.vy = 0 - myGameState.myBalle.vy
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
  self.myBalleManager:Update(dt)

  if self.BonusActif == true then
     self.timeBonus = math.abs(self.timeBonus + dt)
  end
   
  if self.timeBonus > 10 then

    self.timeBonus = 0
    self.BonusActif = false
  end
  
  if self.BonusActif == false then
    myGameState.myBalle.vitesse = 1
  end

end

function game:Draw()
  
   love.graphics.draw(self.background, 0, 0)  
  
   self.mySpriteManager:Draw()
   
   if myGameState.Debug == true then

    love.graphics.print("Nombre de vies "..myGameState.vies
    .." listeCoeur "..#self.listCoeur
    .." listeSprite "..#self.mySpriteManager.list_sprites 
    .." listreBrique "..#self.myBriqueManager.list_briques
    --.." PourcentageCollisionRaquette "..math.floor(self.collisionRaquette.pourcentFinal)
    .." Desti "..myGameState.myBalle.destinationX, 0, 0)
    love.graphics.print("Bonus     "..tostring(self.BonusActif), 850, 490)
    love.graphics.print(" : "..tostring(self.timeBonus), 950, 490)
    
    local r,g,b = love.graphics.getColor() 
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill", self.collisionRaquette.x, self.collisionRaquette.y, 3)
    love.graphics.circle("fill", self.collisionBrique.x, self.collisionBrique.y, 3)
    love.graphics.setColor(r,g,b)
    
    end

    
    love.graphics.print("Niveau      "..myGameState.niveauActuel, 810, 520)
    love.graphics.print("Score                   "..myGameState.score, 765, 550)
    love.graphics.print("Meilleur                           "..myGameState.meilleurScore, 720, 580)
    
end


return game