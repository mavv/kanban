precision highp float;

#define PI 3.14159265359


uniform float randomValue;
uniform float noiseValue;
uniform float scratchValue;

uniform sampler2D uSampler;
uniform vec2 uResolution;
uniform float timeLapse;

varying vec2 vTextureCoord;

const float scratchDistance = .8; // leave this to 0.6, kthxbye
const float xPeriod = 1.;
const float yPeriod = 1.;
const float multi = .3;

vec3 Overlay (vec3 src, vec3 dst) {
	return vec3((dst.x <= 0.5) ? (2.0 * src.x * dst.x) : (1.0 - 2.0 * (1.0 - dst.x) * (1.0 - src.x)),
				(dst.y <= 0.5) ? (2.0 * src.y * dst.y) : (1.0 - 2.0 * (1.0 - dst.y) * (1.0 - src.y)),
				(dst.z <= 0.5) ? (2.0 * src.z * dst.z) : (1.0 - 2.0 * (1.0 - dst.z) * (1.0 - src.z)));
}

vec2 mod289(vec2 x) {
	return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec3 mod289(vec3 x) {
	return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec3 permute(vec3 x) {
	return mod289(((x*34.0)+1.0)*x);
}

float snoise (vec2 v) {
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

void main()
{

	vec3 colour = texture2D(uSampler, vTextureCoord).xyz;
    vec3 finalColour = colour;



    float noise = snoise(vTextureCoord * vec2(1024. + randomValue * 512., 1024. + randomValue * 512.)) * 0.5;
	finalColour += noise * noiseValue;
	vec3 noiseOverlay = Overlay(finalColour, vec3(noise));
	finalColour = finalColour + clamp(.1 * (finalColour - noiseOverlay), 0., 1.);

    float dist = 1.0 / scratchValue;
    float d = distance(vTextureCoord, vec2(randomValue * dist));

	if (d < scratchDistance) {
		// TODO: extract constants
		float turbulence = snoise(vTextureCoord * 2.66) * .5; //clamp(snoise(vTextureCoord * 2.5), .4, .8);
		float vScratch = 0.;
		float scratchBase = (vTextureCoord.x * xPeriod + vTextureCoord.y * yPeriod + turbulence) * PI + timeLapse;
		if (randomValue < 20.) {
			vScratch = multi + sin(scratchBase) * multi;//multi + sin(scratchBase) * multi;//multi + sin(scratchBase) * multi;
			// vScratch = clamp((vScratch * 50000.) + .0001, .0, 1.);
		} else if (randomValue < 40.) {
			vScratch = multi + cos(scratchBase) * multi;
			// vScratch = clamp((vScratch * 50000.) + .0001, .0, 1.);
		} else if (randomValue < 60.) {
			vScratch /= 4.;
		} else if (randomValue < 80.) {
			vScratch /= 4.;
		} else {
			vScratch /= 4.;
		}
		// if (randomValue < 50.) {
		// 	vScratch = multi + sin(scratchBase) * multi;//multi + sin(scratchBase) * multi;//multi + sin(scratchBase) * multi;
		// 	// vScratch = clamp((vScratch * 50000.) + .0001, .0, 1.);
		// } else {
		// 	vScratch = multi + cos(scratchBase) * multi;
		// 	// vScratch = clamp((vScratch * 50000.) + .0001, .0, 1.);
		// }
		// if (randomValue < 25.) {
		// 	vScratch = multi + sin(scratchBase) * multi;
		// 	vScratch = clamp((vScratch * 10000.) + .1, .0, 1.);
		// } else if (randomValue < 50.){
		// 	vScratch = multi + cos(scratchBase) * multi;
		// 	vScratch = clamp((vScratch * 10000.) + .1, .0, 1.);
		// } else if (randomValue < 75.){
		// 	vScratch = multi + sin(fract(pow(scratchBase, 3.))) * multi;
		// 	vScratch = clamp((vScratch * 10000.) + .1, .0, 1.);
		// } else {
		// 	vScratch = multi + cos(fract(pow(scratchBase, 3.))) * multi;
		// 	vScratch = clamp((vScratch * 10000.) + .1, .0, 1.);
		// }
		vScratch = clamp((vScratch * 10000.) + .3, .0, 1.);
		finalColour.xyz /= vScratch; //smoothstep(0., 1., vScratch);
	}


    gl_FragColor = vec4(finalColour, 1.);
}
