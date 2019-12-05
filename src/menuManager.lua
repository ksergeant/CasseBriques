local menuManager = {}
local gameState = require("gameState")
local tweening = require("tweening")

-- Ecran titre
function menuManager:EcranTitreLoad()
    tweening:EnterMenu()
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

    self.myCursor.largeur = self.myCursor.image:getWidth() * self.myCursor.scaleX 
    self.myCursor.hauteur = self.myCursor.image:getHeight() * self.myCursor.scaleY

    self.myCursor.oX = self.myCursor.image:getWidth() / 2
    self.myCursor.oY = self.myCursor.image:getWidth() / 2
   
    self.myCursor.stable = false
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

  for i=1,#tweening.menuTweenBouton do
    if tweening.menuTweenBouton[i].time < tweening.menuTweenBouton[i].duration then
        tweening.menuTweenBouton[i].time = tweening.menuTweenBouton[i].time + dt
    
    end
  end

    if tweening.menuTweenBouton[4].time > tweening.menuTweenBouton[4].duration then
        self.myCursor.stable = true
    end

  for i=1,#tweening.menuTweenTexte do
    if tweening.menuTweenTexte[i].time < tweening.menuTweenTexte[i].duration then
        tweening.menuTweenTexte[i].time = tweening.menuTweenTexte[i].time + dt

    end
  end

    self:EcranTitreCursor()
    self:EcranTitreAnimationTexte(dt)
    
end

function menuManager:EcranTitreDraw()

    local r,g,b = love.graphics.getColor() 
    local c = self.myCursor
    love.graphics.draw(self.backgroundMenuTitre, 0, 0)

    love.graphics.setFont(fontMenuTitre)
    tween = tweening.menuTweenTexte[1].ease(tweening.menuTweenTexte[1].time, tweening.menuTweenTexte[1].value, tweening.menuTweenTexte[1].distance, tweening.menuTweenTexte[1].duration)

    love.graphics.print("SPACE BRICK", 365, tween)
    
    love.graphics.setFont(fontLabelMenu)

    tween = tweening.menuTweenBouton[1].ease(tweening.menuTweenBouton[1].time, tweening.menuTweenBouton[1].value, tweening.menuTweenBouton[1].distance, tweening.menuTweenBouton[1].duration)
    love.graphics.draw(self.myButton1, tween, 200)

    tween = tweening.menuTweenBouton[2].ease(tweening.menuTweenBouton[2].time, tweening.menuTweenBouton[2].value, tweening.menuTweenBouton[2].distance, tweening.menuTweenBouton[2].duration)
    love.graphics.draw(self.myButton2, tween, 300)

    tween = tweening.menuTweenBouton[3].ease(tweening.menuTweenBouton[3].time, tweening.menuTweenBouton[3].value, tweening.menuTweenBouton[3].distance, tweening.menuTweenBouton[3].duration)
    love.graphics.draw(self.myButton3, tween, 400)

    tween = tweening.menuTweenBouton[4].ease(tweening.menuTweenBouton[4].time, tweening.menuTweenBouton[4].value, tweening.menuTweenBouton[4].distance, tweening.menuTweenBouton[4].duration)
    love.graphics.draw(c.image, tween, c.y, 0, c.scaleX, c.scaleY)

    tween = tweening.menuTweenTexte[2].ease(tweening.menuTweenTexte[2].time, tweening.menuTweenTexte[2].value, tweening.menuTweenTexte[2].distance, tweening.menuTweenTexte[2].duration)
    if self.myCursor.pos == 1 then
        love.graphics.setColor(0.8, 0, 0)
        love.graphics.print("Nouvelle Partie", 422, tween)
    else 
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Nouvelle Partie", 422, tween)
    end

    tween = tweening.menuTweenTexte[3].ease(tweening.menuTweenTexte[3].time, tweening.menuTweenTexte[3].value, tweening.menuTweenTexte[3].distance, tweening.menuTweenTexte[3].duration)
    if self.myCursor.pos == 2 then
        love.graphics.setColor(0.8, 0, 0)
        love.graphics.print("Charger Partie", 424, tween)
    else 
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Charger Partie", 424, tween)
    end

    tween = tweening.menuTweenTexte[4].ease(tweening.menuTweenTexte[4].time, tweening.menuTweenTexte[4].value, tweening.menuTweenTexte[4].distance, tweening.menuTweenTexte[4].duration)
    if self.myCursor.pos == 3 then
        love.graphics.setColor(0.8, 0, 0)
        love.graphics.print("Quitter", 463, tween)
    else
        love.graphics.setColor(0, 0, 0) 
        love.graphics.print("Quitter", 463, tween)
    end

    tween = tweening.menuTweenTexte[5].ease(tweening.menuTweenTexte[5].time, tweening.menuTweenTexte[5].value, tweening.menuTweenTexte[5].distance, tweening.menuTweenTexte[5].duration)
    love.graphics.setFont(fontLabelAppuyez)
    love.graphics.setColor(0.2, 0.6, 1, alpha) 
    love.graphics.print("Appuyez sur Espace pour continuer", 280, tween)

    tween = tweening.menuTweenTexte[6].ease(tweening.menuTweenTexte[6].time, tweening.menuTweenTexte[6].value, tweening.menuTweenTexte[6].distance, tweening.menuTweenTexte[6].duration)
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
