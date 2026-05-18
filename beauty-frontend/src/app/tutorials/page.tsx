"use client";

import { useState, useEffect } from 'react';
import { fetchWithAuth } from '../../lib/apiClient';
import { useWebSocket } from '../../contexts/WebSocketContext';
import { Video, Loader2, CheckCircle2, XCircle } from 'lucide-react';

export default function TutorialsPage() {
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
          title: `New Look Tutorial ${Date.now()}`,
          description: 'A newly created makeup tutorial.',
          video_url: videoUrl,
        })
      });
      
      if (res.ok) {
        const newTut = await res.json();
        setTutorials(prev => [...prev, newTut]);
        
        // Subscribe to WebSocket for real-time updates
        setTaskStatus(prev => ({ ...prev, [newTut.id]: 'processing' }));
        const unsubscribe = subscribeToTask(String(newTut.id), (data) => {
          console.log("WebSocket update:", data);
          if (data.status) {
            setTaskStatus(prev => ({ ...prev, [newTut.id]: data.status }));
          }
        });

        // Cleanup isn't strictly necessary here unless we unmount, as WebSocketContext handles it,
        // but it's good practice. We'll leave it attached to see the updates.
      }
    } catch (e) {
      console.error("Failed to create tutorial", e);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex flex-col gap-6 w-full h-full pb-12">
      <div className="glass-card p-8 flex flex-col md:flex-row gap-6 items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold beauty-gradient mb-2">Video Tutorials</h1>
          <p className="text-gray-600 max-w-xl">
            Learn from the best. Our real-time video processing engine ensures high-quality tutorials are dynamically transcoded into HLS streams.
          </p>
        </div>
        <div className="flex gap-4 w-full md:w-auto">
          <input 
            type="text" 
            value={videoUrl}
            onChange={(e) => setVideoUrl(e.target.value)}
            className="flex-1 bg-white/60 border border-white/40 rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-rose-200"
            placeholder="Video URL"
          />
          <button 
            onClick={createTutorial} 
            disabled={loading}
            className="beauty-button px-6 py-2 flex items-center gap-2 disabled:opacity-50"
          >
            {loading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Video className="w-4 h-4" />}
            Transcode
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mt-4">
        {tutorials.map((tut) => (
          <div key={tut.id} className="glass-card p-6 flex flex-col gap-4">
            <div className="aspect-video bg-white/40 rounded-2xl flex items-center justify-center relative overflow-hidden">
               <Video className="w-12 h-12 text-rose-200" />
               {taskStatus[tut.id] === 'processing' && (
                 <div className="absolute inset-0 bg-white/60 backdrop-blur-sm flex flex-col items-center justify-center gap-2 text-blue-500 font-medium">
                   <Loader2 className="w-8 h-8 animate-spin" />
                   Processing...
                 </div>
               )}
               {taskStatus[tut.id] === 'success' && (
                 <div className="absolute top-2 right-2 bg-green-500 text-white p-1 rounded-full">
                   <CheckCircle2 className="w-5 h-5" />
                 </div>
               )}
               {taskStatus[tut.id] === 'error' && (
                 <div className="absolute inset-0 bg-red-100/80 flex flex-col items-center justify-center gap-2 text-red-500 font-medium">
                   <XCircle className="w-8 h-8" />
                   Transcode Failed
                 </div>
               )}
            </div>
            <div>
              <h2 className="text-lg font-semibold">{tut.title}</h2>
              <p className="text-sm text-gray-500">{tut.description}</p>
            </div>
          </div>
        ))}
        {tutorials.length === 0 && !loading && (
          <div className="col-span-full text-center py-12 text-gray-400">
            No tutorials available. Create one to test the pipeline.
          </div>
        )}
      </div>
    </div>
  );
}