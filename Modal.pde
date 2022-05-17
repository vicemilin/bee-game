public abstract class Modal{
  float x, y;
  int width, height;
  
  PGraphics graphics;
  int alpha;
  
  Level level;
  
  public Modal(float x, float y, int w, int h, Level l){
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.graphics = createGraphics(w, h, P2D);
    this.level = l;
    this.alpha = 0;
  }
  
  void updatePosition(){
    if(this.alpha < 250){
      this.alpha += 2;
    }
  }
  
  abstract void reset();
  
  abstract void update();
  
  abstract void draw();
}
