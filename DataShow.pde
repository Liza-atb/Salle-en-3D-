class DataShow {
  PVector p;

  DataShow(float x, float y, float z) {
    p = new PVector(x, y, z);
  }

  void display() {
    pushMatrix();
    translate(p.x, p.y, p.z);
    // --- 1. LE CORPS PRINCIPAL ---
    fill(240); 
    stroke(180); 
    box(50, 20, 40); 
    // --- 2. L'OBJECTIF (La lentille) ---
    pushMatrix();
    translate(-20, 2, 10); // Placé sur le devant, à gauche
    rotateY(HALF_PI);
    fill(40);
    box(12, 12, 15); 
    // La petite lentille en verre (bleutée)
    translate(0, 0, 8);
    fill(100, 150, 255, 200);
    box(8, 8, 2);
    popMatrix();
    // --- 3. DÉTAILS (Grilles d'aération sur le côté) ---
    fill(150);
    for(int i = -1; i <= 1; i++) {
      pushMatrix();
      translate(10, i*4, 20.5);
      box(20, 2, 1);
      popMatrix();
    }
    // --- 4. LE SUPPORT PLAFOND ---
    fill(80);
    pushMatrix();
    translate(0, -25, 0); // Tige qui remonte
    box(4, 30, 4);
    // Socle au plafond
    translate(0, -15, 0);
    box(20, 4, 20);
    popMatrix();
    
    // --- 5. LE FAISCEAU LUMINEUX ---
    if (lightsOn) {
      noStroke();
      fill(255, 255, 200, 30); 
      pushMatrix();
      translate(-100, 5, 10);
      rotateZ(HALF_PI);
      popMatrix();
      // La vraie lumière du projecteur
      spotLight(255, 255, 220, -25, 2, 10, -1, 0.2, 0, PI/6, 2);
    }
    
    popMatrix();
    noStroke();
  }
}
