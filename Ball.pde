class Ball {
  private float rx, ry;
  private float vx, vy;
  final int radius = 5;
  final int mass = 5;
  int count = 0;
  
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
    return -(dvdr + sqrt(d)) / dvdv;
    
    
  }
  
  
    public double timeToHitVerticalWall() {
        if      (vx > 0) return (1.0 - rx - radius) / vx;
        else if (vx < 0) return (radius - rx) / vx;  
        else             return Float.POSITIVE_INFINITY;
    }
    
    
    public double timeToHitHorizontalWall() {
        if      (vy > 0) return (1.0 - ry - radius) / vy;
        else if (vy < 0) return (radius - ry) / vy;
        else             return Float.POSITIVE_INFINITY;
    }
  
  public void bounceOff(Ball that) {
    
    float dx = that.rx - this.rx;
    float dy = that.ry - this.ry;
    float dvx = that.vx - this.vx;
    float dvy = that.vy - this.vy;
    float dvdr = dx*dvx + dy*dvy;
    float dist = this.radius + that.radius;
    float j = 2 * this.mass * that.mass * dvdr / ((this.mass + that.mass) * dist);
    float jx = j * dx / dist;
    float jy = j * dy / dist;
    this.vx += jx / this.mass;
    this.vy += jy / this.mass;
    that.vx -= jx / that.mass;
    that.vy -= jy / that.mass;
    this.count++;
    that.count++;
    
  }
  
  void move(float dt) {
    if((rx + vx*dt < radius) || (rx + vx*dt > 1000 - radius)) { vx = -vx; }
    if((ry + vy*dt < radius) || (ry + vy*dt > 1000 - radius)) { vy = -vy; }
    rx = rx + vx*dt;
    ry = ry + vy*dt;
    
  }
  
  public void bounceOffVerticalWall() {
        vx = -vx;
        count++;
    }

  public void bounceOffHorizontalWall() {
        vy = -vy;
        count++;
    }
  
  
    public int count() {
        return count;
    }
  
  void draw() {
    fill(0);

    ellipse(rx, ry, radius, radius);
  }
  
  
}