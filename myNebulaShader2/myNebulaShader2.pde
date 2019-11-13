/**
 * Nebula. 
 * 
 * From CoffeeBreakStudios.com (CBS)
 * Ported from the webGL version in GLSL Sandbox:
 * http://glsl.heroku.com/e#3265.2
 */
 
PShader nebula;
PImage img, mask;
PGraphics shader;

void setup() {
  size(600, 876, P3D);
  noStroke();
  //blendMode(DIFFERENCE);
  shader=createGraphics(width,height,P3D);
  img = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg1313_1920.png");
  mask = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg_mask3.png");
  //img.resize(int(img.width*0.5), int(img.height*0.5));
  nebula = loadShader("water2.glsl");
  //nebula = loadShader("monjori2.glsl");
  nebula.set("resolution", 600.f, 876.f);
  nebula.set("texture", mask);
  //nebula.set("iResolution", float(width), float(height));
}

void draw() {
  nebula.set("texture", img);
  nebula.set("time", millis() / 2000.0);
  float mapmx = map(mouseX, 0, width, 0, 0.015);
  float mapmy = map(mouseY, 0, width, 0, 4.0);
  nebula.set("mousex", mapmx);
  nebula.set("mousey", mapmy);

  shader(nebula);
  //tint(255, 25);
  image(img, 0, 0, width, height);
}
