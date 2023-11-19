import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.scss';
import { ConfigProvider } from './providers/ConfigProvider';
import { LocalesProvider } from './providers/LocalesProvider';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <ConfigProvider>
      <LocalesProvider>
          <App />
      </LocalesProvider>
    </ConfigProvider>
  </React.StrictMode>,
);
