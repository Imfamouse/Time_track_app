import { createSlice, createAsyncThunk, PayloadAction } from '@reduxjs/toolkit';
import { apiClient, TimeEntry, TimeEntryCreate } from '../api/client';

interface TimeEntriesState {
  entries: TimeEntry[];
  loading: boolean;
  error: string | null;
}

const initialState: TimeEntriesState = {
  entries: [],
  loading: false,
  error: null,
};

export const fetchTimeEntries = createAsyncThunk(
  'timeEntries/fetchAll',
  async (userId?: number) => {
    return await apiClient.getTimeEntries(userId);
  }
);

export const createTimeEntry = createAsyncThunk(
  'timeEntries/create',
  async (data: TimeEntryCreate) => {
    return await apiClient.createTimeEntry(data);
  }
);

export const stopTimeEntry = createAsyncThunk(
  'timeEntries/stop',
  async (id: number) => {
    return await apiClient.stopTimeEntry(id);
  }
);

export const deleteTimeEntry = createAsyncThunk(
  'timeEntries/delete',
  async (id: number) => {
    await apiClient.deleteTimeEntry(id);
    return id;
  }
);

const timeEntriesSlice = createSlice({
  name: 'timeEntries',
  initialState,
  reducers: {},
  extraReducers: (builder) => {
    builder
      // Fetch all
      .addCase(fetchTimeEntries.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(fetchTimeEntries.fulfilled, (state, action: PayloadAction<TimeEntry[]>) => {
        state.loading = false;
        state.entries = action.payload;
      })
      .addCase(fetchTimeEntries.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message || 'Failed to fetch time entries';
      })
      // Create
      .addCase(createTimeEntry.fulfilled, (state, action: PayloadAction<TimeEntry>) => {
        state.entries.unshift(action.payload);
      })
      // Stop
      .addCase(stopTimeEntry.fulfilled, (state, action: PayloadAction<TimeEntry>) => {
        const index = state.entries.findIndex((e) => e.id === action.payload.id);
        if (index !== -1) {
          state.entries[index] = action.payload;
        }
      })
      // Delete
      .addCase(deleteTimeEntry.fulfilled, (state, action: PayloadAction<number>) => {
        state.entries = state.entries.filter((e) => e.id !== action.payload);
      });
  },
});

export default timeEntriesSlice.reducer;