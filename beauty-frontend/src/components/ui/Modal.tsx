"use client";

import { motion, AnimatePresence } from 'framer-motion';
import { X } from 'lucide-react';
import { cn } from '../../lib/utils/cn';

interface ModalProps {
  isOpen: boolean;
  onClose: () => void;
  title: string;
  children: React.ReactNode;
  className?: string;
}

export function Modal({ isOpen, onClose, title, children, className }: ModalProps) {
  return (
    <AnimatePresence>
      {isOpen && (
        <>
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={onClose}
            className="fixed inset-0 z-[60] bg-black/40 backdrop-blur-sm"
          />
          <div className="fixed inset-0 z-[70] flex items-center justify-center p-4 pointer-events-none">
            <motion.div
              initial={{ opacity: 0, scale: 0.9, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.9, y: 20 }}
              className={cn(
                "bg-white/90 backdrop-blur-xl border border-white/60 shadow-2xl rounded-[40px] w-full max-w-2xl max-h-[90vh] overflow-hidden flex flex-col pointer-events-auto",
                className
              )}
            >
              <div className="flex items-center justify-between p-8 border-b border-white/40">
                <h2 className="text-3xl font-bold beauty-gradient">{title}</h2>
                <button 
                  onClick={onClose}
                  className="w-10 h-10 rounded-full flex items-center justify-center hover:bg-gray-100 transition-colors"
                >
                  <X className="w-6 h-6 text-gray-500" />
                </button>
              </div>
              <div className="flex-1 overflow-y-auto p-8">
                {children}
              </div>
            </motion.div>
          </div>
        </>
      )}
    </AnimatePresence>
  );
}