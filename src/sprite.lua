local spriteModel = {}

function spriteModel:Create(pName, pTableauImages, pNombreFrames, pType)
  
  local sprite = {}
  
  sprite.posX = 0
  sprite.posY = 0
  sprite.name = pName
  sprite.oX = 0
  sprite.oY = 0
  sprite.scaleX = 1
  sprite.scaleY = 1
  sprite.type = pType
  sprite.currentImage = 1
  sprite.frames = pNombreFrames
  sprite.images = {} 
  sprite.isAnimed = false
  sprite.delete = false
  sprite.largeur = 0
  sprite.hauteur = 0
  
    for i = 1, #pTableauImages do

        sprite.images[i] = love.graphics.newImage(pTableauImages[i])

    end

  function sprite:anime()
    
    if sprite.currentImage  < sprite.frames then 
      sprite.currentImage = sprite.currentImage + 0.15
      
    else 
      sprite.currentImage = 1
    end

  end

  function sprite:draw()

    love.graphics.circle("fill", self.posX, self.posY, 2)
    print("debug")
  end
  
  
return sprite
end



return spriteModel
