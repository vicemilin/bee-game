public class Game{
  String[] levels = new String[] {
    "level0.json",
    "level1.json",
    "level2.json",
    "level3.json",
    "level4.json",
    "level5.json",
    "level6.json",
    "level7.json",
    "level8.json",
    "level9.json",
    "level11.json",
    "level12.json",
    "level13.json",
    "level14.json",
    "level15.json",
    "level16.json",
    "level17.json",
    "level18.json",
    "level19.json",
    "level20.json",
      "level0.json",
    "level1.json",
    "level2.json",
    "level3.json",
    "level4.json",
    "level5.json",
    "level6.json",
    "level7.json",
    "level8.json",
    "level9.json",
    "level11.json",
    "level12.json",
    "level13.json",
    "level14.json",
    "level15.json",
    "level16.json",
    "level17.json",
    "level18.json",
    "level19.json",
    "level20.json"
  };

  int currentLevel = 11;

  Level level;
  FinishedModal finishedModal;
  MainMenu mainMenu;
  GameMenu gameMenu;
  
  
  public Game(){
    this.level = levelFromJsonFile(levels[currentLevel]);
    this.finishedModal = new FinishedModal(gameWidth/2.0 - gameWidth/8, 0.1 * gameHeight, (int)(gameWidth/4), (int)(0.9 * gameHeight), this.level);
    this.mainMenu = new MainMenu();
    this.gameMenu = new GameMenu();
  }

  void goToNextLevel(){
    this.currentLevel++;
    this.level = levelFromJsonFile(levels[currentLevel]);
    this.level.reset();
  }
  
  void goToLevel(int i){
    this.currentLevel = i;
    this.level = levelFromJsonFile(levels[currentLevel]);
    backgroundMusic.loop();
    this.level.reset();
    this.finishedModal.reset();
  }

  void drawFrameRate_DEBUG(){
    fill(255);
    textSize(30);
    text(frameRate, gameWidth-50, 50);
  } 

  void touchStarted(){
    this.level.bee.up();
    jumpSound.play();
  }
  
  void drawHitoboxes_DEBUG(){
    for(Spider s: level.spiders){
      s.drawHitbox_DEBUG();
    }
    
    for(Rock r: level.rocks){
      r.drawHitbox_DEBUG();
    }
    
    for(Flower f: level.flowers){
      f.drawHitbox_DEBUG();
    }
    
    level.bee.drawHitbox_DEBUG();
    
  }

  void draw(){
    background(255);
    //if(mode > 1){
      this.level.draw();
      image(this.level.graphics, 0, 0, width, height);
      //drawFrameRate_DEBUG();
      println(frameRate);
      
      if(this.level.levelFinished){
        finishedModal.draw();
      }
    /*}
    
    if(mode == 0){
      mainMenu.draw();
      return;
    }
    
    if(mode == 1){
      gameMenu.draw();
      return;
    }*/
    //this.drawHitoboxes_DEBUG();
  }
}
