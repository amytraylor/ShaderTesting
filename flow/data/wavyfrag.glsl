#ifdef GL_ES
precision highp float;
precision highp int;
#endif

uniform float time;
uniform float speed;

uniform sampler2D image;
uniform vec2 strength;
varying vec2 vUv;

// From https://stackoverflow.com/a/36176935/743464
vec2 sineWave( vec2 p ) {
    // wave distortion
    float x = sin( 25.0 * p.y + 30.0 * p.x + time * speed) * (0.1 * strength.x);
    float y = sin( -25.0 * p.y + 30.0 * p.x + time * speed) * (0.1 * strength.y);
    return vec2(p.x+x, p.y+y);
}
    
void main() {

    vec3 color = texture2D( image, sineWave(vUv) ).rgb;
    gl_FragColor = vec4( color, 1.0 );

}