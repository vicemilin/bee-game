public class DeathModal extends Modal{
  public DeathModal(float x, float y, int w, int h, Level l){
    super(x, y, w, h, l);
  }
  
  void reset(){
    this.alpha = 0;
  }
 
  void update(){
    this.updatePosition();
  }
  
  boolean pressed(){
      if(collidePointRect(mouseX, mouseY, this.x, this.y, this.width, this.height)){
        return true;
    }
    return false;
  }
  
  void draw(){
    if (mousePressed){
        if(pressed()){
          this.level.reset();
          this.reset();
          return;
        }
    }
    
    //this.update();
    this.graphics.beginDraw();
    
    this.graphics.noStroke();
    this.graphics.fill(255,115,180);
    this.graphics.rect(0, 0, this.width, this.height, 20);
    
    this.graphics.textFont(racingSansFont);
    
    this.graphics.textSize(this.height/7);
    this.graphics.fill(0,0,255);
    this.graphics.textAlign(CENTER);
    this.graphics.text("GAME OVER!", 0, this.height/3, this.width, this.height/3);
    
    this.graphics.textSize(this.height/9);
    this.graphics.fill(66, 244, 140);
    this.graphics.textAlign(CENTER);
    this.graphics.text("Tap to try again.", 0, 2 * this.height/3, this.width, 2 * this.height/3);
    
    this.graphics.endDraw();
    
    image(this.graphics, this.x, this.y);
  }
}
