export interface DialogContentClasses {
    /** Class name applied to the root element. */
    root: string;
}
export type DialogContentClassKey = keyof DialogContentClasses;
export declare function getDialogContentUtilityClass(slot: string): string;
declare const dialogContentClasses: DialogContentClasses;
export default dialogContentClasses;
