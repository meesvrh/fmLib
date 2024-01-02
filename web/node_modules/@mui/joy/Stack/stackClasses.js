import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getStackUtilityClass(slot) {
  return generateUtilityClass('MuiStack', slot);
}
const stackClasses = generateUtilityClasses('MuiStack', ['root']);
export default stackClasses;