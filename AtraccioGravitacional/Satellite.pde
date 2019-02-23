class Satellite extends Mover{
   public TracePoint[] trace;
   
   private float previousTime;
   private float time_offset = 70;
   
   private PImage image;
   
   public Satellite(PVector initialPosition, PVector initialSpeed){
     super(initialPosition, initialSpeed);
    
     radius = 10;
     
     //We initialise the trace
     trace = new TracePoint[1];
     trace[0] = new TracePoint(position);
     previousTime = millis();
     
     //We load the image
     image = loadImage("Satellite.png");
   }
   
   private void setTracePoint(){
       float currentTime  = millis();
       if(currentTime - previousTime > time_offset){
         previousTime = currentTime;
         TracePoint newTracePoint = new TracePoint(position);
         trace = (TracePoint[])append(trace,newTracePoint);
       }
   }
   
   public void display(){
     //We display the trace
     for(int i = 0; i < trace.length; i++) trace[i].display();
     
     //Then we display the satellite
     PVector cartesianPosition = polar2Cartesian(position);
     image(image,cartesianPosition.x-radius, -(cartesianPosition.y-radius), radius*2, radius*2); 
   }
   
   public void update(){
     super.update();
    setTracePoint();     
   }
   
   public void reset(){
     trace = new TracePoint[1];
     trace[0] = new TracePoint(initialPosition);
     super.reset(); 
   }
   
   public void onCollision(){
      reset();
   }
  
  
}
