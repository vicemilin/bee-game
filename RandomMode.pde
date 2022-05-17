public class RandomLevel extends Level{
  public RandomLevel(){
    super();
  }
  
  int getRandomInt(int min, int max){
    return (int)(Math.random() * ((max - min) + 1)) + min;
  }
  
  void addRandomFlower(int minX, int minY, int maxX, int maxY){
    int x, y, w, h;
    
    x = getRandomInt(minX, maxX);
    y = getRandomInt(minY, maxY);
    h = (int)gameHeight/8;
    w = h;
    
    this.addFlower(new Flower(x, y, w, h));
    
  }
  
  void addRandomRock(int minX, int maxX){
    int x, w, h;
    
    x = getRandomInt(minX, maxX); 
    h = getRandomInt((int)gameHeight/5, (int)gameHeight/2);
    w = h/2;
    
    this.addRock(new Rock(x, w, h));
    
  }
  
  void addRandomSpider(int minX, int maxX){
    int x, w, h;
    
    x = getRandomInt(minX, maxX); 
    h = getRandomInt((int)gameHeight/5, (int)gameHeight/2);
    w = h/2;
    
    this.addSpider(new Spider(x, w, h));
  }
  
  void addRandomObjects(){
    int maxObjects = 5;
    
    int randomRocks = 0;
    int randomSpiders = 0;
    int randomFlowers = 0;
    
    randomFlowers = getRandomInt(0, maxObjects);
    maxObjects -= randomFlowers;
    
    randomRocks = getRandomInt(0, maxObjects);
    maxObjects -= randomRocks;
    
    randomSpiders = getRandomInt(0, maxObjects);
    maxObjects -= randomSpiders;
    
    for(int i = 0; i < randomFlowers; i++){
    }
  }
  
  @Override
  void update(){
    if(this.isStopped){
      this.updateBackground();
      return;
    }

    this.xPosition += this.speed;
    this.updateObjects();

    if(this.checkDeaths()){
      this.gameOver = true;
      this.isStopped = true;
      this.bee.isStopped = true;
    }

    int flowerIndex = this.checkFlowers();

    if(flowerIndex > -1){
      this.flowers.remove(flowerIndex);
    }
  }
  
  /*@Override
  void draw(){
    this.update();
    this.drawBackground();
    //this.drawGround();
    this.drawObjects();
    this.drawFlowersLeft();
    
    if(this.gameOver){
      this.deathModal.draw();
    }

  }*/
}
