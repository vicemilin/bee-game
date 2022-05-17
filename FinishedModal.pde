class FinishedModal extends Modal{
  TextButton nextLevelButton, playAgainButton;
  
  String flowersLeft;
  PImage fImage;
  
  public FinishedModal(float x, float y, int w, int h, Level l){
    super(x, y, w, h, l);
    //this.flowersLeft = this.level.originalFlowers.size() - this.level.flowers.size() + "/" + this.level.originalFlowers.size();
    this.fImage = flowerImage.get();
    this.fImage.resize(this.width/6, this.width/6);
    
    this.nextLevelButton = new TextButton(
      this.x + this.width/4, this.y + 0.75 * this.height, this.width/2, this.height/10, color(127, 248, 255),
      "Next Level", color(127, 7, 0), digoryFont
    );
    
    this.playAgainButton = new TextButton(
      this.x + this.width/4, this.y + 0.75 * this.height + this.height/8, this.width/2, this.height/10, color(127, 248, 255),
      "Play Again", color(127, 7, 0), digoryFont
    );
   
  }
  
  void reset(){
   this.level = game.level;
    this.alpha = 0;
  }
  
  void update(){
    this.updatePosition();
  }
  
  
  void draw(){
    if (mousePressed){
      if(this.nextLevelButton.isPressed()){
        int f = 0;
        JSONArray l = loadUserJsonData();
        if(l != null)
        {
          if(game.currentLevel < l.size()){
            JSONObject j = l.getJSONObject(game.currentLevel);
            if(j != null){
              f = j.getInt("flowers");
            }
          }
        }
        
        int fc = this.level.getFlowersCollected();
        if(fc >= f){
          writeUserJsonData(game.currentLevel, this.level.getFlowersCollected(), this.level.originalFlowers.size());
        }
        game.goToNextLevel();
        this.reset();
        return;
      }

      if(this.playAgainButton.isPressed()){
        int f = 0;
        JSONArray l = loadUserJsonData();
        if(l != null)
        {
          if(game.currentLevel < l.size()){
            JSONObject j = l.getJSONObject(game.currentLevel);
            if(j != null){
              f = j.getInt("flowers");
            }
          }
        }
        
        int fc = this.level.getFlowersCollected();
        if(fc >= f){
          writeUserJsonData(game.currentLevel, this.level.getFlowersCollected(), this.level.originalFlowers.size());
        }
        this.level.reset();
        this.reset();
        return;
      }
    }
    
    this.graphics.beginDraw();
    
    this.graphics.noStroke();
    this.graphics.fill(66, 140, 244);
    this.graphics.rect(0, 0, this.width, this.height, 20);

    this.graphics.textFont(digoryFont);
    this.graphics.textSize(this.width/15); 
    this.graphics.fill(246, 255, 127, this.alpha);
    this.graphics.textAlign(CENTER);
    this.graphics.text("Congratulations!", 0, this.y + this.height/4, this.width, this.y + this.height/5);
    
    //Draw flowers left
    this.flowersLeft = this.level.getFlowersCollected() + "/" + this.level.originalFlowers.size();
    this.graphics.image(this.fImage, this.width/4.0, this.height/2.0, this.width/4, this.width/4);
    this.graphics.textSize(this.width/15);
    this.graphics.fill(0,0,0);
    this.graphics.textAlign(CENTER);
    this.graphics.text(flowersLeft, this.width/2.0 + this.width/6.0 + 10, this.height/2.0 + this.width/6.0);
    
    this.graphics.endDraw();
    
    image(this.graphics, this.x, this.y);
    
    this.nextLevelButton.draw();
    this.playAgainButton.draw();
  }
}
