local spriteModel = {}

function spriteModel:Create(pName, pTableauImages, pNombreFrames)
  
  local sprite = {}
  
  sprite.posX = 0
  sprite.posY = 0
  sprite.name = pName
  sprite.oX = 0
  sprite.oY = 0
  sprite.scaleX = 1
  sprite.scaleY = 1
  sprite.type = nil
  sprite.currentImage = 1
  sprite.frames = pNombreFrames
  sprite.images = {} 
  sprite.isAnimed = false
  sprite.delete = false
  
    for i = 1, #pTableauImages do

        sprite.images[i] = love.graphics.newImage(pTableauImages[i])

    end

  function sprite:anime()
    print(sprite.name)
    if sprite.currentImage  < sprite.frames then 
      sprite.currentImage = sprite.currentImage + 0.15
      
    else 
      sprite.currentImage = 1
    end

  end
  
  
return sprite
end



return spriteModel
