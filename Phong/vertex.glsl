#version 330 core

layout (location = 0) in vec3 Position;
layout (location = 1) in vec3 Normal;
  
// Output to the fragment shader
out vec3 normals; 
out vec3 position;

// Simply pass along the positions and normals.
void main(){
    gl_Position = vec4(Position, 1.0); 
	normals = Normal;
	position = Position;
}  
