class Satellite extends Mover{
   public TracePoint[] trace;
   
   private float previousTime;
   private float time_offset = 70;
   
   public Satellite(PVector initialPosition){
     super(initialPosition);
    //We initialise the trace
     trace = new TracePoint[1];
     trace[0] = new TracePoint(position);
     previousTime = millis();
      
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
     for(int i = 0; i < trace.length; i++) trace[i].display();
     super.display();
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
