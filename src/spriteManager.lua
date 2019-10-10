local spriteManager = {}

spriteManager.list_sprites = {}

local myGameState = require("gameState")

function spriteManager:CreateSprite(pType, pName, pX, pY)
  
  local sprite = {}
 
  sprite.posX = pX
  sprite.posY = pY
  sprite.name = pName
  sprite.type = pType
  sprite.currentImage = 1
  sprite.frames = 1
  sprite.images = {} 
  sprite.delete = false
  
   
  if pType == "Coeur" then 
    sprite.scaleX = 0.3
    sprite.scaleY = 0.3
    sprite.images[1] = love.graphics.newImage("graphiques/Star/Coeur.png")
    sprite.largeur = sprite.images[1]:getWidth() * sprite.scaleX
    sprite.hauteur = sprite.images[1]:getHeight() * sprite.scaleY
    sprite.oX = 0
    sprite.oY = 0

  elseif pType == "Raquette" then

    sprite.scaleX = 0.2
    sprite.scaleY = 0.2
    sprite.isAnimed = true
    sprite.images[1] = love.graphics.newImage("graphiques/Raquette/RaquetteIdle1.png")
    sprite.images[2] = love.graphics.newImage("graphiques/Raquette/RaquetteIdle2.png")
    sprite.images[3] = love.graphics.newImage("graphiques/Raquette/RaquetteIdle3.png")

    sprite.imagesTir = {}
    sprite.imagesTir[1] = love.graphics.newImage("graphiques/Raquette/RaquetteTirIdle1.png")
    sprite.imagesTir[2] = love.graphics.newImage("graphiques/Raquette/RaquetteTirIdle2.png")
    sprite.imagesTir[3] = love.graphics.newImage("graphiques/Raquette/RaquetteTirIdle3.png")

    sprite.imagesBonus = {}
    sprite.imagesBonus[1] = love.graphics.newImage("graphiques/Raquette/RaquetteLarge.png")
    sprite.imagesBonus[2] = love.graphics.newImage("graphiques/Raquette/RaquetteShort.png")

    sprite.largeur = sprite.images[1]:getWidth() * sprite.scaleX 
    sprite.hauteur = sprite.images[1]:getHeight() * sprite.scaleY 

    sprite.oX = sprite.images[1]:getWidth()/2
    sprite.oY = sprite.images[1]:getHeight()/2

  elseif pType == "Missile" then
    sprite.scaleX = 0.3
    sprite.scaleY = 0.3
    sprite.images[1] = love.graphics.newImage("graphiques/Star/Missile.png")
    sprite.largeur = sprite.images[1]:getWidth() * sprite.scaleX 
    sprite.hauteur = sprite.images[1]:getHeight() * sprite.scaleY 

    sprite.oX = 0
    sprite.oY = 0

  else
      print ("Erreur")
  end
  
  function sprite:anime()
    
    if self.type == "Explo" then

      self.frames = #self.images 

      if self.currentImage  < self.frames then 
          self.currentImage = self.currentImage + 0.10
      print ("aniExplo")
      print(self.currentImage)
      else 
        self.currentImage = 1
        self.delete = true
      end

    else

      self.frames = #self.images 

      if self.currentImage  < self.frames then 
      self.currentImage = self.currentImage + 0.15
      
      else 
       self.currentImage = 1
      end

    end


    

  end

  function sprite:draw()

    -- affche le debug du jeu
    
    if myGameState.Debug == true then
      if self.type == "Balle" or 
         self.type == "Raquette" or 
         self.type == "Brique" or 
         self.type == "Wall" or
         self.type == "Bonus" then
        love.graphics.circle("fill", self.posX, self.posY, 2)
        love.graphics.rectangle("line", self.posX- self.largeur/2, self.posY - self.hauteur/2, self.largeur, self.hauteur)
      
      else
        love.graphics.circle("fill", self.posX, self.posY, 2)
        love.graphics.rectangle("line", self.posX, self.posY, self.largeur, self.hauteur)
      end
    end
  end

  table.insert(spriteManager.list_sprites, sprite)
  
  print("Sprite Create")

  return sprite
  
end

function spriteManager:SettingSprite(pSpriteName, pPosX, pPosY)
  
  -- recherche dans le spriteManager et si il est présent, il est modifié
  if #spriteManager.list_sprites~=0 then

    for i = 1, #spriteManager.list_sprites do
      
      local s = spriteManager.list_sprites[i]
      
      if pSpriteName == s.name then 
          
        s.posX = pPosX
        s.posY = pPosY
        print ("Change of sprite done")
        
      end

    end
  
  end
  
end

function spriteManager:Update(dt)
  
    if #spriteManager.list_sprites~=0 then
      
      for i = #spriteManager.list_sprites, 1 , -1 do
      
        local s = spriteManager.list_sprites[i]
        
        if s.delete == true then

          table.remove(spriteManager.list_sprites, i)

        end 

        if s.isAnimed == true then
            s:anime()
        end

        
        
      end
      
    end
        
end

function spriteManager:Draw()
  
  if #spriteManager.list_sprites~=0 then

    for i = #spriteManager.list_sprites, 1 , -1 do
      
      local s = spriteManager.list_sprites[i]
      
      love.graphics.draw(s.images[math.floor(s.currentImage)], 
        s.posX, s.posY, 0, s.scaleX, s.scaleY, s.oX, s.oY)

        s:draw()
                        
    end

  end

end

return spriteManager
