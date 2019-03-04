class CollisionManager {

  public ArrayList<Mover> collidables;      //Array that includes all the elements that can collide   

  private float collisionPadding = 20;      //Little offset for better collision detection

  public CollisionManager() {
    collidables = new ArrayList<Mover>();
  }


  public void update() {
    //Check if anybody is collided, and if so, activate the collision function
    for (int i = 0; i < collidables.size(); i++) {
      for (int j = i+1; j < collidables.size(); j++) {
        //Check collision
        Mover a = collidables.get(i);
        Mover b = collidables.get(j);

        float distance = PVector.sub(a.position, b.position).mag();
        distance+=collisionPadding;
        float radius_sum = a.radius + b.radius;

        if (distance <= radius_sum) {
          a.onCollision();
          b.onCollision();
        }
      }
    }
  }

  //Append the collidable to the array
  public void addCollidable(Mover newCollidable) {
    collidables.add(newCollidable);
  }
}
