PShader contrast, blurry;
PGraphics buf, buf2;
PImage img, mask, copy;
int counter = 0;
int red, green, blue;
int maxPix = 1, minPix = 0;
float smooth = 0;
float[] ranS;
boolean grow=true;

void setup() {
  size(1313, 1920, P2D);
  blendMode(BLEND);
  //buf = createGraphics(width, height, P2D);
  //buf2 = createGraphics(width, height, P2D);
  img = loadImage("Greg1313_1920.png");
  mask = img;
  //  img = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg1313_1920.png");
  //mask = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg1313_1920.png");
  copy = createImage(1313, 1920, ARGB);
  contrast = loadShader("colfrag.glsl");
  blurry = loadShader("blurFragTexture.glsl");
 
  // Don't forget to set these
  blurry.set("sigma", 0.5);//was 4.5
  blurry.set("blurSize", 0.5);//was 9
  
  
  loadPixels();
  
  mask.loadPixels();
  println(mask.pixels.length);
  ranS = new float[mask.pixels.length];
  for(int i = 0; i<mask.pixels.length; i++){
    ranS[i] = random(0, 10);
  }
  for (int x = 0; x < mask.width; x++) {
    for (int y = 0; y < mask.height; y++) {
      int loc = x + y*width;
      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(mask.pixels[loc]);
      float g = green(mask.pixels[loc]);
      float b = blue(mask.pixels[loc]);
      float a = alpha(mask.pixels[loc]);

      // Image Processing would go here
      // If we were to change the RGB values, we would do it here, 
      // before setting the pixel in the display window.
      red = 255; green = 125;
      if(r<red && g<green ){
        //pixels[loc] =  color(0, 0);
        copy.pixels[loc] = color(0,0);
      } else {
        // Set the display pixel to the image pixel
        //pixels[loc] =  color(r,g,b); 
        copy.pixels[loc] = color(r,g,b);
      }
    }
  }
  updatePixels();
   
}
 
void draw() {
 // background(100);
 image(img, 0, 0);
 image(copy, 0, 0);

  for (int x = 0; x<copy.width; x++){
    for(int y = 0; y<copy.height; y++){
      int loc = x + y*width;
       //controls size of blip 
      if(grow){
        if(smooth<maxPix){
          smooth+=0.00020;
        } else {
          grow=false;
        }
      }else {
        if(smooth>0){
          smooth-=0.00020;
        } else {
          grow=true;
        }
      }
      //println(smooth);
      if(copy.pixels[loc]<0){
        noStroke();
        fill(copy.pixels[loc], 150);
        ellipse(x,y,ranS[loc]*smooth, ranS[loc]*smooth);
      }
    }
  }
        
  textSize(25);
  text(red, 25, 25);
  text(green, 25, 50);

}

void keyPressed(){
  if (key=='s'){saveFrame("masktest-###.png");}
}
