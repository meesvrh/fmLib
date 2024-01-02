import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getInputUtilityClass(slot) {
  return generateUtilityClass('MuiInput', slot);
}
const inputClasses = generateUtilityClasses('MuiInput', ['root', 'input', 'formControl', 'focused', 'disabled', 'error', 'adornedStart', 'adornedEnd', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'sizeSm', 'sizeMd', 'sizeLg', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'fullWidth', 'startDecorator', 'endDecorator']);
export default inputClasses;