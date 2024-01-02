import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getChipUtilityClass(slot) {
  return generateUtilityClass('MuiChip', slot);
}
const chipClasses = generateUtilityClasses('MuiChip', ['root', 'clickable', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'disabled', 'endDecorator', 'focusVisible', 'label', 'labelSm', 'labelMd', 'labelLg', 'sizeSm', 'sizeMd', 'sizeLg', 'startDecorator', 'variantPlain', 'variantSolid', 'variantSoft', 'variantOutlined']);
export default chipClasses;