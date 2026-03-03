class Tableau {
  PVector p;
  Tableau(float x, float y, float z) {
    p = new PVector(x, y, z);
  }
  void display() {
    pushMatrix();
    translate(p.x, p.y, p.z);
    // --- 1. LE PANNEAU DU TABLEAU ---
    fill(30, 60, 30); 
    stroke(100);      
    box(10, 180, 450); 
    
    // --- 2. LE SUPPORT À CRAIES ---
    fill(200); 
    noStroke();
    pushMatrix();
    translate(5, 90, 0); 
    // Le support 
    box(15, 4, 450); 
    popMatrix();
    // --- 3. UNE CRAIE  ---
    fill(255); 
    pushMatrix();
    translate(8, 86, 20); 
    box(4, 2, 15); 
    popMatrix();

    popMatrix();
    noStroke();
  }
}
