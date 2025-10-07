import { configureStore } from '@reduxjs/toolkit';
import timeEntriesReducer from './timeEntriesSlice';
import projectsReducer from './projectsSlice';
import statsReducer from './statsSlice';

export const store = configureStore({
  reducer: {
    timeEntries: timeEntriesReducer,
    projects: projectsReducer,
    stats: statsReducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;