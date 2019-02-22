class CollisionManager{
    
    public ArrayList<Mover> collidables;  
  
    public CollisionManager(){
      collidables = new ArrayList<Mover>();
    }
    
    
    
    
    public void update(){
       //Check if anybody is collided, and if so, activate the collision func
       for(int i = 0; i < collidables.size(); i++){
         for(int j = i+1; j < collidables.size();j++){
            //Check collision
            Mover a = collidables.get(i);
            Mover b = collidables.get(j);
            
            float distance = abs(a.position.x-b.position.x);
            float radius_sum = a.radius + b.radius;
          
            if(distance <= radius_sum){
              a.onCollision();
              b.onCollision();
            }
         }
       }
    }
    
    public void addCollidable(Mover newCollidable){
      //Append the collidable to the array
      collidables.add(newCollidable);
    }
}
