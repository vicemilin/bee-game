public abstract class Obstacle{
  float x, y;
  int width, height;
  
  float scrollSpeed;
  
  PImage image;
  PGraphics graphics;
  
  public Obstacle(float x, float y, int w, int h){
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    
    this.scrollSpeed = 2.0;
  }
  
  void setScrollSpeed(float s){
    this.scrollSpeed = s;
  }
  
  void move(){
    this.x -= this.scrollSpeed;
  }
  
  abstract boolean checkCollisionWithBee(Bee b);
  
  abstract void update();
  
  abstract void draw(PGraphics g);
  
}
