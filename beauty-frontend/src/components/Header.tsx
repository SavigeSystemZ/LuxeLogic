"use client";

import { useState } from 'react';
import Link from 'next/link';
import { Sparkles, Star, UserCircle, Menu, X } from 'lucide-react';
import { useAuth } from '../hooks/useAuth';
import { AuthModal } from './AuthModal';
import { cn } from '../lib/utils/cn';

export function Header() {
  const [isAuthModalOpen, setIsAuthModalOpen] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const { user, logout } = useAuth();

  const navLinks = [
    { href: '/tutorials', label: 'Tutorials' },
    { href: '/techniques', label: 'Techniques' },
    { href: '/', label: 'Try-On' },
    { href: '/vision', label: 'Vision AI' },
    ...(user ? [{ href: '/profile', label: 'My Gallery' }] : []),
  ];

  return (
    <header className="w-full max-w-7xl mx-auto flex justify-between items-center py-6 px-6 md:px-12 z-[100] sticky top-0">
      <AuthModal isOpen={isAuthModalOpen} onClose={() => setIsAuthModalOpen(false)} />
      
      <Link href="/" className="flex items-center gap-3 group">
        <div className="w-12 h-12 bg-white/40 backdrop-blur-xl rounded-2xl flex items-center justify-center border border-white/60 group-hover:bg-white/60 transition-all shadow-lg shadow-rose-200/20">
          <Sparkles className="text-rose-400 w-7 h-7" />
        </div>
        <h1 className="text-3xl font-black beauty-gradient tracking-tighter">LuxeLogic</h1>
      </Link>
      
      {/* Desktop Nav */}
      <nav className="hidden lg:flex gap-2 items-center bg-white/30 backdrop-blur-2xl px-2 py-2 rounded-full border border-white/40 shadow-xl">
        {navLinks.map((link) => (
          <Link 
            key={link.href} 
            href={link.href} 
            className="px-6 py-2 rounded-full text-sm font-bold text-gray-700 hover:text-rose-500 hover:bg-white/50 transition-all"
          >
            {link.label}
          </Link>
        ))}
      </nav>

      <div className="flex items-center gap-4">
        <div className="hidden sm:flex items-center gap-4">
          {user ? (
            <Link href="/profile" className="flex items-center gap-3 glass-card px-4 py-2 hover:bg-white/60 transition-colors">
              <div className="w-8 h-8 rounded-full bg-rose-400 flex items-center justify-center text-white text-xs font-bold uppercase">
                {user.username.charAt(0)}
              </div>
              <span className="text-xs font-bold text-gray-700">{user.username}</span>
            </Link>
          ) : (
            <button onClick={() => setIsAuthModalOpen(true)} className="flex items-center gap-2 text-rose-500 hover:text-rose-600 transition-colors font-bold text-sm bg-white/40 px-5 py-2.5 rounded-full border border-white/60">
              <UserCircle className="w-5 h-5" />
              Sign In
            </button>
          )}
          <button className="beauty-button flex items-center gap-2 shadow-rose-200/50">
            <Star className="w-4 h-4 fill-current" />
            <span className="text-xs font-bold uppercase tracking-widest">VIP</span>
          </button>
        </div>

        {/* Mobile Menu Toggle */}
        <button 
          onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
          className="lg:hidden w-12 h-12 rounded-2xl bg-white/40 backdrop-blur-xl flex items-center justify-center border border-white/60 text-gray-700"
        >
          {isMobileMenuOpen ? <X /> : <Menu />}
        </button>
      </div>

      {/* Mobile Menu Overlay */}
      {isMobileMenuOpen && (
        <div className="fixed inset-0 z-[110] bg-white/95 backdrop-blur-3xl flex flex-col p-8 lg:hidden animate-in fade-in slide-in-from-top-4 duration-300">
          <div className="flex justify-between items-center mb-12">
            <h1 className="text-3xl font-black beauty-gradient tracking-tighter">LuxeLogic</h1>
            <button onClick={() => setIsMobileMenuOpen(false)} className="w-12 h-12 rounded-2xl bg-gray-100 flex items-center justify-center text-gray-700">
              <X />
            </button>
          </div>
          <nav className="flex flex-col gap-6">
            {navLinks.map((link) => (
              <Link 
                key={link.href} 
                href={link.href} 
                onClick={() => setIsMobileMenuOpen(false)}
                className="text-4xl font-bold text-gray-800 hover:text-rose-500 transition-colors"
              >
                {link.label}
              </Link>
            ))}
          </nav>
          <div className="mt-auto pt-12 border-t border-gray-100 flex flex-col gap-4">
            {!user && (
               <button onClick={() => { setIsAuthModalOpen(true); setIsMobileMenuOpen(false); }} className="beauty-button w-full py-5 text-xl font-bold">Sign In</button>
            )}
            <button className="beauty-button w-full py-5 text-xl font-bold bg-gray-900 text-white border-none">Get VIP Access</button>
          </div>
        </div>
      )}
    </header>
  );
}