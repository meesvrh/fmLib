import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getCardContentUtilityClass(slot) {
  return generateUtilityClass('MuiCardContent', slot);
}
const cardClasses = generateUtilityClasses('MuiCardContent', ['root']);
export default cardClasses;