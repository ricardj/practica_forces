
int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;

PVector gravity = new PVector(0,-0.08);
PVector initialSpeed = new PVector(3,3);
Mover m1 = new Mover();
Mover m2 = new Mover();

void setup(){
  
  //Frame settings
  size(200,300);
  frame.setSize(SCREEN_WIDTH,SCREEN_HEIGHT);
  
  //Render settinf
  background(255,255,255);
  surface.setLocation(100,100);
  
  //Set initial speed
  m1.speed.set(initialSpeed);
}

void draw(){
  translate(0,SCREEN_HEIGHT);
  background(255,255,255);
 
  m1.applyForce(gravity);
  m1.update();
  m1.display();
  
  
  if (m1.position.y < (int)0) {
    m1.reset();
    m1.speed.set(initialSpeed);
  }
}
