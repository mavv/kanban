attribute vec3 vertex;
attribute vec2 Uv;

// uniform mat4 projectionMatrix;
// uniform mat4 viewMatrix;
// uniform mat4 modelMatrix;
// uniform vec3 modelScale;

varying vec2 vwUv;
varying vec2 vTextureCoord;
varying vec4 vColor;
void main() {
    vwUv = vec2(1.0, 1.0);
	// vec4 worldVertex = modelMatrix * vec4(vertex * modelScale, 1.0);
	// vec4 viewVertex = viewMatrix * worldVertex;
	// gl_Position = projectionMatrix * viewVertex;
    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
	// vwUv = Uv;

}
