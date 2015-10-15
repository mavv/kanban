// attribute vec3 vertex;
// attribute vec2 Uv;
//
//
//
// uniform mat4 projectionMatrix;
// uniform mat4 viewMatrix;
// uniform mat4 modelMatrix;
// uniform vec3 modelScale;
//
// varying vec2 vUv;
//
// void main() {
// 	vec4 worldVertex = modelMatrix * vec4(vertex * modelScale, 1.0);
// 	vec4 viewVertex = viewMatrix * worldVertex;
// 	gl_Position = projectionMatrix * viewVertex;
// 	vUv = Uv;
//
// }

//
// attribute vec3 position;
// attribute vec2 Uv;
//
// varying vec2 vUv;
//
//
// void main() {
//     gl_Position = gl_
// }

uniform mat4 u_modelViewProjMatrix;
    uniform mat4 u_normalMatrix;
    uniform vec3 lightDir;

    attribute vec3 vNormal;
    attribute vec4 vTexCoord;
    attribute vec4 vPosition;

    varying float v_Dot;
    varying vec2 v_texCoord;

    void main()
    {
        gl_Position = u_modelViewProjMatrix * vPosition;
        v_texCoord = vTexCoord.st;
        vec4 transNormal = u_normalMatrix * vec4(vNormal, 1);
        v_Dot = max(dot(transNormal.xyz, lightDir), 0.0);
    }
