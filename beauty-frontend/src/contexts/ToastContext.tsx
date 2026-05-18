"use client";

import { useState, useEffect, createContext, useContext, useCallback } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X, CheckCircle2, AlertCircle, Info } from 'lucide-react';
import { cn } from '../lib/utils/cn';

type ToastType = 'success' | 'error' | 'info';

interface Toast {
  id: string;
  message: string;
  type: ToastType;
}

interface ToastContextType {
  toast: (message: string, type?: ToastType) => void;
}

const ToastContext = createContext<ToastContextType | null>(null);

export function ToastProvider({ children }: { children: React.ReactNode }) {
  const [toasts, setToasts] = useState<Toast[]>([]);

  const toast = useCallback((message: string, type: ToastType = 'info') => {
    const id = Math.random().toString(36).substring(2, 9);
    setToasts((prev) => [...prev, { id, message, type }]);
    setTimeout(() => {
      setToasts((prev) => prev.filter((t) => t.id !== id));
    }, 4000);
  }, []);

  const remove = (id: string) => {
    setToasts((prev) => prev.filter((t) => t.id !== id));
  };

  return (
    <ToastContext.Provider value={{ toast }}>
      {children}
      <div className="fixed bottom-6 right-6 z-[100] flex flex-col gap-3">
        <AnimatePresence>
          {toasts.map((t) => (
            <motion.div
              key={t.id}
              initial={{ opacity: 0, x: 20, scale: 0.9 }}
              animate={{ opacity: 1, x: 0, scale: 1 }}
              exit={{ opacity: 0, x: 20, scale: 0.9 }}
              className={cn(
                "flex items-center gap-3 px-6 py-4 rounded-2xl shadow-xl backdrop-blur-md border min-w-[300px]",
                t.type === 'success' && "bg-green-50/80 border-green-200 text-green-800",
                t.type === 'error' && "bg-red-50/80 border-red-200 text-red-800",
                t.type === 'info' && "bg-blue-50/80 border-blue-200 text-blue-800"
              )}
            >
              {t.type === 'success' && <CheckCircle2 className="w-5 h-5 text-green-500" />}
              {t.type === 'error' && <AlertCircle className="w-5 h-5 text-red-500" />}
              {t.type === 'info' && <Info className="w-5 h-5 text-blue-500" />}
              <p className="text-sm font-medium flex-1">{t.message}</p>
              <button onClick={() => remove(t.id)} className="text-gray-400 hover:text-gray-600">
                <X className="w-4 h-4" />
              </button>
            </motion.div>
          ))}
        </AnimatePresence>
      </div>
    </ToastContext.Provider>
  );
}

export function useToast() {
  const context = useContext(ToastContext);
  if (!context) throw new Error('useToast must be used within ToastProvider');
  return context;
}