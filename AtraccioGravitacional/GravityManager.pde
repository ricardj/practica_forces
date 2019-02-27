class GravityManager{
  
 private ArrayList<Mover> staticMovers;
 private ArrayList<Mover> mobileMovers;
 
 public static final float G = 900;
 
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
       
       PVector force = PVector.sub(M.position,m.position);
       float distance = force.mag();
       force.normalize();

       distance = constrain(distance,500,500.0);
     
       
       float strength = ((G*M.mass*m.mass)/(distance*distance));
       force.mult(strength);
       
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
