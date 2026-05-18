"use client";

import { useState } from 'react';
import { X, User, Mail, Lock } from 'lucide-react';
import { useAuth } from '../hooks/useAuth';

interface AuthModalProps {
  isOpen: boolean;
  onClose: () => void;
}

export function AuthModal({ isOpen, onClose }: AuthModalProps) {
  const { login, register } = useAuth();
  const [isLogin, setIsLogin] = useState(true);
  const [username, setUsername] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  if (!isOpen) return null;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    let success = false;
    if (isLogin) {
      success = await login(username, password);
    } else {
      success = await register(username, email, password);
    }

    setLoading(false);
    if (success) {
      onClose();
    } else {
      setError(isLogin ? "Invalid credentials" : "Registration failed (email may exist)");
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm p-4">
      <div className="bg-white/80 backdrop-blur-md border border-white/60 p-8 rounded-3xl w-full max-w-md shadow-2xl relative overflow-hidden">
        {/* Decorative elements */}
        <div className="absolute top-[-50px] right-[-50px] w-32 h-32 bg-rose-200/50 rounded-full blur-[30px] -z-10" />
        <div className="absolute bottom-[-50px] left-[-50px] w-32 h-32 bg-blue-200/50 rounded-full blur-[30px] -z-10" />

        <button 
          onClick={onClose}
          className="absolute top-4 right-4 text-gray-500 hover:text-gray-800 transition-colors"
        >
          <X className="w-6 h-6" />
        </button>

        <h2 className="text-3xl font-bold beauty-gradient mb-6 text-center">
          {isLogin ? 'Welcome Back' : 'Create Profile'}
        </h2>

        {error && (
          <div className="bg-red-100/80 text-red-600 p-3 rounded-xl mb-4 text-sm text-center backdrop-blur-sm border border-red-200/50">
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="flex flex-col gap-4">
          <div className="relative">
            <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
              <User className="h-5 w-5 text-gray-400" />
            </div>
            <input 
              type="text" 
              required
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              placeholder="Username" 
              className="w-full pl-10 pr-4 py-3 bg-white/50 border border-white/40 rounded-xl focus:outline-none focus:ring-2 focus:ring-rose-300 transition-all placeholder:text-gray-500"
            />
          </div>

          {!isLogin && (
            <div className="relative">
              <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <Mail className="h-5 w-5 text-gray-400" />
              </div>
              <input 
                type="email" 
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="Email Address" 
                className="w-full pl-10 pr-4 py-3 bg-white/50 border border-white/40 rounded-xl focus:outline-none focus:ring-2 focus:ring-rose-300 transition-all placeholder:text-gray-500"
              />
            </div>
          )}

          <div className="relative">
            <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
              <Lock className="h-5 w-5 text-gray-400" />
            </div>
            <input 
              type="password" 
              required
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Password" 
              className="w-full pl-10 pr-4 py-3 bg-white/50 border border-white/40 rounded-xl focus:outline-none focus:ring-2 focus:ring-rose-300 transition-all placeholder:text-gray-500"
            />
          </div>

          <button 
            type="submit" 
            disabled={loading}
            className="mt-2 w-full py-3 bg-gradient-to-r from-rose-400 to-pink-500 hover:from-rose-500 hover:to-pink-600 text-white rounded-xl font-semibold shadow-lg shadow-rose-200/50 transition-all transform hover:scale-[1.02] disabled:opacity-70 disabled:hover:scale-100 disabled:cursor-not-allowed"
          >
            {loading ? 'Processing...' : (isLogin ? 'Sign In' : 'Sign Up')}
          </button>
        </form>

        <p className="mt-6 text-center text-sm text-gray-600">
          {isLogin ? "Don't have an account? " : "Already have an account? "}
          <button 
            type="button"
            onClick={() => { setIsLogin(!isLogin); setError(''); }}
            className="text-rose-500 font-semibold hover:underline focus:outline-none"
          >
            {isLogin ? "Sign Up" : "Sign In"}
          </button>
        </p>
      </div>
    </div>
  );
}