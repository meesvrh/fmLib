import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.scss';
import { ThemeProvider, createTheme } from '@mui/material/styles';

const theme = createTheme({
  palette: {
    mode: 'dark',
    primary: {
      main: '#f2910a',
    },
    error: {
      main: '#f21d0a',
    },
    success: {
      main: '#6bf20a',
    },
    info: {
      main: '#0a6bf2',
    },
    warning: {
      main: '#e87707',
    },
    secondary: {
      main: '#0a6bf2',
    },
  }
});


ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <ThemeProvider theme={theme}>
      <App />
    </ThemeProvider>
  </React.StrictMode>,
);
