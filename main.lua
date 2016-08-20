io.stdout:setvbuf('no')
if arg[#arg] == "-debug" then require("mobdebug").start() end

-- Information de  base
local resolutionHauteur
local resolutionLargeur
-- Espace de nom
local GestionSprite = require("gestionsprite")

-- Taille des blocs
local hauteurBloc = 28
local largeurBloc = 28

-- Liste blocs posé et la liste des bloc précharger
local listeBlocPose = {}
local listeBlocCharge = {}

-- le tableau de jeu
local tableauJeu = {}


tableauJeu[1]   = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[2]   = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[3]   = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[4]   = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[5]   = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[6]   = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[7]   = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[8]   = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[9]   = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[10]  = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[11]  = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[12]  = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[13]  = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[14]  = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[15]  = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[16]  = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[17]  = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[18]  = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[19]  = {0,0,0,0,0,0,0,0,0,0}
tableauJeu[20]  = {0,0,0,0,0,0,0,0,0,0}



function Pose(pCube,nligne,ncolonne)
  
  --local nligne = math.floor((pCube.y/hauteurBloc)+1)
  --local ncolonne = math.floor((pCube.x/largeurBloc)+1)
  
  pCube.ligne = nligne
  
  table.insert(listeBlocPose,pCube)
  
  
  tableauJeu[nligne][ncolonne] = 1

  return nligne

end

function VerifieLigne(nligne)
  
  local n
  local compteur = 0
  for n = 1, 10, 1 do
    if tableauJeu[nligne][n] == 1 then
      compteur = compteur + 1
    end
  end
  local condition = compteur == 10
  
  return condition

end

function love.load()
  
  -- Affichage
  resolutionHauteur = hauteurBloc * 20
  resolutionLargeur = largeurBloc * 10
  love.window.setMode(resolutionLargeur, resolutionHauteur)
  -- Asset
  quadrillage = love.graphics.newImage("images/grille.png")
  gameover    = love.graphics.newImage("images/game_over.png")
  cuberouge   = love.graphics.newImage("images/cube_rouge.png")
  cube = GestionSprite.CreeCarre("rouge",resolutionLargeur/2,0)
  forme = GestionSprite.CreeForme(1)
end

function love.keypressed(key)
  
  if key == "left" and cube.x > 0 then
    cube.x = cube.x - largeurBloc
  end
  if key == "right" and cube.x < resolutionLargeur - largeurBloc then
    cube.x = cube.x + largeurBloc
  end

end

function love.update(dt)
  
  local nligne = math.floor((cube.y/hauteurBloc)+1)
  local ncolonne = math.floor((cube.x/largeurBloc)+1)
  print("ligne ,",nligne)
  print("colonne",ncolonne)
  if cube.y < resolutionHauteur - 14 then
    cube.y = cube.y + 2
 
  else
  Pose(cube,nligne,ncolonne)
  cube = {}
  cube = GestionSprite.CreeCarre("rouge",resolutionLargeur/2,0)
  end
  print(VerifieLigne(20))
  
  --Destruction des carrés
  if VerifieLigne(20) then
    local i
    for i = #listeBlocPose,1,-1 do
      print("BUG",listeBlocPose[i].ligne,"i",i)
      local nC = listeBlocPose[i]
      if nC.ligne == 20 then
        table.remove(listeBlocPose,n)
      end
    end
    tableauJeu[20]  = {0,0,0,0,0,0,0,0,0,0}
  end
  
end

function love.draw()
  
  love.graphics.setBackgroundColor(255,255,255)
  love.graphics.draw(quadrillage)

  --love.graphics.draw(cube.sprite, cube.x, cube.y, 0, 1, 1, 14, 14)
 
  local i
  for i = 1, #forme, 1 do
    local nforme = forme[i]
    love.graphics.draw(nforme.sprite, nforme.x, nforme.y, 0, 1, 1, 14, 14)
  end
  -- afficher sprite de la listeBlocPose
  local n
  for n = 1, #listeBlocPose, 1 do
      local ncube = listeBlocPose[n]
     love.graphics.draw(ncube.sprite, ncube.x, ncube.y, 0, 1, 1, 14, 14)
      print(ncube.ligne)
  end

end