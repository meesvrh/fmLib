import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getListItemButtonUtilityClass(slot) {
  return generateUtilityClass('MuiListItemButton', slot);
}
const listItemButtonClasses = generateUtilityClasses('MuiListItemButton', ['root', 'horizontal', 'vertical', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'focusVisible', 'disabled', 'selected', 'variantPlain', 'variantSoft', 'variantOutlined', 'variantSolid']);
export default listItemButtonClasses;