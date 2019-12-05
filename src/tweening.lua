local tweening = {}
tweening.menuTweenBouton = {}
tweening.menuTweenTexte = {}

-- Fonction de tweening
function tweening.easeInSin(t, b, c, d)
    return -c * math.cos(t/d * (math.pi/2)) + c + b
  end
  
  function tweening.easeOutSin(t, b, c, d)
    return c * math.sin(t/d * (math.pi/2)) + b
  end
  
  function tweening.easeInExpo(t, b, c, d)
      return c * math.pow( 2, 10 * (t/d - 1) ) + b
  end
  
  function tweening.easeOutExpo(t, b, c, d)
      return c * ( -math.pow( 2, -10 * t/d ) + 1 ) + b
  end

  -- Tweening 
function tweening:EnterMenu()

    -- bouton nouvelle partie
   self.menuTweenBouton[1] = {}
   self.menuTweenBouton[1].time = 0
   self.menuTweenBouton[1].value = -100
   self.menuTweenBouton[1].distance = 500
   self.menuTweenBouton[1].duration = 2
   self.menuTweenBouton[1].ease = tweening.easeOutSin
   self.menuTweenBouton[1].y = 200
   
    -- bouton chargement partie
    self.menuTweenBouton[2] = {}
    self.menuTweenBouton[2].time = 0
    self.menuTweenBouton[2].value = -200
    self.menuTweenBouton[2].distance = 600
    self.menuTweenBouton[2].duration = 2.3
    self.menuTweenBouton[2].ease = tweening.easeOutSin
    self.menuTweenBouton[2].y = 250
  
    -- bouton Quitter 
    self.menuTweenBouton[3] = {}
    self.menuTweenBouton[3].time = 0
    self.menuTweenBouton[3].value = -300
    self.menuTweenBouton[3].distance = 700
    self.menuTweenBouton[3].duration = 2.6
    self.menuTweenBouton[3].ease = tweening.easeOutSin
    self.menuTweenBouton[3].y = 300

      -- Cursor
    self.menuTweenBouton[4] = {}
    self.menuTweenBouton[4].time = 0
    self.menuTweenBouton[4].value = -300
    self.menuTweenBouton[4].distance = 630
    self.menuTweenBouton[4].duration = 2
    self.menuTweenBouton[4].ease = tweening.easeOutSin
    self.menuTweenBouton[4].y = 300

    -- Texte
    self.menuTweenTexte[1] = {}
    self.menuTweenTexte[1].time = 0
    self.menuTweenTexte[1].value = -20
    self.menuTweenTexte[1].distance = 90
    self.menuTweenTexte[1].duration = 1.5
    self.menuTweenTexte[1].ease = tweening.easeOutSin
    self.menuTweenTexte[1].y = 200
    
    
    self.menuTweenTexte[2] = {}
    self.menuTweenTexte[2].time = 0
    self.menuTweenTexte[2].value = -20
    self.menuTweenTexte[2].distance = 230
    self.menuTweenTexte[2].duration = 2
    self.menuTweenTexte[2].ease = tweening.easeOutSin
    self.menuTweenTexte[2].y = 250
    
    self.menuTweenTexte[3] = {}
    self.menuTweenTexte[3].time = 0
    self.menuTweenTexte[3].value = -40
    self.menuTweenTexte[3].distance = 350
    self.menuTweenTexte[3].duration = 2.3
    self.menuTweenTexte[3].ease = tweening.easeOutSin
    self.menuTweenTexte[3].y = 300
   
    self.menuTweenTexte[4] = {}
    self.menuTweenTexte[4].time = 0
    self.menuTweenTexte[4].value = -60
    self.menuTweenTexte[4].distance = 470
    self.menuTweenTexte[4].duration = 2.6
    self.menuTweenTexte[4].ease = tweening.easeOutSin
    self.menuTweenTexte[4].y = 300
   
    self.menuTweenTexte[5] = {}
    self.menuTweenTexte[5].time = 0
    self.menuTweenTexte[5].value = -90
    self.menuTweenTexte[5].distance = 590
    self.menuTweenTexte[5].duration = 2.9
    self.menuTweenTexte[5].ease = tweening.easeOutSin
    self.menuTweenTexte[5].y = 300
   
    self.menuTweenTexte[6] = {}
    self.menuTweenTexte[6].time = 0
    self.menuTweenTexte[6].value = -110
    self.menuTweenTexte[6].distance = 660
    self.menuTweenTexte[6].duration = 3.2
    self.menuTweenTexte[6].ease = tweening.easeOutSin
    self.menuTweenTexte[6].y = 300
  end


return tweening