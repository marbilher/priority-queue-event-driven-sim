class Event implements Comparable<Event> {
  
  private double time;
  private Ball a, b;
  private int countA, countB;
  
  public Event(double t, Ball a, Ball b) {}
  
  public int compareTo(Event that) {
    return Double.compare(this.time, that.time);
      //if (this.time < that.time) {
      //  return -1;
      //} else if (this.time > that.time) {
      //  return +1;
      //} else return 0;
  }
  
  public boolean isValid() {
    if (a != null && a.count() != countA) return false;
    if (b != null && b.count() != countB) return false;
    return true;
  }
  
}