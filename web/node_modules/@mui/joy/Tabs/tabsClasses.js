import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getTabsUtilityClass(slot) {
  return generateUtilityClass('MuiTabs', slot);
}
const tabListClasses = generateUtilityClasses('MuiTabs', ['root', 'horizontal', 'vertical', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'sizeSm', 'sizeMd', 'sizeLg']);
export default tabListClasses;