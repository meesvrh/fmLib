import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getStepButtonUtilityClass(slot) {
  return generateUtilityClass('MuiStepButton', slot);
}
const stepButtonClasses = generateUtilityClasses('MuiStepButton', ['root']);
export default stepButtonClasses;