export interface StepClasses {
    /** Class name applied to the root element. */
    root: string;
    /** Class name applied to the indicator element. */
    indicator: string;
    /** Class name applied to the root element if `orientation="horizontal"`. */
    horizontal: string;
    /** Class name applied to the root element if `orientation="vertical"`. */
    vertical: string;
    /** Class name applied to the root element if `active` is true. */
    active: string;
    /** Class name applied to the root element if `completed` is true. */
    completed: string;
    /** Class name applied to the root element if `disabled` is true. */
    disabled: string;
}
export type StepClassKey = keyof StepClasses;
export declare function getStepUtilityClass(slot: string): string;
declare const stepClasses: StepClasses;
export default stepClasses;
