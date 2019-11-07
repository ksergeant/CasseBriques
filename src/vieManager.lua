local vieManager = {}
local spriteManager = require("spriteManager")
local gameState = require ("gameState")
local decal = 0

vieManager.list_vies = {}

function vieManager:CreateVie(pType, pName, pX, pY)
  
  pX = pX + decal

  local vie = spriteManager:CreateSprite(pType, pName, pX, pY)

  vie.images = {}
  vie.scaleX = 0.23
  vie.scaleY = 0.23
  vie.scaleXRef = 0.23
  vie.scaleYRef = 0.23
  vie.grossissement = false
  vie.retrecissement = true
  vie.images[1] = love.graphics.newImage("graphiques/Star/Coeur.png")
  vie.largeur = vie.images[1]:getWidth() * vie.scaleX
  vie.hauteur = vie.images[1]:getHeight() * vie.scaleY
  vie.oX = 0
  vie.oY = 0
  vie.isAnimed = true
  vie.max = 8
  vie.timer = 0
  table.insert(vieManager.list_vies, vie)
  
  decal = decal + 50
  print("vie Create")

  return vie
  
end

function vieManager:Init()

    for i = 1, gameState.vies do 
        self:CreateVie("Coeur", "Coeur"..tostring(i), 10 ,540)
        
    end

end

function vieManager:Delete()

  gameState.vies = gameState.vies - 1
  if #self.list_vies ~=0 then
    local i = #self.list_vies 
    self.list_vies[i].delete = true
    table.remove( self.list_vies, i)
    decal = decal - 50
  end

end

function vieManager:AddVieBonus()
  if gameState.vies < gameState.viesMax then

    gameState.vies = gameState.vies + 1
    local posV = #self.list_vies
    self.list_vies[posV].scaleX = self.list_vies[posV].scaleXRef
    self.list_vies[posV].scaleY = self.list_vies[posV].scaleYRef
    self:CreateVie("Coeur", "Coeur"..tostring(gameState.vies), 10, 540)

  end
end

function vieManager:Anime()
  if #vieManager.list_vies~=nil then

    local vPos = #vieManager.list_vies
    local v = vieManager.list_vies[vPos]
    local timer = 20

    -- Grossisement
    if v.timer < timer and v.grossissement == false then

      v.scaleX = v.scaleX + 0.0003
      v.scaleY = v.scaleY + 0.0003
      v.timer = v.timer + 0.09

     -- v.timer = 0
   --   v.scaleX = 0.2
    --  v.scaleY = 0.2
  
    else 
      v.grossissement = true
      v.timer = 0
     
    end

    -- Retrecissement
    if v.scaleXRef < v.scaleX  and v.grossissement == true then

      v.scaleX = v.scaleX - 0.0003
      v.scaleY = v.scaleY - 0.0003
      v.timer = v.timer + 0.09
    else
      v.grossissement = false
      
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
