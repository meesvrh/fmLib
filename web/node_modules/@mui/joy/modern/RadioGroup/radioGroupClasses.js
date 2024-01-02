import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getRadioGroupUtilityClass(slot) {
  return generateUtilityClass('MuiRadioGroup', slot);
}
const radioGroupClasses = generateUtilityClasses('MuiRadioGroup', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'sizeSm', 'sizeMd', 'sizeLg', 'horizontal', 'vertical']);
export default radioGroupClasses;