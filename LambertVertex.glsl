#define PROCESSING_TEXLIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 ecPosition;
varying vec2 uv;

void main() {
  // Position projetée à l'écran
  gl_Position = transform * position;
  
  // Position et normales dans l'espace "caméra"
  ecPosition = vec3(modelview * position);
  ecNormal = normalize(normalMatrix * normal);
  
  // Passage des données au Fragment Shader
  vertColor = color;
  uv = texCoord;
}
