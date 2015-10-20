
// default vertex shader
precision highp float;

// inputs for the vertex
attribute vec2 aVertexPosition; // position value
attribute vec2 aTextureCoord;
attribute vec4 aColor; // input vertex color

// uniforms used by the vertex shader
uniform mat3 projectionMatrix;

// // outputs for the vertex & inputs for the fragment
varying vec2 vTextureCoord;
varying vec4 vColor;

void main() {
    gl_Position = vec4((projectionMatrix* vec3(aVertexPosition, 1.0)).xy, 0.0, 1.0);
    vTextureCoord = aTextureCoord;
    vColor = vec4(aColor.rgb * aColor.r, aColor.a);
}
