
// const colors = require('tailwindcss/colors')
const colors = require('tailwindcss/colors')

module.exports = {
  purge: {
    enabled: ["production", "staging"].includes(process.env.NODE_ENV),
    content: [
      './app/**/*.html.erb',
      './app/decorators/*.rb',
      './app/components/*.html.erb',
      './app/components/*.rb',
      './app/components/**/*.html.erb',
      './app/components/**/*.rb',
      './app/helpers/**/*.rb',
      './app/javascript/**/*.js',
      './app/javascript/**/*.vue',
    ],
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        amber: colors.amber,
        rose: colors.rose,
        teal: colors.teal,
        sky: colors.sky,
        emerald: colors.emerald,
        lime: colors.lime,
        orange: colors.orange
      },
      fontFamily: {
        'osans': ['"Open Sans"', 'sans-serif'],
        'nsans': ['"Noto Sans"', 'sans-serif'],
        'quick': ['Quicksand', 'sans-serif'],
        'pn': ['proxima-nova', 'sans-serif']
      },
      animation: {
         'spin-fast': 'spin 0.4s linear infinite',
      }

    },
  },
  variants: {
    extend: {
      display: ["group-hover"],
      opacity: ["group-hover"],
      translate: ["group-hover"],
      transform: ["group-hover"],
      width: ["group-hover", "hover"],
      height: ["group-hover", "hover"],
      padding: ["group-hover", "hover"],
      animation: ["group-hover", "hover"],
      scale: ["group-hover", "hover"],
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/line-clamp')
  ],
}
