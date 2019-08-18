local spriteManager = {}

spriteManager.list_sprites = {}

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
  

  if pType == "Balle" then

    sprite.colle = false
    sprite.scaleX = 0.2
    sprite.scaleY = 0.2
    sprite.rayon = 4
    sprite.vx = 0
    sprite.vy = 0
    sprite.images[1] = love.graphics.newImage("graphiques/Star/Balle.png")
    sprite.largeur = sprite.images[1]:getWidth() * sprite.scaleX
    sprite.hauteur = sprite.images[1]:getHeight() * sprite.scaleY
    sprite.oX = sprite.images[1]:getWidth()/2
    sprite.oY = sprite.images[1]:getHeight()/2

  elseif pType == "Coeur" then 
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

  elseif pType == "Brique" then
    sprite.scaleX = 0.2
    sprite.scaleY = 0.2
    sprite.images[1] = love.graphics.newImage("graphiques/Brick/Brick1.png")
    sprite.images[2] = love.graphics.newImage("graphiques/Brick/Brick2.png")
    sprite.images[3] = love.graphics.newImage("graphiques/Brick/Brick3.png")
    sprite.images[4] = love.graphics.newImage("graphiques/Brick/Brick4.png")
    sprite.images[5] = love.graphics.newImage("graphiques/Brick/Brick5.png")
    sprite.images[6] = love.graphics.newImage("graphiques/Brick/Brick6.png")
    sprite.images[7] = love.graphics.newImage("graphiques/Brick/Brick7.png")
    sprite.images[8] = love.graphics.newImage("graphiques/Brick/Brick8.png")
    sprite.images[9] = love.graphics.newImage("graphiques/Brick/Brick9.png")
    sprite.images[10] = love.graphics.newImage("graphiques/Brick/Brick10.png")

    sprite.imagesBroken = {}
    sprite.imagesBroken[1] = love.graphics.newImage("graphiques/Brick/Brick1Broken.png")
    sprite.imagesBroken[2] = love.graphics.newImage("graphiques/Brick/Brick2Broken.png")
    sprite.imagesBroken[3] = love.graphics.newImage("graphiques/Brick/Brick3Broken.png")
    sprite.imagesBroken[4] = love.graphics.newImage("graphiques/Brick/Brick4Broken.png")
    sprite.imagesBroken[5] = love.graphics.newImage("graphiques/Brick/Brick5Broken.png")
    sprite.imagesBroken[6] = love.graphics.newImage("graphiques/Brick/Brick6Broken.png")
    sprite.imagesBroken[7] = love.graphics.newImage("graphiques/Brick/Brick7Broken.png")
    sprite.imagesBroken[8] = love.graphics.newImage("graphiques/Brick/Brick8Broken.png")
    sprite.imagesBroken[9] = love.graphics.newImage("graphiques/Brick/Brick9Broken.png")
    sprite.imagesBroken[10] = love.graphics.newImage("graphiques/Brick/Brick10Broken.png")

    sprite.largeur = sprite.images[1]:getWidth() * sprite.scaleX 
    sprite.hauteur = sprite.images[1]:getHeight() * sprite.scaleY 

    sprite.oX = 0
    sprite.oY = 0

  elseif pType == "Wall" then
    sprite.scaleX = 0.3
    sprite.scaleY = 0.3
    sprite.images[1] = love.graphics.newImage("graphiques/Wall/Wall1.png")
    sprite.images[2] = love.graphics.newImage("graphiques/Wall/Wall2.png")
    sprite.images[3] = love.graphics.newImage("graphiques/Wall/Wall3.png")
    sprite.images[4] = love.graphics.newImage("graphiques/Wall/Wall4.png")
    sprite.images[5] = love.graphics.newImage("graphiques/Wall/Wall5.png")
    sprite.images[6] = love.graphics.newImage("graphiques/Wall/Wall6.png")
    sprite.images[7] = love.graphics.newImage("graphiques/Wall/Wall7.png")
    sprite.images[8] = love.graphics.newImage("graphiques/Wall/Wall8.png")
    sprite.images[9] = love.graphics.newImage("graphiques/Wall/Wall9.png")
    sprite.images[10] = love.graphics.newImage("graphiques/Wall/Wall10.png")

    sprite.largeur = sprite.images[1]:getWidth() * sprite.scaleX 
    sprite.hauteur = sprite.images[1]:getHeight() * sprite.scaleY 

    sprite.oX = 0
    sprite.oY = 0

  elseif pType == "Bonus" then
    sprite.scaleX = 0.3
    sprite.scaleY = 0.3
    sprite.images[1] = love.graphics.newImage("graphiques/Power/AddBall.png")
    sprite.images[2] = love.graphics.newImage("graphiques/Power/Fast.png")
    sprite.images[3] = love.graphics.newImage("graphiques/Power/FireBall.png")
    sprite.images[4] = love.graphics.newImage("graphiques/Power/GlueBall.png")
    sprite.images[5] = love.graphics.newImage("graphiques/Power/LargeRaquet.png")
    sprite.images[6] = love.graphics.newImage("graphiques/Power/Plus50.png")
    sprite.images[7] = love.graphics.newImage("graphiques/Power/Plus100.png")
    sprite.images[8] = love.graphics.newImage("graphiques/Power/Plus250.png")
    sprite.images[9] = love.graphics.newImage("graphiques/Power/Plus500.png")
    sprite.images[10] = love.graphics.newImage("graphiques/Power/ShortRaquet.png")
    sprite.images[11] = love.graphics.newImage("graphiques/Power/Slow.png")
    sprite.images[12] = love.graphics.newImage("graphiques/Power/TirRaquet.png")

    sprite.largeur = sprite.images[1]:getWidth() * sprite.scaleX 
    sprite.hauteur = sprite.images[1]:getHeight() * sprite.scaleY 

    sprite.oX = 0
    sprite.oY = 0

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
    
    self.frames = #self.images 
    if self.currentImage  < self.frames then 
      self.currentImage = self.currentImage + 0.15
      
    else 
      self.currentImage = 1
    end

  end

  function sprite:draw()

    if self.type == "Balle" or self.type == "Raquette" then
      love.graphics.circle("fill", self.posX, self.posY, 2)
      love.graphics.rectangle("line", self.posX- self.largeur/2, self.posY - self.hauteur/2, self.largeur, self.hauteur)
      print("Balle et Raquette")
    else
      love.graphics.circle("fill", self.posX, self.posY, 2)
      love.graphics.rectangle("line", self.posX, self.posY , self.largeur, self.hauteur)
    end

  end

  table.insert(spriteManager.list_sprites, sprite)
  
  print("Sprite Create")

  return sprite
  
end

function spriteManager:SettingSprite(pSpriteName, pPosX, pPosY)
  
  -- recherche dans le spriteManager et si il est présent, il est modifié
  if #spriteManager.list_sprites~=nil then

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
  
    if #spriteManager.list_sprites~=nil then
      
      for i = 1, #spriteManager.list_sprites do
      
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
  
  if #spriteManager.list_sprites~=nil then

    for i = 1, #spriteManager.list_sprites do
      
      local s = spriteManager.list_sprites[i]
      
      love.graphics.draw(s.images[math.floor(s.currentImage)], 
        s.posX, s.posY, 0, s.scaleX, s.scaleY, s.oX, s.oY)

        s:draw()
                        
    end

  end

end

return spriteManager
