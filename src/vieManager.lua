local vieManager = {}
local spriteManager = require("spriteManager")
local gameState = require ("gameState")

vieManager.list_vies = {}

function vieManager:CreateVie(pType, pName, pX, pY)
  
  local vie = spriteManager:CreateSprite("Coeur", pName, pX, pY)

  vie.images = {}
  vie.scaleX = 0.2
  vie.scaleY = 0.2
  vie.images[1] = love.graphics.newImage("graphiques/Star/Coeur.png")
  vie.largeur = vie.images[1]:getWidth() * vie.scaleX
  vie.hauteur = vie.images[1]:getHeight() * vie.scaleY
  vie.oX = 0
  vie.oY = 0
  vie.isAnimed = true
  vie.max = 8
  vie.timer = 0
  table.insert(vieManager.list_vies, vie)
  
  print("vie Create")

  return vie
  
end

function vieManager:Init()

  local decal = 0
    for i = 1, gameState.vies do 
        self:CreateVie("Coeur", "Coeur"..tostring(i), 10 + decal,540)
        decal = decal + 50
        
    end

end

function vieManager:Anime()
  if #vieManager.list_vies~=nil then

    local vPos = #vieManager.list_vies
    local v = vieManager.list_vies[vPos]
    local timer = 15
    
    if v.timer < timer then

      v.scaleX = v.scaleX + 0.0003
      v.scaleY = v.scaleY + 0.0003
      v.timer = v.timer + 0.10

    

    else

      v.timer = 0
      v.scaleX = 0.2
      v.scaleY = 0.2
    end


  end
end

function vieManager:Update(dt)
  
    if #vieManager.list_vies~=nil then
      
      for i = #vieManager.list_vies, 1, -1 do
        
        local v = vieManager.list_vies[i]
        
        if v.delete == true then

          table.remove(vieManager.list_vies, i)

        end 

        if v.isAnimed == true then
            vieManager:Anime()
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
