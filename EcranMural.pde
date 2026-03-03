class EcranMural {
  float L, l, h, e; 
  PImage texFace, texDos, texCote;

  EcranMural(float L, float l, float h, float e, PImage texFace, PImage texDos, PImage texCote) {
    this.L = L; 
    this.l = l; 
    this.h = h; 
    this.e = e; 
    this.texFace = texFace;
    this.texDos = texDos;
    this.texCote = texCote;
  }

  void display(float distanceSol) {
    pushMatrix();
    // 1. LE CADRE ET LA DALLE
    dessinerCadreComplet();
    // 2. Support
    dessinerSupport(distanceSol);
    
    popMatrix();
  }

  void dessinerCadreComplet() {
    fill(40);
    box(e, l + e, L + e);

    if (texFace != null) {
      pushMatrix();
      translate(e/2 + 0.5, 0, 0); 
      rotateY(HALF_PI);
      textureMode(NORMAL);
      beginShape(QUADS);
      texture(texFace);
      vertex(-L/2, -l/2, 0, 0, 0);
      vertex( L/2, -l/2, 0, 1, 0);
      vertex( L/2,  l/2, 0, 1, 1);
      vertex(-L/2,  l/2, 0, 0, 1);
      endShape();
      popMatrix();
    }

    fill(10);
    pushMatrix(); translate(0, 0, L/2 + e/4); box(e+1, l+e, e/2); popMatrix();
    pushMatrix(); translate(0, 0, -L/2 - e/4); box(e+1, l+e, e/2); popMatrix();
    pushMatrix(); translate(0, l/2 + e/4, 0); box(e+1, e/2, L+e); popMatrix();
    pushMatrix(); translate(0, -l/2 - e/4, 0); box(e+1, e/2, L+e); popMatrix();
  }

  void dessinerSupport(float hauteur) {
    fill(20); 
    pushMatrix();
    translate(0, hauteur/2, 0); 
    box(5, hauteur - 2, 5); 
    // Socle au sol 
    pushMatrix();
    translate(0, hauteur/2, 0);
    box(40, 4, 40);
    popMatrix();
    
    popMatrix();
  }
}
