import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getMenuUtilityClass(slot) {
  return generateUtilityClass('MuiMenu', slot);
}
const menuClasses = generateUtilityClasses('MuiMenu', ['root', 'listbox', 'expanded', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'sizeSm', 'sizeMd', 'sizeLg']);
export default menuClasses;