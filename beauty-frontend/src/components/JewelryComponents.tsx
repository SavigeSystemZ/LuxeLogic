"use client";

import { useRef } from "react";
import { useFrame } from "@react-three/fiber";
import * as THREE from "three";

interface JewelryAnchorProps {
  results: any;
  landmarkIndex: number;
  children: React.ReactNode;
}

export function JewelryAnchor({ results, landmarkIndex, children }: JewelryAnchorProps) {
  const groupRef = useRef<THREE.Group>(null);

  useFrame(() => {
    if (results && results.multiFaceLandmarks && results.multiFaceLandmarks.length > 0) {
      const landmark = results.multiFaceLandmarks[0][landmarkIndex];
      if (landmark && groupRef.current) {
        // Position relative to the center
        groupRef.current.position.set(
          (landmark.x - 0.5) * 5,
          -(landmark.y - 0.5) * 5,
          -landmark.z * 5
        );
      }
    }
  });

  return <group ref={groupRef}>{children}</group>;
}

export function Earring() {
  return (
    <group position={[0, -0.2, 0]}>
      {/* Gold Hook */}
      <mesh>
        <torusGeometry args={[0.03, 0.005, 8, 50, Math.PI]} />
        <meshStandardMaterial color="#ffd700" metalness={1} roughness={0.1} />
      </mesh>
      {/* Diamond Drop */}
      <mesh position={[0, -0.05, 0]}>
        <octahedronGeometry args={[0.04, 0]} />
        <meshStandardMaterial color="#fff" metalness={1} roughness={0} transparent opacity={0.8} />
        {/* Diamond Sparkle/Glow */}
        <pointLight intensity={0.5} distance={0.5} color="#fff" />
      </mesh>
    </group>
  );
}

export function Necklace() {
  return (
    <group position={[0, -0.1, 0]} rotation={[Math.PI / 2, 0, 0]}>
      {/* Chain */}
      <mesh>
        <torusGeometry args={[0.3, 0.008, 16, 100]} />
        <meshStandardMaterial color="#e5e4e2" metalness={1} roughness={0.2} />
      </mesh>
      {/* Main Pendant */}
      <mesh position={[0, -0.3, 0.02]} rotation={[-Math.PI / 2, 0, 0]}>
        <sphereGeometry args={[0.05, 16, 16]} />
        <meshStandardMaterial color="#4169e1" metalness={0.9} roughness={0.1} />
        <pointLight intensity={0.8} distance={1} color="#4169e1" />
      </mesh>
    </group>
  );
}

export function NecklaceAnchor({ results, children }: { results: any, children: React.ReactNode }) {
  const groupRef = useRef<THREE.Group>(null);

  useFrame(() => {
    if (results && results.multiFaceLandmarks && results.multiFaceLandmarks.length > 0) {
      const landmarks = results.multiFaceLandmarks[0];
      // Neck base is approximately between the chin and shoulders
      // MediaPipe doesn't have a specific "neck" landmark, but we can interpolate
      const chin = landmarks[152];
      if (chin && groupRef.current) {
        groupRef.current.position.set(
          (chin.x - 0.5) * 5,
          -(chin.y - 0.5) * 5 - 0.5, // slightly below chin
          -chin.z * 5
        );
      }
    }
  });

  return <group ref={groupRef}>{children}</group>;
}
