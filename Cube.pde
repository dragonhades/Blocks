class Cube {
  
  private Cube prevCube;
  private Cube nextCube;
  
  int size = 100;
  float x, y, z;
  float speed = 50;
  
  color c = color(255);
  
  Cube(){
    x = random(0, width);
    y = random(0, height);
    z = -20000;
    
    breed();
  }
  
  Cube(Cube prev){
    prevCube = prev;
    
    x = prev.x;
    y = prev.y;
    z = prev.z;
    
    // 1 2 3 4 5 6
    int seed = (int) random(1, 7);
    switch(seed){
      case 1:
      x = prev.x - size;
      break;
      
      case 2:
      x = prev.x + size;
      break;
      
      case 3:
      y = prev.y - size;
      break;
      
      case 4:
      y = prev.y + size;
      break;
      
      case 5:
      z = prev.z - size;
      break;
      
      case 6:
      z = prev.z + size;
      break;
    }
    
    breed();
  }
  
  private void move(){
    z += speed;
  }
  
  private final void breed(){
    int randNum = (int)random(100);
    if(randNum < 90){
      nextCube = new Cube(this);
    }
  }
  
  public final void draw(){
    if(!gm.gameOver)move();
    
    pushMatrix();
    translate(x,y,z);
    
    // draw box
    stroke(c);
    strokeWeight(3);
    noFill();
    box(size);
    
    popMatrix();
    
    if(nextCube!=null) nextCube.draw();
  }
  
  public final boolean hitTest(){
    float centerX = width /2;
    float centerY = height/2;
    float centerZ = 500;
    
    float boxX = x + view.x;
    float boxY = y + view.y;
    float boxZ = z + view.z;
    
    if(centerX >= boxX - size/2 && 
       centerX <= boxX + size/2 &&
       centerY >= boxY - size/2 &&
       centerY <= boxY + size/2 &&
       centerZ >= boxZ - size/2 &&
       centerZ <= boxZ + size/2)
    {
      c = color(255, 0, 0);
      if(nextCube!=null)nextCube.hitTest();
      return true;
    } else {
      if(nextCube == null) return false;
      else return nextCube.hitTest();
    }
  }
}