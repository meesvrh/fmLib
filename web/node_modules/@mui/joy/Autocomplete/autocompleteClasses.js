import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getAutocompleteUtilityClass(slot) {
  return generateUtilityClass('MuiAutocomplete', slot);
}
const autocompleteClasses = generateUtilityClasses('MuiAutocomplete', ['root', 'wrapper', 'input', 'startDecorator', 'endDecorator', 'formControl', 'focused', 'disabled', 'error', 'multiple', 'limitTag', 'hasPopupIcon', 'hasClearIcon', 'clearIndicator', 'popupIndicator', 'popupIndicatorOpen', 'listbox', 'option', 'loading', 'noOptions', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'sizeSm', 'sizeMd', 'sizeLg', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default autocompleteClasses;