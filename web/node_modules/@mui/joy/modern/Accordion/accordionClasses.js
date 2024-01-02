import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getAccordionUtilityClass(slot) {
  return generateUtilityClass('MuiAccordion', slot);
}
const accordionClasses = generateUtilityClasses('MuiAccordion', ['root', 'expanded', 'disabled']);
export default accordionClasses;