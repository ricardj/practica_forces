class ScrollbarPanel {

  private Scrollbar speed_x_m1;
  private Scrollbar speed_y_m1;
  private Scrollbar speed_x_m2;
  private Scrollbar speed_y_m2;

  public ScrollbarPanel() {
    float scrollbarSeparation = 40;
    float scrollbarGroupSeparation = 200;
    speed_x_m1 = new Scrollbar(600, -500, 100, 16, 1);
    speed_y_m1 = new Scrollbar(600, -500+scrollbarSeparation, 100, 16, 1);

    speed_x_m2 = new Scrollbar(600, -500+scrollbarGroupSeparation, 100, 16, 1);
    speed_y_m2 = new Scrollbar(600, -500+scrollbarSeparation+scrollbarGroupSeparation, 100, 16, 1);
  }

  public void update() {
    speed_x_m1.update();
    speed_y_m1.update();
    speed_x_m2.update();
    speed_y_m2.update();
  }

  public void display() {
    textSize(20);
    fill(0, 0, 255);
    text("Blue ball speed", speed_x_m1.xpos, speed_x_m1.ypos-40);
    speed_x_m1.display();
    speed_y_m1.display();

    textSize(20);
    fill(255, 0, 0);
    text("Red ball speed", speed_x_m2.xpos, speed_x_m2.ypos-40);
    speed_x_m2.display();
    speed_y_m2.display();
  }

  public PVector getSpeedM1() {
    return new PVector(speed_x_m1.getPos(), speed_y_m1.getPos());
  }
  public PVector getSpeedM2() {
    return new PVector(speed_x_m2.getPos(), speed_y_m2.getPos());
  }
}
