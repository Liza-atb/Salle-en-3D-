class Enveloppe {
  float w, h, d;

  Enveloppe(float _w, float _h, float _d) {
    w = _w; h = _h; d = _d;
  }
  void display(float anim) {
    textureMode(NORMAL);
    noStroke();
    fill(255);

    // --- 1. SOL ---
    pushMatrix();

    translate(0, h/2 + 5, 0); 
    fill(200);
    box(w, 10, d); 
    translate(0, -5.1, 0); 
    beginShape(QUADS);
    if(texSol != null) texture(texSol);
    vertex(-w/2, 0, -d/2, 0, 0);
    vertex( w/2, 0, -d/2, 1, 0);
    vertex( w/2, 0,  d/2, 1, 1);
    vertex(-w/2, 0,  d/2, 0, 1);
    endShape();
    popMatrix();
    fill(255);
    // --- 2. PLAFOND ---
    beginShape(QUADS);
    if(texPlafond != null) texture(texPlafond);
    vertex(-w/2, -h/2,  d/2, 0, 1); 
    vertex( w/2, -h/2,  d/2, 1, 1);
    vertex( w/2, -h/2, -d/2, 1, 0);
    vertex(-w/2, -h/2, -d/2, 0, 0);
    endShape();
    // --- 3. MUR FOND (Côté Tableau) ---
    beginShape(QUADS);
    if(texMur != null) texture(texMur);
    vertex(-w/2, -h/2, -d/2, 0, 0);
    vertex(-w/2, -h/2,  d/2, 1, 0);
    vertex(-w/2,  h/2,  d/2, 1, 1);
    vertex(-w/2,  h/2, -d/2, 0, 1);
    endShape();
    // PORTE 1 : SUR MUR FOND (Derrière l'écran mural)
    pushMatrix(); 
    translate(-w/2 + 1, h/2 - 120, d/3); 
    rotateY(HALF_PI);
    dessinerTexturePorte();
    popMatrix();
    // --- 4. MUR GAUCHE (Côté Fenêtre & Porte 2) ---
    beginShape(QUADS);
    if(texMur != null) texture(texMur);
    vertex(-w/2, -h/2, -d/2, 0, 0);
    vertex( w/2, -h/2, -d/2, 1, 0);
    vertex( w/2,  h/2, -d/2, 1, 1);
    vertex(-w/2,  h/2, -d/2, 0, 1);
    endShape();
    // PORTE 2 : entrée principale
    pushMatrix();
    translate(-w/3 , h/2 - 120, -d/2 + 1); 
    dessinerTexturePorte();
    popMatrix();
    // --- 5. MUR DROIT (Côté Radiateurs & Fenêtres) ---
    beginShape(QUADS);
    if(texMur != null) texture(texMur);
    vertex( w/2, -h/2, d/2, 0, 0); 
    vertex(-w/2, -h/2, d/2, 1, 0);
    vertex(-w/2,  h/2, d/2, 1, 1);
    vertex( w/2,  h/2, d/2, 0, 1);
    endShape();
    // --- 6. MUR ARRIÈRE (Opposé au tableau) ---
    beginShape(QUADS);
    if(texMur != null) texture(texMur);
    vertex(w/2, -h/2, -d/2, 0, 0);
    vertex(w/2, -h/2,  d/2, 1, 0);
    vertex(w/2,  h/2,  d/2, 1, 1);
    vertex(w/2,  h/2, -d/2, 0, 1);
    endShape();
    // PORTE 3 : SUR MUR ARRIÈRE
    pushMatrix();
    translate(w/2 - 1, h/2 - 120, d/4); 
    rotateY(-HALF_PI);
    dessinerTexturePorte();
    popMatrix();
    // --- RADIATEURS ET FENÊTRES (3 ensembles : Gauche, Milieu, Droite) ---
    for(int i = 0; i < 3; i++) {
      // Calcul pour répartir les 3 objets (i=0: gauche, i=1: milieu, i=2: droite)
      // On utilise w/3 pour l'espacement sur un mur de largeur w
      float posX = -w/3 + i * (w/3); 
      // 1. Le Radiateur
      pushMatrix();
      translate(posX, h/2 - 60, d/2 - 5); 
      rotateY(PI); 
      dessinerRadiateur();
      popMatrix();
      // 2. La Fenêtre (Placée au-dessus du radiateur)
      pushMatrix();
      translate(posX, -50, d/2 - 2); 
      rotateY(PI); 
      dessinerFenetre(450, 200); 
      popMatrix();
      // 3. AJOUT DU RIDEAU
      pushMatrix();
      translate(posX, -50, d/2 - 10); 
      rotateY(PI);
      dessinerRideau(450, 200,anim); // Même taille que la fenêtre
      popMatrix();
    }
  }

  void dessinerTexturePorte() {
    if(texPorte != null) {
      textureMode(NORMAL);
      // --- FACE A (Visible de l'intérieur) ---
      beginShape(QUADS);
      texture(texPorte);
      vertex(-60, -120, 0, 0, 0);
      vertex( 60, -120, 0, 1, 0);
      vertex( 60,  120, 0, 1, 1);
      vertex(-60,  120, 0, 0, 1);
      endShape();
      
      // --- FACE B (Visible de l'extérieur) ---
      beginShape(QUADS);
      texture(texPorte);
      vertex(-60, -120, -2, 1, 0); 
      vertex( 60, -120, -2, 0, 0);
      vertex( 60,  120, -2, 0, 1);
      vertex(-60,  120, -2, 1, 1);
      endShape();
    }
  }

  void dessinerRadiateur() {
    fill(240);
    box(150, 80, 10);
    if (texRad != null) {
      pushMatrix();
      translate(0, 0, 6);
      beginShape(QUADS);
      texture(texRad);
      vertex(-75, -40, 0, 0, 0); vertex(75, -40, 0, 1, 0);
      vertex(75, 40, 0, 1, 1);   vertex(-75, 40, 0, 0, 1);
      endShape();
      popMatrix();
    }
  }
  
  void dessinerFenetre(float large, float haut) {
  if (texFenetre != null) {
    // 1. Le cadre reste mat
    fill(255);
    box(large + 10, haut + 10, 2); 
    
    // 2. La vitre devient brillante
    pushMatrix();
    translate(0, 0, 1.5); 
    
    // ACTIVATION DES REFLETS
    specular(255);   
    shininess(20.0); 
    beginShape(QUADS);
    texture(texFenetre);
    vertex(-large/2, -haut/2, 0, 0, 0);
    vertex( large/2, -haut/2, 0, 1, 0);
    vertex( large/2,  haut/2, 0, 1, 1);
    vertex(-large/2,  haut/2, 0, 0, 1);
    endShape();
    // Désactivation pour ne pas affecter le reste de la salle
    specular(0); 
    popMatrix();
  }
}

void dessinerRideau(float large, float haut, float anim) {
  if (texRideau != null) {
    pushMatrix();
    translate(0, 0, -5); 
    tint(255, 250); 
    textureMode(NORMAL);
    
    float largeurPanAnime = (large / 2) * anim;
    
    // Boucle pour les deux pans
    for (int side = -1; side <= 1; side += 2) {
      if (side == 0) continue;
      pushMatrix();
      translate(side * (large / 2 - largeurPanAnime / 2), 0, 0);
      beginShape(QUADS);
      texture(texRideau);
      if (side == -1) {
 
        vertex(-largeurPanAnime/2, -haut/2, 0, 0, 0);
        vertex( largeurPanAnime/2, -haut/2, 0, 0.5 * anim, 0);
        vertex( largeurPanAnime/2,  haut/2, 0, 0.5 * anim, 1);
        vertex(-largeurPanAnime/2,  haut/2, 0, 0, 1);
      } else {

        vertex(-largeurPanAnime/2, -haut/2, 0, 1 - (0.5 * anim), 0);
        vertex( largeurPanAnime/2, -haut/2, 0, 1, 0);
        vertex( largeurPanAnime/2,  haut/2, 0, 1, 1);
        vertex(-largeurPanAnime/2,  haut/2, 0, 1 - (0.5 * anim), 1);
      }
      
      endShape();
      popMatrix();
    }
    
    noTint(); 
    
    // Tringle
    fill(80);
    pushMatrix();
    translate(0, -haut/2 - 5, 2); 
    box(large + 20, 4, 4);
    popMatrix();
    
    popMatrix();
  }
}
}
