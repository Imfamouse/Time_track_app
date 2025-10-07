// API клиент для работы с backend
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000';

export interface Project {
  id: number;
  name: string;
  description?: string;
  color: string;
}

export interface TimeEntry {
  id: number;
  user_id: number;
  project_id: number;
  description: string;
  start_time: string;
  end_time?: string;
  duration_minutes?: number;
  is_running: boolean;
}

export interface TimeEntryCreate {
  user_id?: number;
  project_id: number;
  description: string;
  start_time?: string;
}

export interface User {
  id: number;
  name: string;
  email: string;
  role: string;
}

export interface TimeStats {
  total_hours_today: number;
  total_hours_week: number;
  total_hours_month: number;
  entries_count: number;
  top_projects: Array<{
    project_id: number;
    project_name: string;
    hours: number;
    color: string;
  }>;
}

class ApiClient {
  private baseUrl: string;

  constructor(baseUrl: string) {
    this.baseUrl = baseUrl;
  }

  private async request<T>(endpoint: string, options?: RequestInit): Promise<T> {
    const response = await fetch(`${this.baseUrl}${endpoint}`, {
      headers: {
        'Content-Type': 'application/json',
        ...options?.headers,
      },
      ...options,
    });

    if (!response.ok) {
      throw new Error(`API Error: ${response.statusText}`);
    }

    if (response.status === 204) {
      return {} as T;
    }

    return response.json();
  }

  // Projects
  async getProjects(): Promise<Project[]> {
    return this.request<Project[]>('/api/projects');
  }

  async getProject(id: number): Promise<Project> {
    return this.request<Project>(`/api/projects/${id}`);
  }

  // Users
  async getCurrentUser(): Promise<User> {
    return this.request<User>('/api/users/me');
  }

  // Time Entries
  async getTimeEntries(userId?: number): Promise<TimeEntry[]> {
    const params = userId ? `?user_id=${userId}` : '';
    return this.request<TimeEntry[]>(`/api/time-entries${params}`);
  }

  async getTimeEntry(id: number): Promise<TimeEntry> {
    return this.request<TimeEntry>(`/api/time-entries/${id}`);
  }

  async createTimeEntry(data: TimeEntryCreate): Promise<TimeEntry> {
    return this.request<TimeEntry>('/api/time-entries', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  }

  async updateTimeEntry(
    id: number,
    data: Partial<TimeEntryCreate>
  ): Promise<TimeEntry> {
    return this.request<TimeEntry>(`/api/time-entries/${id}`, {
      method: 'PATCH',
      body: JSON.stringify(data),
    });
  }

  async stopTimeEntry(id: number): Promise<TimeEntry> {
    return this.request<TimeEntry>(`/api/time-entries/${id}/stop`, {
      method: 'POST',
    });
  }

  async deleteTimeEntry(id: number): Promise<void> {
    return this.request<void>(`/api/time-entries/${id}`, {
      method: 'DELETE',
    });
  }

  // Stats
  async getStats(userId: number = 1): Promise<TimeStats> {
    return this.request<TimeStats>(`/api/stats?user_id=${userId}`);
  }
}

export const apiClient = new ApiClient(API_BASE_URL);