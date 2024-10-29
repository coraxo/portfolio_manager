module.exports = {
  daisyui: {
    themes: ['light', 'dark']
  },
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
  ],
  theme: {
    extend: {
      screens: {
        'xs': '480px',
      },
    },
  },
  plugins: [
    require("@tailwindcss/typography"), require('daisyui'),
  ],
}
