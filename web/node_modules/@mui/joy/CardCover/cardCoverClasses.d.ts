export interface CardCoverClasses {
    /** Class name applied to the root element. */
    root: string;
}
export type CardCoverClassKey = keyof CardCoverClasses;
export declare function getCardCoverUtilityClass(slot: string): string;
declare const cardCoverClasses: CardCoverClasses;
export default cardCoverClasses;
