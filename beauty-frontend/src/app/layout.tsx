import type { Metadata, Viewport } from "next";
import "./globals.css";
import { Header } from "../components/Header";
import { WebSocketProvider } from "../contexts/WebSocketContext";
import { ToastProvider } from "../contexts/ToastContext";
import { ParticleBackground } from "../components/ParticleBackground";
import { PageTransition } from "../components/PageTransition";

export const viewport: Viewport = {
  themeColor: "#ff9a9e",
  width: "device-width",
  initialScale: 1,
  maximumScale: 1,
};

export const metadata: Metadata = {
  title: "LuxeLogic | Master Your Look",
  description: "Advanced makeup techniques and 3D beauty manipulation.",
  manifest: "/manifest.json",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={`font-sans min-h-screen flex flex-col items-center relative overflow-hidden bg-[#fff5f6]`}>
        <WebSocketProvider>
          <ToastProvider>
            {/* Stunning 3D Particle Background */}
            <ParticleBackground />
            
            {/* Ultra-High-Fidelity Decorative Blobs */}
            <div className="absolute top-[-20%] left-[-10%] w-[60%] h-[60%] bg-gradient-to-br from-rose-200/40 to-transparent rounded-full blur-[120px] -z-10 animate-pulse pointer-events-none" />
            <div className="absolute bottom-[-10%] right-[-10%] w-[50%] h-[50%] bg-gradient-to-tl from-blue-200/40 to-transparent rounded-full blur-[120px] -z-10 animate-pulse delay-1000 pointer-events-none" />
            <div className="absolute top-[30%] right-[-5%] w-[30%] h-[30%] bg-gradient-to-l from-purple-200/30 to-transparent rounded-full blur-[100px] -z-10 pointer-events-none" />
            
            <Header />
            <main className="flex-1 w-full max-w-7xl px-6 md:px-12 z-10 flex flex-col">
              <PageTransition>
                {children}
              </PageTransition>
            </main>
            
            <footer className="w-full max-w-7xl mx-auto px-6 md:px-12 py-10 z-10 border-t border-white/40 mt-12">
              <div className="flex flex-col md:flex-row justify-between items-center gap-6">
                <p className="text-[10px] font-black uppercase tracking-[0.3em] text-gray-400">
                  © 2026 LuxeLogic • <span className="text-rose-400">Kehley Edition</span>
                </p>
                <div className="flex gap-8 text-[10px] font-bold uppercase tracking-widest text-gray-500">
                  <a href="#" className="hover:text-rose-500 transition-colors">Privacy</a>
                  <a href="#" className="hover:text-rose-500 transition-colors">Terms</a>
                  <a href="#" className="hover:text-rose-500 transition-colors">Support</a>
                </div>
              </div>
            </footer>
          </ToastProvider>
        </WebSocketProvider>
      </body>
    </html>
  );
}
