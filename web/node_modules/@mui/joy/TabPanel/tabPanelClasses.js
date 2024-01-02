import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getTabPanelUtilityClass(slot) {
  return generateUtilityClass('MuiTabPanel', slot);
}
const tabListClasses = generateUtilityClasses('MuiTabPanel', ['root', 'hidden', 'sizeSm', 'sizeMd', 'sizeLg', 'horizontal', 'vertical', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default tabListClasses;