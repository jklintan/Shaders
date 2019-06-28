# version 330 core

//Global variables
uniform float time;
uniform int colorMode = 0;
uniform int numb = 200;
uniform float enhanceFactor = 5;
uniform float speed;
uniform vec2 resolution;

in vec3 normals;
in vec3 position;
out vec4 FragColor;  

//Generate 2 somewhat random numbers
vec2 random2( vec2 p, float i ) {
    return fract(sin(vec2(dot(p,vec2(15.2,i)),dot(p,vec2(26,18))))*4785.3);
}

//Generate pseudo random numbers, following "The book of Shaders"
float random(vec2 st) {
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

void main()
{
	const int SEEDS = 500;

	//Get the coord. position on the window
    vec2 thePosition = gl_FragCoord.xy/resolution.xy;

	//Set the backgroundcolor
	vec3 color = vec3(0);

    // Store the points in a vector
    vec2 point[SEEDS];
    float minDist = 1;  

    // Iterate through the points positions
    for (int i = 0; i < SEEDS; i++) {
		
		//If moving
		//point[i] = random2(vec2(float(i),float(i)), sin(time/2000000));

		//If not moving
		point[i] = random2(vec2(float(i), float(i)), i*i/323132);
		
		//Calculate the distance between the coordinate and the current point
        float dist = distance(thePosition, point[i]);

        //Update the minimum distance only if the new distance is smaller
        minDist = min(minDist, dist);
    }

    //Highlight the color for the minimum distance
    color += minDist*enhanceFactor;

	//Display the seeds
	color += (1.-step(.002, minDist))*0.3;

	//Set the output color
    FragColor = vec4(color,1.0);
}







//Thoughts
//Want to be able to locate a preset number of points
//Send in uniform variables by using a menu interface
//Extend by the possibility to add roughness to the surface??