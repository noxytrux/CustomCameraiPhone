precision mediump float;

attribute vec4 position;
attribute vec2 texCoord;

uniform mat4 modelview;

varying highp vec2 texCoordVarying;

void main()
{
    gl_Position = modelview * position;
    texCoordVarying = texCoord;
}
