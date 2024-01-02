import { generateUtilityClass, generateUtilityClasses } from '../className';
export function getSkeletonUtilityClass(slot) {
  return generateUtilityClass('MuiSkeleton', slot);
}
const skeletonClasses = generateUtilityClasses('MuiSkeleton', ['root', 'variantOverlay', 'variantCircular', 'variantRectangular', 'variantText', 'variantInline', 'h1', 'h2', 'h3', 'h4', 'title-lg', 'title-md', 'title-sm', 'body-lg', 'body-md', 'body-sm', 'body-xs']);
export default skeletonClasses;