class Poubelle {
  PVector p;
  float r = 18; 
  float h = 45; 
  
  // Stockage des papiers pour qu'ils soient fixes
  ArrayList<PVector> positionsPapier = new ArrayList<PVector>();
  ArrayList<PVector> rotationsPapier = new ArrayList<PVector>();

  Poubelle(float x, float y, float z) {
    p = new PVector(x, y, z);
    // On génère 5 à 8 petits papiers au fond
    int nbPapiers = (int)random(5, 8);
    for (int i = 0; i < nbPapiers; i++) {
      // Position aléatoire à l'intérieur du rayon
      float angle = random(TWO_PI);
      float dist = random(0, r - 5);
      positionsPapier.add(new PVector(cos(angle) * dist, h/2 - 5, sin(angle) * dist));
      // Rotation aléatoire pour l'effet "froissé"
      rotationsPapier.add(new PVector(random(PI), random(PI), random(PI)));
    }
  }

  void display() {
    pushMatrix();
    translate(p.x, p.y, p.z);
    // --- Corps de la poubelle ---
    fill(60); 
    stroke(40);
    int res = 16;
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i <= res; i++) {
      float a = TWO_PI / res * i;
      vertex(cos(a) * r, -h/2, sin(a) * r);
      vertex(cos(a) * r, h/2, sin(a) * r);
    }
    endShape();
    // --- Fond ---
    fill(40);
    beginShape(POLYGON);
    for (int i = 0; i < res; i++) {
      float a = TWO_PI / res * i;
      vertex(cos(a) * r, h/2, sin(a) * r);
    }
    endShape(CLOSE);
    // --- LES PAPIERS ---
    noStroke();
    fill(240); // Blanc papier
    for (int i = 0; i < positionsPapier.size(); i++) {
      pushMatrix();
      PVector pos = positionsPapier.get(i);
      PVector rot = rotationsPapier.get(i);
      translate(pos.x, pos.y, pos.z);
      rotateX(rot.x);
      rotateY(rot.y);
      rotateZ(rot.z);
      box(8, 8, 8); // Petit cube pour simuler le papier froissé
      popMatrix();
    }
    
    popMatrix();
  }
}
