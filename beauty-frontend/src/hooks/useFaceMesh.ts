"use client";

import { useEffect, useRef, useState } from 'react';
import { FaceMesh, Results } from '@mediapipe/face_mesh';

export function useFaceMesh() {
  const [results, setResults] = useState<Results | null>(null);
  const videoRef = useRef<HTMLVideoElement | null>(null);
  const faceMeshRef = useRef<FaceMesh | null>(null);

  useEffect(() => {
    const faceMesh = new FaceMesh({
      locateFile: (file) => {
        // Try local first, then fallback to CDN
        return `/lib/mediapipe/${file}`;
      },
    });

    faceMesh.setOptions({
      maxNumFaces: 1,
      refineLandmarks: true,
      minDetectionConfidence: 0.5,
      minTrackingConfidence: 0.5,
    });

    faceMesh.onResults((results) => {
      setResults(results);
    });

    faceMeshRef.current = faceMesh;

    // Set up camera
    const setupCamera = async () => {
      if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
        console.error("Browser does not support camera access");
        return;
      }

      const stream = await navigator.mediaDevices.getUserMedia({
        video: { width: 640, height: 480 },
        audio: false,
      });

      if (videoRef.current) {
        videoRef.current.srcObject = stream;
        videoRef.current.play();

        const sendToFaceMesh = async () => {
          if (videoRef.current) {
            await faceMesh.send({ image: videoRef.current });
          }
          requestAnimationFrame(sendToFaceMesh);
        };

        sendToFaceMesh();
      }
    };

    setupCamera();

    const videoEl = videoRef.current;
    return () => {
      faceMesh.close();
      if (videoEl && videoEl.srcObject) {
        const stream = videoEl.srcObject as MediaStream;
        stream.getTracks().forEach(track => track.stop());
      }
    };
  }, []);

  return { results, videoRef };
}
