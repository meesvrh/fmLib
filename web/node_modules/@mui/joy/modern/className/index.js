import { unstable_generateUtilityClass, unstable_generateUtilityClasses } from '@mui/utils';
export { unstable_ClassNameGenerator } from '@mui/utils';
export const generateUtilityClass = (componentName, slot) => unstable_generateUtilityClass(componentName, slot, 'Mui');
export const generateUtilityClasses = (componentName, slots) => unstable_generateUtilityClasses(componentName, slots, 'Mui');