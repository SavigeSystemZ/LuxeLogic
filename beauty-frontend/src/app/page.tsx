"use client";

import dynamic from 'next/dynamic';
import { useState, useEffect } from 'react';
import { Sparkles, MessageCircle, Mic, Star, MicOff } from 'lucide-react';
import { useBeautyAI } from '../hooks/useBeautyAI';
import { fetchWithAuth } from '../lib/apiClient';

// Dynamically import to avoid SSR issues with Three.js
const BeautyScene = dynamic(() => import('../components/BeautyScene'), { 
  ssr: false,
  loading: () => <div className="w-full h-full flex items-center justify-center text-rose-300">Loading 3D Engine...</div>
});

export default function Home() {
  const [inputText, setInputText] = useState("");
  const [activeAction, setActiveAction] = useState<any>(null);
  const [techniques, setTechniques] = useState<any[]>([]);
  const [jewelry, setJewelry] = useState<any[]>([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const [techRes, jewRes] = await Promise.all([
          fetchWithAuth(`${process.env.NEXT_PUBLIC_API_URL || '/api'}/techniques/`),
          fetchWithAuth(`${process.env.NEXT_PUBLIC_API_URL || '/api'}/jewelry/`)
        ]);
        if (techRes.ok) setTechniques(await techRes.json());
        if (jewRes.ok) setJewelry(await jewRes.json());
      } catch (e) {
        console.error("Failed to fetch catalog data", e);
      }
    };
    fetchData();
  }, []);

  const handleAIAction = (action: { type: string; [key: string]: any }) => {
    console.log("AI Action received:", action);
    if (action.type === 'apply_makeup' || action.type === 'highlight_region') {
      setActiveAction(action);
    }
  };

  const { isListening, lastResponse, kehleyMode, setSkinAnalysis, startListening, speak } = useBeautyAI(handleAIAction);

  const handleManualAsk = async () => {
    if (!inputText) return;
    try {
      const response = await fetchWithAuth(`${process.env.NEXT_PUBLIC_API_URL || '/api'}/ai/consult?question=${encodeURIComponent(inputText)}`, {
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
    <>
      {/* Kehley Smith Dedication Overlay */}
      {kehleyMode && (
        <div className="fixed inset-0 pointer-events-none flex items-center justify-center z-50 overflow-hidden">
          <div className="text-4xl font-bold beauty-gradient animate-bounce flex items-center gap-4 bg-white/40 backdrop-blur-md px-12 py-6 rounded-[40px] border border-white/60 shadow-2xl">
            <Sparkles className="w-12 h-12 text-rose-400" />
            Dedicated to Kehley
            <Sparkles className="w-12 h-12 text-rose-400" />
          </div>
        </div>
      )}

      {/* Main Content Layout */}
      <div className="w-full grid grid-cols-1 lg:grid-cols-12 gap-8 flex-1">
        
        {/* Left Sidebar - Techniques & Controls */}
        <div className="lg:col-span-3 flex flex-col gap-6">
          <div className="glass-card p-6">
            <h2 className="text-xl font-semibold mb-6 flex items-center gap-2">
              <Star className="text-rose-400 w-5 h-5" />
              Techniques
            </h2>
            <div className="flex flex-col gap-4">
              {techniques.length > 0 ? techniques.map((tech) => (
                <div key={tech.id} className="p-4 rounded-2xl bg-white/30 border border-white/20 hover:bg-white/50 cursor-pointer transition-all duration-300">
                  <p className="font-medium">{tech.title}</p>
                  {tech.description && <p className="text-sm text-gray-600 mt-1">{tech.description}</p>}
                </div>
              )) : ['Red Carpet Glow', 'Movie Star Contouring', 'Ethereal Eyes', 'Professional Blending'].map((tech) => (
                <div key={tech} className="p-4 rounded-2xl bg-white/30 border border-white/20 hover:bg-white/50 cursor-pointer transition-all duration-300">
                  <p className="font-medium">{tech}</p>
                </div>
              ))}
            </div>
          </div>

          <div className="glass-card p-6 flex-1">
            <h2 className="text-xl font-semibold mb-4 flex items-center gap-2">
              <Sparkles className="text-rose-400 w-5 h-5" />
              Manual Controls
            </h2>
            <div className="flex flex-col gap-4">
              <div>
                <label className="text-sm font-medium text-gray-700 block mb-2">Lipstick Color</label>
                <div className="flex gap-2">
                  {['#e0115f', '#8b0000', '#ffc0cb', '#c04000'].map(color => (
                    <button 
                      key={color}
                      onClick={() => setActiveAction({ type: 'apply_makeup', makeup_type: 'lipstick', color })}
                      className="w-8 h-8 rounded-full border-2 border-white shadow-sm hover:scale-110 transition-transform"
                      style={{ backgroundColor: color }}
                    />
                  ))}
                </div>
              </div>
              <div>
                <label className="text-sm font-medium text-gray-700 block mb-2">Blush Color</label>
                <div className="flex gap-2">
                  {['#ffb6c1', '#ff69b4', '#db7093', '#e6e6fa'].map(color => (
                    <button 
                      key={color}
                      onClick={() => setActiveAction({ type: 'apply_makeup', makeup_type: 'blush', color })}
                      className="w-8 h-8 rounded-full border-2 border-white shadow-sm hover:scale-110 transition-transform"
                      style={{ backgroundColor: color }}
                    />
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Center - 3D Viewer */}
        <div className="lg:col-span-6 flex flex-col gap-6 relative min-h-[500px]">
          <div className="deep-glass rounded-[40px] flex-1 relative overflow-hidden">
            <BeautyScene onAnalysis={setSkinAnalysis} activeAction={activeAction} />
            
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

          <div className="glass-card p-6 flex-1 flex flex-col gap-4">
            <h2 className="text-xl font-semibold flex items-center gap-2">
              <UserCircle className="text-blue-400 w-5 h-5" />
              Skin Analysis
            </h2>
            {activeAction?.type === 'apply_makeup' ? (
              <div className="bg-blue-50/50 p-4 rounded-2xl border border-blue-100">
                <p className="text-sm font-medium text-blue-800">Tone: {activeAction.color}</p>
                <p className="text-xs text-blue-600 mt-1">Applying matching shade...</p>
              </div>
            ) : (
              <div className="bg-white/40 p-4 rounded-2xl border border-white/20">
                <p className="text-sm text-gray-500 italic">Position face in center for real-time analysis...</p>
              </div>
            )}

            <h2 className="text-xl font-semibold mt-4">Jewelry Try-On</h2>
            <div className="grid grid-cols-2 gap-3 overflow-y-auto max-h-[200px] pr-2">
              {jewelry.length > 0 ? jewelry.map((item) => (
                <div key={item.id} className="aspect-square rounded-2xl bg-white/30 border border-white/20 hover:border-rose-300 transition-colors cursor-pointer p-2 flex flex-col items-center justify-center text-center">
                  <div className="w-12 h-12 bg-blue-100/50 rounded-full mb-2 flex items-center justify-center">
                    <Sparkles className="w-5 h-5 text-blue-400" />
                  </div>
                  <p className="text-xs font-medium line-clamp-2">{item.name}</p>
                </div>
              )) : [1, 2, 3, 4].map((i) => (
                <div key={i} className="aspect-square rounded-2xl bg-white/30 border border-white/20 hover:border-rose-300 transition-colors cursor-pointer p-2 flex items-center justify-center">
                  <div className="w-full h-full bg-blue-100/50 rounded-xl" />
                </div>
              ))}
            </div>
          </div>
        </div>

      </div>
    </>
  );
}