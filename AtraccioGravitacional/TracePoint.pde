class TracePoint{
  
    public float radius = 3;
    public PVector position;
   
   public TracePoint(PVector position){
     this.position = new PVector(0,0);
     this.position.set(position);
   }
   
   public void display(){
     fill(255,0,0);
     ellipse(position.x, -position.y,radius*2,radius*2); 
   }
}
