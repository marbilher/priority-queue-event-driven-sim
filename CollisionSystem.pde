public class CollisionSystem {
  
  private static final float HZ = 0.01666;
  private MinPQ<Event> pq;
  private double t = 0.0;
  private Ball[] balls;
  
  public CollisionSystem(Ball[] balls) {  }
  
  private void predict(Ball a, double limit) {
    if (a == null) return;
    for (int i = 0; i < balls.length; i++) {
      double dt = a.timeToHit(balls[i]);
      if (t + dt <= limit)  {
        pq.insert(new Event(t + dt, a, balls[i]));
      }
    }
    //pq.insert(new Event(t + a.timeToHitVerticalWall(), a, null));
    //pq.insert(new Event(t + a.timeToHitHorizontalWall(), a, null));
    double dtX = a.timeToHitVerticalWall();
    double dtY = a.timeToHitHorizontalWall();
    if (t + dtX <= limit) pq.insert(new Event(t + dtX, a, null));
    if (t + dtY <= limit) pq.insert(new Event(t + dtY, null, a));
  }
  
  private void redraw(double limit) { 
      for (int i = 0; i < balls.length; i++) {
          balls[i].draw();
      }
      
      if (t < limit) {
          pq.insert(new Event(t + 1.0 / HZ, null, null));
      }
  }
  public void simulate(double limit) {  
    pq = new MinPQ<Event>();
        for (int i = 0; i < balls.length; i++) {
            predict(balls[i], limit);
        }
        pq.insert(new Event(0, null, null));


        // the main event-driven simulation loop
        while (!pq.isEmpty()) { 

            // get impending event, discard if invalidated
            Event e = pq.delMin();
            if (!e.isValid()) continue;
            Ball a = e.a;
            Ball b = e.b;

            for (int i = 0; i < balls.length; i++)
                balls[i].move((float)e.time - (float)t);
            t = e.time;

            if      (a != null && b != null) a.bounceOff(b);              // particle-particle collision
            else if (a != null && b == null) a.bounceOffVerticalWall();   // particle-wall collision
            else if (a == null && b != null) b.bounceOffHorizontalWall(); // particle-wall collision
            else if (a == null && b == null) redraw(limit);               // redraw event

            // update the priority queue with new collisions involving a or b
            predict(a, limit);
            predict(b, limit);
        }
  }
  
}