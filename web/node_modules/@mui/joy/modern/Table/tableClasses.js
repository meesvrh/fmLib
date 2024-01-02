import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getTableUtilityClass(slot) {
  return generateUtilityClass('MuiTable', slot);
}
const tableClasses = generateUtilityClasses('MuiTable', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'sizeSm', 'sizeMd', 'sizeLg', 'stickyHeader', 'stickyFooter', 'noWrap', 'hoverRow', 'borderAxisNone', 'borderAxisX', 'borderAxisXBetween', 'borderAxisY', 'borderAxisYBetween', 'borderAxisBoth', 'borderAxisBothBetween']);
export default tableClasses;