#version 330 core

layout (location = 0) in vec3 inPos;   // the position variable has attribute position 0
layout (location = 1) in vec3 inNorm; // the normal variable has attribute position 1
  
out vec3 normals;
out vec3 position;

void main(){

    //Set the position for the vertices
    gl_Position = vec4(inPos, 1.0);

    //Send to fragment shader
    position = inPos;
    normals = inNorm;
}