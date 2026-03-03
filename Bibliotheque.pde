class Bibliotheque {
  PVector p;
  float w = 180, h = 250, d = 40;
  
  // Structure pour stocker les données des livres une seule fois
  ArrayList<LivreData> stockLivres = new ArrayList<LivreData>();

  Bibliotheque(float x, float y, float z) {
    p = new PVector(x, y, z);
    genererLivresFixes();
  }

  void genererLivresFixes() {
    int nbLivresParEtage = 15;
    float largeLivre = (w-10) / nbLivresParEtage;
    
    for (int i = 1; i < 5; i++) {
      float yEtage = -h/2 + i * (h/5);
      for (int j = 0; j < nbLivresParEtage; j++) {
        if (random(1) > 0.2) {
          float posX = -w/2 + 10 + j*largeLivre;
          float hLivre = random(30, 45);
          color cLivre = color(random(50, 200), random(50, 100), random(50, 100));
          stockLivres.add(new LivreData(posX, yEtage, hLivre, cLivre, largeLivre));
        }
      }
    }
  }

  void display() {
    pushMatrix();
    translate(p.x, p.y, p.z);
    rotateY(-HALF_PI);
    // --- STRUCTURE ---
    fill(100, 70, 45); 
    pushMatrix(); translate(0, 0, -d/2); box(w, h, 5); popMatrix();
    pushMatrix(); translate(-w/2, 0, 0); box(5, h, d); popMatrix();
    pushMatrix(); translate( w/2, 0, 0); box(5, h, d); popMatrix();
    pushMatrix(); translate(0, -h/2, 0); box(w, 5, d); popMatrix();
    pushMatrix(); translate(0,  h/2, 0); box(w, 5, d); popMatrix();
    
    // --- ÉTAGÈRES ---
    for (int i = 1; i < 5; i++) {
      pushMatrix();
      translate(0, -h/2 + i * (h/5), 0);
      box(w, 4, d);
      popMatrix();
    }
    
    // --- DESSIN DES LIVRES FIXES ---
    for (LivreData l : stockLivres) {
      pushMatrix();
      translate(l.x, l.y - l.h/2 - 2, 0);
      fill(l.c);
      box(l.largeur * 0.8, l.h, d * 0.8);
      popMatrix();
    }
    popMatrix();
  }
}

// classe utilitaire pour mémoriser les livres
class LivreData {
  float x, y, h, largeur;
  color c;
  LivreData(float _x, float _y, float _h, color _c, float _l) {
    x = _x; y = _y; h = _h; c = _c; largeur = _l;
  }
}
