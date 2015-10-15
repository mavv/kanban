#ifdef GL_ES
	precision highp float;
#endif

uniform vec2 resolution;
uniform float time;
uniform sampler2D sampler;
uniform float noiseValue;
uniform float scratchValue;
uniform float randomValue;

varying vec2 vUv;

vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x*34.0)+1.0)*x); }

float snoise (vec2 v)
{
	const vec4 C = vec4(0.211324865405187,	// (3.0-sqrt(3.0))/6.0
						0.366025403784439,	// 0.5*(sqrt(3.0)-1.0)
						-0.577350269189626,	// -1.0 + 2.0 * C.x
						0.024390243902439);	// 1.0 / 41.0

	// First corner
	vec2 i  = floor(v + dot(v, C.yy) );
	vec2 x0 = v -   i + dot(i, C.xx);

	// Other corners
	vec2 i1;
	i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
	vec4 x12 = x0.xyxy + C.xxzz;
	x12.xy -= i1;

	// Permutations
	i = mod289(i); // Avoid truncation effects in permutation
	vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
		+ i.x + vec3(0.0, i1.x, 1.0 ));

	vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
	m = m*m ;
	m = m*m ;

	// Gradients: 41 points uniformly over a line, mapped onto a diamond.
	// The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)

	vec3 x = 2.0 * fract(p * C.www) - 1.0;
	vec3 h = abs(x) - 0.5;
	vec3 ox = floor(x + 0.5);
	vec3 a0 = x - ox;

	// Normalise gradients implicitly by scaling m
	// Approximation of: m *= inversesqrt( a0*a0 + h*h );
	m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );

	// Compute final noise value at P
	vec3 g;
	g.x  = a0.x  * x0.x  + h.x  * x0.y;
	g.yz = a0.yz * x12.xz + h.yz * x12.yw;
	return 130.0 * dot(m, g);
}

void main() {
    float noise = snoise(vUv * vec2(1024.0 + randomValue * 512.0, 1024.0 + randomValue * 512.0)) * 0.5;
	finalColour += noise * noiseValue;

    // Step 5: Apply scratches
	if ( RandomValue < scratchValue )
	{
		// Pick a random spot to show scratches
		float dist = 1.0 / scratchValue;
		float d = distance(vUv, vec2(RandomValue * dist, RandomValue * dist));
		if ( d < 0.4 )
		{
			// Generate the scratch
			float xPeriod = 8.0;
			float yPeriod = 1.0;
			float pi = 3.141592;
			float phase = TimeLapse;
			float turbulence = snoise(vUv * 2.5);
			float vScratch = 0.5 + (sin(((vUv.x * xPeriod + vUv.y * yPeriod + turbulence)) * pi + phase) * 0.5);
			vScratch = clamp((vScratch * 10000.0) + 0.35, 0.0, 1.0);

			finalColour.xyz *= vScratch;
		}
	}
}
// precision mediump float;
//
// uniform vec2 resolution;
// uniform float time;
//
// varying vec2 vTextureCoord;
// uniform sampler2D uSampler;
//
//
// // 2D Random
// float random (in vec2 st) {
//     return fract(sin(dot(st.xy,
//                          vec2(12.9898,78.233)))
//                  * 43758.5453123);
// }
//
// // 2D Noise based on Morgan McGuire @morgan3d
// // https://www.shadertoy.com/view/4dS3Wd
// float noise (in vec2 st) {
//     vec2 i = floor(st);
//     vec2 f = fract(st);
//
//     // Four corners in 2D of a tile
//     float a = random(i) * time;
//     float b = random(i + vec2(1.0, 0.0));
//     float c = random(i + vec2(0.0, 1.0));
//     float d = random(i + vec2(1.0, 1.0));
//
//     // Smooth Interpolation
//
//     // Cubic Hermine Curve.  Same as SmoothStep()
//     vec2 u = f*f*(3.0-2.0*f);
//     // u = smoothstep(0.,1.,f);
//
//     // Mix 4 coorners porcentages
//     return mix(a, b, u.x) +
//             (c - a)* u.y * (1.0 - u.x) +
//             (d - b) * u.x * u.y;
// }
//
// void main(void)
// {
//     vec4 pixel = texture2D(uSampler, vTextureCoord);
//     // pixel.r = 0.1;
//     // pixel.g = 0.2;
//     // pixel.b = 0.3;
//     pixel.a = 0.;
//     gl_FragColor = pixel;
//
//     // vec2 st = gl_FragColor.xy / resolution.xy;
//     // vec2 pos = vec2(st*5.0);
//     // float n = noise(pos);
//     // gl_FragColor = vec4(vec3(n), 1.0);
// }
