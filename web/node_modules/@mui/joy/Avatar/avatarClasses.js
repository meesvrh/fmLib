import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getAvatarUtilityClass(slot) {
  return generateUtilityClass('MuiAvatar', slot);
}
const avatarClasses = generateUtilityClasses('MuiAvatar', ['root', 'colorPrimary', 'colorNeutral', 'colorDanger', 'colorSuccess', 'colorWarning', 'colorContext', 'fallback', 'sizeSm', 'sizeMd', 'sizeLg', 'img', 'variantOutlined', 'variantSoft', 'variantSolid']);
export default avatarClasses;