'use client';

// reexports from system for module augmentation
// Joy typings
export { default as THEME_ID } from './identifier';
export { CssVarsProvider, useColorScheme, getInitColorSchemeScript } from './CssVarsProvider';
export { default as shouldSkipGeneratingVar } from './shouldSkipGeneratingVar';
export { default as styled } from './styled';
export { default as ThemeProvider } from './ThemeProvider';
export * from './ThemeProvider';
export { default as useThemeProps } from './useThemeProps';
export { default as extendTheme, createGetCssVar } from './extendTheme';
export { default as StyledEngineProvider } from './StyledEngineProvider';