export interface AccordionClasses {
    /** Class name applied to the root element. */
    root: string;
    /** Class name applied to the root element if `expanded` is true. */
    expanded: string;
    /** Class name applied to the root element if `disabled` is true. */
    disabled: string;
}
export type AccordionClassKey = keyof AccordionClasses;
export declare function getAccordionUtilityClass(slot: string): string;
declare const accordionClasses: AccordionClasses;
export default accordionClasses;
