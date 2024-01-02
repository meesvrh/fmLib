export interface SnackbarClasses {
    /** Class name applied to the root element. */
    root: string;
    /** Styles applied to the root element if `anchorOrigin={{ 'top', 'center' }}`. */
    anchorOriginTopCenter: string;
    /** Styles applied to the root element if `anchorOrigin={{ 'bottom', 'center' }}`. */
    anchorOriginBottomCenter: string;
    /** Styles applied to the root element if `anchorOrigin={{ 'top', 'right' }}`. */
    anchorOriginTopRight: string;
    /** Styles applied to the root element if `anchorOrigin={{ 'bottom', 'right' }}`. */
    anchorOriginBottomRight: string;
    /** Styles applied to the root element if `anchorOrigin={{ 'top', 'left' }}`. */
    anchorOriginTopLeft: string;
    /** Styles applied to the root element if `anchorOrigin={{ 'bottom', 'left' }}`. */
    anchorOriginBottomLeft: string;
    /** Class name applied to the root element if `color="primary"`. */
    colorPrimary: string;
    /** Class name applied to the root element if `color="danger"`. */
    colorDanger: string;
    /** Class name applied to the root element if `color="neutral"`. */
    colorNeutral: string;
    /** Class name applied to the root element if `color="success"`. */
    colorSuccess: string;
    /** Class name applied to the root element if `color="warning"`. */
    colorWarning: string;
    /** Class name applied to the endDecorator element if supplied. */
    endDecorator: string;
    /** Class name applied to the root element if `size="sm"`. */
    sizeSm: string;
    /** Class name applied to the root element if `size="md"`. */
    sizeMd: string;
    /** Class name applied to the root element if `size="lg"`. */
    sizeLg: string;
    /** Class name applied to the startDecorator element if supplied. */
    startDecorator: string;
    /** Class name applied to the root element if `variant="plain"`. */
    variantPlain: string;
    /** Class name applied to the root element if `variant="outlined"`. */
    variantOutlined: string;
    /** Class name applied to the root element if `variant="soft"`. */
    variantSoft: string;
    /** Class name applied to the root element if `variant="solid"`. */
    variantSolid: string;
}
export type SnackbarClassKey = keyof SnackbarClasses;
export declare function getSnackbarUtilityClass(slot: string): string;
declare const snackbarClasses: SnackbarClasses;
export default snackbarClasses;
