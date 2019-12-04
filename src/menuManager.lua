local menuManager = {}
local gameState = require("gameState")

local gameState
local menuTweenBouton = {}
local menuTweenTexte = {}

local bMenuStable = false
local bMenuVisible
local currentMenu

function easeInSin(t, b, c, d)
    return -c * math.cos(t/d * (math.pi/2)) + c + b
  end
  
  function easeOutSin(t, b, c, d)
    return c * math.sin(t/d * (math.pi/2)) + b
  end
  
  function easeInExpo(t, b, c, d)
      return c * math.pow( 2, 10 * (t/d - 1) ) + b
  end
  
  function easeOutExpo(t, b, c, d)
      return c * ( -math.pow( 2, -10 * t/d ) + 1 ) + b
  end

  -- Tweening 
  function EnterMenu()
  
    gameState = "menu"
    
    bMenuVisible = true
    
    menuTweenBouton[1] = {}
    menuTweenBouton[1].time = 0
    menuTweenBouton[1].value = -100
    menuTweenBouton[1].distance = 500
    menuTweenBouton[1].duration = 2
    menuTweenBouton[1].ease = easeOutSin
    menuTweenBouton[1].y = 200
    menuTweenBouton[1].gameState = "arcade"
    
    menuTweenBouton[2] = {}
    menuTweenBouton[2].time = 0
    menuTweenBouton[2].value = -200
    menuTweenBouton[2].distance = 600
    menuTweenBouton[2].duration = 2.3
    menuTweenBouton[2].ease = easeOutSin
    menuTweenBouton[2].y = 250
    menuTweenBouton[2].gameState = "adventure"
  
    menuTweenBouton[3] = {}
    menuTweenBouton[3].time = 0
    menuTweenBouton[3].value = -300
    menuTweenBouton[3].distance = 700
    menuTweenBouton[3].duration = 2.6
    menuTweenBouton[3].ease = easeOutSin
    menuTweenBouton[3].y = 300
    menuTweenBouton[3].gameState = "exit"

    -- Texte
    menuTweenTexte[1] = {}
    menuTweenTexte[1].time = 0
    menuTweenTexte[1].value = -20
    menuTweenTexte[1].distance = 90
    menuTweenTexte[1].duration = 1.5
    menuTweenTexte[1].ease = easeOutSin
    menuTweenTexte[1].y = 200
    menuTweenTexte[1].gameState = "arcade"
    
    menuTweenTexte[2] = {}
    menuTweenTexte[2].time = 0
    menuTweenTexte[2].value = -20
    menuTweenTexte[2].distance = 230
    menuTweenTexte[2].duration = 2
    menuTweenTexte[2].ease = easeOutSin
    menuTweenTexte[2].y = 250
    menuTweenTexte[2].gameState = "adventure"
  
    menuTweenTexte[3] = {}
    menuTweenTexte[3].time = 0
    menuTweenTexte[3].value = -40
    menuTweenTexte[3].distance = 350
    menuTweenTexte[3].duration = 2.3
    menuTweenTexte[3].ease = easeOutSin
    menuTweenTexte[3].y = 300
    menuTweenTexte[3].gameState = "exit"

    menuTweenTexte[4] = {}
    menuTweenTexte[4].time = 0
    menuTweenTexte[4].value = -60
    menuTweenTexte[4].distance = 470
    menuTweenTexte[4].duration = 2.6
    menuTweenTexte[4].ease = easeOutSin
    menuTweenTexte[4].y = 300
    menuTweenTexte[4].gameState = "exit"

    menuTweenTexte[5] = {}
    menuTweenTexte[5].time = 0
    menuTweenTexte[5].value = -90
    menuTweenTexte[5].distance = 590
    menuTweenTexte[5].duration = 2.9
    menuTweenTexte[5].ease = easeOutSin
    menuTweenTexte[5].y = 300
    menuTweenTexte[5].gameState = "exit"

    menuTweenTexte[6] = {}
    menuTweenTexte[6].time = 0
    menuTweenTexte[6].value = -110
    menuTweenTexte[6].distance = 660
    menuTweenTexte[6].duration = 3.2
    menuTweenTexte[6].ease = easeOutSin
    menuTweenTexte[6].y = 300
    menuTweenTexte[6].gameState = "exit"
    
    currentMenu = 1
  
  end

-- Ecran titre
function menuManager:EcranTitreLoad()
    EnterMenu()
    self.backgroundMenuTitre = love.graphics.newImage("graphiques/Background/BackgroundMenu.png")
    self.myButton1 = love.graphics.newImage("graphiques/Gui/grey_button00.png")
    self.myButton2 = love.graphics.newImage("graphiques/Gui/grey_button00.png")
    self.myButton3 = love.graphics.newImage("graphiques/Gui/grey_button00.png")

    self.myCursor = {}
    self.myCursor.image = love.graphics.newImage("graphiques/Star/Etoile.png")
    self.myCursor.x = 330
    self.myCursor.y = 200
    self.myCursor.scaleX = 0.3
    self.myCursor.scaleY = 0.3
    self.myCursor.pos = 1
    
    font = love.graphics.setNewFont("graphiques/Gui/KenPixelNova.ttf", 20)
    fontClassique = love.graphics.getFont()
    fontMenuTitre = love.graphics.setNewFont("graphiques/Gui/KenPixelNova.ttf",70) 
    fontLabelMenu  = love.graphics.setNewFont("graphiques/Gui/KenPixelNova.ttf",30)
    fontLabelAppuyez = love.graphics.setNewFont("graphiques/Gui/KenPixelNova.ttf",40)

    -- Variables pour l'animation du texte
    alpha = 0.5
    alphaRef = 0.5
    disparu = true
 end

 function menuManager:EcranTitreCursor()

    -- gestion de la position du curseur
    if self.myCursor.pos < 1 then
        self.myCursor.pos = 1
    end

    if self.myCursor.pos > 3 then
        self.myCursor.pos = 3
    end

    if self.myCursor.pos == 1 then
            self.myCursor.y = 200
    elseif self.myCursor.pos == 2 then   
            self.myCursor.y = 300
    elseif self.myCursor.pos == 3 then     
            self.myCursor.y = 400
    end

 end
 
 function menuManager:EcranTitreAnimationTexte(dt)

    -- animation du texte 
    if alpha < 1 and disparu == true then
        alpha = alpha + alpha * dt 
     
    else
        disparu = false
    end

    if alphaRef < alpha and disparu == false  then
        alpha = alpha - alpha * dt 
       
    else 
        disparu = true
    end

 end
 

