public class MainMenu{
  PGraphics graphics;
  public MainMenu(){
    this.graphics = createGraphics(width, height, P2D);
  }

  void update(){
    
  }
  
  void drawButtonPlay(){
    this.graphics.image(buttonPlayImage, width/4 - width/14, height/2, width/7, width/14);
  }
  
  void drawButtonRate(){
    this.graphics.image(buttonRateImage, 0.75*width - width/14, height/2, width/7, width/14);
  }
  
  boolean checkButtonPlay(){
      if(collidePointRect(mouseX, mouseY, width/4 - width/14, height/2, width/7, width/14)){
        return true;
    }
    return false;
  }
  
  boolean checkButtonRate(){
      if(collidePointRect(mouseX, mouseY, 0.75*width - width/14, height/2, width/7, width/14)){
        return true;
    }
    return false;
  }
  
  void drawBackground(){
    this.graphics.image(backgroundImage, 0, 0, width, height);
  }

  void drawTitle(){
    this.graphics.fill(244, 215, 66);
    this.graphics.textFont(chlorinrFont);
    if(gameHeight/7 < 100){
      this.graphics.textSize((int)(gameHeight/7));
    }
    else{
      this.graphics.textSize(100);
    }
    this.graphics.textAlign(CENTER);
    this.graphics.text("Lucky Bee", 0, gameHeight/10, gameWidth, gameHeight/10);
  }

  void draw(){
    if(mode != 0){
      return;
    }
    if(mousePressed){
      if(checkButtonPlay()){
        mode = 1;
        return;
      }
      if(checkButtonRate()){
        link("https://play.google.com/store/apps/details?id=xyz.orbitron.quizzle");
      }
    }
    this.graphics.beginDraw();
    this.graphics.clear();
    
    this.drawBackground();
    this.drawTitle();
    this.drawButtonPlay();
    this.drawButtonRate();
    
    this.graphics.endDraw();
    
    image(this.graphics, 0, 0);
  }
}
