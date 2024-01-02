import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getAspectRatioUtilityClass(slot) {
  return generateUtilityClass('MuiAspectRatio', slot);
}
const aspectRatioClasses = generateUtilityClasses('MuiAspectRatio', ['root', 'content', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default aspectRatioClasses;