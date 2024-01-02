'use client';

import * as React from 'react';
import { ThemeProvider as SystemThemeProvider, useTheme as useSystemTheme } from '@mui/system';
import defaultTheme from './defaultTheme';
import extendTheme from './extendTheme';
import THEME_ID from './identifier';
import { jsx as _jsx } from "react/jsx-runtime";
export const useTheme = () => {
  const theme = useSystemTheme(defaultTheme);
  if (process.env.NODE_ENV !== 'production') {
    // eslint-disable-next-line react-hooks/rules-of-hooks
    React.useDebugValue(theme);
  }

  // @ts-ignore internal logic
  return theme[THEME_ID] || theme;
};
export default function ThemeProvider({
  children,
  theme: themeInput
}) {
  let theme = defaultTheme;
  if (themeInput) {
    theme = extendTheme(THEME_ID in themeInput ? themeInput[THEME_ID] : themeInput);
  }
  return /*#__PURE__*/_jsx(SystemThemeProvider, {
    theme: theme,
    themeId: themeInput && THEME_ID in themeInput ? THEME_ID : undefined,
    children: children
  });
}