import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getOptionUtilityClass(slot) {
  return generateUtilityClass('MuiOption', slot);
}
const optionClasses = generateUtilityClasses('MuiOption', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'focusVisible', 'disabled', 'selected', 'highlighted', 'variantPlain', 'variantSoft', 'variantOutlined', 'variantSolid']);
export default optionClasses;