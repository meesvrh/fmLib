export interface FormLabelClasses {
    /** Class name applied to the root element. */
    root: string;
    /** Class name applied to the asterisk element. */
    asterisk: string;
}
export type FormLabelClassKey = keyof FormLabelClasses;
export declare function getFormLabelUtilityClass(slot: string): string;
declare const formLabelClasses: FormLabelClasses;
export default formLabelClasses;
