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
          DEFAULT: '#D4B483',
          '50': '#FFFFFF',
          '100': '#FEFDFC',
          '200': '#F4EBDE',
          '300': '#E9D9C0',
          '400': '#DFC6A1',
          '500': '#D4B483',
          '600': '#C69B59',
          '700': '#AB7F3B',
          '800': '#82602D',
          '900': '#58411F'
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
