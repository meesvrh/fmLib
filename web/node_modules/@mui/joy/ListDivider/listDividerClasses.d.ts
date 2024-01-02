export interface ListDividerClasses {
    /** Class name applied to the root element. */
    root: string;
    /** Class name applied to the root element if `inset="gutter"`. */
    insetGutter: string;
    /** Class name applied to the root element if `inset="startDecorator"`. */
    insetStartDecorator: string;
    /** Class name applied to the root element if `inset="startContent"`. */
    insetStartContent: string;
    /** Class name applied to the root element if `orientation="horizontal"`. */
    horizontal: string;
    /** Class name applied to the root element if `orientation="vertical"`. */
    vertical: string;
}
export type ListDividerClassKey = keyof ListDividerClasses;
export declare function getListDividerUtilityClass(slot: string): string;
declare const listDividerClasses: ListDividerClasses;
export default listDividerClasses;
