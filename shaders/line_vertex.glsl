#version 100
precision mediump float;

uniform mat4 matrix;

attribute vec4 position;

void main() {
    gl_Position = matrix * position;
}
