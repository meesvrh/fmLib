'use client';

import _extends from "@babel/runtime/helpers/esm/extends";
import { useThemeProps as systemUseThemeProps } from '@mui/system';
import defaultTheme from './defaultTheme';
import THEME_ID from './identifier';
export default function useThemeProps({
  props,
  name
}) {
  return systemUseThemeProps({
    props,
    name,
    defaultTheme: _extends({}, defaultTheme, {
      components: {}
    }),
    themeId: THEME_ID
  });
}