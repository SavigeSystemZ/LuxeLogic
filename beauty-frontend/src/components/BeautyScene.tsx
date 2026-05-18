"use client";

import { Canvas, useFrame } from "@react-three/fiber";
import { OrbitControls, PerspectiveCamera, Environment, useTexture } from "@react-three/drei";
import { Suspense, useRef, useMemo, useEffect, useState } from "react";
import * as THREE from "three";
import { useFaceMesh } from "../hooks/useFaceMesh";
import { JewelryAnchor, Earring } from "./JewelryComponents";

import { TRIANGULATION, UV_MAP } from "../lib/faceMeshConstants";
import { BeautyVertexShader, BeautyFragmentShader } from "../lib/BeautyShader";
import { SkinToneResult, sampleSkinTone } from "../lib/skinAnalysis";

function FaceMeshGeometry({ results, videoRef, onAnalysis, activeAction }: { results: any, videoRef: React.RefObject<HTMLVideoElement>, onAnalysis?: (res: SkinToneResult) => void, activeAction?: any }) {
  const meshRef = useRef<THREE.Mesh>(null);
  const [isReady, setIsReady] = useState(false);
  
  const uniforms = useMemo(() => ({
    uFoundationColor: { value: new THREE.Color("#f5d1c3") },
    uFoundationOpacity: { value: 0.2 },
    uBlushColor: { value: new THREE.Color("#ffb6c1") },
    uBlushOpacity: { value: 0.5 },
    uLipstickColor: { value: new THREE.Color("#e0115f") },
    uLipstickOpacity: { value: 0.8 },
    uHighlightCenter: { value: new THREE.Vector2(0.0, 0.0) },
    uHighlightRadius: { value: 0.0 },
    uHighlightIntensity: { value: 0.0 },
    uSkinSmoothing: { value: 0.5 },
    uHairColor: { value: new THREE.Color("#4b2c20") },
    uHairIntensity: { value: 0.0 },
    uTime: { value: 0.0 }
  }), []);

  useEffect(() => {
    if (activeAction) {
       // ... existing action logic ...
       if (activeAction.type === 'apply_makeup' && activeAction.color) {
        if (activeAction.makeup_type === 'lipstick' || activeAction.target === 'lips') {
           uniforms.uLipstickColor.value.set(activeAction.color);
        } else if (activeAction.makeup_type === 'blush' || activeAction.target === 'cheeks') {
           uniforms.uBlushColor.value.set(activeAction.color);
        } else if (activeAction.makeup_type === 'foundation') {
           uniforms.uFoundationColor.value.set(activeAction.color);
        } else if (activeAction.makeup_type === 'hair') {
           uniforms.uHairColor.value.set(activeAction.color);
           uniforms.uHairIntensity.value = 0.6;
        }
      } else if (activeAction.type === 'set_smoothing') {
        uniforms.uSkinSmoothing.value = activeAction.value || 0.5;
      }
    }
  }, [activeAction, uniforms]);

  useFrame((state) => {
    uniforms.uTime.value = state.clock.getElapsedTime();
    if (results && results.multiFaceLandmarks && results.multiFaceLandmarks.length > 0) {
      setIsReady(true);
      const landmarks = results.multiFaceLandmarks[0];
      // ... existing landmark positioning ...
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
    <>
      {/* Fallback Silhouette when no face is tracked */}
      {!isReady && (
        <mesh position={[0, 0, -1]}>
          <sphereGeometry args={[1.5, 32, 32]} />
          <meshStandardMaterial color="#fff" transparent opacity={0.1} wireframe />
        </mesh>
      )}
      
      <mesh geometry={geometry} ref={meshRef}>
        <shaderMaterial
          vertexShader={BeautyVertexShader}
          fragmentShader={BeautyFragmentShader}
          uniforms={uniforms}
          transparent
          side={THREE.DoubleSide}
        />
      </mesh>

      {/* Permanent Reference Points for tracking verification */}
      {results && results.multiFaceLandmarks && results.multiFaceLandmarks.length > 0 && (
        <points>
          <bufferGeometry>
             <bufferAttribute
               attach="attributes-position"
               count={results.multiFaceLandmarks[0].length}
               array={new Float32Array(results.multiFaceLandmarks[0].flatMap(l => [(l.x - 0.5) * 5, -(l.y - 0.5) * 5, -l.z * 5]))}
               itemSize={3}
             />
          </bufferGeometry>
          <pointsMaterial size={0.02} color="#ff00ff" transparent opacity={0.5} sizeAttenuation />
        </points>
      )}

      {/* Axis Helper for visual orientation */}
      <axesHelper args={[1]} />
    </>
  );
}

export default function BeautyScene({ onAnalysis, activeAction }: { onAnalysis?: (res: SkinToneResult) => void, activeAction?: any }) {
  const { results, videoRef } = useFaceMesh();

  return (
    <div className="w-full h-full relative">
      {/* Hidden video element for MediaPipe processing */}
      <video ref={videoRef} className="hidden" playsInline muted />
      
      <Canvas shadows dpr={[1, 1.5]} gl={{ antialias: false, powerPreference: "high-performance" }}>
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
          <FaceMeshGeometry results={results} videoRef={videoRef} onAnalysis={onAnalysis} activeAction={activeAction} />
          
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

          <Environment preset="city" />
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
