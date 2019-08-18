local briqueManager = {}
local spriteManager = require("spriteManager")

briqueManager.list_briques = {}

function briqueManager:CreateBrick(pType, pName, pTableauImages, pNombreFrames, pCouleur)
  
  local brique = spriteManager:CreateSprite("brique", pName, pTableauImages, pNombreFrames)
 
  brique.posX = 0
  brique.posY = 0
  brique.isBroken = false
  brique.durability = 0
  
  brique.images = {}
  brique.imagesBroken = {}
  brique.images[1] = "graphiques/Brick/Brick1.png"
  brique.images[2] = "graphiques/Brick/Brick2.png"
  brique.images[3] = "graphiques/Brick/Brick3.png"
  brique.images[4] = "graphiques/Brick/Brick4.png"
  brique.images[5] = "graphiques/Brick/Brick5.png"
  brique.images[6] = "graphiques/Brick/Brick6.png"
  brique.images[7] = "graphiques/Brick/Brick7.png"
  brique.images[8] = "graphiques/Brick/Brick8.png"
  brique.images[9] = "graphiques/Brick/Brick9.png"
  brique.images[10] = "graphiques/Brick/Brick10.png"
  
  brique.imagesBroken[1] = "graphiques/Brick/Brick1Broken.png"
  brique.imagesBroken[2] = "graphiques/Brick/Brick2Broken.png"
  brique.imagesBroken[3] = "graphiques/Brick/Brick3Broken.png"
  brique.imagesBroken[4] = "graphiques/Brick/Brick4Broken.png"
  brique.imagesBroken[5] = "graphiques/Brick/Brick5Broken.png"
  brique.imagesBroken[6] = "graphiques/Brick/Brick6Broken.png"
  brique.imagesBroken[7] = "graphiques/Brick/Brick7Broken.png"
  brique.imagesBroken[8] = "graphiques/Brick/Brick8Broken.png"
  brique.imagesBroken[9] = "graphiques/Brick/Brick9Broken.png"
  brique.imagesBroken[10] = "graphiques/Brick/Brick10Broken.png"

  if (pType == "Classique") then
    brique.durability = 1

  end
  brique.largeur = brique.images[1]:getWidth()
  brique.hauteur = brique.images[1]:getHeight()

  table.insert(briqueManager.list_sprites, brique)
  
  print("brique Create")

  return brique
  
end



function briqueManager:Update(dt)
  
    if #briqueManager.list_sprites~=nil then
      
      for i = 1, #briqueManager.list_sprites do
      
        local s = briqueManager.list_sprites[i]
        
        if s.delete == true then

          table.remove(briqueManager.list_sprites, i)

        end 

        if s.isAnimed == true then
            s:anime()
        end

        
        
      end
      
    end
        
end

function briqueManager:Draw()
  
  if #briqueManager.list_sprites~=nil then

    for i = 1, #briqueManager.list_sprites do
      
      local s = briqueManager.list_sprites[i]
      
      love.graphics.draw(s.images[math.floor(s.currentImage)], 
        s.posX, s.posY, 0, s.scaleX, s.scaleY, s.oX, s.oY)

        s:draw()
                        
    end

  end

end

return briqueManager
