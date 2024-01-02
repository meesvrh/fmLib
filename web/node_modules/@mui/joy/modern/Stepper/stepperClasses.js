import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getStepperUtilityClass(slot) {
  return generateUtilityClass('MuiStepper', slot);
}
const stepperClasses = generateUtilityClasses('MuiStepper', ['root', 'sizeSm', 'sizeMd', 'sizeLg', 'horizontal', 'vertical']);
export default stepperClasses;