"use client";

import { useState, useCallback } from 'react';
import { SkinToneResult } from '../lib/skinAnalysis';

export function useBeautyAI(onAction?: (action: { type: string; [key: string]: any }) => void) {
  const [isListening, setIsListening] = useState(false);
  const [lastResponse, setLastResponse] = useState<string>("");
  const [kehleyMode, setKehleyMode] = useState(false);
  const [skinAnalysis, setSkinAnalysis] = useState<SkinToneResult | null>(null);

  const speak = (text: string) => {
    if (!window.speechSynthesis) return;
    
    // Cancel any ongoing speech
    window.speechSynthesis.cancel();
    
    const utterance = new SpeechSynthesisUtterance(text);
    utterance.pitch = 1.1; 
    utterance.rate = 0.9;
    
    const voices = window.speechSynthesis.getVoices();
    const preferredVoice = voices.find(v => v.name.includes("Female") || v.name.includes("Google UK English Female"));
    if (preferredVoice) utterance.voice = preferredVoice;

    window.speechSynthesis.speak(utterance);
    setLastResponse(text);
  };

  const startListening = useCallback(() => {
    if (!('webkitSpeechRecognition' in window)) {
      alert("Speech recognition not supported in this browser.");
      return;
    }

    const recognition = new (window as any).webkitSpeechRecognition();
    recognition.continuous = false;
    recognition.interimResults = false;
    recognition.lang = "en-US";

    recognition.onstart = () => setIsListening(true);
    recognition.onend = () => setIsListening(false);
    
    recognition.onresult = async (event: any) => {
      const transcript = event.results[0][0].transcript;
      
      // Kehley Smith Easter Egg Detection
      if (transcript.toLowerCase().includes("kehley")) {
        setKehleyMode(true);
        setTimeout(() => setKehleyMode(false), 10000); 
      }

      try {
        const queryParams = new URLSearchParams({
          question: transcript,
          tone: skinAnalysis?.tone || "",
          undertone: skinAnalysis?.undertone || ""
        });

        const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000'}/ai/consult?${queryParams}`, {
          method: 'POST'
        });
        const data = await response.json();
        
        // Action Parsing Logic
        let cleanAnswer = data.answer;
        const actionMatch = data.answer.match(/\[ACTION:\s*([^\]]+)\]/);
        if (actionMatch && onAction) {
          try {
            const parts = actionMatch[1].split(',').map((p: string) => p.trim());
            const actionObj: { type: string; [key: string]: any } = { type: '' }; // Initialize with type
            parts.forEach((p: string) => {
              const [k, v] = p.split(':').map((s: string) => s.trim());
              if (k === 'type') {
                actionObj.type = v;
              } else {
                actionObj[k] = v;
              }
            });
            onAction(actionObj);
            // Clean the response text for TTS
            cleanAnswer = data.answer.replace(/\[ACTION:[^\]]+\]/g, '').trim();
          } catch (e) {
            console.error("Action parsing failed", e);
          }
        }

        speak(cleanAnswer);
      } catch (err) {
        speak("I'm sorry, I couldn't connect to my beauty knowledge base.");
      }
    };

    recognition.start();
  }, [skinAnalysis, onAction]); // Added onAction to dependencies for useCallback

  return { isListening, lastResponse, kehleyMode, setSkinAnalysis, startListening, speak };
}
