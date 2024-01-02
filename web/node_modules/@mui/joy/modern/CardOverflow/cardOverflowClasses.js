import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getCardOverflowUtilityClass(slot) {
  return generateUtilityClass('MuiCardOverflow', slot);
}
const aspectRatioClasses = generateUtilityClasses('MuiCardOverflow', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default aspectRatioClasses;