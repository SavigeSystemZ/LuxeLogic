"use client";

import { useAuth } from '../../hooks/useAuth';
import { Sparkles, Heart, Video, ArrowRight } from 'lucide-react';
import Link from 'next/link';

export default function ProfilePage() {
  const { user, loading } = useAuth();

  if (loading) {
    return (
      <div className="flex flex-col items-center justify-center h-full flex-1 w-full mt-10">
        <div className="glass-card p-12 text-center text-rose-300">
          <Sparkles className="w-8 h-8 animate-spin mx-auto mb-4" />
          Loading Profile...
        </div>
      </div>
    );
  }

  if (!user) {
    return (
      <div className="flex flex-col items-center justify-center h-full flex-1 w-full mt-10">
        <div className="glass-card p-12 text-center max-w-lg">
          <h1 className="text-3xl font-bold beauty-gradient mb-4">Please Sign In</h1>
          <p className="text-gray-600 mb-6">
            You must be signed in to view your personalized beauty gallery and saved looks.
          </p>
          <Link href="/" className="beauty-button inline-flex items-center gap-2 px-6 py-2">
            Return Home <ArrowRight className="w-4 h-4" />
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-8 w-full h-full pb-12 mt-4">
      <div className="glass-card p-8 flex flex-col md:flex-row items-center gap-6">
        <div className="w-24 h-24 rounded-full deep-glass flex items-center justify-center text-3xl font-bold text-rose-500 shadow-xl border-4 border-white/40">
          {user.username.charAt(0).toUpperCase()}
        </div>
        <div className="text-center md:text-left">
          <h1 className="text-3xl font-bold beauty-gradient">{user.username}&apos;s Gallery</h1>
          <p className="text-gray-600">{user.email}</p>
          <div className="flex gap-4 mt-4 justify-center md:justify-start">
            <span className="px-3 py-1 bg-white/40 rounded-full text-xs font-medium text-rose-500 border border-white/60">
              Tone: {user.skin_tone || 'Analyzing...'}
            </span>
            <span className="px-3 py-1 bg-white/40 rounded-full text-xs font-medium text-blue-500 border border-white/60">
              Shape: {user.face_shape || 'Unknown'}
            </span>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <div className="glass-card p-6">
          <h2 className="text-xl font-semibold mb-4 flex items-center gap-2">
            <Heart className="w-5 h-5 text-rose-400" />
            Saved Looks
          </h2>
          <div className="grid grid-cols-2 sm:grid-cols-3 gap-4">
            {[1, 2, 3].map(i => (
              <div key={i} className="aspect-square bg-white/30 rounded-2xl border border-white/20 hover:bg-white/50 transition-colors cursor-pointer flex items-center justify-center relative overflow-hidden group">
                <Sparkles className="w-8 h-8 text-rose-300 opacity-50 group-hover:opacity-100 transition-opacity" />
                <div className="absolute bottom-0 left-0 right-0 bg-white/60 backdrop-blur-md p-2 translate-y-full group-hover:translate-y-0 transition-transform">
                  <p className="text-xs font-medium text-center truncate">Look #{i}</p>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="glass-card p-6">
          <h2 className="text-xl font-semibold mb-4 flex items-center gap-2">
            <Video className="w-5 h-5 text-blue-400" />
            Favorite Tutorials
          </h2>
          <div className="flex flex-col gap-3">
            {[1, 2].map(i => (
              <div key={i} className="p-3 bg-white/30 rounded-xl border border-white/20 hover:bg-white/50 transition-colors cursor-pointer flex items-center gap-4">
                <div className="w-16 h-12 bg-blue-100/50 rounded-lg flex items-center justify-center">
                  <Video className="w-4 h-4 text-blue-400" />
                </div>
                <div>
                  <p className="font-medium text-sm">Pro Blending Basics</p>
                  <p className="text-xs text-gray-500">Added yesterday</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}