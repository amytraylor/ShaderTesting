 
PShader nebula;
PImage img, mask;
PGraphics shader;

void setup() {
  size(600, 876, P3D);
  noStroke();
  //blendMode(DIFFERENCE);
  shader=createGraphics(width,height,P3D);
  img = loadImage("C:/Users/ganio/Documents/Thesis/ShaderTesting/images/Greg1313_1920.png");
  mask = loadImage("C:/Users/ganio/Documents/Thesis/ShaderTesting/images/Greg_mask3.png");
  //img.resize(int(img.width*0.5), int(img.height*0.5));
  //nebula = loadShader("water.glsl");
  nebula = loadShader("monjori.glsl");
  nebula.set("resolution", 600.f, 876.f);
  //nebula.set("texture", mask);
  //nebula.set("iResolution", float(width), float(height));
}

void draw() {
  //nebula.set("texture", img);
  nebula.set("time", millis());
  float mapmx = map(mouseX, 0, width, 0, 0.015);
  float mapmy = map(mouseY, 0, width, 0, 4.0);
  //nebula.set("mousex", mapmx);
  //nebula.set("mousey", mapmy);

  shader(nebula);
  //tint(255, 25);
  image(img, 0, 0, width, height);
}
