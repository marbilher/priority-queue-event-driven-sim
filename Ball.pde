class Ball {
  float rx, ry;
  float vx, vy;
  int radius = 5;
  
  Ball(float x, float y) {
    rx = x;
    ry = y;
    vx = 1;
    vy = 1;
  }
  
  void move(float dt) {
    if((rx + vx*dt < radius) || (rx + vx*dt > 1000 - radius)) { vx = -vx; }
    if((ry + vy*dt < radius) || (ry + vy*dt > 1000 - radius)) { vy = -vy; }
    rx = rx + vx*dt;
    ry = ry + vy*dt;
    
  }
  
  void draw() {
    fill(0);

    ellipse(rx, ry, radius, radius);
  }
  
  
}