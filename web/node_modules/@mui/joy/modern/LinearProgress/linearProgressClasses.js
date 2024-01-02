import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getLinearProgressUtilityClass(slot) {
  return generateUtilityClass('MuiLinearProgress', slot);
}
const linearProgressClasses = generateUtilityClasses('MuiLinearProgress', ['root', 'determinate', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'sizeSm', 'sizeMd', 'sizeLg', 'variantPlain', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default linearProgressClasses;