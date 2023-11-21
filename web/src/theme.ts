
import { extendTheme } from '@mui/joy/styles';

declare module '@mui/joy/styles' {
  // No custom tokens found, you can skip the theme augmentation.
}

const theme = extendTheme({
  components: {
    JoyDialogTitle: {
      defaultProps: {
        color: 'primary'
      }
    },
  },
  colorSchemes: {
    light: {
      palette: {}
    },
    dark: {
      palette: {
        primary: {
          "50": "#fffbeb",
          "100": "#fef3c7",
          "200": "#fde68a",
          "300": "#fcd34d",
          "400": "#fbbf24",
          "500": "#f59e0b",
          "600": "#d97706",
          "700": "#b45309",
          "800": "#92400e",
          "900": "#78350f"
        },
      }
    }
  }
})

export default theme;