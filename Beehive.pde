public class Beehive extends Obstacle{
  public Beehive(float x, int w, int h){
    super(x, gameHeight - h - groundImage.height/4, w, h);
    this.image = beehiveImage;
    this.image.resize(this.width, this.height);
    this.graphics = createGraphics(w, h, P2D);
  }
  
  boolean checkCollisionWithBee(Bee bee){
    return (bee.x >= this.x);
  }
  
  
  void update(){
    this.move();
  }
  
  void draw(PGraphics g){
    this.graphics.beginDraw();
    this.graphics.image(this.image,0,0);
    this.graphics.endDraw();
    g.image(this.graphics,this.x,this.y);
  }
}
