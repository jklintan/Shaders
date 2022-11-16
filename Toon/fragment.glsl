# version 330 core

// Inputs from vertex shader.
in vec3 normals;
in vec3 position;

// Output fragment colors.
out vec4 frag_color;

// In this simple toon shader, we have an object color which
// will be the base, a slightly darker shade of this will be
// added as a toon effect.
const vec3 object_color = vec3(0.79f);

// In this case, a small value of this specular exponent
// will give large speculars (shiny feeling) and a large
// value will give small speculars (not shiny). Opposite
// compared to in the Phong reflection due to since we
// represent the speculars with a sharp edge. The only
// thing that will influence the feeling of shininess in
// the material is the size of the specular reflections.
const float specular_exponent = 2;

// In this simple case we model a static light point
// in the 3D space as well as a static camera (view)
// position.
const vec3 light_position = vec3(-3.0f, 3.0f, 5.0f);
const vec3 camera_position = vec3(0.0f, 0.0f, 2.0f);

void main() {

	vec3 output_color = vec3(object_color);

	// Calculate view, light and normal vectors.
	vec3 V = normalize(camera_position - position);
	vec3 L = normalize(light_position - position);
	vec3 N = normalize(normals);
	float NdotL = dot(N, L);

	// Here we calculate the specular highlights.
	// We create a scale factor that is linearly
	// dependent on the distance to the light.
	float vtx_to_light = length(vec3(light_position - position));
	float attenuation = 1.0 / vtx_to_light;

	// Similarly to in the Phong reflection model
	// we only add specular highlights where dot(N, L)
	// is above 0 to not get highlights in backfacing
	// areas. We also borrow some things from the
	// Blinn-Phong model, by using the half-way vector
	// to decide where the specular highlights will be.
	vec3 halfway_vec = normalize(L + V);
	float speculars = attenuation * pow(max(0.0, dot(N, halfway_vec)), specular_exponent);

	// To obtain our toon effect also in the highlights
	// we only add speculars over a specific value. But
	// this can of course be altered to get other effects
	// and to simulate different shininess.
	if(NdotL > 0.0 && speculars > 0.15) {
		output_color += speculars;
	}

	// Create an outline around the object, it might take
	// some altering of the edge values to find the best
	// balance depending on the object.
	float outline = smoothstep(0.32, 0.33, N[2]);

	// The toon effect is essentially created by using a
	// smoothstep to add a slightly darker version of the
	// object color. The edge values can be altered to
	// change where this color switch takes place.
	float toon_effect = 0.5 * smoothstep(0.50, 0.51, NdotL) + 0.5;

	// Add together the toon effect and the outline.
	frag_color = vec4(output_color * toon_effect * outline, 1.0);
}
