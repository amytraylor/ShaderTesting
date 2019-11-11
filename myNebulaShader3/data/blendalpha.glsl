#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER
 

uniform vec2 resolution;
uniform float time;
uniform sampler2D texture;

void main(){
	vec2 uv_not = gl_FragCoord.xy / resolution.xy;
	vec2 uv = vec2(uv_not.x, 1-uv_not.y);
	vec4 texColor = texture(texture, uv);
	if(texColor.a<0.1)
		discard;
	gl_FragColor = texColor;
}