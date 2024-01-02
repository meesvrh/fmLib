import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getStepIndicatorUtilityClass(slot) {
  return generateUtilityClass('MuiStepIndicator', slot);
}
const stepIndicatorClasses = generateUtilityClasses('MuiStepIndicator', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'horizontal', 'vertical']);
export default stepIndicatorClasses;