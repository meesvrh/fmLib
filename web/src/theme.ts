
import { extendTheme } from '@mui/joy/styles';

declare module '@mui/joy/styles' {
  // No custom tokens found, you can skip the theme augmentation.
}

const theme = extendTheme({
  colorSchemes: {
    light: {
      palette: {}
    },
    dark: {
      palette: {
        primary: {
          '50': '#fdfde9',
          '100': '#fcfcc5',
          '200': '#f9f58f',
          '300': '#f6e94e',
          '400': '#f0d611',
          '500': '#e1c011',
          '600': '#c2960c',
          '700': '#9b6d0d',
          '800': '#805613',
          '900': '#6d4616',
        },
      }
    }
  },
  components: {
    JoyButton: {
      styleOverrides: {
        root: ({ ownerState, theme }) => ({
          transition: 'all',
          transitionDuration: '0.3s',
          transitionTimingFunction: 'ease-in-out',
          ...(ownerState.variant === 'outlined' && {
            color: theme.palette.primary[400],
            borderColor: theme.palette.primary[400],
            '&:hover': {
              backgroundColor: theme.palette.primary[400],
              color: theme.palette.common.black,
            },
          }),
        }),
      },
    },
  },
})

export default theme;