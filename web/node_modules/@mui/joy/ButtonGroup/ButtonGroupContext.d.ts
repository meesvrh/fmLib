import * as React from 'react';
import type { ButtonGroupProps } from './ButtonGroupProps';
interface IButtonGroupContext {
    color?: ButtonGroupProps['color'];
    variant?: ButtonGroupProps['variant'];
    size?: ButtonGroupProps['size'];
    disabled?: boolean;
}
/**
 * @ignore - internal component.
 */
declare const ButtonGroupContext: React.Context<IButtonGroupContext>;
export default ButtonGroupContext;
