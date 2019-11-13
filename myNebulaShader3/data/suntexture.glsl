#ifdef GL_ES
precision mediump float;
#endif

#extension GL_OES_standard_derivatives : enable
#define PROCESSING_TEXTURE_SHADER

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;
uniform sampler2D texture;
uniform float mousex;
uniform float mousey;
uniform float mouseym;

const vec3   atmosphereColor = vec3(0.2, 0.2, 0.0) * 1.6;
//const vec3   atmosphereColor = vec3(0.3, 0.6, 1.0) * 1.6;

vec3 shadowedAtmosphereColor(vec2 fragCoord, vec2 iResolution, float minVal) {
    vec2 rel = 0.65 * (fragCoord.xy - iResolution.xy * 0.5) / iResolution.y;
    const float maxVal = 1.0;
    
    float a = min(1.0,
                  pow(max(0.0, 1.0 - dot(rel, rel) * 6.5), 2.4) + 
                  max(abs(rel.x - rel.y) - 0.35, 0.0) * 12.0 +                   
                  max(0.0, 0.2 + dot(rel, vec2(2.75))) + 
                  0.0
                 );
    
    float planetShadow = mix(minVal, maxVal, a);
    
    return atmosphereColor * planetShadow;
}


void main( void ) {
    vec2 uv_not = gl_FragCoord.xy / resolution.xy; 
    vec2 uv = vec2(uv_not.x, 1-uv_not.y);
    vec2 delta = (gl_FragCoord.xy - resolution.xy * mouseym) / resolution.y * mousey;
	//vec2 delta = (gl_FragCoord.xy - resolution.xy * 0.5) / resolution.y * 1.1;
	float atmosphereRadialAttenuation = min(1.0, 0.06 * pow(max(0.0, 1.0 - (length(delta) - 0.9) / 0.9), 4.0));
	//float atmosphereRadialAttenuation = min(1.0, 0.06 * pow(max(0.0, 1.0 - (length(delta) - 0.9) / 0.9), 8.0));
	//vec3 c = shadowedAtmosphereColor(vec2(mousey)/*gl_FragCoord.xy*/, vec2(0.5)/*resolution.xy*/, 0.5);
	vec3 c = shadowedAtmosphereColor(vec2(0.5)/*gl_FragCoord.xy*/, vec2(0.5)/*resolution.xy*/, 0.5);
	//vec3 c = xf(gl_FragCoord.xy, resolution.xy, 0.5);
	c *= atmosphereRadialAttenuation;
	vec3 col = texture2D(texture, uv).xyz;
	gl_FragColor = vec4((col*0.70)+((c *= atmosphereRadialAttenuation)*mousex), 1.0);
	//gl_FragColor = vec4( c, 1.0 );
}