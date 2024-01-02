import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getSelectUtilityClass(slot) {
  return generateUtilityClass('MuiSelect', slot);
}
const selectClasses = generateUtilityClasses('MuiSelect', ['root', 'button', 'indicator', 'startDecorator', 'endDecorator', 'popper', 'listbox', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'sizeSm', 'sizeMd', 'sizeLg', 'focusVisible', 'disabled', 'expanded', 'multiple']);
export default selectClasses;