"use client";

import { useState, useEffect, useCallback } from 'react';

export interface UserProfile {
  id: number;
  username: string;
  email: string;
  skin_tone?: string;
  face_shape?: string;
}

export function useAuth() {
  const [user, setUser] = useState<UserProfile | null>(null);
  const [token, setToken] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchProfile = useCallback(async (authToken: string) => {
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL || '/api'}/profiles/me`, {
        headers: {
          'Authorization': `Bearer ${authToken}`
        }
      });
      if (response.ok) {
        const data = await response.json();
        setUser(data);
      } else {
        logout();
      }
    } catch (e) {
      console.error("Failed to fetch profile", e);
      logout();
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    const storedToken = localStorage.getItem('luxelogic_token');
    if (storedToken) {
      setToken(storedToken);
      fetchProfile(storedToken);
    } else {
      setLoading(false);
    }
  }, [fetchProfile]);

  const login = async (username: string, password: string): Promise<boolean> => {
    try {
      const formData = new URLSearchParams();
      formData.append('username', username);
      formData.append('password', password);

      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL || '/api'}/token`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: formData.toString()
      });

      if (response.ok) {
        const data = await response.json();
        const newToken = data.access_token;
        localStorage.setItem('luxelogic_token', newToken);
        setToken(newToken);
        await fetchProfile(newToken);
        return true;
      }
      return false;
    } catch (e) {
      console.error("Login error", e);
      return false;
    }
  };

  const register = async (username: string, email: string, password: string): Promise<boolean> => {
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL || '/api'}/profiles/`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ username, email, password })
      });

      if (response.ok) {
        // Automatically login after successful registration
        return await login(username, password);
      }
      return false;
    } catch (e) {
      console.error("Registration error", e);
      return false;
    }
  };

  const logout = () => {
    localStorage.removeItem('luxelogic_token');
    setToken(null);
    setUser(null);
  };

  return { user, token, loading, login, register, logout };
}