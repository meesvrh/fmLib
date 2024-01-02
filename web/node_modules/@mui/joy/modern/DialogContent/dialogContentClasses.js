import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getDialogContentUtilityClass(slot) {
  return generateUtilityClass('MuiDialogContent', slot);
}
const dialogContentClasses = generateUtilityClasses('MuiDialogContent', ['root']);
export default dialogContentClasses;