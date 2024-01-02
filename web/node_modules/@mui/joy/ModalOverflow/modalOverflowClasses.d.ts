export interface ModalOverflowClasses {
    /** Styles applied to the root element. */
    root: string;
}
export type ModalOverflowClassKey = keyof ModalOverflowClasses;
export declare function getModalOverflowUtilityClass(slot: string): string;
declare const modalOverflowClasses: ModalOverflowClasses;
export default modalOverflowClasses;
