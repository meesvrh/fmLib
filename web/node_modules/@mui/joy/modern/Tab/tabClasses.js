import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getTabUtilityClass(slot) {
  return generateUtilityClass('MuiTab', slot);
}
const tabListClasses = generateUtilityClasses('MuiTab', ['root', 'disabled', 'focusVisible', 'selected', 'horizontal', 'vertical', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default tabListClasses;