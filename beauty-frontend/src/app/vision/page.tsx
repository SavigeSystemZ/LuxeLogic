/* eslint-disable @next/next/no-img-element */
"use client";

import { useState, useRef } from 'react';
import { fetchWithAuth } from '../../lib/apiClient';
import { Upload, Sparkles, AlertCircle } from 'lucide-react';

export default function VisionPage() {
  const [file, setFile] = useState<File | null>(null);
  const [preview, setPreview] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const selectedFile = e.target.files?.[0];
    if (selectedFile) {
      if (!selectedFile.type.startsWith('image/')) {
        setError('Please select a valid image file.');
        setFile(null);
        setPreview(null);
        return;
      }
      if (selectedFile.size > 10 * 1024 * 1024) { // 10MB limit
        setError('Image file is too large. Maximum size is 10MB.');
        setFile(null);
        setPreview(null);
        return;
      }
      
      setFile(selectedFile);
      setPreview(URL.createObjectURL(selectedFile));
      setResult(null);
      setError(null);
    }
  };

  const handleAnalyze = async () => {
    if (!file) return;
    setLoading(true);
    setError(null);
    
    const formData = new FormData();
    formData.append('file', file);

    try {
      const response = await fetchWithAuth(`${process.env.NEXT_PUBLIC_API_URL || '/api'}/ai/recreate-look`, {
        method: 'POST',
        body: formData,
      });

      if (!response.ok) {
        throw new Error("Failed to analyze image. Please ensure you are logged in.");
      }

      const data = await response.json();
      setResult(data.answer);
    } catch (e: any) {
      setError(e.message || "An unexpected error occurred.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex flex-col items-center justify-center h-full flex-1 w-full mt-10">
      <div className="glass-card p-8 md:p-12 w-full max-w-3xl flex flex-col items-center text-center">
        <h1 className="text-3xl font-bold beauty-gradient mb-4">Recreate The Look</h1>
        <p className="text-gray-600 mb-8 max-w-lg">
          Upload a photo of any makeup look you admire, and our advanced AI vision model will map out exactly how to achieve it on your own face.
        </p>
        
        <input 
          type="file" 
          accept="image/*" 
          className="hidden" 
          ref={fileInputRef} 
          onChange={handleFileChange} 
        />
        
        <div 
          onClick={() => fileInputRef.current?.click()}
          className="w-full h-64 border-2 border-dashed border-rose-300 rounded-[30px] flex flex-col items-center justify-center bg-white/30 hover:bg-white/50 transition-colors cursor-pointer mb-6 relative overflow-hidden"
        >
          {preview ? (
            <div className="absolute inset-0 w-full h-full p-2">
              <img src={preview} alt="Preview" className="w-full h-full object-contain rounded-[20px]" />
            </div>
          ) : (
            <>
              <Upload className="w-10 h-10 text-rose-300 mb-2" />
              <p className="text-rose-400 font-medium">Click to upload an image</p>
            </>
          )}
        </div>
        
        {error && (
          <div className="flex items-center gap-2 text-red-500 mb-4 bg-red-50 px-4 py-2 rounded-xl">
            <AlertCircle className="w-5 h-5" />
            <span className="text-sm font-medium">{error}</span>
          </div>
        )}

        <button 
          onClick={handleAnalyze} 
          disabled={!file || loading}
          className="beauty-button px-12 py-3 text-lg disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
        >
          {loading ? (
            <>
              <Sparkles className="w-5 h-5 animate-spin" />
              Analyzing...
            </>
          ) : (
            <>
              <Sparkles className="w-5 h-5" />
              Analyze Image
            </>
          )}
        </button>

        {result && (
          <div className="mt-8 p-6 bg-white/60 rounded-2xl text-left w-full border border-white/40 shadow-sm">
            <h3 className="font-semibold text-gray-800 mb-2">AI Analysis & Actions</h3>
            <p className="text-sm text-gray-700 whitespace-pre-wrap">{result}</p>
          </div>
        )}
      </div>
    </div>
  );
}