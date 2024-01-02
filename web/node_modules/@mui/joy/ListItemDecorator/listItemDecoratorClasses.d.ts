export interface ListItemDecoratorClasses {
    /** Class name applied to the root element. */
    root: string;
}
export type ListItemDecoratorClassKey = keyof ListItemDecoratorClasses;
export declare function getListItemDecoratorUtilityClass(slot: string): string;
declare const listItemDecoratorClasses: ListItemDecoratorClasses;
export default listItemDecoratorClasses;
