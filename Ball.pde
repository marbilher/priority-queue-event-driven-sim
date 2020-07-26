class Ball {
  private float rx, ry;
  private float vx, vy;
  final int radius = 5;
  final int mass = 5;
  
  Ball(float x, float y) {
    rx = x;
    ry = y;
    vx = 1;
    vy = 1;
  }
  
  public float timeToHit(Ball that) {
    if (this == that) return Float.POSITIVE_INFINITY;
    float dx = that.rx - this.rx;
    float dy = that.ry - this.ry;
    float dvx = that.vx - this.vx;
    float dvy = that.vy - this.vy;
    float dvdr = dx*dvx + dy*dvy;
    if (dvdr > 0) return Float.POSITIVE_INFINITY;
    
    float dvdv = dvx*dvx + dvy+dvy;
    float drdr = dx*dx + dy*dy;
    float sigma = this.radius + that.radius;
    float d = (dvdr*dvdr) - dvdv * (drdr - sigma*sigma);
    if (d < 0) return Float.POSITIVE_INFINITY;
    return -(dvdr + Math.sqrt(d)) / dvdv;
    
    
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