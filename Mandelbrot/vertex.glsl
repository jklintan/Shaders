#version 330 core

//Uniform variables
uniform float time;

layout (location = 0) in vec3 aPos;   // the position variable has attribute position 0
layout (location = 1) in vec3 aColor; // the color variable has attribute position 1

out vec2 xyCoords;

void main(){
    gl_Position = vec4(aPos, 1.0);
    xyCoords = aPos.xy;
}  