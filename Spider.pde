public class Spider extends Obstacle{
  PVector[] hitbox;
  int frameCount = 0;
  
  float omega, maxAngleSpeed, angle;
  
  public Spider(float x, int w, int h){
    super(x, 0, w, h);
    
    this.image = spiderImage;
    this.graphics = createGraphics(2 * w, h + 20, P2D);
    
    this.hitbox = new PVector[7];
    
    this.maxAngleSpeed = PI/60;
    this.omega = PI/60;
    this.angle = 0.0;
  }
  
  String toJsonString(){
    String s = "{\"type\":\"spider\",\n";
    s += "\"x\": " + (this.x / gameWidth) + ",\n"; 
    s += "\"y\": " + (this.y / gameHeight) + ",\n";
    s += "\"width\": " + (this.width / gameWidth) + ",\n"; 
    s += "\"height\": " + (this.height / gameHeight) + ",\n"; 
    s += "\"maxAngleSpeed\": " + this.maxAngleSpeed + ",\n"; 
    s += "\"omega\": " + this.omega; 
    s += "}";
    return s;
  }
  
  void updateHitbox(){
    float angleSin = sin(this.angle);
    float angleCos = cos(this.angle);
    
    float spPosX = this.x - this.width * angleSin;
    float spPosY = this.y + this.height * angleCos - this.height/6;
    
    this.hitbox[0] = new PVector(this.x, 0);
    this.hitbox[1] = new PVector(spPosX, spPosY);
    this.hitbox[2] = new PVector(spPosX + this.width/4, spPosY);
    this.hitbox[3] = new PVector(spPosX + this.width/4, spPosY - this.height/3);
    this.hitbox[4] = new PVector(spPosX - this.width/4, spPosY - this.height/3);
    this.hitbox[5] = new PVector(spPosX - this.width/4, spPosY);
    this.hitbox[6] = new PVector(spPosX, spPosY);
  }
 
  boolean checkCollisionWithBee(Bee b){ 
    return collideCirclePoly(b.x + b.width/2, b.y + b.height/2, b.height, this.hitbox);
  }
  
  void drawHitbox_DEBUG(){
    stroke(0,255,255);
    strokeWeight(2);
    for(int i = 0; i < this.hitbox.length - 1; i++){
      line(this.hitbox[i].x, this.hitbox[i].y, this.hitbox[i + 1].x, this.hitbox[i + 1].y);
    }
  }
  
  void update(){
    this.move();
    this.frameCount++;
    float angleSpeed = this.maxAngleSpeed * cos(this.omega * this.frameCount);
    this.angle += angleSpeed;
    this.updateHitbox();
  }
  
  void draw(PGraphics g){
    this.graphics.beginDraw();
    
    this.graphics.clear();
    
    //Rotate
    this.graphics.pushMatrix();
    this.graphics.translate(this.width, 0);
    this.graphics.rotate(this.angle);
    this.graphics.image(this.image, -this.width/2, 0, this.width, this.height);
    this.graphics.popMatrix();
    
    this.graphics.endDraw();

    g.image(this.graphics, this.x - this.width, this.y);
  }
}
