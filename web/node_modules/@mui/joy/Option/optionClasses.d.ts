export interface OptionClasses {
    /** Class name applied to the root element. */
    root: string;
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
    /** Class name applied to the root element if `color="context"`. */
    colorContext: string;
    /** State class applied to the root element if `disabled={true}`. */
    disabled: string;
    /** State class applied to the root element if the option is selected. */
    selected: string;
    /** State class applied to the root element if the option is highlighted. */
    highlighted: string;
    /** State class applied to the root element if `variant="plain"`. */
    variantPlain: string;
    /** State class applied to the root element if `variant="soft"`. */
    variantSoft: string;
    /** State class applied to the root element if `variant="outlined"`. */
    variantOutlined: string;
    /** State class applied to the root element if `variant="solid"`. */
    variantSolid: string;
}
export type OptionClassKey = keyof OptionClasses;
export declare function getOptionUtilityClass(slot: string): string;
declare const optionClasses: OptionClasses;
export default optionClasses;
