class Table {
  PVector p;
  float w = 110, h = 80, d = 70, tableEpaisseur=5;
  PImage texPerso; 
  Clavier clavier;
  // variables pour l'animation
  float hEcran = 0;
  float cibleH = 0; // 0 = fermé, 35 = ouvert 
  
  Table(float x, float y, float z, int id) {
    p = new PVector(x, y, z);
    texPerso = (id % 2 == 0) ? imgA : imgB;
    clavier = new Clavier(45, 3, 15, texClavier);
  }
  
  void update() {
    hEcran = lerp(hEcran, cibleH, 0.1);
  }

  void display() {
    update();
    textureMode(NORMAL);
    
    pushMatrix();
    translate(p.x, p.y, p.z);
    rotateY(HALF_PI);
    
    // --- 1. LE CAISSON DE LA TABLE (L'enveloppe creuse) ---
    fill(140, 90, 50);
    // On dessine le plateau avec un trou au milieu (en deux parties)
    pushMatrix();
      translate(0, 0, d/4); 
      box(w, 5, d/2); // Partie avant du plateau
      translate(0, 0, -d/2);
      box(w, 5, d/2); // Partie arrière du plateau
    popMatrix();

    // Pieds de table
    fill(40); 
    for(float i=-1; i<=1; i+=2) {
      for (float j=-1; j<=1; j+=2) {
        pushMatrix();
        translate(i*(w/2-5), h/2, j*(d/2-5));
        box(4, h, 4);
        popMatrix();
      }
    }
    // --- 2. SUPPORT FIXE---
    pushMatrix();
    translate(0, -2.5, -d/4); 
    dessinerEmbaseFixe();
    popMatrix();
    // --- 2. UNITÉ CENTRALE (Fixe) ---
    pushMatrix();
    translate(w/3, h/2 - 10, 0);
    dessinerUC();
    popMatrix();
    // --- 3. CHAISE (Fixe) ---
    pushMatrix();
    translate(0, 20, d/2 + 25); 
    dessinerChaise();
    popMatrix();
    // --- 4. LES ACCESSOIRES ESCAMOTABLES ---
    float offsetCache = map(hEcran, 0, 35, 20, 0);
    if (hEcran > 15) { 
        // ÉCRAN
        pushMatrix();
        translate(0, -32 + offsetCache, -d/4);
        dessinerEcran(); 
        dessinerSupport();
        popMatrix();
        // CLAVIER
        pushMatrix();
        translate(0, (-tableEpaisseur/2 - clavier.h/2) + offsetCache, d/6);
        rotateX(-PI/18);
        clavier.display();
        popMatrix();
        // SOURIS
        pushMatrix();
        translate(w/3, -4 + offsetCache, d/6);
        dessinerSouris();
        popMatrix();
    }
    
    popMatrix(); // Fin de la table
  }
  // --- MÉTHODES DE DESSIN ---
  void dessinerUC() {
    fill(30);
    box(20, 50, 45);
    if(texUC != null) {
      beginShape(QUADS);
      texture(texUC);
      vertex(-10, -25, 23.5, 0, 0); vertex(10, -25, 23.5, 1, 0);
      vertex(10, 25, 23.5, 1, 1);  vertex(-10, 25, 23.5, 0, 1);
      endShape();
    }
  }
    
  void dessinerSouris() {
    fill(40);
    box(8, 3, 12);
    pushMatrix();
    translate(0,-1.6,-3);
    fill(60);
    pushMatrix(); translate(-2,0,0); box(3.5,0.5,5); popMatrix();
    pushMatrix(); translate(2,0,0); box(3.5,0.5,5); popMatrix();
    fill(10); translate(0,-0.2,0); box(1,1,2);
    popMatrix();
  }
  
  void dessinerEcran() {
    fill(20);
    box(w*0.6, 35, 5); 
    if(texPerso != null){
      pushStyle();
      noLights();
      emissive(200, 220, 255);
      beginShape(QUADS);
      texture(texPerso);
      vertex(-w*0.3, -17, 3.6, 0, 0); 
      vertex( w*0.3, -17, 3.6, 1, 0);
      vertex( w*0.3,  17, 3.6, 1, 1);
      vertex(-w*0.3,  17, 3.6, 0, 1);
      endShape();
      popStyle();
    }
  }

  void dessinerChaise() {
    fill(100, 70, 40);
    box(40, 5, 40); 
    pushMatrix();
    translate(0, -20, 18);
    box(40, 40, 4); 
    popMatrix();
    fill(20);
    for(float i=-1; i<=1; i+=2) {
      for(float j=-1; j<=1; j+=2) {
        pushMatrix();
        translate(i*18, 30, j*18); 
        box(3, 60, 3); 
        popMatrix();
      }
    }
  }
  
  void dessinerSupport() {
    fill(35);
    // La tige qui coulisse
    pushMatrix();
    translate(0, 15, -1); 
    box(4, 45, 2.5); 
    popMatrix();
    // Fixation derrière l'écran
    fill(45);
    pushMatrix();
    translate(0, 0, -2.5);
    box(8, 8, 1.5); 
    popMatrix();
}

void dessinerEmbaseFixe() {
    fill(25); 
    box(w * 0.4, 1.5, 6); 
    translate(0, -1, 0);
    box(10, 3, 5);
  }
}
