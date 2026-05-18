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
    <mesh position={[0, -0.2, 0]}>
      <torusGeometry args={[0.05, 0.01, 16, 100]} />
      <meshStandardMaterial color="gold" metalness={1} roughness={0.1} />
    </mesh>
  );
}

export function Necklace() {
  return (
    <mesh position={[0, -0.1, 0]} rotation={[Math.PI / 2, 0, 0]}>
      <torusGeometry args={[0.3, 0.015, 16, 100]} />
      <meshStandardMaterial color="silver" metalness={1} roughness={0.2} />
      <mesh position={[0, -0.3, 0]}>
        <octahedronGeometry args={[0.05, 0]} />
        <meshStandardMaterial color="#00f" metalness={0.8} roughness={0.1} />
      </mesh>
    </mesh>
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
