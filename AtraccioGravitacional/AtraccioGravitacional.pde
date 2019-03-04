
int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 700;

/*
You can change the values of the variables inside the PLAYABLE_CODE_AREA.
But you have to take on account that after first iteration they will take the slider values.

In order to deactivate the sliders, comment all the lines where the sliderPanel appears on this class.
*/

//PLAYABLE_CODE_AREA

//Variables for all exercicis
float INITIAL_POSITION_X = 200;
float INITIAL_POSITION_Y = 40;
float INITIAL_MAJOR_AXIS = 150;
float EARTH_MASS = 3200;

//Just for EXERCICI A
float INITIAL_SPEED_X = 0;
float INITIAL_SPEED_Y = 1;

//END_OF_PLAYABLE_CODE_AREA

Earth earth;
Satellite satellite;

CollisionManager collisionManager;
GravityManager gravityManager;

Menu menu;
ScrollbarPanel scrollbarPanel;

//For time controlling
float previousTime;

//Background image
PImage backgroundImage;

//For choosing between simulations
interface Modes {
  int
    A = 0, 
    B = 1, 
    C = 2, 
    D = 3;
}

int currentOption = Modes.A;



void setup() {

  //Frame settings
  size(200, 300);
  surface.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);

  //Render settings
  background(255, 255, 255);
  surface.setLocation(500, 0);

  //Initial conditions for A Mode
  //Intiall position, initial Speed
  earth = new Earth(new PVector(), new PVector());
  satellite = new Satellite(new PVector(INITIAL_POSITION_X, INITIAL_POSITION_Y), new PVector(INITIAL_SPEED_X, INITIAL_SPEED_Y));

  //Gravity and collision managers
  collisionManager = new CollisionManager();
  collisionManager.addCollidable(earth);
  collisionManager.addCollidable(satellite);

  gravityManager = new GravityManager();
  gravityManager.addStatic(earth);
  gravityManager.addMobile(satellite);


  //We set the menu
  menu = new Menu();

  //We set the scrollbarPanel
  scrollbarPanel = new ScrollbarPanel();
}

void draw() {
  
  background(0, 4, 42);
  translate(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);

  checkChangedMode();

  switch(menu.currentOption) {
  case Modes.A:
    drawModeA();
    scrollbarPanel.updateExercisiA();
    scrollbarPanel.displayExercisiA();
    break;

  case Modes.B:
    drawModeB();
    scrollbarPanel.updateMajorAxis();
    scrollbarPanel.displayMajorAxis();
    break;

  case Modes.C:
    drawModeC();
    scrollbarPanel.updateMajorAxis();
    scrollbarPanel.displayMajorAxis();
    break;

  case Modes.D:
    drawModeD();
    break;
  }
  scrollbarPanel.update();
  scrollbarPanel.display();
  menu.update();
  menu.display();
}

void reset() {
  earth.reset();
  satellite.reset();
}

void drawModeA() {
  displayTitle("Exercici A");

  if (satellite.exploding) {
    float currentTime = millis();
    if (currentTime - satellite.timeOfExplosion > 800) {
      reset();
    }
  } else {
    gravityManager.update();

    earth.update();
    satellite.update();

    collisionManager.update();
  }

  earth.display();
  satellite.display();
}

void drawModeB() {
  displayTitle("Exercici B");

  if (satellite.exploding) {
    float currentTime = millis();
    if (currentTime - satellite.timeOfExplosion > 800) {
      reset();
    }
  } else {
    gravityManager.update();
    earth.update();
    satellite.update();
    collisionManager.update();
  }

  earth.display();
  satellite.display();
  satellite.displayOrbitParams();
}

void drawModeC() {
  displayTitle("Exercici C");

  if (satellite.exploding) {
    float currentTime = millis();
    if (currentTime - satellite.timeOfExplosion > 800) {
      reset();
    }
  } else {
    gravityManager.update();
    earth.update();
    satellite.update();
    satellite.updateArea();
    collisionManager.update();
  }

  satellite.displayArea1();
  satellite.displayArea2();
  earth.display();
  satellite.display();
  satellite.displayAreaCalculus();
}

void drawModeD() {
  displayTitle("Exercici D");

  if (satellite.exploding) {
    float currentTime = millis();
    if (currentTime - satellite.timeOfExplosion > 800) {
      reset();
    }
  } else {
    gravityManager.update();

    earth.update();
    satellite.update();

    collisionManager.update();
  }
  earth.display();
  satellite.display();
}

//Checks if the user has changedd between modes in order to reset the simulations
public void checkChangedMode() {
  if (menu.currentOption != currentOption || menu.optionClicked()) {
    currentOption = menu.currentOption;
    reset();
    if (currentOption == Modes.D) {
      satellite.resetCircularMovement();
    }
    if (currentOption == Modes.B || currentOption == Modes.C) {
      satellite.resetOrbitalMovement();
    }
  }
}

public static PVector polar2Cartesian(PVector polar) {
  PVector cartesian = new PVector();
  cartesian.x = polar.x * cos(polar.y);
  cartesian.y = polar.x * sin(polar.y);
  return cartesian;
}

public static PVector cartesian2Polar(PVector cartesian) {
  PVector polar = new PVector();
  polar.x = cartesian.mag();
  polar.y = atan2(cartesian.y, cartesian.x);
  return polar;
}

//Warns the other classes that an other key has been pressed
void keyPressed() {
  satellite.keyPressed();
}

//Displays an upper left title depending on the simulation.
void displayTitle(String title) {
  textSize(50);
  fill(150);
  text(title, -SCREEN_WIDTH/2+140, -SCREEN_HEIGHT/2+30);
}
