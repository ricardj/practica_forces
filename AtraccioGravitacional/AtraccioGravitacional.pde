
int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;

Earth earth;
Satellite satellite;

CollisionManager collisionManager;
GravityManager gravityManager;

void setup(){
  println("Initialising gravitational atraction.");
  
  //Frame settings
  size(200,300);
  surface.setSize(SCREEN_WIDTH,SCREEN_HEIGHT);
  
  //Render settinf
  background(255,255,255);
  surface.setLocation(100,100);
  
  earth = new Earth(new PVector(), new PVector());
  satellite = new Satellite(new PVector(100,0),new PVector(0.5, PI/4));
  
  collisionManager = new CollisionManager();
  collisionManager.addCollidable(earth);
  collisionManager.addCollidable(satellite);
  
  gravityManager = new GravityManager();
  gravityManager.addStatic(earth);
  gravityManager.addMobile(satellite);
}

void draw(){
  translate(SCREEN_WIDTH/2,SCREEN_HEIGHT/2);
  background(255);
  
  gravityManager.update();
  
  earth.update();
  satellite.update();
  
  collisionManager.update();
  
  earth.display();
  satellite.display();
}

void reset(){
  earth.reset();
  satellite.reset();
}

 public static PVector polar2Cartesian(PVector polar){
   PVector cartesian = new PVector();
   cartesian.x = polar.x * cos(polar.y);
   cartesian.y = polar.x * sin(polar.y);
   return cartesian;
 }
 
 public static PVector cartesian2Polar(PVector cartesian){
   PVector polar = new PVector();
   polar.x = cartesian.mag();
   polar.y = atan2(cartesian.y, cartesian.x);
   return polar;
 }
