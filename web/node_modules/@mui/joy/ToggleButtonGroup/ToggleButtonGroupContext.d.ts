import * as React from 'react';
import { SupportedValue, ToggleButtonGroupProps } from './ToggleButtonGroupProps';
interface ToggleButtonGroupContextType {
    onClick?: (event: React.MouseEvent<HTMLButtonElement>, childValue: React.ButtonHTMLAttributes<HTMLButtonElement>['value']) => void;
    value?: ToggleButtonGroupProps<SupportedValue>['value'];
}
/**
 * @ignore - internal component.
 */
declare const ToggleButtonGroupContext: React.Context<ToggleButtonGroupContextType | undefined>;
export default ToggleButtonGroupContext;
