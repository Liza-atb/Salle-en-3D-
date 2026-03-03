#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

// Données venant du vertex shader
varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 ecPosition;
varying vec2 uv;

// Paramètres Processing (Lumières et Textures)
uniform int lightCount;
uniform vec4 lightPosition[8];
uniform vec3 lightDiffuse[8];
uniform vec3 lightAmbient[8];
uniform sampler2D texture;

void main() {
  vec3 normal = normalize(ecNormal);
  vec3 totalDiffuse = vec3(0.0);
  vec3 ambientSum = vec3(0.0);
  
  // Récupère la couleur de la texture à l'endroit UV
  vec4 texColor = texture2D(texture, uv);

  for (int i = 0; i < lightCount; i++) {
    // Calcul de la direction de la lumière
    vec3 lightDir = normalize(lightPosition[i].xyz - ecPosition);
    
    // Lambert (Lumière diffuse)
    float intensity = max(0.0, dot(lightDir, normal));
    totalDiffuse += lightDiffuse[i] * intensity;
    
    // Ajout de la lumière ambiante
    ambientSum += lightAmbient[i];
  }

  // Fusion finale : (Couleur Objet * Texture) * Lumière + Ambiante
  vec3 finalRGB = vertColor.rgb * texColor.rgb * (totalDiffuse + ambientSum);
  gl_FragColor = vec4(finalRGB, vertColor.a * texColor.a);
}
