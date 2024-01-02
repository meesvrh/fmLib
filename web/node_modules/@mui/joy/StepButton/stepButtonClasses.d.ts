export interface StepButtonClasses {
    /** Class name applied to the root element. */
    root: string;
}
export type StepButtonClassKey = keyof StepButtonClasses;
export declare function getStepButtonUtilityClass(slot: string): string;
declare const stepButtonClasses: StepButtonClasses;
export default stepButtonClasses;
