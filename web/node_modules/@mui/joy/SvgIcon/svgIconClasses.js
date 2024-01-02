import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getSvgIconUtilityClass(slot) {
  return generateUtilityClass('MuiSvgIcon', slot);
}
const svgIconClasses = generateUtilityClasses('MuiSvgIcon', ['root', 'colorInherit', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'fontSizeInherit', 'fontSizeXs', 'fontSizeSm', 'fontSizeMd', 'fontSizeLg', 'fontSizeXl', 'fontSizeXl2', 'fontSizeXl3', 'fontSizeXl4', 'sizeSm', 'sizeMd', 'sizeLg']);
export default svgIconClasses;