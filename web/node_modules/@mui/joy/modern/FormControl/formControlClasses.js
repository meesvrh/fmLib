import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getFormControlUtilityClass(slot) {
  return generateUtilityClass('MuiFormControl', slot);
}
const formControlClasses = generateUtilityClasses('MuiFormControl', ['root', 'error', 'disabled', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'sizeSm', 'sizeMd', 'sizeLg', 'horizontal', 'vertical']);
export default formControlClasses;