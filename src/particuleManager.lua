local particuleManager = {}
local menuManager = require("menuManager")
particuleManager.list_particules = {}
particuleManager.timerCursor= 0

function particuleManager:Reset()

  particuleManager.list_particules = {}

end

function particuleManager:CreateParticule(pX, pY, pVx, pVy, pLife)
  
  if pLife == nil then
    pLife = 500
  end

  local particule = {}

  particule.posX = pX
  particule.posY = pY
  particule.life = pLife
  particule.vx = pVx
  particule.vy = pVy
  particule.delete = false

  function particule:Deplace(dt)

    -- Application de la vélocité
    particule.posX = particule.posX + particule.vx * (dt*20)
    particule.posY = particule.posY + particule.vy * (dt*20)
    particule.life = particule.life - 1

    if particule.life < 0 then
      particule.delete = true
    end

  end
  
  table.insert(particuleManager.list_particules, particule)
  
  print("particule Create")

  return particule
  
end

function particuleManager:Cursor(pX, pY)

  for n=1,30 do
    particuleManager:CreateParticule(pX, pY, math.random(-30,30)/10, math.random(-30,30)/10, 500)
  end

end

function particuleManager:Update(dt)

  -- toutes les secondes création d'une explosion de particule à l'origine du curseur dans le menu général
    particuleManager.timerCursor = particuleManager.timerCursor + dt
    if particuleManager.timerCursor > 1 and menuManager.myCursor.stable == true then
       particuleManager.timerCursor = 0
       particuleManager:Cursor(menuManager.myCursor.x + menuManager.myCursor.largeur/2, menuManager.myCursor.y + menuManager.myCursor.hauteur/2)
    end
    if #particuleManager.list_particules~=nil then
      
      for i = #particuleManager.list_particules, 1, -1 do
      
        local p = particuleManager.list_particules[i]
        
        if p.delete == true then

          table.remove(particuleManager.list_particules, i)

        end 
        
        p:Deplace(dt)

      end
      
    end
        
end

function particuleManager:Draw()
  
  if #particuleManager.list_particules~=nil then

    for i = 1, #particuleManager.list_particules do
      
      local p = particuleManager.list_particules[i]

      love.graphics.circle("fill", p.posX, p.posY, 1)
                           
    end

  end

end

return particuleManager
