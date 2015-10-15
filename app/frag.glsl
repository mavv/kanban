precision mediump float;

uniform vec2 resolution;
uniform float time;

varying vec2 vTextureCoord;
uniform sampler2D uSampler;


void main(void)
{
    // gl_FragColor = texture2D(uSampler, vTextureCoord);
    // gl_FragColor = vec4(vec3(0.3,0.2,1.0),1.0);
    vec4 pixel = texture2D(uSampler, vTextureCoord);
    pixel.r = 0.4;
    pixel.a = 0.3;
    gl_FragColor = pixel;
}
