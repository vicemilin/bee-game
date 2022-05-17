import cassette.audiofiles.SoundFile;

PImage beeImage, rockImage, flowerImage, spiderImage, beehiveImage, backgroundImage, groundImage, buttonPlayImage, buttonRateImage, lockImage;

PFont njNarutoFont, chlorinrFont, digoryFont, gypsyCurseFont, racingSansFont, zombieHolocaustFont;

float fontQuality = 15;

SoundFile jumpSound, deathSound, flowerSound, finishedSound, backgroundMusic;

float gameWidth, gameHeight;

void LoadImages(){
  gameWidth = width;
  gameHeight = height;
  
  beeImage = loadImage("bee.png");
  rockImage = loadImage("rock.png");
  flowerImage = loadImage("flower.png");
  spiderImage = loadImage("spider.png");
  beehiveImage = loadImage("beehive.png");
  backgroundImage = loadImage("field.png");
  groundImage = loadImage("ground.png");
  buttonPlayImage = loadImage("playButton.png");
  buttonRateImage = loadImage("rateButton.png");
  lockImage = loadImage("lock.png");
}

void LoadFonts(){
  njNarutoFont = createFont("njnaruto.ttf", fontQuality);
  chlorinrFont = createFont("chlorinr.ttf", fontQuality);
  digoryFont = createFont("Digory_Doodles_PS.ttf", fontQuality);
  gypsyCurseFont = createFont("Gypsy_Curse.ttf", fontQuality);
  racingSansFont = createFont("RacingSansOne-Regular.ttf", fontQuality);
  zombieHolocaustFont = createFont("Zombie_Holocaust.ttf", fontQuality);
}

void LoadSounds(){
  jumpSound = new SoundFile(this, "jump.wav");
  deathSound = new SoundFile(this, "hit.wav");
  flowerSound = new SoundFile(this, "flower.wav");
  backgroundMusic = new SoundFile(this, "background.wav");
  finishedSound = new SoundFile(this, "finished.wav");
}

Flower flowerFromJsonString(String json) {
  JSONObject p = parseJSONObject(json);
  Flower f = new Flower(p.getFloat("x") * gameWidth, p.getFloat("y") * gameHeight, (int)(p.getFloat("width") * gameWidth), (int)(p.getFloat("height") * gameHeight));

  return f;
}

Spider spiderFromJsonString(String json) {
  JSONObject p = parseJSONObject(json);
  Spider s = new Spider(p.getFloat("x") * gameWidth,(int)(p.getFloat("width") * gameWidth), (int)(p.getFloat("height") * gameHeight));
  
  s.maxAngleSpeed = p.getFloat("maxAngleSpeed");
  s.omega = p.getFloat("omega");
  
  return s;
}

Rock rockFromJsonString(String json) {
  JSONObject p = parseJSONObject(json);
  Rock r = new Rock(p.getFloat("x") * gameWidth,(int)(p.getFloat("width") * gameWidth), (int)(p.getFloat("height") * gameHeight));

  return r;
}

Level levelFromJsonFile(String jsonPath){
  Level l = new Level();
  JSONObject json = loadJSONObject(jsonPath);
  
  l.speed = json.getFloat("speed")/800.0 * gameWidth + 1;
  
  JSONArray rocks = json.getJSONArray("rocks");
  for(int i = 0; i < rocks.size(); i++){
    JSONObject p = rocks.getJSONObject(i);
    Rock r = new Rock(p.getFloat("x") * gameWidth,(int)(p.getFloat("width") * gameWidth), (int)(p.getFloat("height") * gameHeight));
    l.addRock(r);
  }
  
  JSONArray spiders = json.getJSONArray("spiders");
  for(int i = 0; i < spiders.size(); i++){
    JSONObject p = spiders.getJSONObject(i);
    Spider s = new Spider(p.getFloat("x") * gameWidth,(int)(p.getFloat("width") * gameWidth), (int)(p.getFloat("height") * gameHeight));
    s.maxAngleSpeed = p.getFloat("maxAngleSpeed");
    s.omega = p.getFloat("omega");
    l.addSpider(s);
  }
  
  JSONArray flowers = json.getJSONArray("flowers");
  for(int i = 0; i < flowers.size(); i++){
    JSONObject p = flowers.getJSONObject(i);
    Flower f = new Flower(p.getFloat("x") * gameWidth, p.getFloat("y") * gameHeight, (int)(p.getFloat("width") * gameWidth), (int)(p.getFloat("height") * gameHeight));
    l.addFlower(f);
  }
  l.endPosition = (json.getFloat("endPosition") / 800.0) * gameWidth;
  l.beehive.x = l.endPosition;
  
  l.initSpeeds();
  
  return l;
}

JSONArray loadUserJsonData(){
  /*if(!(new File(dataPath("userData"))).exists()){
    return null;
  }*/
  JSONArray a;
  try{
    a = loadJSONArray("userData");
    return a;
  }
  catch(Exception e){
    a = null;
  }
  
  return a;
}

void writeUserJsonData(int level, int flowers, int maxFlowers){
  JSONObject levelData = new JSONObject();
  
  levelData.setInt("flowers", flowers);
  levelData.setInt("maxFlowers", maxFlowers);
  
  JSONArray json = loadUserJsonData();
  if(json == null){
    json = new JSONArray();
  }
  json.setJSONObject(level, levelData);
  
  saveJSONArray(json, "userData");
}
