import { createApp } from 'vue'
import './style.css'
import App from './App.vue'

// Vuetify
import 'vuetify/styles'
import { createVuetify } from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'

const fmTheme = {
    dark: true,
    colors: {
        primary: '#f0d611',
      },
}

const vuetify = createVuetify({
    theme: {
        defaultTheme: 'fmTheme',
        themes: {
            fmTheme,
        },
    },
    components,
    directives,
})

createApp(App).use(vuetify).mount('#app')
