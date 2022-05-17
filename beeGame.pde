Game game;
MainMenu mainMenu;
int mode = 0;

void setup() {
  fullScreen(P2D);
  orientation(LANDSCAPE);
  shapeMode(CENTER);
  frameRate(70);
  smooth();

  LoadImages();
  LoadFonts();
  LoadSounds();


  game = new Game();
}

void mousePressed() {
  game.touchStarted();
}

void draw() {
  //beginDraw();
  //clear();
  game.draw();

  System.gc();

  /*int percent = (int)(100*(double)usedMem()/totalMem());
   println(percent + "%");*/
}

public long totalMem() {
  return Runtime.getRuntime().totalMemory();
}

public long usedMem() {
  return Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
}
