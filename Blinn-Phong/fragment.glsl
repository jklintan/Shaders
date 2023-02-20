# version 330 core

// Inputs from vertex shader.
in vec3 normals;
in vec3 position;

// Output fragment colors.
out vec4 frag_color;

// Reflection constants for the Blinn-Phong reflection model.
// Each one is separated into RGB parameters, essentially
// deciding the color of the reflections.
const vec3 k_ambient = vec3(0.3f, 0.3f, 0.3f);
const vec3 k_diffuse = vec3(0.3f, 0.3f, 0.3f);
const vec3 k_specular = vec3(1.0f, 1.0f, 1.0f);

// Alpha can be seen as a shininess constant, a low value
// gives a large reflection = not so shiny. A high value
// gives a small reflection = shiny (metal like).
const float alpha = 32;

// In this simple case we model a static light point
// in the 3D space with a specific intensity, as well
// as having the camera static on a position in the
// positive z-axis. These could of course all 3 be
// sent in as a uniform instead.
vec3 light_position = vec3(-2.0f, 2.0f, 5.0f);
vec3 light_intensity = vec3(1.0f, 1.0f, 1.0f);
vec3 camera_position = vec3(0.0f, 0.0f, 2.0f);

void main() {
	vec3 light_direction = light_position - position;
	light_intensity = normalize(light_intensity);

	// Ambient reflections.
	// The ambient reflection is simply the light intensity
	// times the ambient reflection constant.
	vec3 Ia = k_ambient * light_intensity;

	// Diffuse reflections.
	// In this case we have only 1 light source but this can easily
	// be extended to be a sum over number of light sources.
	// k_diffuse * dot(LightDirection, Normal) * lightIntesity
	vec3 N = normalize(normals);
	vec3 L = normalize(light_direction);
	float LdotN = dot(L, N);
	vec3 Id = k_diffuse * clamp(LdotN, 0.0, 1.0) * light_intensity;

	// Specular reflections.
	// The same is valid as for diffuse reflections, that
	// this can easily be extended as a sum over the number
	// of lightsources in the scene.
	// k_specular * dot(N, H)^alpha * lightIntensity
	vec3 Is = vec3(0.0, 0.0, 0.0);

	// Double check that the light source is in front of the
	// current pixel, otherwise we can get an error where
	// the back of our object gets lit as well.
	if(LdotN > 0.0) {
		// Calculate the view-vector and the half-way vector.
		vec3 V =  normalize(camera_position - position);
		vec3 H = normalize(L + V);
		float NdotH = dot(N, H);
		Is = k_specular * pow(max(NdotH, 0.0), alpha) * light_intensity;
	}

	// Add together all the reflection terms and set fragment colors.
	frag_color = vec4(Ia + Id + Is, 1.0);
}
