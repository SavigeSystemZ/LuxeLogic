"use client";

import { useState } from 'react';
import Link from 'next/link';
import { Sparkles, Star, UserCircle } from 'lucide-react';
import { useAuth } from '../hooks/useAuth';
import { AuthModal } from './AuthModal';

export function Header() {
  const [isAuthModalOpen, setIsAuthModalOpen] = useState(false);
  const { user, logout } = useAuth();

  return (
    <header className="w-full max-w-6xl mx-auto flex justify-between items-center mt-6 mb-12 z-10">
      <AuthModal isOpen={isAuthModalOpen} onClose={() => setIsAuthModalOpen(false)} />
      
      <div className="flex items-center gap-2">
        <Link href="/" className="flex items-center gap-2">
          <div className="w-10 h-10 bg-white/40 backdrop-blur-md rounded-xl flex items-center justify-center border border-white/40 hover:bg-white/60 transition-colors">
            <Sparkles className="text-rose-400 w-6 h-6" />
          </div>
          <h1 className="text-2xl font-bold beauty-gradient">LuxeLogic</h1>
        </Link>
      </div>
      
      <nav className="hidden md:flex gap-8 items-center glass-card px-8 py-3">
        <Link href="/tutorials" className="hover:text-rose-400 transition-colors">Tutorials</Link>
        <Link href="/techniques" className="hover:text-rose-400 transition-colors">Techniques</Link>
        <Link href="/" className="hover:text-rose-400 transition-colors">Try-On</Link>
        <Link href="/vision" className="hover:text-rose-400 transition-colors">Vision AI</Link>
        {user && <Link href="/profile" className="hover:text-rose-400 transition-colors">My Gallery</Link>}
      </nav>

      <div className="flex items-center gap-4">
        {user ? (
          <div className="flex items-center gap-3">
            <span className="text-sm font-medium text-gray-700">Hi, {user.username}</span>
            <button onClick={logout} className="text-sm text-rose-500 hover:underline">Logout</button>
          </div>
        ) : (
          <button onClick={() => setIsAuthModalOpen(true)} className="flex items-center gap-2 text-rose-500 hover:text-rose-600 transition-colors font-medium">
            <UserCircle className="w-5 h-5" />
            Sign In
          </button>
        )}
        <button className="beauty-button flex items-center gap-2">
          <Star className="w-4 h-4" />
          VIP Access
        </button>
      </div>
    </header>
  );
}