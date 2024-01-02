import * as React from 'react';
import { FormControlProps } from './FormControlProps';
/**
 * @internal
 */
export type FormControlContextValue = undefined | (Pick<FormControlProps, 'error' | 'disabled' | 'required' | 'color' | 'size'> & {
    labelId: string;
    htmlFor: string | undefined;
    'aria-describedby': string | undefined;
    setHelperText: (node: null | HTMLElement) => void;
    registerEffect: () => () => void;
});
declare const FormControlContext: React.Context<FormControlContextValue>;
export default FormControlContext;
