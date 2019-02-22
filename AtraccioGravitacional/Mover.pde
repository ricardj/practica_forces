class Mover{
  
   public PVector position;
   public PVector speed;
   public PVector acceleration;
   
   public float mass;
   private float radius;
   
   public PVector initialPosition = new PVector(50,200);
   
   
   public Mover(){
     this.mass = 1;
     this.radius = 40;
     position = new PVector().set(initialPosition);
     speed = new PVector();
     acceleration = new PVector();
     
   }
   
   
   public void applyForce(PVector force){
       acceleration.add(PVector.div(force,mass));
   }
   
   public void update(){
     position.add(speed);
     speed.add(acceleration);
     
     //We reset the acceleration
     acceleration.set(0,0);
   }
   
   public void display(){
    
    stroke(5);
    fill (0,0,255);
    ellipse(position.x, -position.y, radius, radius); 
    
   }
   
   public void reset(){
     position.set(initialPosition);
     speed.set(0,0);
     acceleration.set(0,0);
   }
   
   public void onCollide(){
    println("Oh, damn. I've just collided with someone..."); 
   }
  
}
