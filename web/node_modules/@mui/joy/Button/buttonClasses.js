import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getButtonUtilityClass(slot) {
  return generateUtilityClass('MuiButton', slot);
}
const buttonClasses = generateUtilityClasses('MuiButton', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'focusVisible', 'disabled', 'sizeSm', 'sizeMd', 'sizeLg', 'fullWidth', 'startDecorator', 'endDecorator', 'loading', 'loadingIndicatorCenter']);
export default buttonClasses;