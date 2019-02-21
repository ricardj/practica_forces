class Mover{
   private float mover_radius = 40;
  
   public PVector position;
   public PVector speed;
   public PVector acceleration;
   
   public float mass;
   
   Mover(){
     this.mass = 1;
     position = new PVector(0,0);
     speed = new PVector(0,0);
     acceleration = new PVector(0,0);
   }
   
   
   public void applyForce(PVector force){
       acceleration.add(PVector.div(force,mass));
   }
   
   public void update(){
     speed.add(acceleration);
     position.add(speed);
     
     //We reset the acceleration
     acceleration.set(0,0);
   }
   
   public void display(){
    stroke(5);
    fill (0,0,255);
    ellipse(position.x, -position.y, mover_radius, mover_radius); 
   }
   
   public void reset(){
     position.set(0,0);
     speed.set(0,0);
     acceleration.set(0,0);
   }
  
}
