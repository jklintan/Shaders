# version 330 core
/*
Visualization of the Julia set. The Julia set J(f) is the
smallest closed set containing at least three points
which is completely invariant under f.
Source: https://en.wikipedia.org/wiki/Julia_set
*/

// Global variables
uniform float time;

// 2D coordinates
in vec2 xyCoords;
// Output fragment color
out vec4 FragColor;

// Add two complex number c = x + yi together
vec2 complex_add(vec2 lhs, vec2 rhs)
{
	return vec2(lhs.x + rhs.x, lhs.y + rhs.y);
}

// Multiply two complex number c = x + yi together
vec2 complex_mul(vec2 lhs, vec2 rhs)
{
	return vec2(lhs.x * rhs.x - lhs.y * rhs.y, lhs.x * rhs.y + lhs.y * rhs.x);
}

// Determine which points on the screen that belongs to
// the Julia set and which does not.
float julia_iteration(float max_iters, vec2 z, vec2 c) {
	for(int i = 0 ; i < max_iters ; i++) {
		if(length(z) > 2.0) {
			return i/max_iters;
		}

		// Find new z which we calculate from
		// f(z) = z^2 + c
		vec2 z_squared = complex_mul(z, z);
		z = complex_add(z_squared, c);
	}
	// This will determine the background color
	// e.g. this is a number not part of the Julia set.
	return 0.0;
}

void main()
{
	// Animation parameters, use a Hermite interpolation
	const float timespan = 20.0;  // Reset animation after 20s
	float w = smoothstep(0.0, 40.0, fract(time/timespan));
	float scale_anim_param = 1.0 + smoothstep(2.0, 0.1, fract(time/timespan));
	float anim_param = 0.64 + 80.0 * w;

	// Get the complex number to base the Julia set on, using
	// different complex numbers gives different looks of the
	// Julia set. Some interesting numbers are:
	// c = -0.70176 - 0.3842i
	// c = 0.285 + 0.01i
	// c = -0.835 - 0.2321i
	// c = -0.4 + 0.6i
	
	// c = i, a dendrite fractal (on the boundary of the Mandelbrot set)
	// c = -0.123 + 0.745i, Douady's rabbit fractal
	// c = -0.75, the San Marco fractal
	// c = -0.391 - 0.587i, the Siegel disk fractal

	vec2 complex_number = vec2(-0.835, -0.2321);

	// By multiplying the complex number with the anim_param
	// we can get interesting animations of the set.
	// complex_number = complex_mul(complex_number, vec2(anim_param, anim_param));

	float color = julia_iteration(1000, xyCoords * 2, complex_number);
	float multiplier = 2.0; // Used to enhance the colors & contrast.
	FragColor = vec4(vec3(color) * multiplier, 1.0);
}
