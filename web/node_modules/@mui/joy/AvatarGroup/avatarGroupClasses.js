import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getAvatarGroupUtilityClass(slot) {
  return generateUtilityClass('MuiAvatarGroup', slot);
}
const avatarGroupClasses = generateUtilityClasses('MuiAvatarGroup', ['root']);
export default avatarGroupClasses;