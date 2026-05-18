"use client";

import { useState, useEffect } from 'react';
import { fetchWithAuth } from '../../lib/apiClient';
import { useWebSocket } from '../../contexts/WebSocketContext';
import { useToast } from '../../contexts/ToastContext';
import { Video, Loader2, CheckCircle2, XCircle, Play, PlusCircle } from 'lucide-react';

export default function TutorialsPage() {
  const { toast } = useToast();
  const [tutorials, setTutorials] = useState<any[]>([]);
  const [videoUrl, setVideoUrl] = useState("test_video.mp4");
  const [loading, setLoading] = useState(false);
  const [taskStatus, setTaskStatus] = useState<Record<string, string>>({});
  const { subscribeToTask } = useWebSocket();

  useEffect(() => {
    const fetchTutorials = async () => {
      try {
        const res = await fetchWithAuth(`${process.env.NEXT_PUBLIC_API_URL || '/api'}/tutorials/`);
        if (res.ok) {
          setTutorials(await res.json());
        }
      } catch (e) {
        console.error("Failed to fetch tutorials", e);
      }
    };
    fetchTutorials();
  }, []);

  const createTutorial = async () => {
    if (!videoUrl) return;
    setLoading(true);
    try {
      const res = await fetchWithAuth(`${process.env.NEXT_PUBLIC_API_URL || '/api'}/tutorials/`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          title: `Masterclass ${Date.now().toString().slice(-4)}`,
          description: 'High-fidelity makeup application guide.',
          video_url: videoUrl,
        })
      });
      
      if (res.ok) {
        const newTut = await res.json();
        setTutorials(prev => [newTut, ...prev]);
        toast("Video uploaded! Transcoding started...", "info");
        
        setTaskStatus(prev => ({ ...prev, [newTut.id]: 'processing' }));
        subscribeToTask(String(newTut.id), (data) => {
          if (data.status) {
            setTaskStatus(prev => ({ ...prev, [newTut.id]: data.status }));
            if (data.status === 'success') toast("Tutorial ready to stream!", "success");
            if (data.status === 'error') toast("Transcoding failed.", "error");
          }
        });
      }
    } catch (e) {
      toast("Server connection error.", "error");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex flex-col gap-10 w-full h-full pb-12 mt-4">
      <div className="glass-card p-10 flex flex-col lg:flex-row gap-10 items-center justify-between border-rose-100/50 shadow-2xl shadow-rose-100/20">
        <div className="text-center lg:text-left">
          <h1 className="text-4xl font-bold beauty-gradient mb-3">Video Masterclasses</h1>
          <p className="text-gray-500 max-w-2xl leading-relaxed">
            Our real-time video processing engine ensures high-resolution tutorials are dynamically transcoded into low-latency HLS streams for your device.
          </p>
        </div>
        <div className="flex flex-col sm:flex-row gap-4 w-full lg:w-auto shrink-0">
          <input 
            type="text" 
            value={videoUrl}
            onChange={(e) => setVideoUrl(e.target.value)}
            className="flex-1 lg:w-64 bg-white/60 border border-white/40 rounded-2xl px-5 py-4 focus:outline-none focus:ring-2 focus:ring-rose-200 shadow-inner"
            placeholder="Remote Video MP4 URL"
          />
          <button 
            onClick={createTutorial} 
            disabled={loading}
            className="beauty-button px-10 py-4 flex items-center justify-center gap-3 disabled:opacity-50 font-bold"
          >
            {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : <PlusCircle className="w-5 h-5" />}
            Generate
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-8">
        {tutorials.map((tut) => (
          <div key={tut.id} className="glass-card p-4 group flex flex-col gap-5 hover:scale-[1.02] transition-transform duration-500 border-white/40 shadow-xl overflow-hidden">
            <div className="aspect-video bg-gray-900 rounded-[24px] flex items-center justify-center relative overflow-hidden group/thumb">
               <Video className="w-16 h-16 text-white/10 group-hover/thumb:scale-110 transition-transform duration-700" />
               <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent opacity-0 group-hover/thumb:opacity-100 transition-opacity" />
               
               {taskStatus[tut.id] === 'processing' && (
                 <div className="absolute inset-0 bg-white/60 backdrop-blur-md flex flex-col items-center justify-center gap-4 text-rose-500 font-bold">
                   <Loader2 className="w-10 h-10 animate-spin" />
                   <span className="tracking-widest uppercase text-xs">Transcoding...</span>
                 </div>
               )}
               {taskStatus[tut.id] === 'success' && (
                 <div className="absolute inset-0 flex items-center justify-center">
                   <button className="w-16 h-16 rounded-full bg-white/20 backdrop-blur-md flex items-center justify-center text-white border border-white/40 hover:scale-110 transition-transform shadow-2xl">
                     <Play className="w-8 h-8 fill-current ml-1" />
                   </button>
                   <div className="absolute top-4 right-4 bg-green-500 text-white p-1 rounded-full shadow-lg">
                     <CheckCircle2 className="w-4 h-4" />
                   </div>
                 </div>
               )}
               {taskStatus[tut.id] === 'error' && (
                 <div className="absolute inset-0 bg-red-50/90 flex flex-col items-center justify-center gap-3 text-red-500 font-bold">
                   <XCircle className="w-10 h-10" />
                   <span className="text-xs uppercase tracking-widest">Processing Failed</span>
                 </div>
               )}
            </div>
            <div className="px-3 pb-2">
              <h2 className="text-xl font-bold text-gray-800 line-clamp-1">{tut.title}</h2>
              <p className="text-sm text-gray-500 mt-1 line-clamp-2 leading-relaxed">{tut.description}</p>
              <div className="mt-4 pt-4 border-t border-white/40 flex justify-between items-center text-[10px] font-bold uppercase tracking-widest text-gray-400">
                <span>4K Ultra HD</span>
                <span>HLS Streaming</span>
              </div>
            </div>
          </div>
        ))}
        {tutorials.length === 0 && !loading && (
          <div className="col-span-full h-64 flex flex-col items-center justify-center text-gray-400 gap-4 opacity-60">
            <Video className="w-12 h-12" />
            <p className="font-medium">No masterclasses found. Create your first one above.</p>
          </div>
        )}
      </div>
    </div>
  );
}