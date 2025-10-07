import { describe, expect, it } from 'vitest';
import React from 'react';
import { render, screen } from '@testing-library/react';
import { Provider } from 'react-redux';
import { configureStore } from '@reduxjs/toolkit';

import { App } from './App';
import timeEntriesReducer from './store/timeEntriesSlice';
import projectsReducer from './store/projectsSlice';
import statsReducer from './store/statsSlice';

const createTestStore = () =>
  configureStore({
    reducer: {
      timeEntries: timeEntriesReducer,
      projects: projectsReducer,
      stats: statsReducer,
    },
  });

describe('App bootstrap', () => {
  it('renders main heading', () => {
    const store = createTestStore();
    render(
      <Provider store={store}>
        <App />
      </Provider>
    );
    expect(screen.getByText(/Time Track/i)).toBeDefined();
  });
});
