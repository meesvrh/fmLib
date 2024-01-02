import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getRadioUtilityClass(slot) {
  return generateUtilityClass('MuiRadio', slot);
}
const radioClasses = generateUtilityClasses('MuiRadio', ['root', 'radio', 'icon', 'action', 'input', 'label', 'checked', 'disabled', 'focusVisible', 'colorPrimary', 'colorDanger', 'colorNeutral', 'colorSuccess', 'colorWarning', 'colorContext', 'sizeSm', 'sizeMd', 'sizeLg', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default radioClasses;