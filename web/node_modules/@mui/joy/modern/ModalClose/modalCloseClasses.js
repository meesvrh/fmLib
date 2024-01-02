import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getModalCloseUtilityClass(slot) {
  return generateUtilityClass('MuiModalClose', slot);
}
const modalCloseClasses = generateUtilityClasses('MuiModalClose', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'sizeSm', 'sizeMd', 'sizeLg']);
export default modalCloseClasses;