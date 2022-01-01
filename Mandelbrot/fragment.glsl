# version 330 core

/*
Visualization of the Mandelbrot set based on a static
number of iterations per pixel.

The Mandelbrot set is the set of numbers c for which
the function f(z) = z^2 + c does not diverge to
infinity from z = 0 (when f(0), f(f(0)), etc remains
bounded in absolute value).
Source: https://en.wikipedia.org/wiki/Mandelbrot_set
*/

// Global variables
uniform float time;

// Image resolution
uniform float width;
uniform float height;

in vec2 xyCoords;
out vec4 FragColor;

// Square a complex number x + yi
vec2 square_imaginary(vec2 complex_n) {
	return vec2(
		pow(complex_n.x, 2) - pow(complex_n.y, 2), 
		2 * complex_n.x*complex_n.y
	);
}

// Determine which points on the screen that belongs to
// the Mandelbrot set and which does not.
// A coordinate c will always be in a closed disk of
// radius 2 around the origin, e.g. the absolute value
// of z_n must remain at or below 2 for c to be in the
// Mandelbrot set.
float mandelbrot_iteration(float max_iters, vec2 coord) {
	vec2 z_n = vec2(0.0, 0.0);
	for(int i = 0 ; i < max_iters ; i++) {
		z_n = square_imaginary(z_n) + coord;
		if(length(z_n) > 2.0) {
			return i/max_iters;
		}
	}
	return max_iters;
}
  
void main()
{
	// Animation parameters, use a Hermite interpolation
	const float timespan = 20.0;  // Reset animation after 20s
	float w = smoothstep(0.0, 1.0, fract(time/timespan));

	float scale = 2.0;
	float anim_param = 0.0 + 75.0 * w;
	float k = mandelbrot_iteration(anim_param, (xyCoords) * scale);
	FragColor = vec4(vec3(0.0, 0.0, 0.0) + k, 1.0);
}