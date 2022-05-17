public class Bee{
  float x, y;
  int width, height;
  
  float gravity = 0.7;
  float lift = -12.0/400.0 * (float)gameHeight;
  PImage image;
  
  float angleMin = -PI/6.0;
  float angleMax = PI/2.0;
  
  float angle = 0;
  float velocity = 0;
  
  float velocityMin = (-12.0/400.0)*(float)gameHeight;
  float velocityMax = (20.0/400.0)*(float)gameHeight;
  
  PGraphics graphics;
  
  boolean isStopped;
  
  public Bee(float x, float y, int w, int h){
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    
    this.image = beeImage;
    this.image.resize(w, h);
    this.graphics = createGraphics(this.width, this.width, P2D);
     
    this.isStopped = false;
  }
  
  void updateAngle(){
    if(this.velocity <= this.velocityMin){
      this.angle = this.angleMin;
    }

    if(this.velocity >= this.velocityMax){
      this.angle = this.angleMax;
    }

    this.angle = (this.velocity - this.velocityMin) * (this.angleMax - this.angleMin) / (this.velocityMax-this.velocityMin) + this.angleMin;
   
  }
  
  void up(){
    this.velocity += this.lift;
  }
  
  void update(){
    this.velocity += this.gravity;
    this.velocity *= 0.98;
    this.y += this.velocity;
    
    if (this.y >= gameHeight - gameWidth/80 - this.height){
      this.y = gameHeight - gameWidth/80 - this.height;
      this.velocity = 0;
    }
    
    if (this.y <= 0 - this.height/2) {
      this.y = - this.height/2;
      this.velocity = 0;
    }
    
    this.updateAngle();
  }
  
  void drawHitbox_DEBUG(){
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(this.x + this.width/2, this.y + this.height/2, this.height, this.height);
  }
  
  void draw(PGraphics g){
    if(!this.isStopped){
      this.update();
    }
    this.graphics.beginDraw();
    this.graphics.clear();
    
    this.graphics.pushMatrix();

    this.graphics.translate(this.graphics.width/2.0, this.graphics.height/2.0);
    this.graphics.rotate(this.angle);
    this.graphics.image(this.image, -this.image.width/2.0, -this.image.height/2.0);
    
    this.graphics.popMatrix();
     
    this.graphics.endDraw();

    g.image(this.graphics, this.x, this.y);
  }
}
