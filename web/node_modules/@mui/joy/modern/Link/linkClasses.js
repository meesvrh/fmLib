import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getLinkUtilityClass(slot) {
  return generateUtilityClass('MuiLink', slot);
}
const linkClasses = generateUtilityClasses('MuiLink', ['root', 'disabled', 'focusVisible', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'focusVisible', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid', 'underlineNone', 'underlineHover', 'underlineAlways', 'h1', 'h2', 'h3', 'h4', 'title-lg', 'title-md', 'title-sm', 'body-lg', 'body-md', 'body-sm', 'body-xs', 'startDecorator', 'endDecorator']);
export default linkClasses;