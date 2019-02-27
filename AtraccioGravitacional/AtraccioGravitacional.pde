
int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 700;

Earth earth;
Satellite satellite;

CollisionManager collisionManager;
GravityManager gravityManager;

Menu menu;


//For time controlling
float previousTime;

interface Modes{
 int
 A = 0,
 B = 1,
 C = 2,
 D = 3;
}

int currentOption = Modes.A;

void setup(){
  
  //Frame settings
  size(200,300);
  surface.setSize(SCREEN_WIDTH,SCREEN_HEIGHT);
  
  //Render settinf
  background(255,255,255);
  surface.setLocation(500,0);
  
  //Intiall position, initial Speed
  //All in polar coordinates
  earth = new Earth(new PVector(), new PVector());
  //325/2
  satellite = new Satellite(new PVector(200,0),new PVector(0, 0.9));
  
  collisionManager = new CollisionManager();
  collisionManager.addCollidable(earth);
  collisionManager.addCollidable(satellite);
  
  gravityManager = new GravityManager();
  gravityManager.addStatic(earth);
  gravityManager.addMobile(satellite);
  
  
  //We set the menu
  menu = new Menu();
  
}

void draw(){
  translate(SCREEN_WIDTH/2,SCREEN_HEIGHT/2);
  background(255);
  
  checkChangedMode();
  
  switch(menu.currentOption){
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
  menu.update();
  menu.display();
  
}

void reset(){
  earth.reset();
  satellite.reset();
}

void drawModeA(){
  
  
  if(satellite.exploding){
    float currentTime = millis();
    if(currentTime - satellite.timeOfExplosion > 800){
         reset();
    }
  }else{
    gravityManager.update();
  
    earth.update();
    satellite.update();
  
    collisionManager.update();
  }
  
  earth.display();
  satellite.display();
}

void drawModeB(){
  if(satellite.exploding){
    float currentTime = millis();
    if(currentTime - satellite.timeOfExplosion > 800){
         reset();
    }
  }else{
    earth.update();
    satellite.updateAnalytic();
    collisionManager.update();
  }
  
  earth.display();
  satellite.display();
  satellite.displayOrbitParams();
}

void drawModeC(){
  if(satellite.exploding){
    float currentTime = millis();
    if(currentTime - satellite.timeOfExplosion > 800){
         reset();
    }
  }else{
    earth.update();
    satellite.updateAnalytic();
    satellite.updateArea();
    collisionManager.update();
  }
  
  satellite.displayArea1();
  satellite.displayArea2();
  earth.display();
  satellite.display();
  satellite.displayAreaCalculus();
  
}

void drawModeD(){
  if(satellite.exploding){
    float currentTime = millis();
    if(currentTime - satellite.timeOfExplosion > 800){
         reset();
    }
  }else{
    earth.update();
    satellite.updateAnalytic();
    collisionManager.update();
  }
  earth.display();
  satellite.display();
}

public void checkChangedMode(){
 if(menu.currentOption != currentOption) {
   currentOption = menu.currentOption;
   reset();
   if(currentOption == Modes.D){
     satellite.eccentricity = 0;
     satellite.K = 15;
     satellite.W = PI/100;
   }
   if(currentOption == Modes.B || currentOption == Modes.C){
     satellite.W = PI/200;
     satellite.K = 15;
     satellite.eccentricity = 0.5;
   }
 }
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

void keyPressed(){
  satellite.keyPressed(); 
}
