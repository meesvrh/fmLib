import * as React from 'react';
import { ColorPaletteProp, VariantProp } from '@mui/joy/styles/types';
/**
 * @internal For internal usage only.
 *
 * Use this function in a slot to get the matched default variant and color when the parent's variant and/or color changes.
 */
export declare function getChildVariantAndColor(parentVariant: VariantProp | undefined, parentColor: ColorPaletteProp | undefined): {
    variant: VariantProp | undefined;
    color: ColorPaletteProp | undefined;
};
/**
 * @internal For internal usage only.
 *
 * This hook should be used in a children that are connected with its parent
 * to get the matched default variant and color when the parent's variant and/or color changes.
 *
 * For example, the `Option` component in `Select` component is using this function.
 */
export declare function useVariantColor(instanceVariant: VariantProp | undefined, instanceColor: ColorPaletteProp | undefined, alwaysInheritColor?: boolean): {
    variant: VariantProp | undefined;
    color: ColorPaletteProp | undefined;
};
/**
 * @internal For internal usage only.
 */
export declare function VariantColorProvider({ children, color, variant, }: React.PropsWithChildren<{
    variant: VariantProp | undefined;
    color: ColorPaletteProp | undefined;
}>): React.JSX.Element;
