export interface AccordionDetailsClasses {
    /** Class name applied to the root element. */
    root: string;
    /** Class name applied to the content element. */
    content: string;
    /** Class name applied to the root element when expanded. */
    expanded: string;
}
export type AccordionDetailsClassKey = keyof AccordionDetailsClasses;
export declare function getAccordionDetailsUtilityClass(slot: string): string;
declare const accordionDetailsClasses: AccordionDetailsClasses;
export default accordionDetailsClasses;
