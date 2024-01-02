import * as React from 'react';
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
export declare const scopedVariables: {
    '--NestedList-marginRight': string;
    '--NestedList-marginLeft': string;
    '--NestedListItem-paddingLeft': string;
    '--ListItemButton-marginBlock': string;
    '--ListItemButton-marginInline': string;
    '--ListItem-marginBlock': string;
    '--ListItem-marginInline': string;
};
interface ListProviderProps {
    /**
     * If `undefined`, there is no effect.
     * If `true` or `false`, affects the nested List styles.
     */
    nested?: boolean;
    /**
     * If `true`, display the list in horizontal direction.
     * @default false
     */
    row?: boolean;
    /**
     * Only for horizontal list.
     * If `true`, the list sets the flex-wrap to "wrap" and adjust margin to have gap-like behavior (will move to `gap` in the future).
     *
     * @default false
     */
    wrap?: boolean;
}
/**
 * @ignore - internal component.
 */
declare function ListProvider(props: React.PropsWithChildren<ListProviderProps>): React.JSX.Element;
export default ListProvider;
