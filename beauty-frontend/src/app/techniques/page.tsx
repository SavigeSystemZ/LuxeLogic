"use client";

import { useState, useEffect } from 'react';
import { Star } from 'lucide-react';

export default function TechniquesPage() {
  const [techniques, setTechniques] = useState<any[]>([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL || '/api'}/techniques/`);
        if (res.ok) setTechniques(await res.json());
      } catch (e) {
        console.error("Failed to fetch techniques", e);
      }
    };
    fetchData();
  }, []);

  return (
    <div className="flex flex-col gap-6 w-full h-full">
      <h1 className="text-3xl font-bold beauty-gradient mb-6">Professional Techniques</h1>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {techniques.length > 0 ? techniques.map((tech) => (
          <div key={tech.id} className="glass-card p-6 hover:scale-105 transition-transform duration-300">
            <h2 className="text-xl font-semibold mb-2 flex items-center gap-2">
              <Star className="text-rose-400 w-5 h-5" />
              {tech.title}
            </h2>
            {tech.description && <p className="text-gray-600 mb-4">{tech.description}</p>}
            <button className="beauty-button w-full text-sm">View Steps</button>
          </div>
        )) : (
          <div className="text-center col-span-full py-12 text-gray-500">Loading techniques...</div>
        )}
      </div>
    </div>
  );
}