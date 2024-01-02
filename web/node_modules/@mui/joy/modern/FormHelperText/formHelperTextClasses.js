import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getFormHelperTextUtilityClass(slot) {
  return generateUtilityClass('MuiFormHelperText', slot);
}
const formHelperTextClasses = generateUtilityClasses('MuiFormHelperText', ['root']);
export default formHelperTextClasses;