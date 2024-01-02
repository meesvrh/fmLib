export interface AvatarGroupClasses {
    /** Class name applied to the root element. */
    root: string;
}
export type AvatarGroupClassKey = keyof AvatarGroupClasses;
export declare function getAvatarGroupUtilityClass(slot: string): string;
declare const avatarGroupClasses: AvatarGroupClasses;
export default avatarGroupClasses;
