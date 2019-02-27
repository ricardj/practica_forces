class Earth extends Mover{
  
  private PImage image;
  
  public Earth(PVector initialPosition, PVector initialSpeed){
    super(initialPosition, initialSpeed);
    radius = 30;
    mass = 3200;
    
    image = loadImage("Earth.png");
  }
  
  public void display(){

    //PVector cartesianPosition = polar2Cartesian(position);
    image(image,position.x-radius, -(position.y+radius), radius*2, radius*2); 
  }
  
  public void update(){
     super.update();
  } 
}
