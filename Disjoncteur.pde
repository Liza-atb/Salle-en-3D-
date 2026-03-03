class Disjoncteur {
  PVector p;
  Disjoncteur(float x, float y, float z) {
    p = new PVector(x, y, z);
  }
  void display() {
    pushMatrix();
    translate(p.x, p.y, p.z);
    // --- 1. BOITIER PRINCIPAL ---
    fill(210);
    stroke(150);
    translate(0, 0, 4); 
    box(45, 70, 8); 
    // --- 2. CAPOT TRANSLUCIDE ---
    pushMatrix();
    translate(0, 0, 4.2); 
    fill(100, 150, 200, 100);
    box(38, 62, 1);
    popMatrix();
    // --- 3. LES VOYANTS (LEDs en haut) ---
    noStroke();
    for (int i = 0; i < 3; i++) {
      pushMatrix();
      translate(-12 + i*12, -25, 4.1);
      if (i == 0) fill(255, 0, 0);      
      else if (i == 1) fill(0, 255, 0); 
      else fill(255, 200, 0);           

      box(4, 4, 1); 
      popMatrix();
    }

    // --- 4. LES INTERRUPTEURS (Disjoncteurs) ---
    for (int i = 0; i < 5; i++) {
      float posX = -16 + i*8;
      // L'interrupteur lui-même
      pushMatrix();
      translate(posX, -5, 4.1);
      if(i == 2) fill(50); 
      else fill(240);    
      box(5, 12, 3);
      popMatrix();
      // La petite manette (le levier)
      pushMatrix();
      float offsetVal = (i == 2) ? 3 : -3;
      translate(posX, -5 + offsetVal, 5.5);
      fill(80);
      box(3, 4, 4);
      popMatrix();
      // L'étiquette sous le disjoncteur
      pushMatrix();
      translate(posX, 5, 4.1);
      fill(255);
      box(6, 4, 0.5);
      popMatrix();
    }
    // --- 5. BOUTON DE TEST (Gros bouton rond en bas) ---
    pushMatrix();
    translate(12, 22, 4.1);
    fill(0, 100, 255); 
    box(8, 8, 2); 
    popMatrix();
    // Étiquette "TEST" à côté
    pushMatrix();
    translate(0, 22, 4.1);
    fill(255);
    box(10, 4, 0.5);
    popMatrix();

    popMatrix();
    noStroke();
  }
}
