class TracePoint{
  
    public float radius = 3;
    public PVector position;
   
   public TracePoint(PVector position){
     this.position = new PVector(0,0);
     this.position.set(position);
   }
   
   public void display(){
     fill(255,0,0);
     float x = position.x * cos(position.y);
     float y = position.x * sin(position.y);
     ellipse(x, -y,radius*2,radius*2); 
   }
}
