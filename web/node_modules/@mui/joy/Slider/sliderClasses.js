import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getSliderUtilityClass(slot) {
  return generateUtilityClass('MuiSlider', slot);
}
const sliderClasses = generateUtilityClasses('MuiSlider', ['root', 'disabled', 'dragging', 'focusVisible', 'marked', 'vertical', 'trackInverted', 'trackFalse', 'rail', 'track', 'mark', 'markActive', 'markLabel', 'thumb', 'thumbStart', 'thumbEnd', 'valueLabel', 'valueLabelOpen', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'disabled', 'sizeSm', 'sizeMd', 'sizeLg', 'input']);
export default sliderClasses;