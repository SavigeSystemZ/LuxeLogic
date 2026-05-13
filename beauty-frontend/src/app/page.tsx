"use client";

import dynamic from 'next/dynamic';
import { useState, useEffect } from 'react';
import { Sparkles, MessageCircle, Mic, Star, MicOff } from 'lucide-react';
import { useBeautyAI } from '../hooks/useBeautyAI';

// Dynamically import to avoid SSR issues with Three.js
const BeautyScene = dynamic(() => import('../components/BeautyScene'), { 
  ssr: false,
  loading: () => <div className="w-full h-full flex items-center justify-center text-rose-300">Loading 3D Engine...</div>
});

export default function Home() {
  const { isListening, lastResponse, kehleyMode, setSkinAnalysis, startListening, speak } = useBeautyAI(handleAIAction);
  const [inputText, setInputText] = useState("");
  const beautySceneRef = useRef<HTMLDivElement>(null);

  const handleAIAction = (action: { type: string; [key: string]: any }) => {
    console.log("AI Action received:", action);
    // Here we can dispatch actions to the 3D scene, e.g., apply lipstick
    if (action.type === 'apply_makeup' && action.color) {
      // Logic to update the 3D makeup in BeautyScene via context or ref
      // For now, just a console log
      console.log(`Applying ${action.type} with color ${action.color}`);
    }
  };

  const handleManualAsk = async () => {
    if (!inputText) return;
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000'}/ai/consult?question=${encodeURIComponent(inputText)}`, {
        method: 'POST'
      });
      const data = await response.json();
      speak(data.answer);
      setInputText("");
    } catch (err) {
      speak("Connection error.");
    }
  };

  return (
    <main className={`flex min-h-screen flex-col items-center p-6 md:p-12 relative overflow-hidden transition-colors duration-1000 ${kehleyMode ? 'bg-rose-50' : ''}`}>
      {/* Decorative background blobs */}
      <div className={`absolute top-[-10%] left-[-5%] w-[40%] h-[40%] bg-rose-200/30 rounded-full blur-[100px] -z-10 animate-pulse ${kehleyMode ? 'scale-150 bg-rose-400/40' : ''}`} />
      <div className="absolute bottom-[-5%] right-[-5%] w-[40%] h-[40%] bg-blue-200/30 rounded-full blur-[100px] -z-10 animate-pulse delay-1000" />

      {/* Kehley Smith Dedication Overlay */}
      {kehleyMode && (
        <div className="absolute inset-0 pointer-events-none flex items-center justify-center z-50 overflow-hidden">
          <div className="text-4xl font-bold beauty-gradient animate-bounce flex items-center gap-4 bg-white/40 backdrop-blur-md px-12 py-6 rounded-[40px] border border-white/60 shadow-2xl">
            <Sparkles className="w-12 h-12 text-rose-400" />
            Dedicated to Kehley
            <Sparkles className="w-12 h-12 text-rose-400" />
          </div>
        </div>
      )}

      {/* Header */}
      <header className="w-full max-w-6xl flex justify-between items-center mb-12 z-10">
        <div className="flex items-center gap-2">
          <div className="w-10 h-10 bg-white/40 backdrop-blur-md rounded-xl flex items-center justify-center border border-white/40">
            <Sparkles className="text-rose-400 w-6 h-6" />
          </div>
          <h1 className="text-2xl font-bold beauty-gradient">LuxeLogic</h1>
        </div>
        
        <nav className="hidden md:flex gap-8 items-center glass-card px-8 py-3">
          <a href="#" className="hover:text-rose-400 transition-colors">Tutorials</a>
          <a href="#" className="hover:text-rose-400 transition-colors">Techniques</a>
          <a href="#" className="hover:text-rose-400 transition-colors">Try-On</a>
          <a href="#" className="hover:text-rose-400 transition-colors">Jewelry</a>
        </nav>

        <button className="beauty-button flex items-center gap-2">
          <Star className="w-4 h-4" />
          VIP Access
        </button>
      </header>

      {/* Main Content Layout */}
      <div className="w-full max-w-7xl grid grid-cols-1 lg:grid-cols-12 gap-8 flex-1 z-10">
        
        {/* Left Sidebar - Techniques */}
        <div className="lg:col-span-3 flex flex-col gap-6">
          <div className="glass-card p-6 flex-1">
            <h2 className="text-xl font-semibold mb-6 flex items-center gap-2">
              <Star className="text-rose-400 w-5 h-5" />
              Techniques
            </h2>
            <div className="flex flex-col gap-4">
              {['Red Carpet Glow', 'Movie Star Contouring', 'Ethereal Eyes', 'Professional Blending'].map((tech) => (
                <div key={tech} className="p-4 rounded-2xl bg-white/30 border border-white/20 hover:bg-white/50 cursor-pointer transition-all duration-300">
                  <p className="font-medium">{tech}</p>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Center - 3D Viewer */}
        <div className="lg:col-span-6 flex flex-col gap-6 relative min-h-[500px]">
          <div className="deep-glass rounded-[40px] flex-1 relative overflow-hidden">
            <BeautyScene onAnalysis={setSkinAnalysis} />
            
            {/* Overlay Controls */}
            <div className="absolute bottom-6 left-1/2 -translate-x-1/2 flex gap-4">
              <button 
                onClick={startListening}
                className={`w-14 h-14 rounded-full deep-glass flex items-center justify-center hover:scale-110 transition-transform shadow-xl ${isListening ? 'bg-rose-100 animate-pulse' : ''}`}
              >
                {isListening ? <MicOff className="w-6 h-6 text-rose-500" /> : <Mic className="w-6 h-6 text-rose-500" />}
              </button>
            </div>
          </div>
        </div>

        {/* Right Sidebar - AI & Products */}
        <div className="lg:col-span-3 flex flex-col gap-6">
          <div className="glass-card p-6 h-[250px] flex flex-col">
            <h2 className="text-xl font-semibold mb-4 flex items-center gap-2">
              <MessageCircle className="text-blue-400 w-5 h-5" />
              Beauty AI
            </h2>
            <div className="bg-white/40 rounded-2xl p-4 flex-1 text-sm italic text-gray-600 mb-4 overflow-y-auto">
              {lastResponse || "How can I help you beautify today? Try saying 'Show me star contouring' or 'Apply Kehley's favorite glow'."}
            </div>
            <div className="relative">
              <input 
                type="text" 
                value={inputText}
                onChange={(e) => setInputText(e.target.value)}
                onKeyDown={(e) => e.key === 'Enter' && handleManualAsk()}
                placeholder="Ask me anything..." 
                className="w-full bg-white/60 border border-white/40 rounded-full px-5 py-2 pr-12 focus:outline-none focus:ring-2 focus:ring-rose-200"
              />
              <button 
                onClick={handleManualAsk}
                className="absolute right-2 top-1/2 -translate-y-1/2 w-8 h-8 rounded-full bg-rose-400 text-white flex items-center justify-center"
              >
                <Sparkles className="w-4 h-4" />
              </button>
            </div>
          </div>

          <div className="glass-card p-6 flex-1">
            <h2 className="text-xl font-semibold mb-4">Jewelry Try-On</h2>
            <div className="grid grid-cols-2 gap-3">
              {[1, 2, 3, 4].map((i) => (
                <div key={i} className="aspect-square rounded-2xl bg-white/30 border border-white/20 hover:border-rose-300 transition-colors cursor-pointer p-2 flex items-center justify-center">
                  <div className="w-full h-full bg-blue-100/50 rounded-xl" />
                </div>
              ))}
            </div>
          </div>
        </div>

      </div>

      {/* Footer / Status */}
      <footer className="w-full max-w-6xl mt-12 py-6 border-t border-white/20 text-center text-gray-500 text-sm">
        <p>© 2026 LuxeLogic • Advanced Beauty Systems • <span className="text-rose-300 font-medium">Kehley Edition</span></p>
      </footer>
    </main>
  );
}
  return (
    <main className={`flex min-h-screen flex-col items-center p-6 md:p-12 relative overflow-hidden transition-colors duration-1000 ${kehleyMode ? 'bg-rose-50' : ''}`}>
      {/* Decorative background blobs */}
      <div className={`absolute top-[-10%] left-[-5%] w-[40%] h-[40%] bg-rose-200/30 rounded-full blur-[100px] -z-10 animate-pulse ${kehleyMode ? 'scale-150 bg-rose-400/40' : ''}`} />
      <div className="absolute bottom-[-5%] right-[-5%] w-[40%] h-[40%] bg-blue-200/30 rounded-full blur-[100px] -z-10 animate-pulse delay-1000" />

      {/* Kehley Smith Dedication Overlay */}
      {kehleyMode && (
        <div className="absolute inset-0 pointer-events-none flex items-center justify-center z-50 overflow-hidden">
          <div className="text-4xl font-bold beauty-gradient animate-bounce flex items-center gap-4 bg-white/40 backdrop-blur-md px-12 py-6 rounded-[40px] border border-white/60 shadow-2xl">
            <Sparkles className="w-12 h-12 text-rose-400" />
            Dedicated to Kehley
            <Sparkles className="w-12 h-12 text-rose-400" />
          </div>
        </div>
      )}

      {/* Header */}
      <header className="w-full max-w-6xl flex justify-between items-center mb-12 z-10">
        <div className="flex items-center gap-2">
          <div className="w-10 h-10 bg-white/40 backdrop-blur-md rounded-xl flex items-center justify-center border border-white/40">
            <Sparkles className="text-rose-400 w-6 h-6" />
          </div>
          <h1 className="text-2xl font-bold beauty-gradient">LuxeLogic</h1>
        </div>
        
        <nav className="hidden md:flex gap-8 items-center glass-card px-8 py-3">
          <a href="#" className="hover:text-rose-400 transition-colors">Tutorials</a>
          <a href="#" className="hover:text-rose-400 transition-colors">Techniques</a>
          <a href="#" className="hover:text-rose-400 transition-colors">Try-On</a>
          <a href="#" className="hover:text-rose-400 transition-colors">Jewelry</a>
        </nav>

        <button className="beauty-button flex items-center gap-2">
          <Star className="w-4 h-4" />
          VIP Access
        </button>
      </header>

      {/* Main Content Layout */}
      <div className="w-full max-w-7xl grid grid-cols-1 lg:grid-cols-12 gap-8 flex-1 z-10">
        
        {/* Left Sidebar - Techniques */}
        <div className="lg:col-span-3 flex flex-col gap-6">
          <div className="glass-card p-6 flex-1">
            <h2 className="text-xl font-semibold mb-6 flex items-center gap-2">
              <Star className="text-rose-400 w-5 h-5" />
              Techniques
            </h2>
            <div className="flex flex-col gap-4">
              {['Red Carpet Glow', 'Movie Star Contouring', 'Ethereal Eyes', 'Professional Blending'].map((tech) => (
                <div key={tech} className="p-4 rounded-2xl bg-white/30 border border-white/20 hover:bg-white/50 cursor-pointer transition-all duration-300">
                  <p className="font-medium">{tech}</p>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Center - 3D Viewer */}
        <div className="lg:col-span-6 flex flex-col gap-6 relative min-h-[500px]">
          <div className="deep-glass rounded-[40px] flex-1 relative overflow-hidden">
            <BeautyScene onAnalysis={setSkinAnalysis} />
            
            {/* Overlay Controls */}
            <div className="absolute bottom-6 left-1/2 -translate-x-1/2 flex gap-4">
              <button 
                onClick={startListening}
                className={`w-14 h-14 rounded-full deep-glass flex items-center justify-center hover:scale-110 transition-transform shadow-xl ${isListening ? 'bg-rose-100 animate-pulse' : ''}`}
              >
                {isListening ? <MicOff className="w-6 h-6 text-rose-500" /> : <Mic className="w-6 h-6 text-rose-500" />}
              </button>
            </div>
          </div>
        </div>

        {/* Right Sidebar - AI & Products */}
        <div className="lg:col-span-3 flex flex-col gap-6">
          <div className="glass-card p-6 h-[250px] flex flex-col">
            <h2 className="text-xl font-semibold mb-4 flex items-center gap-2">
              <MessageCircle className="text-blue-400 w-5 h-5" />
              Beauty AI
            </h2>
            <div className="bg-white/40 rounded-2xl p-4 flex-1 text-sm italic text-gray-600 mb-4 overflow-y-auto">
              {lastResponse || "How can I help you beautify today? Try saying 'Show me star contouring' or 'Apply Kehley's favorite glow'."}
            </div>
            <div className="relative">
              <input 
                type="text" 
                value={inputText}
                onChange={(e) => setInputText(e.target.value)}
                onKeyDown={(e) => e.key === 'Enter' && handleManualAsk()}
                placeholder="Ask me anything..." 
                className="w-full bg-white/60 border border-white/40 rounded-full px-5 py-2 pr-12 focus:outline-none focus:ring-2 focus:ring-rose-200"
              />
              <button 
                onClick={handleManualAsk}
                className="absolute right-2 top-1/2 -translate-y-1/2 w-8 h-8 rounded-full bg-rose-400 text-white flex items-center justify-center"
              >
                <Sparkles className="w-4 h-4" />
              </button>
            </div>
          </div>

          <div className="glass-card p-6 flex-1">
            <h2 className="text-xl font-semibold mb-4">Jewelry Try-On</h2>
            <div className="grid grid-cols-2 gap-3">
              {[1, 2, 3, 4].map((i) => (
                <div key={i} className="aspect-square rounded-2xl bg-white/30 border border-white/20 hover:border-rose-300 transition-colors cursor-pointer p-2 flex items-center justify-center">
                  <div className="w-full h-full bg-blue-100/50 rounded-xl" />
                </div>
              ))}
            </div>
          </div>
        </div>

      </div>

      {/* Footer / Status */}
      <footer className="w-full max-w-6xl mt-12 py-6 border-t border-white/20 text-center text-gray-500 text-sm">
        <p>© 2026 LuxeLogic • Advanced Beauty Systems • <span className="text-rose-300 font-medium">Kehley Edition</span></p>
      </footer>
    </main>
  );
}
