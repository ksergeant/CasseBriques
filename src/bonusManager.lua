local bonusManager = {}
local spriteManager = require("spriteManager")

bonusManager.list_briques = {}

function bonusManager:CreateBonus(pType, pName, pTableauImages, pNombreFrames, pCouleur)
  
  local bonus = spriteManager:CreateSprite("bonus", pName, pTableauImages, pNombreFrames)
 
  bonus.posX = 0
  bonus.posY = 0
  bonus.isBroken = false
  bonus.durability = 0
  
  bonus.images = {}
  bonus.imagesBroken = {}
  bonus.images[1] = "graphiques/Brick/Brick1.png"
  bonus.images[2] = "graphiques/Brick/Brick2.png"
  bonus.images[3] = "graphiques/Brick/Brick3.png"
  bonus.images[4] = "graphiques/Brick/Brick4.png"
  bonus.images[5] = "graphiques/Brick/Brick5.png"
  bonus.images[6] = "graphiques/Brick/Brick6.png"
  bonus.images[7] = "graphiques/Brick/Brick7.png"
  bonus.images[8] = "graphiques/Brick/Brick8.png"
  bonus.images[9] = "graphiques/Brick/Brick9.png"
  bonus.images[10] = "graphiques/Brick/Brick10.png"
  
  bonus.imagesBroken[1] = "graphiques/Brick/Brick1Broken.png"
  bonus.imagesBroken[2] = "graphiques/Brick/Brick2Broken.png"
  bonus.imagesBroken[3] = "graphiques/Brick/Brick3Broken.png"
  bonus.imagesBroken[4] = "graphiques/Brick/Brick4Broken.png"
  bonus.imagesBroken[5] = "graphiques/Brick/Brick5Broken.png"
  bonus.imagesBroken[6] = "graphiques/Brick/Brick6Broken.png"
  bonus.imagesBroken[7] = "graphiques/Brick/Brick7Broken.png"
  bonus.imagesBroken[8] = "graphiques/Brick/Brick8Broken.png"
  bonus.imagesBroken[9] = "graphiques/Brick/Brick9Broken.png"
  bonus.imagesBroken[10] = "graphiques/Brick/Brick10Broken.png"

  if (pType == "Classique") then
    bonus.durability = 1

  end
  bonus.largeur = bonus.images[1]:getWidth()
  bonus.hauteur = bonus.images[1]:getHeight()

  table.insert(bonusManager.list_sprites, bonus)
  
  print("bonus Create")

  return bonus
  
end



function bonusManager:Update(dt)
  
    if #bonusManager.list_sprites~=nil then
      
      for i = 1, #bonusManager.list_sprites do
      
        local s = bonusManager.list_sprites[i]
        
        if s.delete == true then

          table.remove(bonusManager.list_sprites, i)

        end 

        if s.isAnimed == true then
            s:anime()
        end

        
        
      end
      
    end
        
end

function bonusManager:Draw()
  
  if #bonusManager.list_sprites~=nil then

    for i = 1, #bonusManager.list_sprites do
      
      local s = bonusManager.list_sprites[i]
      
      love.graphics.draw(s.images[math.floor(s.currentImage)], 
        s.posX, s.posY, 0, s.scaleX, s.scaleY, s.oX, s.oY)

        s:draw()
                        
    end

  end

end

return bonusManager
