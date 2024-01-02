export interface ModalClasses {
    /** Class name applied to the root element. */
    root: string;
    /** Class name applied to the root element when open is false. */
    hidden: string;
    /** Class name applied to the backdrop element. */
    backdrop: string;
}
export type ModalClassKey = keyof ModalClasses;
export declare function getModalUtilityClass(slot: string): string;
declare const modalClasses: ModalClasses;
export default modalClasses;
