import cassette.audiofiles.SoundFile;

public class Level{
  float speed = 2;
  float endPosition = 1600;
  
  Bee bee;
  
  ArrayList<Rock> rocks, originalRocks;
  ArrayList<Spider> spiders, originalSpiders;
  ArrayList<Flower> flowers, originalFlowers;
  
  float backgroundX1 = 0; 
  float backgroundX2 = gameWidth;
  
  float xPosition;
  
  Beehive beehive;
  
  boolean gameOver = false;
  boolean isStopped = false;
  boolean levelFinished = false;
  
  DeathModal deathModal;
  
  PGraphics graphics;
  
  public Level(){
     this.rocks = new ArrayList<Rock>();
     this.originalRocks = new ArrayList<Rock>();
     
     this.flowers = new ArrayList<Flower>();
     this.originalFlowers = new ArrayList<Flower>();
     
     this.spiders = new ArrayList<Spider>();
     this.originalSpiders = new ArrayList<Spider>();
     
     this.bee = new Bee(gameWidth/15, gameHeight/10, (int)(gameWidth/15), (int)(gameWidth/15 * 0.82));
     this.beehive = new Beehive(this.endPosition, (int)gameHeight/3, (int)gameHeight/3);
     this.xPosition = 0;
     
     this.deathModal = new DeathModal(gameWidth/2.0 - gameWidth/10, gameHeight/2.0 - gameHeight/6.0, (int)(gameWidth/5.0), (int)(gameHeight/3.0), this);
     
     this.graphics = createGraphics((int)gameWidth, (int)gameHeight);
     //this.graphics = createGraphics(800,400);
  }
  
  void addRock(Rock r){
    this.rocks.add(r);
    this.originalRocks.add(rockFromJsonString(r.toJsonString()));
  }
  
  void addFlower(Flower f){
    this.flowers.add(f);
    this.originalFlowers.add(flowerFromJsonString(f.toJsonString()));
  }
  
  void addSpider(Spider s){
    this.spiders.add(s);
    this.originalSpiders.add(spiderFromJsonString(s.toJsonString()));
  }
  
  void initSpeeds(){
    for(Rock r : this.rocks){
      r.scrollSpeed = this.speed;
    }
    
    for(Spider s : this.spiders){
      s.scrollSpeed = this.speed;
    }
    
    for(Flower f : this.flowers){
      f.scrollSpeed = this.speed;
    }
    
    this.beehive.scrollSpeed = this.speed;
  }
  
  boolean isObjectVisible(float objectXPosition){
    if(objectXPosition < 1.3 * gameWidth && objectXPosition > -0.5*gameWidth){
      return true;
    }
    return false;
  }
  
  void drawObjects(){
    for(Rock r : this.rocks){
      if(this.isObjectVisible(r.x)){
        r.draw(this.graphics);
      }
    }

    for(Flower f : this.flowers){
      if(this.isObjectVisible(f.x)){
        f.draw(this.graphics);
      }
    }
    
    for(Spider s : this.spiders){
      if(this.isObjectVisible(s.x)){
        s.draw(this.graphics);
      }
    }

    this.bee.draw(this.graphics);

    if(this.isObjectVisible(this.beehive.x)){
      this.beehive.draw(this.graphics);
    }
  }
  
  void updateObjects(){
    for(Rock r : this.rocks){
      r.update();
    }
    
    for(Flower f : this.flowers){
      f.update();
    }
    
    for(Spider s : this.spiders){
      s.update();
    }
    if(!this.bee.isStopped){      
      this.bee.update();
    }
    
    this.beehive.update();
  }
  
  boolean checkDeaths(){
    for(Rock r : this.rocks){
      if(this.isObjectVisible(r.x)){
        if(r.checkCollisionWithBee(this.bee)) return true;
      }
    }
    
    for(Spider s : this.spiders){
      if(this.isObjectVisible(s.x)){
        if(s.checkCollisionWithBee(this.bee)) return true;
      }
    }
    
    return false;
  }
  
  int checkFlowers(){
    for(int i = 0; i < this.flowers.size(); i++){
      if(this.isObjectVisible(this.flowers.get(i).x)){
        if(this.flowers.get(i).checkCollisionWithBee(this.bee)) return i;
      }
    }
    
    return -1;
  }
  
  boolean checkEnd(){
    return this.xPosition > this.endPosition;
  }
  
  void updateBackground(){
    this.backgroundX1 -= this.speed/10;
    this.backgroundX2 -= this.speed/10;
  
    if (this.backgroundX1 <= -width){
      this.backgroundX1 = 0;
      this.backgroundX2 = gameWidth;
    }
  }
  
  void drawBackground(){
    this.graphics.image(backgroundImage, this.backgroundX1, 0, gameWidth, gameHeight);
    this.graphics.image(backgroundImage, this.backgroundX2, 0, gameWidth, gameHeight);
  }
  
  void drawFlowersLeft(){
    String t = this.originalFlowers.size() - this.flowers.size() + "/" + this.originalFlowers.size();
    this.graphics.image(flowerImage, gameWidth - gameWidth/6, 10, gameWidth/20, gameWidth/20);
    this.graphics.textFont(digoryFont);
    this.graphics.textSize(gameHeight/30);
    this.graphics.fill(0);
    this.graphics.textAlign(CENTER, CENTER);
    this.graphics.text(t, gameWidth - gameWidth/15, gameHeight/15);
  }
  
  void resetObjects(){
    this.rocks = new ArrayList<Rock>();
    for(Rock r : this.originalRocks){
      this.rocks.add(rockFromJsonString(r.toJsonString()));
    }
    
    this.flowers = new ArrayList<Flower>();
    for(Flower f : this.originalFlowers){
      this.flowers.add(flowerFromJsonString(f.toJsonString()));
    }
    
    this.spiders = new ArrayList<Spider>();
    for(Spider s : this.originalSpiders){
      this.spiders.add(spiderFromJsonString(s.toJsonString()));
    }
    
    this.bee = new Bee(gameWidth/15, gameHeight/10, (int)(gameWidth/15), (int)(gameWidth/15 * 0.82));
    this.beehive = new Beehive(this.endPosition, (int)gameHeight/3, (int)gameHeight/3);
    this.initSpeeds();
  }
  
  int getFlowersCollected(){
    return this.originalFlowers.size() - this.flowers.size();
  }
  
  void reset(){
    this.resetObjects();
    //backgroundMusic.stop();
    //backgroundMusic.play();
    
    this.gameOver = false;
    this.isStopped = false;
    this.levelFinished = false;
    this.bee.isStopped = false;
    this.xPosition = 0;
  }
  
  void update(){
    if(this.checkEnd() && this.levelFinished == false){
      this.levelFinished = true;
      this.bee.isStopped = true;
    }
    
    if(this.isStopped){
      //this.updateBackground();
      return;
    }
    
    this.updateBackground();
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
  
  void draw(){
    this.update();
    this.graphics.beginDraw();
    this.drawBackground();
    //this.drawGround();
    this.drawObjects();
    this.drawFlowersLeft();
    this.graphics.endDraw();
    
    if(this.gameOver){
      this.deathModal.draw();
    }

  }
}
