class Satellite extends Mover{
  
  //Sattellite image
  private PImage image;
  
  //Trace for the sattellite
  public int MAXIMUM_TRACE_SIZE = 300;
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
   public float minorAxis = 80;
   public float majorAxis = 200;
   public float eccentricity;
   
   public Satellite(PVector initialPosition, PVector initialSpeed){
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
   
   private void setTracePoint(){
       float currentTime  = millis();
       if(currentTime - previousTime > time_offset){
         previousTime = currentTime;
         TracePoint newTracePoint = new TracePoint(position);
         trace.add(newTracePoint);
         if(trace.size() > MAXIMUM_TRACE_SIZE) trace.remove(0);
         
         if(recordFirstArea) area1.add(newTracePoint);
         if(playSecondArea) area2.add(newTracePoint);
       }
   }
   
   public void display(){
     //We display the trace
     for(int i = 1; i < trace.size(); i++) trace.get(i).display();
     
     //Then we display the satellite
     if(!exploding){
         image(image,position.x-radius, -(position.y+radius), radius*2, radius*2); 
     }else{
         image(explosionImage,position.x-radius, -(position.y+radius), radius*2, radius*2); 
     }
     
   }
   
   public void displayArea1(){
    //We display the lines for area 1
     stroke(255,0,0);
     for(int i = 0; i < area1.size();i++){
       TracePoint tracePoint = area1.get(i);
       line(0,0,tracePoint.position.x,-tracePoint.position.y);
     }
     stroke(0); 
   }
   
   public void displayArea2(){
     //We display the lines for area 2
     stroke(255,0,0);
     for(int i = 0; i < area2.size();i++){
       TracePoint tracePoint = area2.get(i);
       line(0,0,tracePoint.position.x,-tracePoint.position.y);
     }
     stroke(0); 
   }
   
   public void displayOrbitParams(){
     textSize(30);
     float offset = SCREEN_HEIGHT/4;
     float leftOffset = -SCREEN_WIDTH/2;
     float padding = 30;
     stroke(0);
     fill(0);
     textAlign(LEFT);
     text("Rmin: " + minorAxis,leftOffset,offset);
     text("Rmax: " + majorAxis,leftOffset,offset+padding);
     text("E: "+ eccentricity,leftOffset,offset+2*padding);
   }
   
   public void displayAreaCalculus(){
      textSize(15);
      float offset = SCREEN_HEIGHT/4;
      float leftOffset = -SCREEN_WIDTH/2;
      float padding = 30;
      float leftPadding = 120;
      stroke(0);
      fill(0);
      textAlign(LEFT);
      stroke(0);
      text("Trapezi Areas: ",leftOffset,offset);
      text("Simpson Areas: ",leftOffset+leftPadding,offset);
      text(area1_trapezi,leftOffset,offset+padding);
      text(area2_trapezi,leftOffset,offset+padding*2);
      text(area1_sampson,leftOffset+leftPadding,offset+padding);
      text(area2_sampson,leftOffset+leftPadding,offset+padding*2);
   }
   
   public void update(){
     super.update();
     setTracePoint();
   }
   
   public void reset(){
     trace.clear();
     trace.add(new TracePoint(initialPosition));
     exploding = false;
     area1.clear();
     area2.clear();
     
     firstStage = true;
     secondStage = false;
     recordFirstArea = false;
     playSecondArea = false;
     enterPressed = false;
       
     super.reset(); 
   }
   
   //Reset EXercici D
   public void resetCircularMovement(){
     position.set(200,0);
     speed.set(0,4);
   }
   
   public void resetOrbitalMovement(){
      position.set(-minorAxis,0);
      speed.set(0,-sqrt(2*3200*(1/minorAxis-1/(2*majorAxis))));
   }
   
   public void onCollision(){
     //println("Satellite just collided");
     exploding = true;
     timeOfExplosion = millis();
   }
   
   
   //For managing Exercici C Input Managinf
   public boolean firstStage = true;
   public boolean secondStage = false;
   public boolean recordFirstArea = false;
   public boolean playSecondArea = false;
   public boolean enterPressed = false;
   public void updateArea(){
     if(enterPressed)
     {
         if(playSecondArea){
           //Todo: complete that
         }   
         
         if(secondStage)
        {
           secondStage = false;
           playSecondArea = true;
        }
         if(recordFirstArea)
        {
           recordFirstArea = false;
           secondStage = true;
        }
        if(firstStage)
        {
           recordFirstArea = true;
           firstStage = false;
        }
       }
     
     enterPressed = false;
   }
   
   public void keyPressed(){
     println("key pressed");
      if(keyCode == ENTER){
        enterPressed = true;
      }
   }
  
}
