local vieManager = {}
local spriteManager = require("spriteManager")

vieManager.list_vie = {}

function vieManager:CreateVie(pType, pName, pTableauImages, pNombreFrames, pCouleur)
  
  local vie = spriteManager:CreateSprite("vie", pName, pTableauImages, pNombreFrames)
 
  vie.posX = 0
  vie.posY = 0
  vie.isBroken = false
  vie.durability = 0
  
  vie.images = {}
  vie.imagesBroken = {}
  vie.images[1] = "graphiques/Brick/Brick1.png"
  vie.images[2] = "graphiques/Brick/Brick2.png"
  vie.images[3] = "graphiques/Brick/Brick3.png"
  vie.images[4] = "graphiques/Brick/Brick4.png"
  vie.images[5] = "graphiques/Brick/Brick5.png"
  vie.images[6] = "graphiques/Brick/Brick6.png"
  vie.images[7] = "graphiques/Brick/Brick7.png"
  vie.images[8] = "graphiques/Brick/Brick8.png"
  vie.images[9] = "graphiques/Brick/Brick9.png"
  vie.images[10] = "graphiques/Brick/Brick10.png"
  
  vie.imagesBroken[1] = "graphiques/Brick/Brick1Broken.png"
  vie.imagesBroken[2] = "graphiques/Brick/Brick2Broken.png"
  vie.imagesBroken[3] = "graphiques/Brick/Brick3Broken.png"
  vie.imagesBroken[4] = "graphiques/Brick/Brick4Broken.png"
  vie.imagesBroken[5] = "graphiques/Brick/Brick5Broken.png"
  vie.imagesBroken[6] = "graphiques/Brick/Brick6Broken.png"
  vie.imagesBroken[7] = "graphiques/Brick/Brick7Broken.png"
  vie.imagesBroken[8] = "graphiques/Brick/Brick8Broken.png"
  vie.imagesBroken[9] = "graphiques/Brick/Brick9Broken.png"
  vie.imagesBroken[10] = "graphiques/Brick/Brick10Broken.png"

  if (pType == "Classique") then
    vie.durability = 1

  end
  vie.largeur = vie.images[1]:getWidth()
  vie.hauteur = vie.images[1]:getHeight()

  table.insert(vieManager.list_sprites, vie)
  
  print("vie Create")

  return vie
  
end



function vieManager:Update(dt)
  
    if #vieManager.list_sprites~=nil then
      
      for i = 1, #vieManager.list_sprites do
      
        local s = vieManager.list_sprites[i]
        
        if s.delete == true then

          table.remove(vieManager.list_sprites, i)

        end 

        if s.isAnimed == true then
            s:anime()
        end

        
        
      end
      
    end
        
end

function vieManager:Draw()
  
  if #vieManager.list_sprites~=nil then

    for i = 1, #vieManager.list_sprites do
      
      local s = vieManager.list_sprites[i]
      
      love.graphics.draw(s.images[math.floor(s.currentImage)], 
        s.posX, s.posY, 0, s.scaleX, s.scaleY, s.oX, s.oY)

        s:draw()
                        
    end

  end

end

return vieManager
