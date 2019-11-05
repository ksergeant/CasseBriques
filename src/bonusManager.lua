local bonusManager = {}
local spriteManager = require("spriteManager")
local gameState = require ("gameState")
bonusManager.list_bonus = {}

function bonusManager:CreateBonus(pType, pName, pX, pY, pId)
  
  local bonus = spriteManager:CreateSprite("Bonus", pName, pX, pY)
  
  bonus.currentImage = pId
  bonus.vy = 150
  bonus.images = {}
 
  bonus.images[1] = love.graphics.newImage("graphiques/Power/AddBall.png")
  bonus.images[2] = love.graphics.newImage("graphiques/Power/Fast.png")
  bonus.images[3] = love.graphics.newImage("graphiques/Power/FireBall.png")
  bonus.images[4] = love.graphics.newImage("graphiques/Power/GlueBall.png")
  bonus.images[5] = love.graphics.newImage("graphiques/Power/LargeRaquet.png")
  bonus.images[6] = love.graphics.newImage("graphiques/Power/Plus50.png")
  bonus.images[7] = love.graphics.newImage("graphiques/Power/Plus100.png")
  bonus.images[8] = love.graphics.newImage("graphiques/Power/Plus250.png")
  bonus.images[9] = love.graphics.newImage("graphiques/Power/Plus500.png")
  bonus.images[10] = love.graphics.newImage("graphiques/Power/ShortRaquet.png")
  bonus.images[11] = love.graphics.newImage("graphiques/Power/Slow.png")
  bonus.images[12] = love.graphics.newImage("graphiques/Power/TirRaquet.png")
  bonus.images[13] = love.graphics.newImage("graphiques/Power/Coeur.png")
 
  bonus.scaleX = 0.18
  bonus.scaleY = 0.18

  bonus.largeur = bonus.images[1]:getWidth() * bonus.scaleX 
  bonus.hauteur = bonus.images[1]:getHeight() * bonus.scaleY 
  bonus.oX = bonus.images[1]:getWidth()/2
  bonus.oY = bonus.images[1]:getHeight()/2

 if pId == 13 then
  bonus.scaleX = 0.25
  bonus.scaleY = 0.25
  bonus.largeur = bonus.images[13]:getWidth() * bonus.scaleX 
  bonus.hauteur = bonus.images[13]:getHeight() * bonus.scaleY 
  bonus.oX = bonus.images[13]:getWidth()/2
  bonus.oY = bonus.images[13]:getHeight()/2
 end

  table.insert(bonusManager.list_bonus, bonus)
  
  print("bonus Create")

  return bonus
  
end



function bonusManager:Update(dt)
  
    if #bonusManager.list_bonus~=0 then
      
      for i = #bonusManager.list_bonus, 1, -1 do
      
        local bo = bonusManager.list_bonus[i]
        
        if bo.delete == true then

          table.remove(bonusManager.list_bonus, i)

        end 

        bo.posY = bo.posY + (bo.vy * dt)
        
        if bo.posY > gameState.hauteur then
          bo.delete = true
        end
        
      end
      
    end
        
end

return bonusManager
