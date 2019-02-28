class TracePoint {

  public float tracePoint_radius = 5;
  public PVector position;

  public TracePoint(PVector position) {
    this.position = new PVector(0, 0);
    this.position.set(position);
  }

  public void display() {
    fill(0, 0, 0);
    ellipse(position.x, -position.y, tracePoint_radius, tracePoint_radius);
  }
}
