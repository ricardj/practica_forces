class Menu{
 
  public int MENU_HEIGHT = 100;
  private Option[] options;
  
  public int currentOption = 0;
  
  public Menu(){
    options = new Option[4];
    options[0] = new Option("Exercici A");
    options[1] = new Option("Exercici B");
    options[2] = new Option("Exercici C");
    options[3] = new Option("Exercici D");
    
    float cellWidth = SCREEN_WIDTH / options.length;
    float cellHeight = MENU_HEIGHT; 
    
    for(int i = 0 ; i < options.length; i++){
      options[i].position.set(cellWidth*i+(cellWidth-Option.OPTION_WIDTH)/2
                              ,(SCREEN_HEIGHT-MENU_HEIGHT/2)-(Option.OPTION_HEIGHT)/2);
    }
    
  }
  
  public void display(){
    translate(-SCREEN_WIDTH/2,-SCREEN_HEIGHT/2);
    fill(230);
    rect(0,SCREEN_HEIGHT-MENU_HEIGHT, SCREEN_WIDTH,MENU_HEIGHT);
    for(int i = 0; i < options.length; i++) options[i].display();
  }
  
  public void update(){
    for(int i = 0; i < options.length; i++){
      options[i].update();
      if(mousePressed && options[i].mouseOver) currentOption = i;
    }
  }
  
  
}
