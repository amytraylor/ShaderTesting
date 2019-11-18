#define PROCESSING_TEXTURE_SHADER
 
uniform sampler2D texture;
varying vec4 vertTexCoord;
 
uniform vec4 o = vec4(0, 0, 0, -7.0); 
uniform lowp mat4 colorMatrix = mat4(1.0, 0.0, 0.0, 0.0, 
                                     0.0, 1.0, 0.0, 0.0, 
                                     0.0, 0.0, 1.0, 0.0, 
                                     0.0, 0.0, 0.0, 18.0);
 
void main() {
  vec4 pix = texture2D(texture, vertTexCoord.st);
  vec4 color = (pix * colorMatrix) + o;
  gl_FragColor = color;
}