export interface CardContentClasses {
    /** Class name applied to the root element. */
    root: string;
}
export type CardContentClassKey = keyof CardContentClasses;
export declare function getCardContentUtilityClass(slot: string): string;
declare const cardClasses: CardContentClasses;
export default cardClasses;
