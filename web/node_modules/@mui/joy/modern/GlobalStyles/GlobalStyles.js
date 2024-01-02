'use client';

import _extends from "@babel/runtime/helpers/esm/extends";
import * as React from 'react';
import { GlobalStyles as SystemGlobalStyles } from '@mui/system';
import defaultTheme from '../styles/defaultTheme';
import THEME_ID from '../styles/identifier';
import { jsx as _jsx } from "react/jsx-runtime";
function GlobalStyles(props) {
  return /*#__PURE__*/_jsx(SystemGlobalStyles, _extends({}, props, {
    defaultTheme: defaultTheme,
    themeId: THEME_ID
  }));
}
export default GlobalStyles;