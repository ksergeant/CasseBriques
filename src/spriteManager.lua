local spriteManager = {}

spriteManager.list_sprites = {}

local spriteModel = require("sprite")

function spriteManager:CreateSprite(pName, pTableauImages, pNombreFrames)
  
  local spriteTempo = {}
 
  spriteTempo = spriteModel:Create(pName, pTableauImages, pNombreFrames)
  
  table.insert(spriteManager.list_sprites, spriteTempo)
  
  print("Sprite Create")
  
end

function spriteManager:SettingSprite(pSpriteName, pPosX, pPosY, pScaleX, pScaleY, pOrigineX, pOrigineY, pType, pIsAnimed)
  
  -- recherche dans le spriteManager et si il est présent, il est modifié
  if #spriteManager.list_sprites~=nil then

    for i = 1, #spriteManager.list_sprites do
      
      local s = spriteManager.list_sprites[i]
      
      if pSpriteName == s.name then 
          
        s.posX = pPosX
        s.posY = pPosY
        s.scaleX = pScaleX
        s.scaleY = pScaleY
        s.oX = pOrigineX
        s.oY = pOrigineY
        s.type = pType
        s.isAnimed = pIsAnimed
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
            s.anime()
        end
        
      end
      
    end
        
end

function spriteManager:Draw()
  
  if #spriteManager.list_sprites~=nil then

    for i = 1, #spriteManager.list_sprites do
      
      local s = spriteManager.list_sprites[i]
      
      love.graphics.draw(s.images[math.floor(s.currentImage)], 
        s.posX, s.posY, 0, s.scaleX, s.scaleY, 1)
                        
    end

  end

end

return spriteManager
