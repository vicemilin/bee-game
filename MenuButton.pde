public class MenuButton{
  float x, y;
  int radius;
  PGraphics graphics;

  public MenuButton(float x, float y, int r){
    this.x = x;
    this.y = y;
    this.radius = r;
    this.graphics = createGraphics(r, r, P2D); 
  }

  boolean isPressed(){
      if(collidePointCircle(mouseX, mouseY, this.x, this.y, this.radius)){
        return true;
    }
    return false;
  }
  
  void draw(){

  }
}
