import { describe, expect, it } from 'vitest';
import React from 'react';
import { render, screen } from '@testing-library/react';

import { App } from './App';

describe('App bootstrap', () => {
  it('renders heading', () => {
    render(<App />);
    expect(screen.getByText('Time Track App')).toBeDefined();
  });
});
