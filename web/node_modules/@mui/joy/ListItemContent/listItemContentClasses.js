import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getListItemContentUtilityClass(slot) {
  return generateUtilityClass('MuiListItemContent', slot);
}
const listItemContentClasses = generateUtilityClasses('MuiListItemContent', ['root']);
export default listItemContentClasses;