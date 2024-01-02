import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getAutocompleteListboxUtilityClass(slot) {
  return generateUtilityClass('MuiAutocompleteListbox', slot);
}
const autocompleteListboxClasses = generateUtilityClasses('MuiAutocompleteListbox', ['root', 'sizeSm', 'sizeMd', 'sizeLg', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default autocompleteListboxClasses;