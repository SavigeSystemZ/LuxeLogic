"use client";

import { useState, useEffect } from 'react';
import { Star, CheckCircle2, ChevronRight } from 'lucide-react';
import { Modal } from '../../components/ui/Modal';
import { fetchWithAuth } from '../../lib/apiClient';

export default function TechniquesPage() {
  const [techniques, setTechniques] = useState<any[]>([]);
  const [selectedTech, setSelectedTech] = useState<any>(null);
  const [isModalOpen, setIsModalOpen] = useState(false);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await fetchWithAuth(`${process.env.NEXT_PUBLIC_API_URL || '/api'}/techniques/`);
        if (res.ok) setTechniques(await res.json());
      } catch (e) {
        console.error("Failed to fetch techniques", e);
      }
    };
    fetchData();
  }, []);

  const openSteps = (tech: any) => {
    setSelectedTech(tech);
    setIsModalOpen(true);
  };

  return (
    <div className="flex flex-col gap-6 w-full h-full pb-12">
      <h1 className="text-4xl font-bold beauty-gradient mb-8">Professional Techniques</h1>
      
      <Modal 
        isOpen={isModalOpen} 
        onClose={() => setIsModalOpen(false)} 
        title={selectedTech?.title || 'Technique Steps'}
      >
        <div className="flex flex-col gap-6">
          <p className="text-gray-600 italic leading-relaxed">{selectedTech?.description}</p>
          <div className="flex flex-col gap-4">
            {selectedTech?.steps?.length > 0 ? selectedTech.steps.map((step: any) => (
              <div key={step.id} className="flex gap-4 p-5 rounded-3xl bg-white/40 border border-white/40 shadow-sm hover:shadow-md transition-shadow">
                <div className="w-10 h-10 rounded-full bg-rose-100 flex items-center justify-center text-rose-500 font-bold shrink-0">
                  {step.step_number}
                </div>
                <div>
                  <h3 className="font-bold text-gray-800 text-lg">{step.title}</h3>
                  <p className="text-gray-600 text-sm mt-1">{step.description}</p>
                </div>
              </div>
            )) : (
              <div className="p-8 text-center text-gray-400 bg-white/30 rounded-3xl border border-dashed border-white/60">
                Steps coming soon to the master catalog.
              </div>
            )}
          </div>
          <button className="beauty-button w-full py-4 text-lg font-bold flex items-center justify-center gap-2 mt-4 shadow-rose-200/50">
            <CheckCircle2 className="w-5 h-5" />
            Mark as Mastered
          </button>
        </div>
      </Modal>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        {techniques.length > 0 ? techniques.map((tech) => (
          <div key={tech.id} className="glass-card p-8 group hover:scale-[1.03] transition-all duration-500 flex flex-col h-full border-white/40 shadow-xl hover:shadow-rose-100/40">
            <div className="flex items-center justify-between mb-4">
               <div className="w-12 h-12 rounded-2xl bg-rose-100/50 flex items-center justify-center text-rose-500">
                 <Star className="w-6 h-6 fill-current" />
               </div>
               {tech.category && (
                 <span className="px-3 py-1 bg-white/60 rounded-full text-[10px] font-bold uppercase tracking-wider text-gray-500 border border-white/60">
                   {tech.category}
                 </span>
               )}
            </div>
            <h2 className="text-2xl font-bold text-gray-800 mb-3">{tech.title}</h2>
            <p className="text-gray-500 text-sm mb-8 line-clamp-3 leading-relaxed flex-1">{tech.description}</p>
            <button 
              onClick={() => openSteps(tech)}
              className="beauty-button w-full text-sm font-bold flex items-center justify-center gap-2 group-hover:bg-white transition-colors"
            >
              View Steps
              <ChevronRight className="w-4 h-4" />
            </button>
          </div>
        )) : (
          [1,2,3].map(i => (
            <div key={i} className="glass-card p-8 h-[300px] animate-pulse">
              <div className="w-12 h-12 bg-white/40 rounded-2xl mb-4" />
              <div className="h-6 w-3/4 bg-white/40 rounded-lg mb-3" />
              <div className="h-4 w-full bg-white/40 rounded-lg mb-2" />
              <div className="h-4 w-5/6 bg-white/40 rounded-lg" />
            </div>
          ))
        )}
      </div>
    </div>
  );
}