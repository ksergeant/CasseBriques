local menuManager = {}
local gameState = require("gameState")

-- Ecran titre

function menuManager:EcranTitreLoad()
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
        print (alpha)
        print ("superieur")
    else
        disparu = false
    end

    if alphaRef < alpha and disparu == false  then
        alpha = alpha - alpha * dt 
        print (alpha)
        print ("inferieur")
    else 
        disparu = true
    end

 end
 

function menuManager:EcranTitreUpdate(dt)

    self:EcranTitreCursor()
    self:EcranTitreAnimationTexte(dt)
    
end

function menuManager:EcranTitreDraw()

    local r,g,b = love.graphics.getColor() 
    local c = self.myCursor
    love.graphics.draw(self.backgroundMenuTitre, 0, 0)

    love.graphics.draw(self.myButton1, 400, 200)
    love.graphics.draw(self.myButton2, 400, 300)
    love.graphics.draw(self.myButton3, 400, 400)

    love.graphics.draw(c.image, c.x, c.y, 0, c.scaleX, c.scaleY)

    love.graphics.setFont(fontMenuTitre)
    love.graphics.print("SPACE BRICK", 365, 90)
    
   love.graphics.setFont(fontLabelMenu)

    if self.myCursor.pos == 1 then
        love.graphics.setColor(0.8, 0, 0)
        love.graphics.print("Nouvelle Partie", 420, 210)
    else 
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Nouvelle Partie", 420, 210)
    end

    if self.myCursor.pos == 2 then
        love.graphics.setColor(0.8, 0, 0)
        love.graphics.print("Charger Partie", 422, 310)
    else 
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Charger Partie", 422, 310)
    end

    if self.myCursor.pos == 3 then
        love.graphics.setColor(0.8, 0, 0)
        love.graphics.print("Quitter", 460, 410)
    else
        love.graphics.setColor(0, 0, 0) 
        love.graphics.print("Quitter", 460, 410)
    end

    love.graphics.setFont(fontLabelAppuyez)
    love.graphics.setColor(0.2, 0.6, 1, alpha) 
    love.graphics.print("Appuyez sur Espace pour continuer", 280, 500)

    love.graphics.setFont(fontMenuTitre)
    love.graphics.setColor(0.8, 0, 0) -- Rouge
    love.graphics.print("by Moks", 810, 550)
    
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
