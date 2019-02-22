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
     //position.add(speed);
     float x = speed.x * cos(speed.y);
     float y = speed.x * sin(speed.y);
     //position.x = 
     position.y = position.y + speed.y;
     
     speed.add(acceleration);
     
     //We reset the acceleration
     acceleration.set(0,0);
   }
   
   public void display(){
    
    stroke(5);
    fill (0,0,255);
    float x = position.x * cos(position.y);
    float y = position.x * sin(position.y);
    ellipse(x, -y, radius*2, radius*2); 
    
   }
   
   public void reset(){
     position.set(initialPosition);
     speed.set(initialSpeed);
     acceleration.set(0,0);
   }
   
   public void onCollision(){
    println("Oh, damn. I've just collided with someone..."); 
   }

  
}
