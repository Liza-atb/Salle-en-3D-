// --- Paramètres Généraux ---
final float ROOM_W = 2200, ROOM_H = 400, ROOM_D = 1200;
// Listes d'objets
ArrayList<Table> tables = new ArrayList<Table>();
BureauProf bureau;
Tableau tableau;
DataShow projecteur;
Enveloppe salle;
// Navigation -- On place la caméra à l'intérieur
PVector camPos = new PVector(-300, 80, 200);
float rotX = 0, rotY = 0;
boolean lightsOn = true;
// Ressources
PImage texSol, texMur, texPorte, texEcran, texClavier, texUC, texRad, texPlafond, imgA, imgB, texFenetre, texRideau;
// shader
PShader lambertShader;
//Écran à côté du tableau
EcranMural grandEcran;
// Menu de l'application
boolean auMenu = true;
float boutonPulse = 0;
// Disjoncteur :
Disjoncteur tableauElectrique;
// Var de controle pour l'état de l'animation des rideaux
float animRideau = 0.2; // 1.0=fermé, 0.2=ouvert
float cibleRideau = 0.2;
ArrayList<Bibliotheque> biblios = new ArrayList<Bibliotheque>();
Poubelle poubelle;
ArrayList<PorteManteau> porteManteaux = new ArrayList<PorteManteau>();
Horloge horloge;

void setup() {
  size(1000, 750, P3D);
  lambertShader = loadShader("LambertFragment.glsl", "LambertVertex.glsl");
  noStroke();
  // Chargement des images
  texSol = loadImage("images/sol.jpg");
  texMur = loadImage("images/peinture.jpg");
  texPorte = loadImage("images/porte_inter.jpg");
  texEcran = loadImage("images/cours.png");
  texClavier = loadImage("images/clavier.png");
  texUC = loadImage("images/ucFace.png");
  texRad = loadImage("images/radiateur.png");
  texPlafond = loadImage("images/plafond.jpeg");
  texFenetre = loadImage("images/fenetre.jpg");
  texRideau = loadImage("images/rideau.png");
  imgA = loadImage("images/ecran0.png");
  imgB = loadImage("images/ecran1.png");
  
  // Initialisation
  salle = new Enveloppe(ROOM_W, ROOM_H, ROOM_D);
  tableau = new Tableau(-1095, 0, 0);
  poubelle = new Poubelle(-1075,177 , -150);
  projecteur = new DataShow(-800, -130, 0);
  // --- LE BUREAU DU PROF (Positionné dans la 1ère rangée) ---
  bureau = new BureauProf(-500, 150, 45);
  //Écran mural
  grandEcran = new EcranMural(250, 150, 0, 8, texEcran, texMur, texMur);;
  // disjoncteur : 
  tableauElectrique = new Disjoncteur(-ROOM_W/3 + 120, 40, -ROOM_D/2);
  
  int indexGlobal = 0; 
for (int i = 0; i < 4; i++) {    
  int nbTables = (i == 0) ? 4 : 6; 
  for (int j = 0; j < nbTables; j++) {  
    float tx = -500 + i*320;       
    float tz = -450 + j*110;
    tables.add(new Table(tx, 150, tz, indexGlobal));
    indexGlobal++; 
  }
}
    // Bibliothèque
    float positionContreMur = (ROOM_W / 2) - 25;
    float decalageGauche = -200;
    for (int k = -1; k <= 1; k++) {
      biblios.add(new Bibliotheque(positionContreMur, 75, k * 200 + decalageGauche)); 
    }
    // Porte manteau
    float xMurAvant = -1095; 
    porteManteaux.add(new PorteManteau(xMurAvant, -20, -450));
    
    horloge = new Horloge(-1098, -135, 0);
}

void draw() {
  if(auMenu){
    afficherMenu();
  }
  else {
  background(20);
  //Mise à ajour de la caméra
  updateCamera();
  //Configuration des lumières
  if (lightsOn) {
    ambientLight(130, 130, 150);
    pointLight(255, 255, 240, 0, -180, 0);
    // Effet Specular pour la brillance des écrans
    lightSpecular(255, 255, 255); 
  } else {
    ambientLight(25, 25, 45);
  }
  
  pushMatrix();
    // Matériau légèrement brillant pour toute la salle
    specular(180); 
    shininess(15);
    // Activer le shader
    shader(lambertShader);
    // dessin de la biblio
    for (Bibliotheque b : biblios) {
      b.display();
    }
    // Animation fluide du rideau
    animRideau = lerp(animRideau, cibleRideau, 0.05);
    // Dessiner les éléments
    salle.display(animRideau);
    bureau.display();
    tableau.display();
    poubelle.display();
    tableauElectrique.display();
    // --- POSITIONNEMENT ÉCRAN COIN GAUCHE ---
    pushMatrix();
      translate(-999, 50, 480); 
      rotateY(QUARTER_PI); 
      grandEcran.display(150);
    popMatrix();
    
    for (PorteManteau pm : porteManteaux) {
      pm.display();
    }
    
    projecteur.display();
    horloge.display();
    resetShader();
    
    for (Table t : tables) {
      t.display();
    }
    
   
  popMatrix();
  }
}

