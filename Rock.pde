public class Rock extends Obstacle{
  PVector[] hitbox;
  
  public Rock(float x, int w, int h){
    super(x, gameHeight - h + h/10, w, h);
    
    this.image = rockImage;
    ;this.graphics = createGraphics(w, h, P2D);
    
    this.hitbox = new PVector[6];
    
    this.updateHitbox();
  }
  
  void updateHitbox(){
    this.hitbox[0] = new PVector(this.x + this.width/4, this.y);
    this.hitbox[1] = new PVector(this.x, this.y + this.height / 2);
    this.hitbox[2] = new PVector(this.x, this.y + this.height);
    this.hitbox[3] = new PVector(this.x + this.width - this.width/10, this.y + this.height);
    this.hitbox[4] = new PVector(this.x + this.width - this.width/10, this.y + this.height/2);
    this.hitbox[5] = new PVector(this.x + this.width/4, this.y);
  }
  
  String toJsonString(){
    String s = "{\"type\":\"rock\",\n";
    s += "\"x\": " + (this.x / gameWidth) + ",\n"; 
    s += "\"y\": " + (this.y / gameHeight) + ",\n";
    s += "\"width\": " + (this.width / gameWidth) + ",\n"; 
    s += "\"height\": " + (this.height / gameHeight); 
    s += "}";
    return s;
  }
  
  void drawHitbox_DEBUG(){
    stroke(0,255,255);
    strokeWeight(2);
    for(int i = 0; i < this.hitbox.length - 1; i++){
      line(this.hitbox[i].x, this.hitbox[i].y, this.hitbox[i + 1].x, this.hitbox[i + 1].y);
    }
  }
  
  boolean checkCollisionWithBee(Bee b){
    return collideCirclePoly(b.x + b.width/2, b.y + b.height/2, b.height, this.hitbox);
  }
  
  void update(){
    this.move();
    this.updateHitbox();
  }
  
  void draw(PGraphics g){
    this.graphics.beginDraw();
    this.graphics.image(this.image, 0, 0, this.width, this.height);
    this.graphics.endDraw();
    
    g.image(this.graphics,this.x,this.y);
  }
}
