import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getAutocompleteOptionUtilityClass(slot) {
  return generateUtilityClass('MuiAutocompleteOption', slot);
}
const autocompleteOptionClasses = generateUtilityClasses('MuiAutocompleteOption', ['root', 'focused', 'focusVisible', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantSoft', 'variantOutlined', 'variantSolid']);
export default autocompleteOptionClasses;