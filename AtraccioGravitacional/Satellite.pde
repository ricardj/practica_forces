class Satellite extends Mover{
  
  public int MAXIMUM_TRACE_SIZE = 200;
  
   public ArrayList<TracePoint> trace;
   public ArrayList<TracePoint> area1;
   public ArrayList<TracePoint> area2;
   
   
   private float previousTime;
   private float time_offset = 70;
   
   private PImage image;
   private PImage explosionImage;
   
   public boolean exploding;
   public float timeOfExplosion;
   
   public float minorAxis = 100;
   public float majorAxis = 100;
   public float eccentricity = 0;
   public float H;
   public float K;
   public float W;
   
   public Satellite(PVector initialPosition, PVector initialSpeed){
     super(initialPosition, initialSpeed);
    
     radius = 20;
     mass = 10;
     
     W = PI/200;
     K = 15;
     eccentricity = 0.5;
     H = W*initialPosition.x*initialPosition.x;
     
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
     //PVector cartesianPosition = polar2Cartesian(position);
     PVector cartesianPosition = position;
     if(!exploding){
         image(image,cartesianPosition.x-radius, -(cartesianPosition.y+radius), radius*2, radius*2); 
     }else{
         image(explosionImage,cartesianPosition.x-radius, -(cartesianPosition.y+radius), radius*2, radius*2); 
     }
     
   }
   
   public void displayArea1(){
    //We display the lines
     stroke(255,0,0);
     for(int i = 0; i < area1.size();i++){
       TracePoint tracePoint = area1.get(i);
       line(0,0,tracePoint.position.x,-tracePoint.position.y);
     }
     stroke(0); 
   }
   
   public void displayArea2(){
     //We display the lines
     stroke(255,0,0);
     for(int i = 0; i < area2.size();i++){
       TracePoint tracePoint = area2.get(i);
       line(0,0,tracePoint.position.x,-tracePoint.position.y);
     }
     stroke(0); 
   }
   
   public void displayOrbitParams(){
     stroke(0);
     text("Rmin: " + minorAxis,0,0);
     text("Rmax: " + majorAxis,0,0);
     text("E: "+ eccentricity,0,0);
   }
   public void displayAreaCalculus(){
      stroke(0);
      text("Trapezi Areas: ",0,0);
      text("Simpson Areas: ",0,0);
   }
   
   public void update(){
     super.update();
     setTracePoint();   
   }
   
   public void updateAnalytic(){
     PVector polarPosition = AtraccioGravitacional.cartesian2Polar(position);
     
     
     
     
     polarPosition.x = 10*K/(1-eccentricity*cos(polarPosition.y));
     W = H/(polarPosition.x*polarPosition.x);
     polarPosition.y += W;
     
     
     position = AtraccioGravitacional.polar2Cartesian(polarPosition);
     
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
   
   public void onCollision(){
     //println("Satellite just collided");
     exploding = true;
     timeOfExplosion = millis();
   }
   
   public boolean firstStage = true;
   public boolean secondStage = false;
   public boolean recordFirstArea = false;
   public boolean playSecondArea = false;
   public boolean enterPressed = false;
   public void updateArea(){
     if(enterPressed)
     {
       if(playSecondArea){
         
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
