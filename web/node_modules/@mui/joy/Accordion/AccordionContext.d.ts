import * as React from 'react';
/**
 * @ignore - internal component.
 */
declare const AccordionContext: React.Context<Partial<{
    disabled: boolean;
    expanded: boolean;
    toggle: (event: React.SyntheticEvent) => void;
    accordionId: string;
}>>;
export default AccordionContext;
