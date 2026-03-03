class PorteManteau {
  PVector p;
  float w = 200; // Largeur de la planche
  float h = 50;  // Hauteur de la planche
  float d = 8;   // Épaisseur

  PorteManteau(float x, float y, float z) {
    p = new PVector(x, y, z);
  }

  void display() {
    pushMatrix();
    translate(p.x, p.y, p.z);
    // --- La planche de support ---
    fill(130, 100, 70); 
    stroke(0, 50);
    box(d, h, w); 
    // --- Les Crochets ---
    fill(180); 
    noStroke();
    int nbCrochets = 6;
    for (int i = 0; i < nbCrochets; i++) {
      pushMatrix();
      float offsetZ = -w/2 + (i + 0.5) * (w/nbCrochets);
      translate(d/2 + 5, 0, offsetZ); 
      // Base du crochet
      box(10, 10, 5);
      // Tige montante
      translate(2, -12, 0);
      box(4, 25, 4);
      popMatrix();
    }
    popMatrix();
  }
}
