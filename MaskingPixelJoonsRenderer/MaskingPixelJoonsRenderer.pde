import joons.JoonsRenderer;

JoonsRenderer jr;

//camera declarations
float eyeX = 0;
float eyeY = 0;
float eyeZ = 0;
float centerX = 0;
float centerY = 0;
float centerZ = -1;
float upX = 0;
float upY = 1;
float upZ = 0;
float fov = PI / 4; 
float aspect = 4/3f;  
float zNear = 5;
float zFar = 10000;

PImage img, mask, copy, copy2;
int counter = 0;
int red, green, blue;
int maxPix = 1, minPix = 0;
float smooth, smooth2 = 0;
float[] ranS;
boolean grow, grow2=true;
boolean fourk=false;

void settings() {
  if (fourk) {
    size(1313, 1920, P3D);
  } else {
    size(600, 876, P3D);
  }
}

void setup() {
  //size(1313, 1920, P3D);
  //blendMode(BLEND);
  //buf = createGraphics(width, height, P2D);
  //buf2 = createGraphics(width, height, P2D);
  if (fourk) {
    //4k screen
    //size(1313, 1920, P2D);
    //fullScreen(P2D);
    noStroke();
    //img = loadImage("Greg1313_1920.png");
    //mask = loadImage("Greg1313_1920.png");
    img = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg1313_1920.png");
    mask = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg1313_1920.png");
    copy = createImage(1313, 1920, ARGB);
    copy2 = createImage(1313, 1920, ARGB);

  } else {
    //HD
    //size(600, 876, P2D);
    noStroke();
    //img = loadImage("Greg600_876.png");
    //mask = img;
    img = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg600_876.png");
    mask = loadImage("C:/Users/ganio/OneDrive/Documents/Thesis/ShaderTesting/images/Greg600_876.png");
    copy = createImage(600, 876, ARGB);
    copy2 = createImage(600, 876, ARGB);
  }
 
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
  
  //joons
  jr = new JoonsRenderer(this);
  jr.setSampler("ipr"); //Rendering mode, either "ipr" or "bucket".
  jr.setSizeMultiplier(1); //Set size of the .PNG file as a multiple of the Processing sketch size.
  jr.setAA(-2, 0, 1); //Set anti-aliasing, (min, max, samples). -2 < min, max < 2, samples = 1,2,3,4..
  jr.setCaustics(1); //Set caustics. 1 ~ 100. affects quality of light scattered through glass.
  //jr.setTraceDepth(1,4,4); //Set trace depth, (diffraction, reflection, refraction). Affects glass. (1,4,4) is good.
  //jr.setDOF(170, 5); //Set depth of field of camera, (focus distance, lens radius). Larger radius => more blurry.
   
}
 
void draw() {
  jr.beginRecord(); //Make sure to include methods you want rendered.
  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  perspective(fov, aspect, zNear, zFar);
 // background(100);
 
  pushMatrix();
  translate(-40, 20, 140);
  //pushMatrix();
  rotateY(-PI/8);

  //jr.fill("light"); or
  //jr.fill("light", r, g, b); or
  //jr.fill("light", r, g, b, int samples);
  jr.fill("diffuse", 5, 5, 5);
  sphere(13);
  popMatrix();
  
 beginShape();
 texture(img);
 vertex(0,0, 0, 0);
 vertex(width, 0, 1, 0);
 vertex(width, height, 1, 1);
 vertex(0, height, 0, 1);
 endShape();
 
 //image(img, 0, 0);
 //image(copy2, 0, 0);
 jr.fill("shiny", 150, 255, 255, 0.1f);
 rect(0,0,width,height);
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
        
  //textSize(25);
  //text(red, 25, 25);
  //text(green, 25, 50);
  jr.endRecord(); //Make sure to end record.
  jr.displayRendered(true); //Display rendered image if rende
}

void keyPressed(){
  if (key=='s'){saveFrame("masktest-###.png");}
  if (key=='r'||key=='R') jr.render(); //Press 'r' key to start rendering.

}
