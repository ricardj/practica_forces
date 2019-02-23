
int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;

Earth earth;
Satellite satellite;

CollisionManager collisionManager;
GravityManager gravityManager;

interface Modes{
 int
 A = 0,
 B = 1,
 C = 2,
 D = 3;
}

int currentMode = Modes.A;

void setup(){
  println("Initialising gravitational atraction.");
  
  //Frame settings
  size(200,300);
  surface.setSize(SCREEN_WIDTH,SCREEN_HEIGHT);
  
  //Render settinf
  background(255,255,255);
  surface.setLocation(100,100);
  
  //Intiall position, initial Speed
  //All in polar coordinates
  earth = new Earth(new PVector(), new PVector());
  satellite = new Satellite(new PVector(100,0),new PVector(1.5, PI/2));
  
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
  
  switch(currentMode){
   case Modes.A:
     drawModeA();
     break;
     
   case Modes.B:
     drawModeB();
     break;
     
   case Modes.C:
     drawModeC();
     break;
     
   case Modes.D:
     drawModeD();
     break;
  }
  
}

void reset(){
  earth.reset();
  satellite.reset();
}

void drawModeA(){
  gravityManager.update();
  
  earth.update();
  satellite.update();
  
  collisionManager.update();
  
  earth.display();
  satellite.display();
}

void drawModeB(){
  
}

void drawModeC(){
  
}

void drawModeD(){
  
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
