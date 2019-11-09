PShader contrast, blurry;
PGraphics buf;
PImage img, mask;
 
void setup() {
  size(600, 876, P2D);
  buf = createGraphics(width, height, P2D);
  img = loadImage("Hawk600_876.png");
  mask = loadImage("Hawk_mask2.png");
  contrast = loadShader("colfrag.glsl");
  blurry = loadShader("blurFragTexture.glsl");
 
  // Don't forget to set these
  blurry.set("sigma", 4.5);
  blurry.set("blurSize", 9);
}
 
void draw() {
  background(100);
  //image(img, 0, 0, width, height);
  buf.beginDraw();
    // Reset transparency
    // Note, the color used here will affect your edges
    // even with zero for alpha
    //buf.background(100, 0); // set to match main background
 
    //buf.noStroke();
    //buf.fill(255, 30, 30);
    //buf.ellipse(width/2, height/2, 40, 40);
    //buf.ellipse(mouseX, mouseY, 40, 40);
    buf.image(img, 0, 0, width, height);
    buf.image(mask, 0, 0, width, height);
    //blurry.set("horizontalPass", 1);
    //buf.filter(blurry);
   // blurry.set("horizontalPass", 0);
    //buf.filter(blurry);
  buf.endDraw();
 
 // shader(contrast);
  image(buf, 0,0, width,height);
}
