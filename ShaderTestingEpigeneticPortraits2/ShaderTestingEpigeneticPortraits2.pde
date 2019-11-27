PShader sunburst;
PImage img, mask;


void setup() {
  size(600, 876, P3D);
  noStroke();
  img = loadImage("C:/Users/ganio/Documents/Thesis/ShaderTesting/images/Flannery600_876.png");
  mask = loadImage("C:/Users/ganio/Documents/Thesis/ShaderTesting/images/Greg_mask3.png");
  sunburst = loadShader("suntexture.glsl");
  sunburst.set("resolution", 600.f, 876.f);
  sunburst.set("texture", mask);

  
}

void draw() {
  float mapmx = map(mouseX, 0, width, 0, 2);
  float mapmy = map(mouseY, 0, width, 1.1, 2.0);
  float mapmymove = map(mouseY, 0, width, 0.3, 0.7);
  sunburst.set("mousex", mapmx);
  sunburst.set("mousey", mapmy);
  sunburst.set("mouseym", mapmymove);
  shader(sunburst);
  image(img, 0, 0, width, height);
}

//shader color calculations
//117, 113, 182
//0.46, 0.44, 0.71
//224, 117, 115
//0.88, 0.46, 0.45
