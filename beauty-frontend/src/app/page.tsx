"use client";

import dynamic from 'next/dynamic';
import { useState, useEffect } from 'react';
import { Sparkles, MessageCircle, Mic, Star, MicOff, Heart, Save, ShieldCheck, UserCircle, Settings } from 'lucide-react';
import { useBeautyAI } from '../hooks/useBeautyAI';
import { fetchWithAuth } from '../lib/apiClient';
import { useToast } from '../contexts/ToastContext';
import { Modal } from '../components/ui/Modal';

// Dynamically import to avoid SSR issues with Three.js
const BeautyScene = dynamic(() => import('../components/BeautyScene'), { 
  ssr: false,
  loading: () => (
    <div className="w-full h-full flex flex-col items-center justify-center text-rose-300 gap-4">
      <div className="w-12 h-12 border-4 border-rose-200 border-t-rose-500 rounded-full animate-spin" />
      <p className="font-bold tracking-widest uppercase text-[10px]">Initializing 3D Engine</p>
    </div>
  )
});

export default function Home() {
  const { toast } = useToast();
  const [inputText, setInputText] = useState("");
  const [activeAction, setActiveAction] = useState<any>(null);
  const [techniques, setTechniques] = useState<any[]>([]);
  const [jewelry, setJewelry] = useState<any[]>([]);
  const [isSaveModalOpen, setIsSaveModalOpen] = useState(false);
  const [lookName, setLookName] = useState("");
  const [debugMode, setDebugMode] = useState(false);

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
        toast("Failed to load beauty catalog.", "error");
      }
    };
    fetchData();
  }, [toast]);

  const handleAIAction = (action: { type: string; [key: string]: any }) => {
    console.log("AI Action received:", action);
    if (action.type === 'apply_makeup' || action.type === 'highlight_region') {
      setActiveAction(action);
      if (action.makeup_type) {
        toast(`Applied ${action.makeup_type} shade!`, "success");
      }
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
      toast("Connection error with Beauty AI.", "error");
    }
  };

  const handleSaveLook = () => {
    toast(`Look "${lookName}" saved to your gallery!`, "success");
    setIsSaveModalOpen(false);
    setLookName("");
  };

  return (
    <>
      <Modal isOpen={isSaveModalOpen} onClose={() => setIsSaveModalOpen(false)} title="Save Master Look">
        <div className="flex flex-col gap-6">
          <p className="text-gray-600 font-medium">Give your current makeup configuration a name to find it later in your gallery.</p>
          <input 
            type="text"
            value={lookName}
            onChange={(e) => setLookName(e.target.value)}
            placeholder="e.g. Red Carpet Glow"
            className="w-full bg-white/50 border border-white/40 rounded-3xl px-6 py-4 focus:outline-none focus:ring-2 focus:ring-rose-300 transition-all shadow-inner"
          />
          <button 
            onClick={handleSaveLook}
            disabled={!lookName}
            className="beauty-button w-full py-5 text-xl font-bold flex items-center justify-center gap-2 shadow-rose-200/50"
          >
            <Save className="w-6 h-6" />
            Save to Gallery
          </button>
        </div>
      </Modal>

      {/* Kehley Smith Dedication Overlay */}
      {kehleyMode && (
        <div className="fixed inset-0 pointer-events-none flex items-center justify-center z-50 overflow-hidden">
          <div className="text-5xl font-black beauty-gradient animate-bounce flex items-center gap-6 bg-white/60 backdrop-blur-3xl px-16 py-10 rounded-[60px] border border-white/80 shadow-[0_40px_100px_rgba(255,154,158,0.4)]">
            <Sparkles className="w-16 h-16 text-rose-400" />
            Dedicated to Kehley
            <Sparkles className="w-16 h-16 text-rose-400" />
          </div>
        </div>
      )}

      {/* Main Content Layout */}
      <div className="w-full grid grid-cols-1 lg:grid-cols-12 gap-8 flex-1 pb-12">
        
        {/* Left Sidebar - Techniques & Controls */}
        <div className="lg:col-span-3 flex flex-col gap-6">
          <div className="glass-card p-6 border-white/40 shadow-xl">
            <h2 className="text-xl font-bold mb-6 flex items-center gap-3">
              <Star className="text-rose-400 w-6 h-6 fill-current" />
              Quick Techniques
            </h2>
            <div className="flex flex-col gap-3">
              {(techniques.length > 0 ? techniques.slice(0, 4) : ['Red Carpet Glow', 'Movie Star Contouring', 'Ethereal Eyes', 'Natural']).map((tech) => (
                <button 
                  key={typeof tech === 'string' ? tech : tech.id} 
                  onClick={() => typeof tech !== 'string' && handleAIAction({ type: 'apply_makeup', makeup_type: 'foundation', color: '#f5d1c3' })}
                  className="p-5 rounded-3xl bg-white/40 border border-white/40 hover:bg-white/70 hover:scale-[1.03] active:scale-95 transition-all text-left group shadow-sm hover:shadow-rose-100/40"
                >
                  <p className="font-bold text-gray-800 text-sm">{typeof tech === 'string' ? tech : tech.title}</p>
                </button>
              ))}
            </div>
          </div>

          <div className="glass-card p-6 flex-1 border-white/40 shadow-xl">
            <h2 className="text-xl font-bold mb-8 flex items-center gap-3">
              <Sparkles className="text-rose-400 w-6 h-6" />
              Manual Palette
            </h2>
            <div className="flex flex-col gap-10">
              <div>
                <label className="text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] block mb-5 px-1">Lipstick Boutique</label>
                <div className="grid grid-cols-4 gap-4">
                  {['#e0115f', '#8b0000', '#ffc0cb', '#c04000', '#ff0000', '#900c3f', '#ff69b4', '#db7093'].map(color => (
                    <button 
                      key={color}
                      onClick={() => handleAIAction({ type: 'apply_makeup', makeup_type: 'lipstick', color })}
                      className="aspect-square rounded-2xl border-4 border-white shadow-md hover:scale-125 active:scale-90 transition-all hover:z-10"
                      style={{ backgroundColor: color }}
                    />
                  ))}
                </div>
              </div>
              <div>
                <label className="text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] block mb-5 px-1">Blush & Bloom</label>
                <div className="grid grid-cols-4 gap-4">
                  {['#ffb6c1', '#ff69b4', '#db7093', '#e6e6fa', '#f08080', '#ffa07a', '#ffa500', '#fa8072'].map(color => (
                    <button 
                      key={color}
                      onClick={() => handleAIAction({ type: 'apply_makeup', makeup_type: 'blush', color })}
                      className="aspect-square rounded-2xl border-4 border-white shadow-md hover:scale-125 active:scale-90 transition-all hover:z-10"
                      style={{ backgroundColor: color }}
                    />
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Center - 3D Viewer */}
        <div className="lg:col-span-6 flex flex-col gap-6 relative min-h-[650px]">
          <div className="deep-glass rounded-[60px] flex-1 relative overflow-hidden group shadow-[0_30px_80px_rgba(0,0,0,0.1)] border-white/40">
            <BeautyScene onAnalysis={setSkinAnalysis} activeAction={activeAction} />
            
            {/* Viewport Status & Debug */}
            <div className="absolute top-10 left-10 flex flex-col gap-4 items-start">
              <div className="px-5 py-2.5 rounded-full glass-card flex items-center gap-3 border-white/60">
                <div className="w-2.5 h-2.5 rounded-full bg-green-400 animate-pulse shadow-[0_0_10px_#4ade80]" />
                <span className="text-[11px] font-black uppercase tracking-widest text-gray-700">3D AR Engine Active</span>
              </div>
              <button 
                onClick={() => setDebugMode(!debugMode)}
                className="px-5 py-2.5 rounded-full glass-card text-[11px] font-black uppercase tracking-widest text-rose-500 hover:bg-white/80 transition-all shadow-xl flex items-center gap-2 border-white/60 group"
              >
                <Settings className="w-4 h-4 group-hover:rotate-90 transition-transform" />
                {debugMode ? 'Hide Tracker Feed' : 'Show Tracker Feed'}
              </button>
            </div>

            {/* Debug Video Overlay */}
            {debugMode && (
              <div className="absolute top-36 left-10 w-72 aspect-video rounded-[40px] overflow-hidden border-4 border-rose-300 shadow-2xl z-20 animate-in zoom-in-95 fade-in duration-500">
                <video 
                  id="debug-video"
                  autoPlay 
                  muted 
                  className="w-full h-full object-cover scale-x-[-1]"
                  ref={(el) => {
                    const mainVideo = document.querySelector('video.hidden') as HTMLVideoElement;
                    if (el && mainVideo) el.srcObject = mainVideo.srcObject;
                  }}
                />
                <div className="absolute top-4 right-4 px-3 py-1.5 bg-black/60 backdrop-blur-md rounded-full text-[9px] font-bold text-white uppercase tracking-widest border border-white/20">
                  Raw Camera Input
                </div>
              </div>
            )}

            {/* Floating Action Bar */}
            <div className="absolute bottom-12 left-1/2 -translate-x-1/2 flex items-center gap-10 p-3 rounded-full glass-card pr-12 shadow-[0_20px_50px_rgba(255,154,158,0.3)] border-white/80 scale-110">
              <button 
                onClick={startListening}
                className={`w-20 h-20 rounded-full flex items-center justify-center transition-all duration-700 shadow-2xl ${isListening ? 'bg-rose-500 shadow-rose-300 scale-90' : 'bg-white hover:bg-rose-50'}`}
              >
                {isListening ? <MicOff className="w-10 h-10 text-white" /> : <Mic className="w-10 h-10 text-rose-500" />}
              </button>
              
              <div className="h-12 w-[2px] bg-gray-100 rounded-full" />
              
              <button 
                onClick={() => setIsSaveModalOpen(true)}
                className="flex items-center gap-4 text-gray-800 font-black hover:text-rose-500 transition-colors uppercase tracking-widest text-[12px]"
              >
                <div className="w-12 h-12 rounded-full bg-white flex items-center justify-center shadow-lg border border-white">
                   <Heart className="w-6 h-6 text-rose-400 fill-rose-50" />
                </div>
                <span>Save Current Look</span>
              </button>
            </div>
          </div>
        </div>

        {/* Right Sidebar - AI & Products */}
        <div className="lg:col-span-3 flex flex-col gap-6">
          <div className="glass-card p-6 h-[320px] flex flex-col border-rose-100/50 shadow-xl">
            <h2 className="text-xl font-bold mb-5 flex items-center gap-3">
              <MessageCircle className="text-blue-400 w-6 h-6" />
              Beauty AI
            </h2>
            <div className="bg-white/40 rounded-[32px] p-6 flex-1 text-sm italic font-medium text-gray-600 mb-6 overflow-y-auto leading-relaxed border border-white/40 shadow-inner scrollbar-hide">
              {lastResponse || "How can I help you beautify today, darling? Try saying 'Apply a bold red lip' or 'Give me the Kehley Smith glow'."}
            </div>
            <div className="relative">
              <input 
                type="text" 
                value={inputText}
                onChange={(e) => setInputText(e.target.value)}
                onKeyDown={(e) => e.key === 'Enter' && handleManualAsk()}
                placeholder="Ask me anything..." 
                className="w-full bg-white/70 border border-white/40 rounded-full px-7 py-4 pr-16 focus:outline-none focus:ring-4 focus:ring-rose-100 shadow-sm font-medium transition-all"
              />
              <button 
                onClick={handleManualAsk}
                className="absolute right-2.5 top-1/2 -translate-y-1/2 w-11 h-11 rounded-full bg-rose-400 text-white flex items-center justify-center hover:bg-rose-500 transition-colors shadow-lg active:scale-90"
              >
                <Sparkles className="w-6 h-6" />
              </button>
            </div>
          </div>

          <div className="glass-card p-6 flex-1 flex flex-col gap-8 shadow-xl border-white/40">
            <div>
              <h2 className="text-xl font-bold flex items-center gap-3 mb-5">
                <ShieldCheck className="text-blue-500 w-6 h-6" />
                Skin Intelligence
              </h2>
              <div className="p-6 rounded-[32px] bg-blue-50/50 border border-blue-100 flex flex-col gap-4 shadow-sm">
                <div className="flex justify-between items-center">
                  <span className="text-[10px] text-blue-600 font-black uppercase tracking-widest">Confidence Score</span>
                  <span className="text-[10px] font-black text-blue-800 uppercase tracking-widest">98.4%</span>
                </div>
                <div className="w-full h-3 bg-white rounded-full overflow-hidden shadow-inner p-0.5">
                  <div className="h-full bg-gradient-to-r from-blue-400 to-indigo-500 rounded-full animate-in slide-in-from-left duration-1000" style={{ width: '85%' }} />
                </div>
                <div className="flex justify-between items-center mt-1">
                  <span className="text-xs font-bold text-gray-700">Tone Match</span>
                  <span className="text-xs font-black text-blue-600">{activeAction?.color || '#F5D1C3'}</span>
                </div>
              </div>
            </div>

            <div>
              <h2 className="text-xl font-bold mb-5 px-1">Luxe Boutique</h2>
              <div className="grid grid-cols-2 gap-4 overflow-y-auto max-h-[250px] pr-2 scrollbar-hide">
                {(jewelry.length > 0 ? jewelry : [1, 2, 3, 4, 5, 6]).map((item: any) => (
                  <button 
                    key={item.id || item} 
                    className="aspect-square rounded-[40px] bg-white/40 border border-white/40 hover:border-rose-300 hover:bg-white/80 transition-all cursor-pointer p-5 flex flex-col items-center justify-center text-center group shadow-sm hover:shadow-rose-100/50"
                  >
                    <div className="w-14 h-14 bg-rose-50 rounded-full mb-4 flex items-center justify-center group-hover:scale-110 transition-transform shadow-sm">
                      <Sparkles className="w-6 h-6 text-rose-400" />
                    </div>
                    <p className="text-[9px] font-black uppercase tracking-tight text-gray-500 line-clamp-2 leading-tight px-1">{item.name || 'Masterpiece Item'}</p>
                  </button>
                ))}
              </div>
            </div>
          </div>
        </div>

      </div>
    </>
  );
}