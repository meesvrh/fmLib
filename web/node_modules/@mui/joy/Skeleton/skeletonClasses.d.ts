export interface SkeletonClasses {
    /** Class name applied to the root element. */
    root: string;
    /** Class name applied to the root element if `variant="overlay"`. */
    variantOverlay: string;
    /** Class name applied to the root element if `variant="circular"`. */
    variantCircular: string;
    /** Class name applied to the root element if `variant="rectangular"`. */
    variantRectangular: string;
    /** Class name applied to the root element if `variant="text"`. */
    variantText: string;
    /** Class name applied to the root element if `variant="inline"`. */
    variantInline: string;
    /** Class name applied to the root element if `level="h1"`. */
    h1: string;
    /** Class name applied to the root element if `level="h2"`. */
    h2: string;
    /** Class name applied to the root element if `level="h3"`. */
    h3: string;
    /** Class name applied to the root element if `level="h4"`. */
    h4: string;
    /** Class name applied to the root element if `level="title-lg"`. */
    'title-lg': string;
    /** Class name applied to the root element if `level="title-md"`. */
    'title-md': string;
    /** Class name applied to the root element if `level="title-sm"`. */
    'title-sm': string;
    /** Class name applied to the root element if `level="body-lg"`. */
    'body-lg': string;
    /** Class name applied to the root element if `level="body-md"`. */
    'body-md': string;
    /** Class name applied to the root element if `level="body-sm"`. */
    'body-sm': string;
    /** Class name applied to the root element if `level="body-xs"`. */
    'body-xs': string;
}
export type SkeletonClassKey = keyof SkeletonClasses;
export declare function getSkeletonUtilityClass(slot: string): string;
declare const skeletonClasses: SkeletonClasses;
export default skeletonClasses;
