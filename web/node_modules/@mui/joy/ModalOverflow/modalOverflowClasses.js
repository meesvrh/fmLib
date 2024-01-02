import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getModalOverflowUtilityClass(slot) {
  return generateUtilityClass('MuiModalOverflow', slot);
}
const modalOverflowClasses = generateUtilityClasses('MuiModalOverflow', ['root']);
export default modalOverflowClasses;