import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getDividerUtilityClass(slot) {
  return generateUtilityClass('MuiDivider', slot);
}
const dividerClasses = generateUtilityClasses('MuiDivider', ['root', 'horizontal', 'vertical', 'insetContext', 'insetNone']);
export default dividerClasses;