void updateCamera() {
  float speed = 10;
  // 1. DÉPLACEMENTS HORIZONTAUX (Flèches)
  if (keyPressed && key == CODED) {
    if (keyCode == UP) {
      camPos.x += cos(rotY) * speed;
      camPos.z += sin(rotY) * speed;
    }
    if (keyCode == DOWN) {
      camPos.x -= cos(rotY) * speed;
      camPos.z -= sin(rotY) * speed;
    }
    if (keyCode == LEFT) {
      camPos.x += sin(rotY) * speed;
      camPos.z -= cos(rotY) * speed;
    }
    if (keyCode == RIGHT) {
      camPos.x -= sin(rotY) * speed;
      camPos.z += cos(rotY) * speed;
    }
  }

  // 2. DÉPLACEMENTS VERTICAUX
  if (keyPressed) {
    if (key == 'a' || key == 'A') {
      camPos.y -= speed;
    }
    if (key == 'e' || key == 'E') {
      camPos.y += speed; // Descendre
    }
  }
  // 3. ROTATION (Souris)
  if (mousePressed) {
    rotY += (mouseX - pmouseX) * 0.01;
    rotX -= (mouseY - pmouseY) * 0.01;
    rotX = constrain(rotX, -1.5, 1.5); 
  }
  // 4. RENDU
  float lookX = camPos.x + cos(rotY);
  float lookY = camPos.y + tan(rotX);
  float lookZ = camPos.z + sin(rotY);
  camera(camPos.x, camPos.y, camPos.z, lookX, lookY, lookZ, 0, 1, 0);
}
// Fonction qui permet d'afficher le menu 
void afficherMenu() {
  background(30, 40, 50); 
  textAlign(CENTER, CENTER);
  // Titre
  fill(255, 204, 0); 
  textSize(40);
  text("BIENVENUE DANS LA SALLE A106", width/2, height/5);
  // PANNEAU CENTRAL
  rectMode(CENTER);
  fill(40, 50, 70, 220);
  noStroke();
  rect(width/2, height/2 + 10, 550, 380, 20);
  // Instructions
  fill(255);
  textSize(22);
  float startY = height/2 - 130;
  // Catégorie : Navigation
  fill(0, 200, 255);
  text("--- NAVIGATION ---", width/2, startY);
  fill(255);
  text("↑ ↓ ← → : Déplacer la caméra", width/2, startY + 30);
  text("[A] : Monter | [E] : Descendre", width/2, startY + 60);
  text("Souris (Clic gauche maintenu) : Tourner la caméra", width/2, startY + 90);
  // Catégorie : Équipements
  fill(0, 200, 255);
  text("--- ÉQUIPEMENTS ---", width/2, startY + 140);
  fill(255);
  text("[L] : Allumer / Éteindre Lumières", width/2, startY + 170);
  text("[O] : Ouvrir tous les PC", width/2, startY + 200);
  text("[F] : Fermer tous les PC", width/2, startY + 230);
  text("[R] : Ouvrir / Fermer les Rideaux", width/2, startY + 260);
  // Bouton pour commencer
  // Calcul de la taille avec un sinus pour l'effet de pulsation
  boutonPulse = sin(frameCount * 0.1) * 10;
  float btnW = 320 + boutonPulse;
  float btnH = 65 + boutonPulse/2;
  // Changement de couleur dynamique (vert qui brille légèrement)
  fill(0, 255 + boutonPulse * 5, 120 + boutonPulse * 3);
  rect(width/2, height - 90, btnW, btnH, 30);

  fill(0);
  textSize(22);
  text("APPUYEZ SUR 'ENTRÉE'", width/2, height - 95);
}
void keyPressed() {
  // Si on est au menu et qu'on appuie sur Entrée, on lance la salle
  if (auMenu && keyCode == ENTER) {
    auMenu = false;
  }
  if (key == 'l' || key == 'L') lightsOn = !lightsOn;
  
  // Ouvrir tout
  if (key == 'o' || key == 'O') {
    for (Table t : tables) t.cibleH = 35;
  }
  // Fermer tout
  if (key == 'f' || key == 'F') {
    for (Table t : tables) t.cibleH = 0;
  }
  
  if (key == 'r' || key == 'R') {
    if (cibleRideau == 0.2) cibleRideau = 1.0; // Si ouvret on ferme
    else cibleRideau = 0.2; // si fermé on ouvre
  }
}
