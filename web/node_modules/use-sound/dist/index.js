
'use strict'

if (process.env.NODE_ENV === 'production') {
  module.exports = require('./use-sound.cjs.production.min.js')
} else {
  module.exports = require('./use-sound.cjs.development.js')
}
