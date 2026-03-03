class Horloge {
  PVector p;
  float diametre = 80;
  float epaisseurCadre = 10;
  color couleurFond = color(40, 44, 52); 

  Horloge(float x, float y, float z) {
    p = new PVector(x, y, z);
  }

  void display() {
    pushMatrix();
    translate(p.x, p.y, p.z);
    rotateY(HALF_PI); 
    fill(40);
    noStroke();
    float res = 60; 
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i <= res; i++) {
      float a = TWO_PI / res * i;
      vertex(cos(a) * (diametre/2 + 2), sin(a) * (diametre/2 + 2), 0);
      vertex(cos(a) * (diametre/2 + 2), sin(a) * (diametre/2 + 2), epaisseurCadre);
    }
    endShape();

    // 2. LE FOND EN COULEUR
    fill(couleurFond); 
    beginShape(POLYGON);
    for (int i = 0; i < res; i++) {
      float a = TWO_PI / res * i;
      vertex(cos(a) * (diametre/2), sin(a) * (diametre/2), epaisseurCadre - 2);
    }
    endShape(CLOSE);

    // 3. LES TIRETS DES HEURES (Les marquages noirs)
    fill(0); 
    for (int i = 0; i < 12; i++) {
      pushMatrix();
      float angle = i * (TWO_PI / 12);
      rotateZ(angle);
      translate(0, -diametre/2 + 8, epaisseurCadre - 1.9); 

      if (i % 3 == 0) {
        box(4, 12, 1); 
      } else {
        box(2, 6, 1);
      }
      popMatrix();
    }
    // 4. LES AIGUILLES
    fill(20);
    // Heures
    pushMatrix();
    translate(0, 0, epaisseurCadre - 1.5); 
    rotateZ(radians(150)); 
    rectMode(CENTER);
    rect(0, -12, 4, 25);
    popMatrix();
    // Minutes
    pushMatrix();
    translate(0, 0, epaisseurCadre - 1); 
    rotateZ(radians(10)); 
    rect(0, -18, 2, 40);
    popMatrix();
    // 5. LA VITRE (Optionnelle, bien collée)
    fill(255, 255, 255, 30); 
    beginShape(POLYGON);
    for (int i = 0; i < res; i++) {
      float a = TWO_PI / res * i;
      vertex(cos(a) * (diametre/2), sin(a) * (diametre/2), epaisseurCadre + 0.1);
    }
    endShape(CLOSE);
    
    popMatrix();
  }
}
