PShader contrast, blurry;
PGraphics buf, buf2;
PImage img, mask;
int counter = 0;
void setup() {
  size(600, 876, P2D);
  buf = createGraphics(width, height, P2D);
  buf2 = createGraphics(width, height, P2D);
  img = loadImage("Hawk600_876.png");
  mask = loadImage("Hawk_mask2.png");
  
  contrast = loadShader("colfrag.glsl");
  blurry = loadShader("blurFragTexture.glsl");
 
  // Don't forget to set these
  blurry.set("sigma", 0.5);//was 4.5
  blurry.set("blurSize", 0.5);//was 9
  
  
}
 
void draw() {
  background(100);
  loadPixels();
  mask.loadPixels();
  for (int y = 0; y < mask.height; y++) {
    for (int x = 0; x < mask.width; x++) {
      int loc = x + y*width;
      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(mask.pixels[loc]);
      float g = green(mask.pixels[loc]);
      float b = blue(mask.pixels[loc]);
      float a = alpha(mask.pixels[loc]);
      println(a);
      // Image Processing would go here
      // If we were to change the RGB values, we would do it here, 
      // before setting the pixel in the display window.
      if(a<255){
        counter+=1;
      }
      
      //if(a<255){
      //  pixels[loc] =  color(0);
      //} else {
      //  // Set the display pixel to the image pixel
      //  pixels[loc] =  color(r,g,b); 
      //}
    }
  }
  updatePixels();
  println(counter);
  ////image(img, 0, 0, width, height);
  //buf.beginDraw();
  //   buf.image(img, 0, 0, width, height);
  //  buf.endDraw();
 
  // buf2.beginDraw();
  //    //buf.image(img, 0, 0, width, height);
  //  buf2.image(mask, 0, 0, width, height);
  //  buf2.endDraw();
  //shader(contrast);
  image(buf, 0,0, width,height);
  image(buf2, 0,0, width,height);
}
