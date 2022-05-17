public class TextButton extends Button{
  color backgroundColor, textColor;
  String text;
  PFont font;
  
  
  public TextButton(float x, float y, int w, int h, color bg, String text, color t, PFont font){
    super(x, y, w, h);
    this.backgroundColor = bg;
    this.text = text;
    this.textColor = t;
    this.font = font;
  }
  
  void draw(){
    this.graphics.beginDraw();
    
    this.graphics.noStroke();
    this.graphics.fill(this.backgroundColor);
    this.graphics.rect(0, 0, this.width, this.height, this.height/10);

    this.graphics.textFont(this.font);

    this.graphics.textSize(this.height/4);
    this.graphics.fill(this.textColor);
    this.graphics.textAlign(CENTER, CENTER);
    this.graphics.text(this.text, 0, 0, this.width, this.height);
    
    this.graphics.endDraw();
    
    image(this.graphics, this.x, this.y);
  }
}
