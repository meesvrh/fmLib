export interface AccordionSummaryClasses {
    /** Class name applied to the root element. */
    root: string;
    /** Class name applied to the button element. */
    button: string;
    /** Class name applied to the indicator element. */
    indicator: string;
    /** Class name applied when the accordion is disabled. */
    disabled: string;
    /** Class name applied when the accordion is expanded. */
    expanded: string;
}
export type AccordionSummaryClassKey = keyof AccordionSummaryClasses;
export declare function getAccordionSummaryUtilityClass(slot: string): string;
declare const accordionSummaryClasses: AccordionSummaryClasses;
export default accordionSummaryClasses;
