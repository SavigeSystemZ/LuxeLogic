export const BeautyVertexShader = `
  varying vec2 vUv;
  void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
  }
`;

export const BeautyFragmentShader = `
  uniform vec3 uFoundationColor;
  uniform float uFoundationOpacity;
  uniform vec3 uBlushColor;
  uniform float uBlushOpacity;
  uniform vec3 uLipstickColor;
  uniform float uLipstickOpacity;
  varying vec2 vUv;

  void main() {
    // Start with a transparent base or skin-like base
    vec4 finalColor = vec4(1.0, 1.0, 1.0, 0.0);

    // Apply Foundation
    finalColor = mix(finalColor, vec4(uFoundationColor, 1.0), uFoundationOpacity);

    // Procedural Blush Mask (simplified for prototype)
    float blushMask = smoothstep(0.4, 0.2, distance(vUv, vec2(0.3, 0.4))) + 
                      smoothstep(0.4, 0.2, distance(vUv, vec2(0.7, 0.4)));
    finalColor.rgb = mix(finalColor.rgb, uBlushColor, blushMask * uBlushOpacity);

    // Procedural Lipstick Mask (simplified for prototype)
    float lipstickMask = smoothstep(0.1, 0.05, distance(vUv, vec2(0.5, 0.2)));
    finalColor.rgb = mix(finalColor.rgb, uLipstickColor, lipstickMask * uLipstickOpacity);

    gl_FragColor = finalColor;
  }
`;
