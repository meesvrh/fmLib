export interface DialogActionsClasses {
    /** Class name applied to the root element. */
    root: string;
}
export type DialogActionsClassKey = keyof DialogActionsClasses;
export declare function getDialogActionsUtilityClass(slot: string): string;
declare const dialogActionsClasses: DialogActionsClasses;
export default dialogActionsClasses;
