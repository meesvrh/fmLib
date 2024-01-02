import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getListItemUtilityClass(slot) {
  return generateUtilityClass('MuiListItem', slot);
}
const listItemClasses = generateUtilityClasses('MuiListItem', ['root', 'startAction', 'endAction', 'nested', 'nesting', 'sticky', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantSoft', 'variantOutlined', 'variantSolid']);
export default listItemClasses;