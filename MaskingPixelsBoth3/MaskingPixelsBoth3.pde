PImage img, mask, copy, copy2;
int counter = 0;
int red, green, blue;
int maxPix = 1, minPix = 0;
float smooth, smooth2 = 0;
float[] ranS;
boolean grow, grow2=true;

void setup() {
  size(1313, 1920, P2D);
  blendMode(BLEND);
  //buf = createGraphics(width, height, P2D);
  //buf2 = createGraphics(width, height, P2D);
  img = loadImage("C:/Users/ganio/Documents/Thesis/ShaderTesting/images/Greg1313_1920.png");
  mask = loadImage("C:/Users/ganio/Documents/Thesis/ShaderTesting/images/Greg_mask3.png");
  copy = createImage(1313, 1920, ARGB);
  copy2 = createImage(1313, 1920, ARGB);
 
  loadPixels();  
  mask.loadPixels();
  ranS = new float[mask.pixels.length];
  for(int i = 0; i<mask.pixels.length; i++){
    ranS[i] = random(0, 5);
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
      if(r==255&&g==255&&b==255){
        copy.pixels[loc] = color(0,0);
      } else if(r<red && g<green ){
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
  
  loadPixels();  
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int loc = x + y*width;      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      float a = alpha(img.pixels[loc]);

      red = 255; green = 125;
      if(r<red && g<green ){
        copy2.pixels[loc] = color(0,0);
      } else {
        // Set the display pixel to the image pixel
        copy2.pixels[loc] = color(r,g,b);
      }
    }
  }
  updatePixels();
   
}
 
void draw() {
 // background(100);
 image(img, 0, 0);
 image(copy2, 0, 0);

  for (int x = 0; x<copy.width; x++){
    for(int y = 0; y<copy.height; y++){
      int loc = x + y*width;
       //controls size of blip 
      if(grow){ if(smooth<maxPix){ smooth+=0.00020; } else {grow=false;}}else {if(smooth>0){smooth-=0.00020;} else { grow=true;}}
      //println(smooth);
      if(copy.pixels[loc]<0){
        noStroke();
        fill(copy.pixels[loc], 15);
        ellipse(x,y,ranS[loc]*smooth, ranS[loc]*smooth);
      }
    }
  }
  
    for (int x = 0; x<copy2.width; x++){
    for(int y = 0; y<copy2.height; y++){
      int loc = x + y*width;
       //controls size of blip 
      if(grow2){ if(smooth2<maxPix*2){ smooth2+=0.00020; } else {grow2=false;}}else {if(smooth2>0){smooth2-=0.00020;} else { grow2=true;}}
      //println(smooth);
      if(copy2.pixels[loc]<0){
        noStroke();
        fill(copy2.pixels[loc], 100);
        ellipse(x,y,ranS[loc]*smooth2, ranS[loc]*smooth2);
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
