import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getAccordionGroupUtilityClass(slot) {
  return generateUtilityClass('MuiAccordionGroup', slot);
}
const accordionGroupClasses = generateUtilityClasses('MuiAccordionGroup', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'sizeSm', 'sizeMd', 'sizeLg']);
export default accordionGroupClasses;