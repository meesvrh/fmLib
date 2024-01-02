import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getCardActionsUtilityClass(slot) {
  return generateUtilityClass('MuiCardActions', slot);
}
const cardActionsClasses = generateUtilityClasses('MuiCardActions', ['root']);
export default cardActionsClasses;