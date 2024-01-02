export interface CardActionsClasses {
    /** Class name applied to the root element. */
    root: string;
}
export type CardActionsClassKey = keyof CardActionsClasses;
export declare function getCardActionsUtilityClass(slot: string): string;
declare const cardActionsClasses: CardActionsClasses;
export default cardActionsClasses;
