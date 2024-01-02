export interface FormHelperTextClasses {
    /** Class name applied to the root element. */
    root: string;
}
export type FormHelperTextClassKey = keyof FormHelperTextClasses;
export declare function getFormHelperTextUtilityClass(slot: string): string;
declare const formHelperTextClasses: FormHelperTextClasses;
export default formHelperTextClasses;
