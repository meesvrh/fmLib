import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getModalDialogUtilityClass(slot) {
  return generateUtilityClass('MuiModalDialog', slot);
}
const modalDialogClasses = generateUtilityClasses('MuiModalDialog', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'sizeSm', 'sizeMd', 'sizeLg', 'layoutCenter', 'layoutFullscreen']);
export default modalDialogClasses;