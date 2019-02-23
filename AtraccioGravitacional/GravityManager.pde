class GravityManager{
  
 private ArrayList<Mover> staticMovers;
 private ArrayList<Mover> mobileMovers;
 
 public GravityManager(){
   //Initialise the arrays  
   staticMovers = new ArrayList<Mover>();
   mobileMovers = new ArrayList<Mover>();
   
 }
 
 public void update(){
   //Apply the forces of the static movers to the mobile movers
   for(int i = 0; i < staticMovers.size(); i++){
     for(int j = 0; j < mobileMovers.size(); j++){
       Mover M = staticMovers.get(i);
       Mover m = mobileMovers.get(j);
       
       //Force caused by the M to the m
       //TODO: complete that
       PVector force = new PVector();
       float scalar = (M.mass*m.mass)/sq(m.position.x-M.position.x);
       force.x = scalar*-1;
       //PVector r  = PVector.sub(polar2Cartesian(M.position), polar2Cartesian(m.position)).normalize();
       //force = PVector.mult(r,(M.mass*m.mass)/sq(m.position.x-M.position.x));
       
       m.applyForce(force);
     }
   }
 }
 
 public void addStatic(Mover staticMover){
   staticMovers.add(staticMover);
 }
 
 public void addMobile(Mover mobileMover){
   mobileMovers.add(mobileMover);
 }
  
}
