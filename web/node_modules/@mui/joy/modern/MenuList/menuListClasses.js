import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getMenuListUtilityClass(slot) {
  return generateUtilityClass('MuiMenuList', slot);
}
const menuClasses = generateUtilityClasses('MuiMenuList', ['root', 'nested', 'sizeSm', 'sizeMd', 'sizeLg', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default menuClasses;