public class GameMenu{
  PGraphics graphics;
  JSONArray levelData;
  int playedLevels = 0;
  int flowersCollected = 0;
  
  public GameMenu(){
    this.graphics = createGraphics(width, height);
    this.levelData = loadUserJsonData();
  }
  
  void drawFlowersCollected(){
  }
  
  void drawContinue(){
    
  }
  
  void checkContinue(){
    
  }
    
  void drawLevelButton(int i, int j, JSONObject data){
    this.graphics.noStroke();
    //this.graphics.stroke(249, 97, 67);
    //this.graphics.strokeWeight(3);
    this.graphics.fill(67, 249, 249);
    
    this.graphics.rect(width/66.0 + i * (width/12.0 + width/66.0), height / 5 + j * (height/6 + width/50.0), width/12, height/6,10);
    
    if(data == null){
      this.graphics.image(lockImage, width/66.0 + i * (width/12.0 + width/66.0), height / 5 + j * (height/6 + width/50.0), width/12, height/6);
      this.graphics.textFont(digoryFont);
      this.graphics.textSize(gameHeight/30);
      this.graphics.fill(255,0,0);
      this.graphics.textAlign(CENTER, CENTER);
      this.graphics.text((j*10+i + 1) + "", width/66.0 + i * (width/12.0 + width/66.0), height / 5 + j * (height/6 + width/50.0), width/12, height/6);
    }
    else{
      int f = data.getInt("flowers");
      String t = f + "/" + data.getInt("maxFlowers");
      this.flowersCollected += f;
      this.graphics.textFont(digoryFont);
      this.graphics.textSize(gameHeight/30);
      this.graphics.fill(0);
      this.graphics.textAlign(CENTER, CENTER);
      this.graphics.text(t, width/66.0 + i * (width/12.0 + width/66.0), height / 5 + j * (height/6 + width/50.0), width/12, height/6);
    }
  }
  
  void drawLevelButtons(){
    boolean drawnOne = false;
    if(this.levelData != null){
      for(int j = 0; j < this.levelData.size(); j++){
        JSONObject json = this.levelData.getJSONObject(j);
        this.drawLevelButton(j % 10, j / 10, json);
      }
      this.playedLevels = this.levelData.size();
    }
      
    for(int i = playedLevels; i < game.levels.length; i++){
        if(!drawnOne){
          JSONObject json = loadJSONObject(game.levels[i]);
          JSONArray fs = json.getJSONArray("flowers");
          JSONObject flowerData = new JSONObject();
          flowerData.setInt("flowers", 0);
          flowerData.setInt("maxFlowers", fs.size());
          this.drawLevelButton(i % 10, i / 10, flowerData);
          drawnOne = true;
          continue;
        }
        this.drawLevelButton(i % 10, i / 10, null);
    }
  }
  
  int checkLevelButtons(){
    for(int k = 0; k <= this.playedLevels; k++){
      int i = k % 10;
      int j = k / 10;
      if(collidePointRect(mouseX, mouseY, width/66.0 + i * (width/12.0 + width/66.0), height / 5 + j * (height/6 + width/50.0), width/12, height/6)) return k;
    }
    return -1;
  }
  
  void drawBackground(){
    this.graphics.image(backgroundImage, 0, 0, width, height);
  }
  
  void update(){
    
  }
  
  void draw(){
    if(mousePressed){
      int chosenLevel = checkLevelButtons();
      if(chosenLevel >= 0){
        game.goToLevel(chosenLevel);
        mode++;
      }
    }
    
    this.graphics.beginDraw();
    this.graphics.clear();
    
    this.drawBackground();
    this.drawLevelButtons();
    
    this.graphics.endDraw();
    
    image(this.graphics, 0, 0);
  }
}
