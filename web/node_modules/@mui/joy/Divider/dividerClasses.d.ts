export interface DividerClasses {
    /** Class name applied to the root element. */
    root: string;
    /** Class name applied to the root element if `orientation="horizontal"`. */
    horizontal: string;
    /** Class name applied to the root element if `orientation="vertical"`. */
    vertical: string;
    /** Class name applied to the root element if `inset="context"`. */
    insetContext: string;
    /** Class name applied to the root element if `inset="none"`. */
    insetNone: string;
}
export type DividerClassKey = keyof DividerClasses;
export declare function getDividerUtilityClass(slot: string): string;
declare const dividerClasses: DividerClasses;
export default dividerClasses;
