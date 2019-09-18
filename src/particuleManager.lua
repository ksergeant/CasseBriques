local particuleManager = {}
local spriteManager = require("spriteManager")

particuleManager.list_particule = {}

function particuleManager:CreateParticule(pType, pName, pTableauImages, pNombreFrames, pCouleur)
  
  local particule = spriteManager:CreateSprite("particule", pName, pTableauImages, pNombreFrames)
 
  particule.posX = 0
  particule.posY = 0
  particule.isBroken = false
  particule.durability = 0
  
  particule.images = {}
  particule.imagesBroken = {}
  particule.images[1] = "graphiques/Brick/Brick1.png"
  particule.images[2] = "graphiques/Brick/Brick2.png"
  particule.images[3] = "graphiques/Brick/Brick3.png"
  particule.images[4] = "graphiques/Brick/Brick4.png"
  particule.images[5] = "graphiques/Brick/Brick5.png"
  particule.images[6] = "graphiques/Brick/Brick6.png"
  particule.images[7] = "graphiques/Brick/Brick7.png"
  particule.images[8] = "graphiques/Brick/Brick8.png"
  particule.images[9] = "graphiques/Brick/Brick9.png"
  particule.images[10] = "graphiques/Brick/Brick10.png"
  
  particule.imagesBroken[1] = "graphiques/Brick/Brick1Broken.png"
  particule.imagesBroken[2] = "graphiques/Brick/Brick2Broken.png"
  particule.imagesBroken[3] = "graphiques/Brick/Brick3Broken.png"
  particule.imagesBroken[4] = "graphiques/Brick/Brick4Broken.png"
  particule.imagesBroken[5] = "graphiques/Brick/Brick5Broken.png"
  particule.imagesBroken[6] = "graphiques/Brick/Brick6Broken.png"
  particule.imagesBroken[7] = "graphiques/Brick/Brick7Broken.png"
  particule.imagesBroken[8] = "graphiques/Brick/Brick8Broken.png"
  particule.imagesBroken[9] = "graphiques/Brick/Brick9Broken.png"
  particule.imagesBroken[10] = "graphiques/Brick/Brick10Broken.png"

  if (pType == "Classique") then
    particule.durability = 1

  end
  particule.largeur = particule.images[1]:getWidth()
  particule.hauteur = particule.images[1]:getHeight()

  table.insert(particuleManager.list_sprites, particule)
  
  print("particule Create")

  return particule
  
end



function particuleManager:Update(dt)
  
    if #particuleManager.list_sprites~=nil then
      
      for i = 1, #particuleManager.list_sprites do
      
        local s = particuleManager.list_sprites[i]
        
        if s.delete == true then

          table.remove(particuleManager.list_sprites, i)

        end 

        if s.isAnimed == true then
            s:anime()
        end

        
        
      end
      
    end
        
end

function particuleManager:Draw()
  
  if #particuleManager.list_sprites~=nil then

    for i = 1, #particuleManager.list_sprites do
      
      local s = particuleManager.list_sprites[i]
      
      love.graphics.draw(s.images[math.floor(s.currentImage)], 
        s.posX, s.posY, 0, s.scaleX, s.scaleY, s.oX, s.oY)

        s:draw()
                        
    end

  end

end

return particuleManager
