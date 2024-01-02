export interface AutocompleteOptionClasses {
    /** Class name applied to the root element. */
    root: string;
    /** State class applied to the root element if focused. */
    focused: string;
    /** State class applied to the `component`'s `focusVisibleClassName` prop. */
    focusVisible: string;
    /** Class name applied to the root element if `color="primary"`. */
    colorPrimary: string;
    /** Class name applied to the root element if `color="neutral"`. */
    colorNeutral: string;
    /** Class name applied to the root element if `color="danger"`. */
    colorDanger: string;
    /** Class name applied to the root element if `color="success"`. */
    colorSuccess: string;
    /** Class name applied to the root element if `color="warning"`. */
    colorWarning: string;
    /** Class name applied to the root element when color inversion is triggered. */
    colorContext: string;
    /** State class applied to the root element if `variant="plain"`. */
    variantPlain: string;
    /** State class applied to the root element if `variant="soft"`. */
    variantSoft: string;
    /** State class applied to the root element if `variant="outlined"`. */
    variantOutlined: string;
    /** State class applied to the root element if `variant="solid"`. */
    variantSolid: string;
}
export type AutocompleteOptionClassKey = keyof AutocompleteOptionClasses;
export declare function getAutocompleteOptionUtilityClass(slot: string): string;
declare const autocompleteOptionClasses: AutocompleteOptionClasses;
export default autocompleteOptionClasses;
