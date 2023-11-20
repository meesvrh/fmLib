// /** @type {import('tailwindcss').Config} */
// export default {
//   content: [
//     "./index.html",
//     "./src/**/*.{js,ts,jsx,tsx}",
//   ],
//   theme: {
//     extend: {
//       fontFamily: {
//       },
//       colors: {
//       },
//     },
//   },
//   plugins: [],
// }

const withMT = require("@material-tailwind/react/utils/withMT");
 
module.exports = withMT({
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
      },
      colors: {
        primary: {
          DEFAULT: '#F2910A',
        },
        secondary: {
          DEFAULT: '#0a6bf2',
        },
        dark: {
          DEFAULT: '#2C2D34',
        }
      },
    },
  },
  plugins: [],
});