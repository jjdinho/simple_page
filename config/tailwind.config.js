const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        'liberty': {
          DEFAULT: '#4357AD',
          '50': '#C1C8E7',
          '100': '#B2BBE1',
          '200': '#95A1D6',
          '300': '#7787CA',
          '400': '#5A6DBF',
          '500': '#4357AD',
          '600': '#334385',
          '700': '#242E5C',
          '800': '#141A34',
          '900': '#04060B'
        },
        'tan': {
          DEFAULT: '#EBA000',
          '50': '#FFE2A3',
          '100': '#FFDB8F',
          '200': '#FFCF66',
          '300': '#FFC23D',
          '400': '#FFB514',
          '500': '#EBA000',
          '600': '#B37A00',
          '700': '#7A5400',
          '800': '#422D00',
          '900': '#0A0700'
        },
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
