import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getChipDeleteUtilityClass(slot) {
  return generateUtilityClass('MuiChipDelete', slot);
}
const chipDeleteClasses = generateUtilityClasses('MuiChipDelete', ['root', 'disabled', 'focusVisible', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantSolid', 'variantSoft', 'variantOutlined']);
export default chipDeleteClasses;