
int numBalls = 100;
Ball[] balls = new Ball[numBalls];
int frames = 0;

void setup() {
  size(1000, 1000);
  background(255);

  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(0, 1000), random(0, 1000));
  }
  
  CollisionSystem system = new CollisionSystem(balls);
  system.simulate(100);
}

void draw() {
    background(255);

    //for (int i = 0; i < numBalls; i++) {
    //  balls[i].move(2);
    //  balls[i].draw();
    //}  
    //frames++;
}