export async function fetchWithAuth(url: string, options: RequestInit = {}) {
  const token = typeof window !== 'undefined' ? localStorage.getItem('luxelogic_token') : null;
  
  const headers = new Headers(options.headers || {});
  if (token && !headers.has('Authorization')) {
    headers.set('Authorization', `Bearer ${token}`);
  }

  const finalOptions = {
    ...options,
    headers
  };

  const response = await fetch(url, finalOptions);
  
  if (response.status === 401) {
    // Handle unauthorized globally (e.g., clear token)
    if (typeof window !== 'undefined') {
      localStorage.removeItem('luxelogic_token');
      // Could dispatch an event here to notify useAuth to clear state
      window.dispatchEvent(new Event('auth:unauthorized'));
    }
  }

  return response;
}