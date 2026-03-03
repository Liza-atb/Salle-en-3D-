class BureauProf {
  PVector p;
  PImage imgLogo; // stocke l'image du mac
  BureauProf(float x, float y, float z) {
    p = new PVector(x, y, z);
    //charger l'image 
    imgLogo = loadImage("images/macProf.png");
  }

  void display() {
    pushMatrix();
    translate(p.x, p.y, p.z);
    rotateY(HALF_PI); 
    // --- DESSIN DU BUREAU ---
    fill(100, 50, 20);
    box(220, 5, 70);  
    // Pieds du bureau (pour qu'il ne flotte pas)
    fill(30);
    for(float i=-1; i<=1; i+=2) {
      pushMatrix();
      translate(i*100, 40, 0); 
      box(5, 80, 70); 
      popMatrix();
    }
    // Le Macbook (placé devant la chaise du prof)
    pushMatrix();
    translate(-30, -5, -10);
    // ROTATION : PI (180°) pour que l'écran soit face au prof
    rotateY(PI);
    dessinerMacbook();
    popMatrix();
    // Le Carnet Notebook
    pushMatrix();
    translate(40, -4, 10);
    rotateY(0.3); 
    dessinerNotebook();
    popMatrix();
    // AJOUT DE LA CHAISE DU PROFESSEUR
    pushMatrix();
    translate(0, 20, -60); 
    // ROTATION de 180° pour faire face aux étudiants
    rotateY(PI); 
    dessinerChaiseProf();
    popMatrix();
    
    popMatrix();
  }
  
  void dessinerChaiseProf() {
    fill(50, 50, 80); 
    box(45, 5, 45);  
  
    pushMatrix();
    translate(0, -25, 20);
    box(45, 50, 5); 
    popMatrix();
    // Pieds
    fill(20);
    for(float i=-1; i<=1; i+=2) {
      for(float j=-1; j<=1; j+=2) {
        pushMatrix();
        translate(i*20, 30, j*20);
        box(3, 60, 3);
        popMatrix();
      }
    }
  }
  void dessinerMacbook() {
    // --- PARTIE 1 : LA BASE ---
    fill(200);
    box(40, 2, 30); 
    // --- PARTIE 2 : L'ÉCRAN ---
    pushMatrix();
    translate(0, -1, -15); 
    rotateX(-1.2); 
    translate(0, 0, -15);
    // Le dos de l'écran (Aluminium)
    fill(180);
    box(40, 2, 30);
    // LA DALLE (Face au prof)
    pushMatrix();
    translate(0, -1.1, 0);
    fill(10);
    box(38, 0.1, 28);
    popMatrix();
    // --- L'IMAGE QUI COUVRE TOUT LE DOS (Face aux étudiants) ---
    if (imgLogo != null) {
      pushMatrix();
      // On se décale de 1.1 pour être juste au-dessus de la surface
      translate(0, 1.1, 0); 
      rotateX(HALF_PI); // On met l'image à plat sur le dos
      textureMode(NORMAL);
      beginShape(QUADS);
      texture(imgLogo);
      vertex(-20, -15, 0, 0, 0); // Coin haut-gauche
      vertex( 20, -15, 0, 1, 0); // Coin haut-droit
      vertex( 20,  15, 0, 1, 1); // Coin bas-droit
      vertex(-20,  15, 0, 0, 1); // Coin bas-gauche
      
      endShape();
      popMatrix();
    }
    
    popMatrix();
  }

  void dessinerNotebook() {
    // Couverture du carnet
    fill(200, 50, 50); 
    box(20, 2, 25);
    // Pages blanches (un peu plus petites)
    translate(0, -1.1, 0);
    fill(255);
    box(18, 0.5, 23);
  }
}
