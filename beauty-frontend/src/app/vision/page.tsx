/* eslint-disable @next/next/no-img-element */
"use client";

import { useState, useRef } from 'react';
import { fetchWithAuth } from '../../lib/apiClient';
import { useToast } from '../../contexts/ToastContext';
import { Upload, Sparkles, AlertCircle, Wand2, History } from 'lucide-react';

export default function VisionPage() {
  const { toast } = useToast();
  const [file, setFile] = useState<File | null>(null);
  const [preview, setPreview] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const selectedFile = e.target.files?.[0];
    if (selectedFile) {
      if (!selectedFile.type.startsWith('image/')) {
        toast("Please select a valid image file.", "error");
        return;
      }
      if (selectedFile.size > 10 * 1024 * 1024) {
        toast("Image too large. Max 10MB.", "error");
        return;
      }
      
      setFile(selectedFile);
      setPreview(URL.createObjectURL(selectedFile));
      setResult(null);
      toast("Image ready for analysis!", "info");
    }
  };

  const handleAnalyze = async () => {
    if (!file) return;
    setLoading(true);
    
    const formData = new FormData();
    formData.append('file', file);

    try {
      const response = await fetchWithAuth(`${process.env.NEXT_PUBLIC_API_URL || '/api'}/ai/recreate-look`, {
        method: 'POST',
        body: formData,
      });

      if (!response.ok) throw new Error();

      const data = await response.json();
      setResult(data.answer);
      toast("AI analysis complete! Look generated.", "success");
    } catch (e) {
      toast("Failed to analyze image. Ensure you are signed in.", "error");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex flex-col gap-10 w-full h-full pb-12 mt-4">
      <div className="flex flex-col md:flex-row justify-between items-end gap-6">
        <div>
          <h1 className="text-4xl font-bold beauty-gradient mb-2 text-left">Recreate The Look</h1>
          <p className="text-gray-500 max-w-2xl text-left leading-relaxed">
            Upload any inspiration photo and our AI Vision model will generate a 3D makeup mapping tailored to your unique features.
          </p>
        </div>
        <button className="flex items-center gap-2 text-rose-500 font-bold hover:underline bg-white/40 px-6 py-3 rounded-2xl border border-white/60">
          <History className="w-5 h-5" />
          Previous Scans
        </button>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        
        {/* Uploader Section */}
        <div className="lg:col-span-7">
          <div className="glass-card p-10 flex flex-col items-center text-center">
            <input 
              type="file" 
              accept="image/*" 
              className="hidden" 
              ref={fileInputRef} 
              onChange={handleFileChange} 
            />
            
            <div 
              onClick={() => fileInputRef.current?.click()}
              className="w-full aspect-video border-2 border-dashed border-rose-200 rounded-[40px] flex flex-col items-center justify-center bg-white/20 hover:bg-white/40 hover:border-rose-300 transition-all cursor-pointer mb-8 relative overflow-hidden group shadow-inner"
            >
              {preview ? (
                <img src={preview} alt="Preview" className="absolute inset-0 w-full h-full object-contain p-4 group-hover:scale-[1.02] transition-transform" />
              ) : (
                <>
                  <div className="w-20 h-20 bg-rose-50 rounded-full flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
                    <Upload className="w-8 h-8 text-rose-300" />
                  </div>
                  <p className="text-rose-400 font-bold text-lg">Drop or Click to Upload</p>
                  <p className="text-gray-400 text-sm mt-1 uppercase tracking-widest font-medium">JPEG, PNG, WEBP (Max 10MB)</p>
                </>
              )}
            </div>
            
            <button 
              onClick={handleAnalyze} 
              disabled={!file || loading}
              className="beauty-button px-16 py-4 text-xl font-bold disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-3 shadow-rose-200/50"
            >
              {loading ? (
                <>
                  <Wand2 className="w-6 h-6 animate-spin" />
                  Magical Analysis...
                </>
              ) : (
                <>
                  <Sparkles className="w-6 h-6" />
                  Recreate Look
                </>
              )}
            </button>
          </div>
        </div>

        {/* Result Section */}
        <div className="lg:col-span-5 h-full">
          {result ? (
            <div className="glass-card p-10 h-full flex flex-col border-rose-100/50">
              <h3 className="text-2xl font-bold text-gray-800 mb-6 flex items-center gap-3">
                <Wand2 className="w-6 h-6 text-rose-400" />
                AI Mapping
              </h3>
              <div className="flex-1 text-gray-600 whitespace-pre-wrap leading-loose italic bg-white/30 rounded-3xl p-6 border border-white/40 shadow-inner overflow-y-auto max-h-[400px]">
                {result}
              </div>
              <button className="beauty-button w-full mt-8 bg-white border-rose-200">
                Apply to My 3D Mesh
              </button>
            </div>
          ) : (
            <div className="glass-card p-10 h-[500px] flex flex-col items-center justify-center text-center opacity-60">
              <Sparkles className="w-16 h-16 text-rose-200 mb-4" />
              <p className="text-gray-400 font-medium">Analysis data will appear here once you upload an image.</p>
            </div>
          )}
        </div>

      </div>
    </div>
  );
}