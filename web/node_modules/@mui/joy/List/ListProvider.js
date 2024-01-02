'use client';

import _extends from "@babel/runtime/helpers/esm/extends";
import * as React from 'react';
import RowListContext from './RowListContext';
import WrapListContext from './WrapListContext';
import NestedListContext from './NestedListContext';

/**
 * This variables should be used in a List to create a scope
 * that will not inherit variables from the upper scope.
 *
 * Used in `Menu`, `MenuList`, `TabList`, `Select`, and `Autocomplete` to communicate with nested List.
 *
 * e.g. menu group:
 * <Menu>
 *   <List>...</List>
 *   <List>...</List>
 * </Menu>
 */
import { jsx as _jsx } from "react/jsx-runtime";
export const scopedVariables = {
  '--NestedList-marginRight': '0px',
  '--NestedList-marginLeft': '0px',
  '--NestedListItem-paddingLeft': 'var(--ListItem-paddingX)',
  // reset ListItem, ListItemButton negative margin (caused by NestedListItem)
  '--ListItemButton-marginBlock': '0px',
  '--ListItemButton-marginInline': '0px',
  '--ListItem-marginBlock': '0px',
  '--ListItem-marginInline': '0px'
};
/**
 * @ignore - internal component.
 */
function ListProvider(props) {
  const {
    children,
    nested,
    row = false,
    wrap = false
  } = props;
  const baseProviders = /*#__PURE__*/_jsx(RowListContext.Provider, {
    value: row,
    children: /*#__PURE__*/_jsx(WrapListContext.Provider, {
      value: wrap,
      children: React.Children.map(children, (child, index) => /*#__PURE__*/React.isValidElement(child) ? /*#__PURE__*/React.cloneElement(child, _extends({}, index === 0 && {
        'data-first-child': ''
      }, index === React.Children.count(children) - 1 && {
        'data-last-child': ''
      })) : child)
    })
  });
  if (nested === undefined) {
    return baseProviders;
  }
  return /*#__PURE__*/_jsx(NestedListContext.Provider, {
    value: nested,
    children: baseProviders
  });
}
export default ListProvider;