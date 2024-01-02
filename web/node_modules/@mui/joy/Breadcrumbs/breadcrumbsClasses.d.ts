export interface BreadcrumbsClasses {
    /** Class name applied to the root element. */
    root: string;
    /** Class name applied to the ol element. */
    ol: string;
    /** Class name applied to the li element. */
    li: string;
    /** Class name applied to the separator element. */
    separator: string;
    /** Class name applied to the root element if `size="sm"`. */
    sizeSm: string;
    /** Class name applied to the root element if `size="md"`. */
    sizeMd: string;
    /** Class name applied to the root element if `size="lg"`. */
    sizeLg: string;
}
export type BreadcrumbsClassKey = keyof BreadcrumbsClasses;
export declare function getBreadcrumbsUtilityClass(slot: string): string;
declare const breadcrumbsClasses: BreadcrumbsClasses;
export default breadcrumbsClasses;
