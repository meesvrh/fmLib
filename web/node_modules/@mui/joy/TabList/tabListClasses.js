import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getTabListUtilityClass(slot) {
  return generateUtilityClass('MuiTabList', slot);
}
const tabListClasses = generateUtilityClasses('MuiTabList', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'sizeSm', 'sizeMd', 'sizeLg']);
export default tabListClasses;