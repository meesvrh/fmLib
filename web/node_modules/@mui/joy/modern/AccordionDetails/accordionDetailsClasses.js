import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getAccordionDetailsUtilityClass(slot) {
  return generateUtilityClass('MuiAccordionDetails', slot);
}
const accordionDetailsClasses = generateUtilityClasses('MuiAccordionDetails', ['root', 'content', 'expanded']);
export default accordionDetailsClasses;