class Satellite extends Mover {

  //Sattellite image
  private PImage image;

  //Trace for the sattellite
  public int MAXIMUM_TRACE_SIZE = 150;
  public ArrayList<TracePoint> trace;
  private float previousTime;
  private float time_offset = 70;

  //Attributes for area managing
  public ArrayList<TracePoint> area1;
  public ArrayList<TracePoint> area2;
  public float area1_trapezi;
  public float area1_sampson;
  public float area2_trapezi;
  public float area2_sampson;


  //Explosion managing and representation
  private PImage explosionImage;
  public boolean exploding;
  public float timeOfExplosion;

  //Atributes fo Orbit handling
  public float minorAxis;
  public float majorAxis;
  public float eccentricity;
  public float focus;
  public float fartherPosition;

  public Satellite(PVector initialPosition, PVector initialSpeed) {
    //We call the mover constructor
    super(initialPosition, initialSpeed);

    //Init settings
    radius = 20;
    mass = 10;


    //We initialise the trace
    trace = new ArrayList<TracePoint>();
    trace.add(new TracePoint(position));
    previousTime = millis();

    //We load the image
    image = loadImage("Satellite.png");

    //We load the explosion thing
    explosionImage = loadImage("Explosion.png");
    exploding = false;

    //For area calculating
    area1 = new ArrayList<TracePoint>();
    area2 = new ArrayList<TracePoint>();
    area1_trapezi = 0;
    area1_sampson = 0;
    area2_trapezi = 0;
    area2_sampson = 0;
  }

  private void setTracePoint() {
    float currentTime  = millis();
    if (currentTime - previousTime > time_offset) {
      previousTime = currentTime;
      TracePoint newTracePoint = new TracePoint(position);
      trace.add(newTracePoint);
      if (trace.size() > MAXIMUM_TRACE_SIZE) trace.remove(0);

      if (recordFirstArea) area1.add(newTracePoint);
      if (playSecondArea) area2.add(newTracePoint);
    }
  }

  public void display() {
    //We display the trace
    for (int i = 1; i < trace.size(); i++) trace.get(i).display();

    //Then we display the satellite
    if (!exploding) {
      image(image, position.x-radius, -(position.y+radius), radius*2, radius*2);
    } else {
      image(explosionImage, position.x-radius, -(position.y+radius), radius*2, radius*2);
    }
  }

  public void displayArea1() {
    //We display the lines for area 1
    stroke(255, 0, 0);
    for (int i = 0; i < area1.size(); i++) {
      TracePoint tracePoint = area1.get(i);
      line(0, 0, tracePoint.position.x, -tracePoint.position.y);
    }
    stroke(0);
  }

  public void displayArea2() {
    //We display the lines for area 2
    stroke(0, 255, 0);
    for (int i = 0; i < area2.size(); i++) {
      TracePoint tracePoint = area2.get(i);
      line(0, 0, tracePoint.position.x, -tracePoint.position.y);
    }
    stroke(0);
  }

  public void displayOrbitParams() {
    textSize(30);
    float offset = SCREEN_HEIGHT/4;
    float leftOffset = -SCREEN_WIDTH/2;
    float padding = 30;
    stroke(0);
    fill(127.5);
    textAlign(LEFT);
    text("Rmin: " + minorAxis, leftOffset, offset);
    text("Rmax: " + majorAxis, leftOffset, offset+padding);
    text("E: "+ eccentricity, leftOffset, offset+2*padding);
  }

  public void displayAreaCalculus() {
    textSize(15);
    float offset = SCREEN_HEIGHT/4;
    float leftOffset = -SCREEN_WIDTH/2;
    float padding = 30;
    float leftPadding = 120;
    stroke(0);
    fill(127.5);
    textAlign(LEFT);
    stroke(0);
    text("Trapezi Areas: ", leftOffset, offset);
    text("Simpson Areas: ", leftOffset+leftPadding, offset);
    text(area1_trapezi, leftOffset, offset+padding);
    text(area2_trapezi, leftOffset, offset+padding*2);
    text(area1_sampson, leftOffset+leftPadding, offset+padding);
    text(area2_sampson, leftOffset+leftPadding, offset+padding*2);
  }

