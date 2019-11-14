PShader sunburst;
PImage img, mask, copy, copy2;
int counter = 0;
int red, green, blue;
int maxPix = 1, minPix = 0;
float smooth, smooth2 = 0;
float[] ranS;
boolean grow=true, grow2=false;

void setup() {
  frameRate(30);
  //4k screen
  /*size(1313, 1920, P2D);
  //fullScreen(P2D);
  noStroke();
  img = loadImage("Greg1313_1920.png");
  mask = loadImage("Greg1313_1920.png");
  //img = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg1313_1920.png");
  //mask = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg1313_1920.png");
  copy = createImage(1313, 1920, ARGB);
  copy2 = createImage(1313, 1920, ARGB);
  sunburst = loadShader("suntexture.glsl");
  sunburst.set("resolution", 1313.f, 1920.f);
  sunburst.set("texture", mask);*/

  //HD
   size(600, 876, P2D);
   noStroke();
   img = loadImage("Greg600_876.png");
   mask = img;
   //img = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg600_876.png");
   //mask = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg600_876.png");
   copy = createImage(600, 876, ARGB);
   copy2 = createImage(600, 876, ARGB);
   sunburst = loadShader("suntexture.glsl");
   sunburst.set("resolution", 600.f, 876.f);
   sunburst.set("texture", mask);

  //loading pixels for mask
  loadPixels();  
  mask.loadPixels();
  ranS = new float[mask.pixels.length];
  for (int i = 0; i<mask.pixels.length; i++) {
    ranS[i] = random(0, 7);
  }
  for (int x = 0; x < mask.width; x++) {
    for (int y = 0; y < mask.height; y++) {
      int loc = x + y*width;      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(mask.pixels[loc]);
      float g = green(mask.pixels[loc]);
      float b = blue(mask.pixels[loc]);
      float a = alpha(mask.pixels[loc]);

      red = 255; 
      green = 125;
      if (r==255&&g==255&&b==255) {
        copy.pixels[loc] = color(0, 0);
      } else if (r<red && g<green ) {
        copy.pixels[loc] = color(0, 0);
      } else {
        copy.pixels[loc] = color(r, g, b);
      }
    }
  }
  updatePixels();

  //load pixels for main image
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

      //if pixels are out of a certain range, set them to transparent black
      red = 255; 
      green = 125;
      if (r<red && g<green ) {
        copy2.pixels[loc] = color(0, 0);
      } else {
        // Set the display pixel to the image pixel
        copy2.pixels[loc] = color(r, g, b);
      }
    }
  }
  updatePixels();
}

void draw() {
  //shader
  float mapmx = map(mouseX, 0, width, 0, 2);
  float mapmy = map(mouseY, 0, width, 1.1, 2.0);
  float mapmymove = map(mouseY, 0, width, 0.3, 0.7);
  sunburst.set("mousex", mapmx);
  sunburst.set("mousey", mapmy);
  sunburst.set("mouseym", mapmymove);
  shader(sunburst);
  //pixel animations
  image(img, 0, 0);
  //image(copy2, 0, 0);

  for (int x = 0; x<copy.width; x++) {
    for (int y = 0; y<copy.height; y++) {
      int loc = x + y*width;
      //controls size of blip 
      if (grow) { 
        if (smooth<maxPix) { 
          smooth+=0.00000020;
        } else {
          grow=false;
        }
      } else {
        if (smooth>0) {
          smooth-=0.00000020;
        } else { 
          grow=true;
        }
      }
      //println(smooth);
      if (copy.pixels[loc]<0) {
        noStroke();
        fill(copy.pixels[loc], 15);
        ellipse(x, y, ranS[loc]*smooth, ranS[loc]*smooth);
      }
    }
  }

  for (int x = 0; x<copy2.width; x++) {
    for (int y = 0; y<copy2.height; y++) {
      int loc = x + y*width;
      //controls size of blip 
      if (grow2) { 
        if (smooth2<maxPix) { 
          smooth2+=0.00000020;
        } else {
          grow2=false;
        }
      } else {
        if (smooth2>0) {
          smooth2-=0.00000020;
        } else { 
          grow2=true;
        }
      }
      //println(smooth);
      //number is less than zero because color was returning negative values
      if (copy2.pixels[loc]<0) {
        noStroke();
        fill(copy2.pixels[loc], 10);
        ellipse(x, y, ranS[loc]*smooth2, ranS[loc]*smooth2);
      }
    }
  }


  //image(img, 0, 0, width, height);
}

void keyPressed(){
  if (key=='s'){saveFrame("test/test-###.png");}
  if (keyCode==UP){maxPix+=1;}
  if (keyCode==DOWN){
      if(maxPix>1){
        maxPix-=1;
      }
    }
}
//shader color calculations
//117, 113, 182
//0.46, 0.44, 0.71
//224, 117, 115
//0.88, 0.46, 0.45
