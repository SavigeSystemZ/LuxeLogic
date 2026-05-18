import type { Metadata, Viewport } from "next";
import "./globals.css";
import { Header } from "../components/Header";
import { WebSocketProvider } from "../contexts/WebSocketContext";
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
      <body className={`font-sans min-h-screen flex flex-col items-center relative overflow-hidden transition-colors duration-1000 bg-rose-50`}>
        <WebSocketProvider>
          {/* Stunning 3D Particle Background */}
          <ParticleBackground />
          
          {/* Decorative background blobs - Global */}
          <div className={`absolute top-[-10%] left-[-5%] w-[40%] h-[40%] bg-rose-200/30 rounded-full blur-[100px] -z-10 animate-pulse`} />
          <div className="absolute bottom-[-5%] right-[-5%] w-[40%] h-[40%] bg-blue-200/30 rounded-full blur-[100px] -z-10 animate-pulse delay-1000" />
          
          <Header />
          <main className="flex-1 w-full max-w-7xl px-6 md:px-12 z-10 flex flex-col">
            <PageTransition>
              {children}
            </PageTransition>
          </main>
          
          <footer className="w-full max-w-6xl mt-12 mb-6 py-6 border-t border-white/20 text-center text-gray-500 text-sm z-10">
            <p>© 2026 LuxeLogic • Advanced Beauty Systems • <span className="text-rose-300 font-medium">Kehley Edition</span></p>
          </footer>
        </WebSocketProvider>
      </body>
    </html>
  );
}
