"use client";

import { Canvas, useFrame } from "@react-three/fiber";
import { OrbitControls, PerspectiveCamera, Environment, useTexture } from "@react-three/drei";
import { Suspense, useRef, useMemo } from "react";
import * as THREE from "three";
import { useFaceMesh } from "../hooks/useFaceMesh";
import { JewelryAnchor, Earring } from "./JewelryComponents";

import { TRIANGULATION, UV_MAP } from "../lib/faceMeshConstants";
import { BeautyVertexShader, BeautyFragmentShader } from "../lib/BeautyShader";
import { SkinToneResult, sampleSkinTone } from "../lib/skinAnalysis";

function FaceMeshGeometry({ results, videoRef, onAnalysis }: { results: any, videoRef: React.RefObject<HTMLVideoElement>, onAnalysis?: (res: SkinToneResult) => void }) {
  const meshRef = useRef<THREE.Mesh>(null);
  
  const uniforms = useMemo(() => ({
    uFoundationColor: { value: new THREE.Color("#f5d1c3") },
    uFoundationOpacity: { value: 0.2 },
    uBlushColor: { value: new THREE.Color("#ffb6c1") },
    uBlushOpacity: { value: 0.5 },
    uLipstickColor: { value: new THREE.Color("#e0115f") },
    uLipstickOpacity: { value: 0.8 }
  }), []);

  useFrame(() => {
    if (results && results.multiFaceLandmarks && results.multiFaceLandmarks.length > 0) {
      const landmarks = results.multiFaceLandmarks[0];

      // Periodically sample skin tone
      if (videoRef.current && Math.random() < 0.01) { 
        const analysis = sampleSkinTone(videoRef.current, landmarks);
        if (analysis) {
          uniforms.uFoundationColor.value.set(analysis.hex);
          if (onAnalysis) onAnalysis(analysis);
        }
      }

      const positions = meshRef.current?.geometry.attributes.position;
      
      if (positions) {
        for (let i = 0; i < landmarks.length; i++) {
          const landmark = landmarks[i];
          positions.setXYZ(i, (landmark.x - 0.5) * 5, -(landmark.y - 0.5) * 5, -landmark.z * 5);
        }
        positions.needsUpdate = true;
      }
    }
  });

  const geometry = useMemo(() => {
    const geo = new THREE.BufferGeometry();
    const vertices = new Float32Array(468 * 3);
    const uvs = new Float32Array(468 * 2);
    
    // Fill initial vertices and UVs
    for (let i = 0; i < 468; i++) {
      uvs[i * 2] = UV_MAP[i]?.[0] || 0.5;
      uvs[i * 2 + 1] = UV_MAP[i]?.[1] || 0.5;
    }

    geo.setAttribute('position', new THREE.BufferAttribute(vertices, 3));
    geo.setAttribute('uv', new THREE.BufferAttribute(uvs, 2));
    geo.setIndex(TRIANGULATION);
    
    return geo;
  }, []);

  return (
    <mesh geometry={geometry}>
      <shaderMaterial
        vertexShader={BeautyVertexShader}
        fragmentShader={BeautyFragmentShader}
        uniforms={uniforms}
        transparent
        side={THREE.DoubleSide}
      />
    </mesh>
  );
}

export default function BeautyScene({ onAnalysis }: { onAnalysis?: (res: SkinToneResult) => void }) {
  const { results, videoRef } = useFaceMesh();

  return (
    <div className="w-full h-full relative">
      {/* Hidden video element for MediaPipe processing */}
      <video ref={videoRef} className="hidden" playsInline muted />
      
      <Canvas shadows>
        <PerspectiveCamera makeDefault position={[0, 0, 5]} fov={50} />
        <OrbitControls 
          enableDamping 
          dampingFactor={0.05}
          minDistance={1}
          maxDistance={10}
        />
        
        <ambientLight intensity={0.5} />
        <pointLight position={[10, 10, 10]} intensity={1} />

        <Suspense fallback={null}>
          <FaceMeshGeometry results={results} videoRef={videoRef} onAnalysis={onAnalysis} />
          
          {/* Virtual Jewelry Try-On */}
          {results && (
            <>
              {/* Left Ear */}
              <JewelryAnchor results={results} landmarkIndex={234}>
                <Earring />
              </JewelryAnchor>
              {/* Right Ear */}
              <JewelryAnchor results={results} landmarkIndex={454}>
                <Earring />
              </JewelryAnchor>
            </>
          )}

          <Environment preset="soft" />
        </Suspense>
      </Canvas>

      {/* Mini preview of the actual camera feed */}
      <div className="absolute top-4 right-4 w-32 h-24 rounded-2xl overflow-hidden border-2 border-white/40 glass-card">
        <video 
          ref={(el) => { if (el && videoRef.current) el.srcObject = videoRef.current.srcObject; }} 
          autoPlay 
          muted 
          className="w-full h-full object-cover scale-x-[-1]"
        />
      </div>
    </div>
  );
}