  //162
  //222
  //182
  public void update() {
   /* if (position.mag() - focus >= majorAxis){
      //majorAxis = (int)((GravityManager.G*earth.mass*position.mag())/(2*GravityManager.G*earth.mass-position.mag()*speed.magSq()));
      majorAxis = position.mag() - focus;
    }*/

    //if (abs(cartesian2Polar(position).y) == PI && position.mag() < majorAxis)
    if (position.mag() > fartherPosition) {
      fartherPosition = position.mag();
      //focus = fartherPosition - (new PVector(INITIAL_POSITION_X, INITIAL_POSITION_Y).mag());
      focus = fartherPosition-majorAxis;
    }
    
    eccentricity = abs(focus/majorAxis);

    minorAxis = majorAxis * sqrt(1-sq(eccentricity));

    super.update();
    setTracePoint();
  }

  public void reset() {
    trace.clear();
    trace.add(new TracePoint(initialPosition));
    exploding = false;
    area1.clear();
    area2.clear();

    firstStage = true;
    secondStage = false;
    resetStage = false;
    recordFirstArea = false;
    playSecondArea = false;
    enterPressed = false;
    firstAreaStartTime = 0;
    firstAreaTotalTime =0;
    secondAreaStartTime = 0;
    secondAreaTotalTime =0;

    super.reset();
    
    position.set(INITIAL_POSITION_X,INITIAL_POSITION_Y);
    speed.set(INITIAL_SPEED_X,INITIAL_SPEED_Y);
    
  }

  //Reset EXercici D
  public void resetCircularMovement() {
    PVector circularSpeed = (new PVector(-INITIAL_POSITION_Y, INITIAL_POSITION_X)).normalize();
    float radius = (new PVector(INITIAL_POSITION_Y, -INITIAL_POSITION_X)).mag();
    circularSpeed.mult(sqrt(GravityManager.G*earth.mass*(1/radius)));
    speed.set(circularSpeed);
    minorAxis = 0;
    majorAxis = INITIAL_MAJOR_AXIS;
    eccentricity = 0;
    focus = 0;
    fartherPosition = 0;
  }

  //Reset for ExerciciB and ExerciciC
  public void resetOrbitalMovement() {
    majorAxis = INITIAL_MAJOR_AXIS;


    float startingRadius = (new PVector(INITIAL_POSITION_X, INITIAL_POSITION_Y)).mag();
    position.set(INITIAL_POSITION_X, INITIAL_POSITION_Y);
    speed.set(-INITIAL_POSITION_Y, INITIAL_POSITION_X);
    speed.normalize();
    speed.mult(sqrt(2*earth.mass*(1/startingRadius-1/(2*majorAxis))));

    fartherPosition = startingRadius;
  }

  public void onCollision() {
    //println("Satellite just collided");
    exploding = true;
    timeOfExplosion = millis();
  }


  //For managing Exercici C Input Managing
  public boolean firstStage = true;
  public boolean resetStage = false;
  public boolean secondStage = false;
  public boolean recordFirstArea = false;
  public boolean playSecondArea = false;
  public boolean enterPressed = false;
  public float firstAreaStartTime = 0;
  public float firstAreaTotalTime =0;
  public float secondAreaStartTime = 0;
  public float secondAreaTotalTime =0;

  public void updateArea() {
    if (playSecondArea) {
      secondAreaTotalTime = millis() - secondAreaStartTime;
      if (secondAreaTotalTime >= firstAreaTotalTime) {
        playSecondArea = false;
        resetStage = true;
        calculateArea2();
      }
    }

    if (enterPressed)
    {   

      if (secondStage)
      {
        secondStage = false;
        playSecondArea = true;
        secondAreaStartTime = millis();
      }
      if (recordFirstArea)
      {
        recordFirstArea = false;
        firstAreaTotalTime = millis() - firstAreaStartTime;
        calculateArea1();
        secondStage = true;
      }
      if (firstStage)
      {
        recordFirstArea = true;
        firstAreaStartTime = millis();
        firstStage = false;
      }
      if (resetStage) {
        area1.clear();
        area2.clear();
        firstStage = true;
        resetStage = false;
        area1_trapezi = 0;
        area1_sampson = 0;
        area2_trapezi = 0;
        area2_sampson = 0;
      }
    }

    enterPressed = false;
  }

  public void keyPressed() {
    if (keyCode == ENTER) {
      enterPressed = true;
    }
  }

  public void calculateArea1() {
    area1_trapezi = calculateTrapeziArea(area1);
    area1_sampson = calculateSimpsonArea(area1);
  }

  public void calculateArea2() {
    area2_trapezi = calculateTrapeziArea(area2);
    area2_sampson = calculateSimpsonArea(area2);
  }

  public float calculateSimpsonArea(ArrayList<TracePoint> function) {
    //Todo: complete this function
    return 40;
  }

  public float calculateTrapeziArea(ArrayList<TracePoint> function) {
    //TOD: complete this function 
    return 50;
  }
}
