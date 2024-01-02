import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getFormLabelUtilityClass(slot) {
  return generateUtilityClass('MuiFormLabel', slot);
}
const formLabelClasses = generateUtilityClasses('MuiFormLabel', ['root', 'asterisk']);
export default formLabelClasses;