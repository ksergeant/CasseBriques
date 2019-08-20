local niveauManager = {}
local spriteManager = require("spriteManager")

niveauManager.list_niveau = {}

function niveauManager:CreateNiveau(pType, pName, pTableauImages, pNombreFrames, pCouleur)
  
  local niveau = spriteManager:CreateSprite("niveau", pName, pTableauImages, pNombreFrames)
 
  niveau.posX = 0
  niveau.posY = 0
  niveau.isBroken = false
  niveau.durability = 0
  
  niveau.images = {}
  niveau.imagesBroken = {}
  niveau.images[1] = "graphiques/Brick/Brick1.png"
  niveau.images[2] = "graphiques/Brick/Brick2.png"
  niveau.images[3] = "graphiques/Brick/Brick3.png"
  niveau.images[4] = "graphiques/Brick/Brick4.png"
  niveau.images[5] = "graphiques/Brick/Brick5.png"
  niveau.images[6] = "graphiques/Brick/Brick6.png"
  niveau.images[7] = "graphiques/Brick/Brick7.png"
  niveau.images[8] = "graphiques/Brick/Brick8.png"
  niveau.images[9] = "graphiques/Brick/Brick9.png"
  niveau.images[10] = "graphiques/Brick/Brick10.png"
  
  niveau.imagesBroken[1] = "graphiques/Brick/Brick1Broken.png"
  niveau.imagesBroken[2] = "graphiques/Brick/Brick2Broken.png"
  niveau.imagesBroken[3] = "graphiques/Brick/Brick3Broken.png"
  niveau.imagesBroken[4] = "graphiques/Brick/Brick4Broken.png"
  niveau.imagesBroken[5] = "graphiques/Brick/Brick5Broken.png"
  niveau.imagesBroken[6] = "graphiques/Brick/Brick6Broken.png"
  niveau.imagesBroken[7] = "graphiques/Brick/Brick7Broken.png"
  niveau.imagesBroken[8] = "graphiques/Brick/Brick8Broken.png"
  niveau.imagesBroken[9] = "graphiques/Brick/Brick9Broken.png"
  niveau.imagesBroken[10] = "graphiques/Brick/Brick10Broken.png"

  if (pType == "Classique") then
    niveau.durability = 1

  end
  niveau.largeur = niveau.images[1]:getWidth()
  niveau.hauteur = niveau.images[1]:getHeight()

  table.insert(niveauManager.list_sprites, niveau)
  
  print("niveau Create")

  return niveau
  
end



function niveauManager:Update(dt)
  
    if #niveauManager.list_sprites~=nil then
      
      for i = 1, #niveauManager.list_sprites do
      
        local s = niveauManager.list_sprites[i]
        
        if s.delete == true then

          table.remove(niveauManager.list_sprites, i)

        end 

        if s.isAnimed == true then
            s:anime()
        end

        
        
      end
      
    end
        
end

function niveauManager:Draw()
  
  if #niveauManager.list_sprites~=nil then

    for i = 1, #niveauManager.list_sprites do
      
      local s = niveauManager.list_sprites[i]
      
      love.graphics.draw(s.images[math.floor(s.currentImage)], 
        s.posX, s.posY, 0, s.scaleX, s.scaleY, s.oX, s.oY)

        s:draw()
                        
    end

  end

end

return niveauManager
