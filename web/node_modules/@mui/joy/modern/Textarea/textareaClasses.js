import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getTextareaUtilityClass(slot) {
  return generateUtilityClass('MuiTextarea', slot);
}
const textareaClasses = generateUtilityClasses('MuiTextarea', ['root', 'textarea', 'startDecorator', 'endDecorator', 'formControl', 'disabled', 'error', 'focused', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'sizeSm', 'sizeMd', 'sizeLg', 'variantPlain', 'variantOutlined', 'variantSoft']);
export default textareaClasses;