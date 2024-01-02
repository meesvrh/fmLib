export interface StepperClasses {
    /** Class name applied to the root element. */
    root: string;
    /** Class name applied to the root element if `size="sm"`. */
    sizeSm: string;
    /** Class name applied to the root element if `size="md"`. */
    sizeMd: string;
    /** Class name applied to the root element if `size="lg"`. */
    sizeLg: string;
    /** Class name applied to the root element if `orientation="horizontal"`. */
    horizontal: string;
    /** Class name applied to the root element if `orientation="vertical"`. */
    vertical: string;
}
export type StepperClassKey = keyof StepperClasses;
export declare function getStepperUtilityClass(slot: string): string;
declare const stepperClasses: StepperClasses;
export default stepperClasses;
