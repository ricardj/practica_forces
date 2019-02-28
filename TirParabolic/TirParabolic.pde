
int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;

PVector gravity = new PVector(0, -0.08);
PVector initialSpeed_m1 = new PVector(3, 3);
PVector initialSpeed_m2 = new PVector(3, 3);
PVector initialPosition = new PVector(0, 0);
Mover m1 = new Mover();
Mover m2 = new Mover();

ScrollbarPanel scrollbarPanel;


void setup() {

  //Frame settings
  size(200, 300);
  surface.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);

  //Render settinf
  background(255, 255, 255);
  surface.setLocation(100, 100);

  //Set initial speed
  m1.speed.set(initialSpeed_m1);
  m2.speed.set(initialSpeed_m2);
  
  //Set acceleration 
  m2.acceleration.set(gravity);

  m2.moverColor.set(255, 0, 0);

  scrollbarPanel = new ScrollbarPanel();
}

void draw() {
  translate(0, SCREEN_HEIGHT);
  background(255, 255, 255);

  m1.applyForce(gravity);
  m1.updateAnalytical();
  m1.display();


  m2.updateNumerical();
  m2.display();

  scrollbarPanel.update();
  scrollbarPanel.display();

  if (m1.position.y < (int)0 && m2.position.y < (int)0 
    || m1.position.x > (int)SCREEN_WIDTH && m2.position.x > (int)SCREEN_WIDTH
    || m1.position.y < (int)0 && m2.position.x > (int)SCREEN_WIDTH
    || m1.position.x > (int)SCREEN_WIDTH && m2.position.y < (int)0) {
    resetConditions();
  }
}

void resetConditions() {
  m1.reset();
  m1.speed.set(scrollbarPanel.getSpeedM1());
  m2.reset();
  m2.speed.set(scrollbarPanel.getSpeedM2());
  m2.acceleration.set(gravity);
}
