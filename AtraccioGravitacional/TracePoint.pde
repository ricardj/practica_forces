class TracePoint{
  
    public float radius = 5;
    public PVector position;
   
   public TracePoint(PVector position){
     this.position = new PVector(0,0);
     this.position.set(position);
   }
   
   public void display(){
     fill(255,0,0);
    ellipse(position.x, -position.y,radius,radius); 
   }
  
}
