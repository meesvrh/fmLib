import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.scss';
import { SettingsProvider } from './providers/SettingsProvider';
import { CssVarsProvider } from '@mui/joy/styles';
import theme from './theme';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <SettingsProvider>
      <CssVarsProvider
        defaultMode="dark"
        theme={theme}
      >
        <App />
      </CssVarsProvider>
    </SettingsProvider>
  </React.StrictMode>,
);
