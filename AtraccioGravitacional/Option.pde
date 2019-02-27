class Option{
  
  
  public static final int OPTION_HEIGHT = 60;
  public static final int OPTION_WIDTH = 120;
  
  public String title;
  public PVector position;
  
  private boolean mouseOver = false;
  
  public Option(String title){
    this.title = title;
    position = new PVector();
  }
  
  public void display(){
    if(mouseOver) fill(210);
    else fill(240);
    rect(position.x, position.y, OPTION_WIDTH, OPTION_HEIGHT);
    fill(0);
    textSize(20);
    textAlign(CENTER,CENTER);
    text(title,position.x+OPTION_WIDTH/2,position.y+OPTION_HEIGHT/2);
  }
  
  public void update(){
    if(mouseX > position.x && mouseY > position.y && mouseX < position.x + OPTION_WIDTH && mouseY < position.y + OPTION_HEIGHT ){
      mouseOver = true;
    }else{
       mouseOver = false; 
    }
  }
  
}
