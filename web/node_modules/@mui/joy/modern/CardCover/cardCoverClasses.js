import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getCardCoverUtilityClass(slot) {
  return generateUtilityClass('MuiCardCover', slot);
}
const cardCoverClasses = generateUtilityClasses('MuiCardCover', ['root']);
export default cardCoverClasses;