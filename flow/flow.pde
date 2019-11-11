PShader flow;
PImage img, img2;

void setup(){
 size(1313, 1920, P3D); 
  img = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg1313_1920.png");
  img2 = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg_mask1.png");
  flow = loadShader("flowfrag.glsl", "flowvert.glsl");
  //flowvert.set("iResolution", 600.f, 876.f);
  //flowfrag = loadShader();
  flow.set("resolution", 1313.f, 1920.f);
  flow.set("image1", img);
  flow.set("image2", img2);
  flow.set("speed", 2);
  flow.set("color", 1);
  
}

void draw(){
  //flow.set("time", millis());
  shader(flow);
  //image(img, 0, 0, width, height);
  rect(0,0,width,height);
  
  
}
