export interface ListItemContentClasses {
    /** Class name applied to the root element. */
    root: string;
}
export type ListItemContentClassKey = keyof ListItemContentClasses;
export declare function getListItemContentUtilityClass(slot: string): string;
declare const listItemContentClasses: ListItemContentClasses;
export default listItemContentClasses;
