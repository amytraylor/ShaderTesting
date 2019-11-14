#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER
//http://glslsandbox.com/e#58487.1
uniform float time; // time
uniform vec2  resolution; // resolution
uniform sampler2D texture;
uniform float mousex;
uniform float mousey;

#define PI 3.14159265
#define TAU (2*PI)
#define PHI (sqrt(5)*0.5 + 0.5)
float pModPolar(inout vec2 p, float repetitions) {
  float angle = 2.*PI/repetitions;
  float a = atan(p.y, p.x) + angle/2.;
  float r = length(p);
  float c = floor(a/angle);
  a = mod(a,angle) - angle/2.;
  p = vec2(cos(a), sin(a))*r;
  // For an odd number of repetitions, fix cell index of the cell in -x direction
  // (cell index would be e.g. -5 and 5 in the two halves of the cell):
  if (abs(c) >= (repetitions/2.)) c = abs(c);
  return c;
}


void main(void){
  vec2 uv_not = gl_FragCoord.xy / resolution.xy; 
  vec2 uv = vec2(uv_not.x, 1-uv_not.y);
  vec3 destColor = vec3(0.4, 0.2, 0.5);
  //scale
  vec2 p = (gl_FragCoord.xy * mousey - resolution.xy) / min(resolution.x, resolution.y);
  //vec2 p = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y);  
  //bumps on ring
  float a = atan(p.y / p.x) * 128.0;
  //float a = atan(p.y / p.x) * 32.0;

  float l = 0.2/ abs(length(p) - 0.8 + sin(a + time * mousey) * 0.004);
  //float l = 0.2/ abs(length(p) - 0.8 + sin(a + time * 3.5) * 0.004);
  
  
  vec2 pp = p;
  //pModPolar(pp,32.0);
  float d = length(pp)*0.4; //+vec2(sin(time),cos(time))*0.5);
  p.x = dot(p*1.6,p*0.2);
  d=.14/(d*d);
  p.y += sin(time*4.44+p.x*54.0)*0.15;
  l*= (sin(time*3.6+p.y*15.2)+2.7)/abs(cos(time+p.x*3.2+p.y*d));
  
  destColor *= 0.5 + sin(a*0.25 + time * 1.3+p.x*p.x) * 0.2;
  vec3 col = texture2D(texture, uv).xyz;
  
  vec3 final = l*destColor;
  gl_FragColor = vec4((col*0.98)+(final*mousex), 1.0);
  //gl_FragColor = vec4(l*destColor, 1.0);
}