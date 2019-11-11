// Credit https://www.shadertoy.com/view/4t23DD
#ifdef GL_ES
precision highp float;
precision highp int;
#endif

#define PROCESSING_COLOR_SHADER

varying vec2 vUv;
varying vec4 vertTexCoord;

uniform float time;
uniform float speed;

uniform float resolution;
uniform sampler2D image1;
uniform sampler2D image2;
uniform vec3 color;

void main() {
	vec2 uv = vertTexCoord.st * resolution; 
    //vec2 uv = vUv.xy * resolution; 
    
    vec4 texCol = vec4( texture2D(image1, uv ) );
    mat3 tfm;
    tfm[0] = vec3(texCol.z,0.0,0);
    tfm[1] = vec3(0.0,texCol.y,0);
    tfm[2] = vec3(0,0,1.0);    
    vec2 muv = (vec3(uv,1.0)*tfm).xy + time* speed;
    texCol = vec4( vec3(texture2D(image2, muv)) * color, 1.0 );

    gl_FragColor = texCol;

}