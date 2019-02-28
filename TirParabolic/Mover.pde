class Mover {
  private float mover_radius = 40;

  public PVector initialPosition = new PVector(50, 200);
  public float acumulatedTime = 0;

  public PVector position;
  public PVector speed;
  public PVector acceleration;

  public float mass;

  public TracePoint[] trace;

  private float previousTime;
  private float time_offset = 70;

  public PVector moverColor;

  public Mover() {
    this.mass = 1;
    position = new PVector().set(initialPosition);
    speed = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    trace = new TracePoint[1];
    trace[0] = new TracePoint(position);
    previousTime = millis();

    moverColor = new PVector(0, 0, 255);
  }


  public void applyForce(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }

  public void updateAnalytical() {
    position.add(speed);
    speed.add(acceleration);

    //We reset the acceleration
    acceleration.set(0, 0);

    setTracePoint();
  }

  public void updateNumerical() {
    
    float x = initialPosition.x + speed.x*acumulatedTime;
    float y = initialPosition.y + speed.y*acumulatedTime + (1.0/2.0)*acceleration.y*sq(acumulatedTime);
    position.set(x,y);

    acumulatedTime += (frameRate/60);
    
    println();
    println(initialPosition.y + speed.y*acumulatedTime + acceleration.y*sq(acumulatedTime));
    println(position.y);
    println(acumulatedTime);
    println(acceleration.y);
    println(acceleration.y*sq(acumulatedTime));
    
    setTracePoint();
  }

  private void setTracePoint() {
    float currentTime  = millis();
    if (currentTime - previousTime > time_offset) {
      previousTime = currentTime;
      TracePoint newTracePoint = new TracePoint(position);
      trace = (TracePoint[])append(trace, newTracePoint);
    }
  }

  public void display() {

    for (int i = 0; i < trace.length; i++) trace[i].display();

    stroke(5);
    fill (moverColor.x, moverColor.y, moverColor.z);
    ellipse(position.x, -position.y, mover_radius, mover_radius);
  }

  public void reset() {
    position.set(initialPosition);
    speed.set(0, 0);
    acceleration.set(0, 0);
    trace = new TracePoint[1];
    trace[0] = new TracePoint(position);
    acumulatedTime = 0;
  }
}
