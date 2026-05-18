"use client";

import dynamic from 'next/dynamic';
import { useState, useEffect } from 'react';
import { Sparkles, MessageCircle, Mic, Star, MicOff, Heart, Save, ShieldCheck, UserCircle } from 'lucide-react';
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
      <p className="font-bold tracking-widest uppercase text-xs">Initializing 3D Engine</p>
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
          <p className="text-gray-600">Give your current makeup configuration a name to find it later in your gallery.</p>
          <input 
            type="text"
            value={lookName}
            onChange={(e) => setLookName(e.target.value)}
            placeholder="e.g. Red Carpet Glow"
            className="w-full bg-white/50 border border-white/40 rounded-2xl px-6 py-4 focus:outline-none focus:ring-2 focus:ring-rose-300"
          />
          <button 
            onClick={handleSaveLook}
            disabled={!lookName}
            className="beauty-button w-full py-4 text-lg font-bold flex items-center justify-center gap-2 shadow-rose-200/50"
          >
            <Save className="w-5 h-5" />
            Save to Gallery
          </button>
        </div>
      </Modal>

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
      <div className="w-full grid grid-cols-1 lg:grid-cols-12 gap-8 flex-1 pb-8">
        
        {/* Left Sidebar - Techniques & Controls */}
        <div className="lg:col-span-3 flex flex-col gap-6">
          <div className="glass-card p-6">
            <h2 className="text-xl font-semibold mb-6 flex items-center gap-2">
              <Star className="text-rose-400 w-5 h-5" />
              Quick Techniques
            </h2>
            <div className="flex flex-col gap-3">
              {(techniques.length > 0 ? techniques.slice(0, 4) : ['Red Carpet Glow', 'Movie Star Contouring', 'Ethereal Eyes', 'Natural']).map((tech, idx) => (
                <button 
                  key={typeof tech === 'string' ? tech : tech.id} 
                  onClick={() => typeof tech !== 'string' && handleAIAction({ type: 'apply_makeup', makeup_type: 'foundation', color: '#f5d1c3' })}
                  className="p-4 rounded-2xl bg-white/30 border border-white/20 hover:bg-white/50 hover:scale-[1.02] active:scale-95 transition-all text-left group"
                >
                  <p className="font-medium text-gray-800">{typeof tech === 'string' ? tech : tech.title}</p>
                </button>
              ))}
            </div>
          </div>

          <div className="glass-card p-6 flex-1">
            <h2 className="text-xl font-semibold mb-6 flex items-center gap-2">
              <Sparkles className="text-rose-400 w-5 h-5" />
              Manual Palette
            </h2>
            <div className="flex flex-col gap-8">
              <div>
                <label className="text-xs font-bold text-gray-500 uppercase tracking-widest block mb-4">Lipstick Boutique</label>
                <div className="grid grid-cols-4 gap-3">
                  {['#e0115f', '#8b0000', '#ffc0cb', '#c04000', '#ff0000', '#900c3f', '#ff69b4', '#db7093'].map(color => (
                    <button 
                      key={color}
                      onClick={() => handleAIAction({ type: 'apply_makeup', makeup_type: 'lipstick', color })}
                      className="aspect-square rounded-2xl border-2 border-white shadow-sm hover:scale-110 active:scale-90 transition-all"
                      style={{ backgroundColor: color }}
                    />
                  ))}
                </div>
              </div>
              <div>
                <label className="text-xs font-bold text-gray-500 uppercase tracking-widest block mb-4">Blush & Bloom</label>
                <div className="grid grid-cols-4 gap-3">
                  {['#ffb6c1', '#ff69b4', '#db7093', '#e6e6fa', '#f08080', '#ffa07a', '#ffa500', '#fa8072'].map(color => (
                    <button 
                      key={color}
                      onClick={() => handleAIAction({ type: 'apply_makeup', makeup_type: 'blush', color })}
                      className="aspect-square rounded-2xl border-2 border-white shadow-sm hover:scale-110 active:scale-90 transition-all"
                      style={{ backgroundColor: color }}
                    />
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Center - 3D Viewer */}
        <div className="lg:col-span-6 flex flex-col gap-6 relative min-h-[600px]">
          <div className="deep-glass rounded-[50px] flex-1 relative overflow-hidden group shadow-2xl">
            <BeautyScene onAnalysis={setSkinAnalysis} activeAction={activeAction} />
            
            {/* Viewport Badge */}
            <div className="absolute top-6 left-6 px-4 py-2 rounded-full glass-card flex items-center gap-2">
              <div className="w-2 h-2 rounded-full bg-green-400 animate-pulse" />
              <span className="text-[10px] font-bold uppercase tracking-wider text-gray-600">Live Face Mesh Active</span>
            </div>

            {/* Floating Action Bar */}
            <div className="absolute bottom-10 left-1/2 -translate-x-1/2 flex items-center gap-6 p-2 rounded-full glass-card pr-8 shadow-2xl border-white/50">
              <button 
                onClick={startListening}
                className={`w-16 h-16 rounded-full flex items-center justify-center transition-all duration-500 ${isListening ? 'bg-rose-500 shadow-rose-300 shadow-xl' : 'bg-white hover:bg-rose-50'}`}
              >
                {isListening ? <MicOff className="w-8 h-8 text-white" /> : <Mic className="w-8 h-8 text-rose-500" />}
              </button>
              
              <div className="h-10 w-[1px] bg-gray-200" />
              
              <button 
                onClick={() => setIsSaveModalOpen(true)}
                className="flex items-center gap-3 text-gray-700 font-bold hover:text-rose-500 transition-colors"
              >
                <Heart className="w-6 h-6" />
                <span>Save Look</span>
              </button>
            </div>
          </div>
        </div>

        {/* Right Sidebar - AI & Products */}
        <div className="lg:col-span-3 flex flex-col gap-6">
          <div className="glass-card p-6 h-[300px] flex flex-col border-rose-100/50">
            <h2 className="text-xl font-semibold mb-4 flex items-center gap-2">
              <MessageCircle className="text-blue-400 w-5 h-5" />
              Beauty AI
            </h2>
            <div className="bg-white/40 rounded-3xl p-5 flex-1 text-sm italic text-gray-600 mb-6 overflow-y-auto leading-relaxed border border-white/40 shadow-inner">
              {lastResponse || "How can I help you beautify today? Try saying 'Apply a bold red lip' or 'What blush matches my tone?'"}
            </div>
            <div className="relative">
              <input 
                type="text" 
                value={inputText}
                onChange={(e) => setInputText(e.target.value)}
                onKeyDown={(e) => e.key === 'Enter' && handleManualAsk()}
                placeholder="Ask me anything..." 
                className="w-full bg-white/60 border border-white/40 rounded-full px-6 py-3 pr-14 focus:outline-none focus:ring-2 focus:ring-rose-200 shadow-sm"
              />
              <button 
                onClick={handleManualAsk}
                className="absolute right-2 top-1/2 -translate-y-1/2 w-10 h-10 rounded-full bg-rose-400 text-white flex items-center justify-center hover:bg-rose-500 transition-colors shadow-lg"
              >
                <Sparkles className="w-5 h-5" />
              </button>
            </div>
          </div>

          <div className="glass-card p-6 flex-1 flex flex-col gap-6">
            <div>
              <h2 className="text-xl font-semibold flex items-center gap-2 mb-4">
                <ShieldCheck className="text-blue-400 w-5 h-5" />
                Smart Analysis
              </h2>
              <div className="p-5 rounded-3xl bg-blue-50/50 border border-blue-100 flex flex-col gap-2">
                <div className="flex justify-between items-center">
                  <span className="text-xs text-blue-600 font-bold uppercase tracking-wider">Detected Tone</span>
                  <span className="text-xs font-bold text-blue-800">{activeAction?.color || '#F5D1C3'}</span>
                </div>
                <div className="w-full h-2 bg-white rounded-full overflow-hidden">
                  <div className="h-full bg-blue-400 rounded-full" style={{ width: '85%' }} />
                </div>
              </div>
            </div>

            <div>
              <h2 className="text-xl font-semibold mb-4">Jewelry Boutique</h2>
              <div className="grid grid-cols-2 gap-4 overflow-y-auto max-h-[250px] pr-2 scrollbar-hide">
                {(jewelry.length > 0 ? jewelry : [1, 2, 3, 4, 5, 6]).map((item: any) => (
                  <button 
                    key={item.id || item} 
                    className="aspect-square rounded-[32px] bg-white/30 border border-white/20 hover:border-rose-300 hover:bg-white/60 transition-all cursor-pointer p-4 flex flex-col items-center justify-center text-center group"
                  >
                    <div className="w-12 h-12 bg-rose-50 rounded-full mb-3 flex items-center justify-center group-hover:scale-110 transition-transform shadow-sm">
                      <Sparkles className="w-5 h-5 text-rose-400" />
                    </div>
                    <p className="text-[10px] font-bold uppercase tracking-tighter text-gray-500 line-clamp-2">{item.name || 'Luxe Item'}</p>
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