PShader sunburst, smoke;
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
  sunburst = loadShader("suntexture.glsl");
  sunburst.set("resolution", 600.f, 876.f);
  sunburst.set("texture", mask);
  smoke = loadShader("water.glsl");
  smoke.set("iResolution", 600.f, 876.f);
  //smoke.set("texture", mask);
  
}

void draw() {
  //sunburst.set("texture", img);
  //sunburst.set("time", millis() / 2000.0);
  //smoke.set("texture", img);
  smoke.set("iTime", millis());
  float mapmx = map(mouseX, 0, width, 0, 2);
  float mapmy = map(mouseY, 0, width, 1.1, 2.0);
  float mapmymove = map(mouseY, 0, width, 0.3, 0.7);
  sunburst.set("mousex", mapmx);
  sunburst.set("mousey", mapmy);
  sunburst.set("mouseym", mapmymove);
  shader.beginDraw();
  shader.filter(sunburst);
  shader.image(img, 0,0,width,height);
  shader.endDraw();

  //shader(sunburst);
  shader(smoke);
  //tint(255, 25);
  image(shader, 0, 0, width, height);
}

//shader color calculations
//117, 113, 182
//0.46, 0.44, 0.71
//224, 117, 115
//0.88, 0.46, 0.45
