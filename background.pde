class Background {
  void draw() {
    stroke(255);
    strokeWeight(5);
    noFill();
    beginShape();
    vertex(0, height, 0);
    vertex(width, height, 0);
    vertex(width, height, -20000);
    vertex(0, height, -20000);
    vertex(0, height, 0);
    endShape();
  }
}