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
  size(600, 876, P2D);
  noStroke();
  //blendMode(DIFFERENCE);
  //shader=createGraphics(width,height,P2D);
  img = loadImage("C:/Users/ganio/Documents/Thesis/ShaderTesting/images/Hawk.png");
  mask = loadImage("C:/Users/ganio/Documents/Thesis/ShaderTesting/images/Hawk.png");
  //img.resize(int(img.width*0.5), int(img.height*0.5));
  nebula = loadShader("water.glsl");
  //nebula.set("resolution", 600.f, 876.f);
  nebula.set("iResolution", float(width), float(height));
}

void draw() {
  nebula.set("iTime", millis() / 500.0);
  //image(img, 0, 0, width, height);
  //shader.beginDraw();
  //shader.shader(nebula);
  //////shader.fill(0,255, 255, 10);
  ////shader.rect(0,0,width,height);
  //shader.image(img, 0, 0, width, height);
  //shader.endDraw();
  //image(shader, 0, 0, width, height);
  // This kind of raymarching effects are entirely implemented in the
  // fragment shader, they only need a quad covering the entire view 
  // area so every pixel is pushed through the shader. 
  //rect(0, 0, width, height);
  //tint(255, 200);
  image(img, 0, 0, width, height);
  shader(nebula);
  //tint(255, 25);
  image(mask, 0, 0, width, height);
}
