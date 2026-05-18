"use client";

import React, { createContext, useContext, useEffect, useState } from 'react';

interface WebSocketContextType {
  subscribeToTask: (taskId: string, onMessage: (data: any) => void) => () => void;
}

const WebSocketContext = createContext<WebSocketContextType | null>(null);

export function WebSocketProvider({ children }: { children: React.ReactNode }) {
  const [connections] = useState<Map<string, WebSocket>>(new Map());

  const subscribeToTask = (taskId: string, onMessage: (data: any) => void) => {
    if (connections.has(taskId)) {
      // Already connected, just return a no-op cleanup
      return () => {};
    }

    let wsUrl = `${process.env.NEXT_PUBLIC_WS_URL || 'ws://localhost:8000'}/ws/tasks/${taskId}`;
    if (typeof window !== 'undefined') {
      const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
      wsUrl = `${protocol}//${window.location.host}/api/ws/tasks/${taskId}`;
    }
    const ws = new WebSocket(wsUrl);

    ws.onmessage = (event) => {
      try {
        const data = JSON.parse(event.data);
        onMessage(data);
      } catch (e) {
        console.error("WebSocket message parse error", e);
      }
    };

    ws.onclose = () => {
      connections.delete(taskId);
    };

    connections.set(taskId, ws);

    // Cleanup function to close the connection
    return () => {
      if (ws.readyState === WebSocket.OPEN || ws.readyState === WebSocket.CONNECTING) {
        ws.close();
      }
      connections.delete(taskId);
    };
  };

  // Cleanup all connections on unmount
  useEffect(() => {
    return () => {
      connections.forEach(ws => ws.close());
      connections.clear();
    };
  }, [connections]);

  return (
    <WebSocketContext.Provider value={{ subscribeToTask }}>
      {children}
    </WebSocketContext.Provider>
  );
}

export function useWebSocket() {
  const context = useContext(WebSocketContext);
  if (!context) {
    throw new Error('useWebSocket must be used within a WebSocketProvider');
  }
  return context;
}