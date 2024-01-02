import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getSnackbarUtilityClass(slot) {
  return generateUtilityClass('MuiSnackbar', slot);
}
const snackbarClasses = generateUtilityClasses('MuiSnackbar', ['root', 'anchorOriginTopCenter', 'anchorOriginBottomCenter', 'anchorOriginTopRight', 'anchorOriginBottomRight', 'anchorOriginTopLeft', 'anchorOriginBottomLeft', 'colorPrimary', 'colorDanger', 'colorNeutral', 'colorSuccess', 'colorWarning', 'endDecorator', 'sizeSm', 'sizeMd', 'sizeLg', 'startDecorator', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default snackbarClasses;