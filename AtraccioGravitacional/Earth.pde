class Earth extends Mover{
  
  private PImage image;
  
  public Earth(PVector initialPosition, PVector initialSpeed){
    super(initialPosition, initialSpeed);
    radius = 30;
    mass = 400;
    
    image = loadImage("Earth.png");
  }
  
  public void display(){

    PVector cartesianPosition = polar2Cartesian(position);
    image(image,cartesianPosition.x-radius, -(cartesianPosition.y+radius), radius*2, radius*2); 
  }
  
  public void update(){
     super.update();
  } 
}
