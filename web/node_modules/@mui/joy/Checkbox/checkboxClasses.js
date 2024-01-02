import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getCheckboxUtilityClass(slot) {
  return generateUtilityClass('MuiCheckbox', slot);
}
const checkboxClasses = generateUtilityClasses('MuiCheckbox', ['root', 'checkbox', 'action', 'input', 'label', 'checked', 'disabled', 'focusVisible', 'indeterminate', 'colorPrimary', 'colorDanger', 'colorNeutral', 'colorSuccess', 'colorWarning', 'colorContext', 'sizeSm', 'sizeMd', 'sizeLg', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default checkboxClasses;