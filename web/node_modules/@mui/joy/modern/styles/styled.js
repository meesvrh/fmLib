import { createStyled } from '@mui/system';
import defaultTheme from './defaultTheme';
import THEME_ID from './identifier';
const styled = createStyled({
  defaultTheme,
  themeId: THEME_ID
});
export default styled;