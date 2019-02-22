
int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;

Earth earth;
Mover satellite;

void setup(){
  println("Initialising gravitational atraction.");
  
  //Frame settings
  size(200,300);
  surface.setSize(SCREEN_WIDTH,SCREEN_HEIGHT);
  
  //Render settinf
  background(255,255,255);
  surface.setLocation(100,100);
  
  earth = new Earth();
  satellite = new Mover();
}

void draw(){
  translate(SCREEN_WIDTH/2,SCREEN_HEIGHT/2);
  earth.display();
  earth.update();
  satellite.updateNumerical();
  satellite.display();
}
