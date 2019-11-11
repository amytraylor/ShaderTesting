#ifdef GL_ES
precision highp float;
precision highp int;
#endif

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

varying vec2 vUv;
//varying vec4 vertTexCoord;

attribute vec3 position;
attribute vec2 uv;

void main() {

    vUv = uv;
    //uv = vertTexCoord.st;
    //vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );

}