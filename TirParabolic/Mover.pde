class Mover{
   private float mover_radius = 40;
  
   public PVector position;
   public PVector speed;
   public PVector acceleration;
   
   public float mass;
   
   public TracePoint[] trace;
   
   private float previousTime;
   private float time_offset = 70;
   
   public Mover(){
     this.mass = 1;
     position = new PVector(0,0);
     speed = new PVector(0,0);
     acceleration = new PVector(0,0);
     
     trace = new TracePoint[1];
     trace[0] = new TracePoint(position);
     previousTime = millis();
   }
   
   
   public void applyForce(PVector force){
       acceleration.add(PVector.div(force,mass));
   }
   
   public void update(){
     speed.add(acceleration);
     position.add(speed);
     
     //We reset the acceleration
     acceleration.set(0,0);
     
     float currentTime  = millis();
     if(currentTime - previousTime > time_offset){
       previousTime = currentTime;
       TracePoint newTracePoint = new TracePoint(position);
       trace = (TracePoint[])append(trace,newTracePoint);
     }
     
   }
   
   public void display(){
    
    for(int i = 0; i < trace.length; i++) trace[i].display();
    
    stroke(5);
    fill (0,0,255);
    ellipse(position.x, -position.y, mover_radius, mover_radius); 
    
   }
   
   public void reset(){
     position.set(0,0);
     speed.set(0,0);
     acceleration.set(0,0);
     trace = new TracePoint[1];
     trace[0] = new TracePoint(position);
   }
  
}
