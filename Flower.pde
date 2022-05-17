public class Flower extends Obstacle{
  float rotationSpeed, angle; 
  
  public Flower(float x, float y, int w, int h){
    super(x, y, w, h);
    this.image = flowerImage;
    
    this.graphics = createGraphics(w, h, P2D);
    
    this.rotationSpeed = PI/120;
    this.angle = 0;
  }
  
  String toJsonString(){
    String s = "{\"type\":\"flower\",\n";
    s += "\"x\": " + (this.x / gameWidth) + ",\n"; 
    s += "\"y\": " + (this.y / gameHeight) + ",\n";
    s += "\"width\": " + (this.width / gameWidth) + ",\n"; 
    s += "\"height\": " + (this.height / gameHeight); 
    s += "}";
    return s;
  }
  
  boolean checkCollisionWithBee(Bee b){
    return collideCircleCircle(b.x + b.width/2, b.y + b.height/2, b.height, this.x + this.height/2, this.y + this.height/2, this.height);
  }
  
  void drawHitbox_DEBUG(){
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(this.x + this.width/2, this.y + this.height/2, this.height, this.height);
  }
  
  void update(){
    this.move();
    this.angle += this.rotationSpeed;
  }
  
  void draw(PGraphics g){
    this.graphics.beginDraw();
    
    this.graphics.clear();
    
    //Rotate
    this.graphics.pushMatrix();
    this.graphics.translate(this.width/2, this.height/2);
    this.graphics.rotate(this.angle);
    this.graphics.image(this.image,-this.width/2,-this.height/2, this.width, this.height);
    this.graphics.popMatrix();
    
    this.graphics.endDraw();
    
    g.image(this.graphics, this.x, this.y);
  }
}
