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
  
  // Highlight system
  uniform vec2 uHighlightCenter;
  uniform float uHighlightRadius;
  uniform float uHighlightIntensity;
  
  // Advanced AR
  uniform float uSkinSmoothing; // 0.0 to 1.0
  uniform vec3 uHairColor;
  uniform float uHairIntensity;

  varying vec2 vUv;

  void main() {
    // Start with a transparent base or skin-like base
    vec4 finalColor = vec4(1.0, 1.0, 1.0, 0.0);

    // Apply Foundation (with smoothing simulation)
    // Smoothing is simulated by mixing more of the foundation color and reducing texture noise (noise not present in procedural base)
    float baseOpacity = uFoundationOpacity + (uSkinSmoothing * 0.1);
    finalColor = mix(finalColor, vec4(uFoundationColor, 1.0), baseOpacity);

    // Procedural Blush Mask
    float blushMask = smoothstep(0.4, 0.2, distance(vUv, vec2(0.3, 0.4))) + 
                      smoothstep(0.4, 0.2, distance(vUv, vec2(0.7, 0.4)));
    finalColor.rgb = mix(finalColor.rgb, uBlushColor, blushMask * uBlushOpacity);

    // Procedural Lipstick Mask
    float lipstickMask = smoothstep(0.1, 0.05, distance(vUv, vec2(0.5, 0.2)));
    finalColor.rgb = mix(finalColor.rgb, uLipstickColor, lipstickMask * uLipstickOpacity);

    // Hair Coloring (Simulated via upper UV boundary)
    float hairMask = smoothstep(0.7, 0.9, vUv.y);
    finalColor.rgb = mix(finalColor.rgb, uHairColor, hairMask * uHairIntensity);

    // Dynamic Highlighting
    float highlightDist = distance(vUv, uHighlightCenter);
    float highlightMask = smoothstep(uHighlightRadius, uHighlightRadius * 0.2, highlightDist);
    finalColor.rgb += vec3(1.0, 1.0, 1.0) * highlightMask * uHighlightIntensity;
    finalColor.a = max(finalColor.a, highlightMask * uHighlightIntensity);
    
    // Final Alpha
    finalColor.a = max(finalColor.a, baseOpacity);
    finalColor.a = max(finalColor.a, hairMask * uHairIntensity);

    gl_FragColor = finalColor;
  }
`;
