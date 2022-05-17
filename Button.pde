public abstract class Button{
  float x, y;
  int width, height;
  
  PGraphics graphics;
  
  public Button(float x, float y, int w, int h){
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.graphics = createGraphics(w, h, P2D); 
  }

  boolean isPressed(){
      if(collidePointRect(mouseX, mouseY, this.x, this.y, this.width, this.height)){
        return true;
      }
    return false;
  }
  
  abstract void draw();
}
