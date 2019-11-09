#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
#define PROCESSING_TEXTURE_SHADER
uniform vec2      iResolution;     // viewport resolution (in pixels)
uniform float     iTime;          // shader playback time (in seconds)
uniform sampler2D texture;

void main(){
	vec2 coord = gl_FragCoord.xy / iResolution;
	vec2 flipcoord = vec2(coord.x, 1-coord.y);
	vec3 color = vec3(0.0);
	vec4 image = texture2D(texture, flipcoord);
	gl_FragColor = vec4(image);
}