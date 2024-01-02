import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getTooltipUtilityClass(slot) {
  return generateUtilityClass('MuiTooltip', slot);
}
const tooltipClasses = generateUtilityClasses('MuiTooltip', ['root', 'tooltipArrow', 'arrow', 'touch', 'placementLeft', 'placementRight', 'placementTop', 'placementBottom', 'colorPrimary', 'colorDanger', 'colorNeutral', 'colorSuccess', 'colorWarning', 'colorContext', 'sizeSm', 'sizeMd', 'sizeLg', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default tooltipClasses;