function menuManager:EcranTitreUpdate(dt)

    bMenuStable = true
  for i=1,#menuTweenBouton do
    if menuTweenBouton[i].time < menuTweenBouton[i].duration then
      menuTweenBouton[i].time = menuTweenBouton[i].time + dt
      bMenuStable = false
    end
  end

  bMenuStable = true
  for i=1,#menuTweenTexte do
    if menuTweenTexte[i].time < menuTweenTexte[i].duration then
      menuTweenTexte[i].time = menuTweenTexte[i].time + dt
      bMenuStable = false
    end
  end

  -- Exécute l'action choisie par le joueur
  if bMenuStable == true and bMenuVisible == false and gameState == "menu" then
    gameState = menuTweenBouton[currentMenu].gameState
  end
  
  if gameState == "exit" then
    love.event.quit()
  end

    self:EcranTitreCursor()
    self:EcranTitreAnimationTexte(dt)
    
end

function menuManager:EcranTitreDraw()

    local r,g,b = love.graphics.getColor() 
    local c = self.myCursor
    love.graphics.draw(self.backgroundMenuTitre, 0, 0)

    love.graphics.setFont(fontMenuTitre)
    tween = menuTweenTexte[1].ease(menuTweenTexte[1].time, menuTweenTexte[1].value, menuTweenTexte[1].distance, menuTweenTexte[1].duration)

    love.graphics.print("SPACE BRICK", 365, tween)
    
   love.graphics.setFont(fontLabelMenu)

    tween = menuTweenBouton[1].ease(menuTweenBouton[1].time, menuTweenBouton[1].value, menuTweenBouton[1].distance, menuTweenBouton[1].duration)
    love.graphics.draw(self.myButton1, tween, 200)

    tween = menuTweenBouton[2].ease(menuTweenBouton[2].time, menuTweenBouton[2].value, menuTweenBouton[2].distance, menuTweenBouton[2].duration)
    love.graphics.draw(self.myButton2, tween, 300)

    tween = menuTweenBouton[3].ease(menuTweenBouton[3].time, menuTweenBouton[3].value, menuTweenBouton[3].distance, menuTweenBouton[3].duration)
    love.graphics.draw(self.myButton3, tween, 400)

    love.graphics.draw(c.image, c.x, c.y, 0, c.scaleX, c.scaleY)

    tween = menuTweenTexte[1].ease(menuTweenTexte[2].time, menuTweenTexte[2].value, menuTweenTexte[2].distance, menuTweenTexte[2].duration)
    if self.myCursor.pos == 1 then
        love.graphics.setColor(0.8, 0, 0)
        love.graphics.print("Nouvelle Partie", 420, tween)
    else 
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Nouvelle Partie", 420, tween)
    end

    tween = menuTweenTexte[1].ease(menuTweenTexte[3].time, menuTweenTexte[3].value, menuTweenTexte[3].distance, menuTweenTexte[3].duration)
    if self.myCursor.pos == 2 then
        love.graphics.setColor(0.8, 0, 0)
        love.graphics.print("Charger Partie", 422, tween)
    else 
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Charger Partie", 422, tween)
    end

    tween = menuTweenTexte[4].ease(menuTweenTexte[4].time, menuTweenTexte[4].value, menuTweenTexte[4].distance, menuTweenTexte[4].duration)
    if self.myCursor.pos == 3 then
        love.graphics.setColor(0.8, 0, 0)
        love.graphics.print("Quitter", 460, tween)
    else
        love.graphics.setColor(0, 0, 0) 
        love.graphics.print("Quitter", 460, tween)
    end

    tween = menuTweenTexte[1].ease(menuTweenTexte[5].time, menuTweenTexte[5].value, menuTweenTexte[5].distance, menuTweenTexte[5].duration)
    love.graphics.setFont(fontLabelAppuyez)
    love.graphics.setColor(0.2, 0.6, 1, alpha) 
    love.graphics.print("Appuyez sur Espace pour continuer", 280, tween)

    tween = menuTweenTexte[1].ease(menuTweenTexte[6].time, menuTweenTexte[6].value, menuTweenTexte[6].distance, menuTweenTexte[6].duration)
    love.graphics.setFont(fontMenuTitre)
    love.graphics.setColor(0.8, 0, 0) -- Rouge
    love.graphics.print("by Moks", 810, tween)
    
    love.graphics.setFont(fontClassique)
    love.graphics.setColor(r,g,b)
end

-- Ecran Jeu
function menuManager:EcranJeuUpdate(dt)
       
end

function menuManager:EcranJeuDraw()
    
end

-- Ecran GameOver
function menuManager:EcranGameoverUpdate(dt)
       
end

function menuManager:EcranGameoverDraw()
    
end


return menuManager
