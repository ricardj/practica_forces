class Mover{
  
   public PVector position;
   public PVector speed;
   public PVector acceleration;
   
   public float mass;
   public float radius;
   
   public PVector initialPosition;
   public PVector initialSpeed;
   
   
   public Mover(PVector initialPosition,PVector initialSpeed){
     this.mass = 1;
     this.radius = 3;
     this.initialPosition = new PVector().set(initialPosition);
     this.initialSpeed = new PVector().set(initialSpeed);
     position = new PVector().set(initialPosition);
     speed = new PVector().set(initialSpeed);
     acceleration = new PVector();
   }
   
   
   public void applyForce(PVector force){
      acceleration.add(PVector.div(force,mass));
   }
   
   public void update(){
     //We convert the position and the speed to cartesian to sum them
     position.add(speed);
     speed.add(acceleration);
     
     //We reset the acceleration
     acceleration.set(0,0);
   }
   
   public void display(){
    
    stroke(5);
    fill (0,0,255);
    //PVector position = polar2Cartesian(position);
    ellipse(position.x, -position.y, radius*2, radius*2); 
    
   }
   
   public void reset(){
     position.set(initialPosition);
     speed.set(initialSpeed);
     acceleration.set(0,0);
     
   }
   
   public void onCollision(){
    //println("Oh, damn. I've just collided with someone..."); 
   }
}
