import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getMenuButtonUtilityClass(slot) {
  return generateUtilityClass('MuiMenuButton', slot);
}
const menuButtonClasses = generateUtilityClasses('MuiMenuButton', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorInfo', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'disabled', 'sizeSm', 'sizeMd', 'sizeLg', 'fullWidth', 'startDecorator', 'endDecorator', 'loading', 'loadingIndicatorCenter']);
export default menuButtonClasses;