class ScrollbarPanel {


  private Scrollbar scrollbarPositionX;
  private Scrollbar scrollbarPositionY;
  private Scrollbar scrollbarMajorAxis;
  private Scrollbar scrollbarSpeedX;
  private Scrollbar scrollbarSpeedY;


  public ScrollbarPanel() {
    float verticalOffset = 50;
    int scrollbarHeight = 13;
    scrollbarPositionX = new Scrollbar(-SCREEN_WIDTH/3-60, -SCREEN_HEIGHT/3, 200, scrollbarHeight, 1);
    scrollbarPositionY = new Scrollbar(-SCREEN_WIDTH/3-60, -SCREEN_HEIGHT/3+verticalOffset, 200, scrollbarHeight, 1);
    scrollbarMajorAxis = new Scrollbar(-SCREEN_WIDTH/3-60, -SCREEN_HEIGHT/3+verticalOffset*2, 200, scrollbarHeight, 1);
    
    scrollbarPositionX.title = "Posicio inicial X"; 
    scrollbarPositionY.title = "Posicio incial Y";
    scrollbarMajorAxis.title = "Semi eix major";
    
    scrollbarPositionX.setPos(150);
    scrollbarPositionY.setPos(150);
    scrollbarMajorAxis.setPos(150);
    
  }

  public void update() {
    scrollbarPositionX.update();
    INITIAL_POSITION_X = scrollbarPositionX.getPos();

    scrollbarPositionY.update();
    INITIAL_POSITION_Y = scrollbarPositionY.getPos();

    scrollbarMajorAxis.update();
    INITIAL_MAJOR_AXIS = scrollbarMajorAxis.getPos();
  }

  public void display() {
    scrollbarPositionX.display();
    scrollbarPositionY.display();
    scrollbarMajorAxis.display();
  }
}
