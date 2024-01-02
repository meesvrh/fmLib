import * as React from 'react';
import THEME_ID from './identifier';
import type { Theme } from './types';
import type { CssVarsThemeOptions } from './extendTheme';
export declare const useTheme: () => Theme;
export default function ThemeProvider({ children, theme: themeInput, }: React.PropsWithChildren<{
    theme?: CssVarsThemeOptions | {
        [k in typeof THEME_ID]: CssVarsThemeOptions;
    };
}>): React.JSX.Element;
