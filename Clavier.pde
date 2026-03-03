class Clavier {
  float w, h, d;
  PImage img;

  Clavier(float w, float h, float d, PImage img) {
    this.w = w;
    this.h = h;
    this.d = d;
    this.img = img;
  }

  void display() {
    // corps
    fill(30);
    box(w, h, d);

    // image du clavier
    pushMatrix();
    translate(0, -h/2 - 0.1, 0);
    rotateX(HALF_PI);

    pushStyle();
    noLights();
    beginShape(QUADS);
    texture(img);
    vertex(-w/2, -d/2, 0, 0, 0);
    vertex( w/2, -d/2, 0, 1, 0);
    vertex( w/2,  d/2, 0, 1, 1);
    vertex(-w/2,  d/2, 0, 0, 1);
    endShape();
    popStyle();

    popMatrix();
  }
}
