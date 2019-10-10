float fov = radians(40);
int z = 1001;

GameManager gm;

Background bkgd;
ArrayList<Cube> cubes;


int lastTime;

void setup() {
  size(1600, 900, P3D);
  //noCursor();
  smooth();

  gm = new GameManager();

  perspective(fov, float(width)/float(height), z - 1000, z + 20000); 

  lastTime = millis();

  bkgd = new Background();

  cubes = new ArrayList<Cube>();
}

PVector view = new PVector(0, 0, 0);

void draw() {
  if (!gm.gameOver) {
    background(0);

    if (millis() - lastTime > 400) {
      lastTime = millis();
      createBlock();
    }

    view.x = -(mouseX - width *0.5);
    view.y = -(mouseY - height*0.5);

    pushMatrix();
    translate(width/2, height/2, -100);
    stroke(100, 255, 125);
    box(8);
    popMatrix();

    pushMatrix();
    translate(view.x, view.y, view.z);

    bkgd.draw();

    for (Cube c : cubes) {
      boolean hit = c.hitTest();
      c.draw();
      if (hit) {
        gm.gameOver = true;
      }
    }
    popMatrix();
    
    if (gm.gameOver) {
      fill(255, 0, 0);
      textSize(70);
      textAlign(CENTER);
      text("Press R to Retry.", width*0.5, 500, -100);
    }
  }
}

void createBlock() {
  cubes.add(new Cube());
}

void keyPressed(){
  if(key == 'r'){
    if(gm.gameOver == true){
      gm.gameOver = false;
      setup();
    }
  }
}