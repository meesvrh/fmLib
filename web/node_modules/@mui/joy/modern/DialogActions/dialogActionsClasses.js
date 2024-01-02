import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getDialogActionsUtilityClass(slot) {
  return generateUtilityClass('MuiDialogActions', slot);
}
const dialogActionsClasses = generateUtilityClasses('MuiDialogActions', ['root']);
export default dialogActionsClasses;