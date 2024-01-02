import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getCardUtilityClass(slot) {
  return generateUtilityClass('MuiCard', slot);
}
const cardClasses = generateUtilityClasses('MuiCard', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'sizeSm', 'sizeMd', 'sizeLg', 'horizontal', 'vertical']);
export default cardClasses;