GestionSprite = {}

GestionSprite.CreeCarre = function(pNomCarre,pX,pY)
  local carre = {}
  carre.x = pX + 14
  carre.y = pY + 14
    if pNomCarre == "rouge" then
      carre.sprite =  cuberouge
    end
  
  return carre
end
GestionSprite.CreeForme = function (pForme)
 local cube1
 local cube2
 local cube3
 local cube4
 print(pForme)
 if pForme == 1 then
   cube1 = GestionSprite.CreeCarre("rouge",28*3,0)
   cube2 = GestionSprite.CreeCarre("rouge",28*4,0)
   cube3 = GestionSprite.CreeCarre("rouge",28*5,0)
   cube4 = GestionSprite.CreeCarre("rouge",28*6,0)
 end
 local table = {cube1,cube2,cube3,cube4}
 
 return table
end
return GestionSprite