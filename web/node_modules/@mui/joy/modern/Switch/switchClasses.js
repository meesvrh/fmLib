import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getSwitchUtilityClass(slot) {
  return generateUtilityClass('MuiSwitch', slot);
}
const switchClasses = generateUtilityClasses('MuiSwitch', ['root', 'checked', 'disabled', 'action', 'input', 'thumb', 'track', 'focusVisible', 'readOnly', 'colorPrimary', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'sizeSm', 'sizeMd', 'sizeLg', 'variantOutlined', 'variantSoft', 'variantSolid', 'startDecorator', 'endDecorator']);
export default switchClasses;