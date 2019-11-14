//#version 150
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER


float TAU = 6.28318530718;
int MAX_ITER = 15;//was 5


out vec4 fragColor;
//Shader Inputs

uniform vec2      iResolution;     // viewport resolution (in pixels)
uniform float     iTime;          // shader playback time (in seconds)
uniform sampler2D texture;



void main(){
	float time = iTime * .025+23.0;
	//float time = iTime * .5+23.0;
    // uv should be the 0-1 uv of texture...
	vec2 uv_not = gl_FragCoord.xy/iResolution; 
	vec2 uv = vec2(uv_not.x, 1-uv_not.y);   
    vec2 p = mod(uv*TAU, TAU)-250.0;
	vec2 i = vec2(p);
	float c = 1.0;
	float inten = .005;//was .005

	for (int n = 0; n < MAX_ITER; n++) 
	{
		float t = time * (1.0 - (3.5 / float(n+1)));
		i = p + vec2(cos(t - i.x) + sin(t + i.y), sin(t - i.y) + cos(t + i.x));
		c += 1.0/length(vec2(p.x / (sin(i.x+t)/inten),p.y / (cos(i.y+t)/inten)));
	}
	c /= float(MAX_ITER);
	c = 1.17-pow(c, 1.4);
	vec3 colour = vec3(pow(abs(c), 255.0));//was 8, 58 makes it darker/increases contrast
	colour = clamp(colour + vec3(0.0, 0.0, 0.0), 0.0, 1.0);
    //colour = clamp(colour + vec3(0.0, 0.35, 0.5), 0.0, 1.0);
    vec3 col = texture2D(texture, uv).xyz;//1.0 - 0.995
    //vec3 col = texture2D(texture, 0.995 - 1.0 * uv).xyz;//1.0 - 0.995
    //vec3 col = texture2D(texture, 0.5 - 0.495 * uv).xyz;
    //gl_FragColor = vec4(col / (0.1 + w), 1.0);

	fragColor = vec4((col*0.95)+(colour*0.05), 1.0);
}